#%%
# import plotly.graph_objects as go
import argparse
import pandas as pd
import altair as alt


# def coverage_area_chart(input_coverage_csv, plot_name):
#     fig = go.Figure()
#     fig.add_trace(go.Scatter(x=input_coverage_csv.iloc[:,1], y=input_coverage_csv.iloc[:,2],
#                         fill='toself',
#                         hoveron = 'points+fills', # select where hover is active
#                         # line_color='darkviolet',
#                         text="Coverage",
#                         hoverinfo = 'text+x+y'))
    
#     fig.write_html(plot_name)


#%%




# example = "/Users/jason/Library/CloudStorage/OneDrive-UW/jason_rupp/nanopore/20240418_chainLAMP/ATJ329/processed_results/SQK-NBD114-24_barcode01/SQK-NBD114-24_barcode01_f20_aligned_sorted_coverage_report.csv"


# df = pd.read_csv(example)
target_region_map = pd.read_csv("target_region_map_updated.csv")

# df.columns = ["reference", "seq_index", "coverage"]

def yrule_for_rate_plot(target, size, color="black"):
        tmp_df = target_region_map[target_region_map['Name'] == target]
        return (
            alt.Chart(
                pd.DataFrame({'seq_index': [tmp_df['Start'].values[0]]})
                ).mark_rule(
                    # strokeDash=[12, 6], 
                    size=size,
                    color=color
                    ).encode(
                        x=alt.X('seq_index:Q'))
            ) + (
            alt.Chart(
                pd.DataFrame({'seq_index': [tmp_df['End'].values[0]]})
                ).mark_rule(
                    # strokeDash=[12, 6], 
                    size=size,
                    color=color
                    ).encode(
                        x=alt.X('seq_index:Q'))
            )

def yrule_annotation_for_rate_plot(target):
    label_x_pos = sum([
        target_region_map[target_region_map['Name'] == target]['Start'],
        target_region_map[target_region_map['Name'] == target]['End']
        ])/2
    return alt.Chart(
        pd.DataFrame(
            [{'seq_index': label_x_pos, 'coverage':-20}]
            )).mark_text(
        text=f'{target}',  # Replace 'Annotation Text' with your desired text
        align='right',
        baseline='middle',
        # dx=dx,  # Offset from the mark
        size=10,
        angle=335
    ).encode(
        x=alt.X('seq_index:Q'),
        y=alt.Y('coverage:Q'),  # Adjust y position of annotation
    )

def rect_plot_target_fill(target, color):
    tmp_df = target_region_map[target_region_map['Name'] == target]
    return alt.Chart(
        pd.DataFrame([
        {"start": tmp_df["Start"], "end": tmp_df["End"]},
    ])
    ).mark_rect(
        color=color, 
        fillOpacity=0.1
        ).encode(
            x="start:Q",
            x2="end:Q",
    # color="red"
    )

def plot_target_region(target, color, size):
     return rect_plot_target_fill(target, color) + \
        yrule_for_rate_plot(target, size) + \
        yrule_annotation_for_rate_plot(target)


def all_target_region_highlights():
    target_14 = plot_target_region("Target 14.2", "#B22222", 0.5)
    target_12 = plot_target_region("Target 12", "#32CD32", 0.5)
    target_10 = plot_target_region("Target 10", "#D8BFD8", 0.5)
    target_8 = plot_target_region("Target 8.3", "#87CEEB", 0.5)
    target_7 = plot_target_region("Target 7", "#E6AB02", 0.5)
    target_4 = plot_target_region("Target 4.1", "#A6761D", 0.5)
    target_3 = plot_target_region("Target 3", "#3CB371", 0.5)
    return target_14 + target_12 + target_10 + \
    target_8 + target_7 + target_4 + target_3

# target_14_fill = rect_plot_for_rate_plot("Target 14.2", 'blue')
# target_14_lines = yrule_for_rate_plot("Target 14.2", 0.5)
# target_14_lab = yrule_annotation_for_rate_plot("Target 14.2")

# target_12_fill = rect_plot_for_rate_plot("Target 12", 'blue')
# target_12_lines = yrule_for_rate_plot("Target 12", 0.5)
# target_12_lab = yrule_annotation_for_rate_plot("Target 12")

# target_10_fill = rect_plot_for_rate_plot("Target 10", 'blue')
# target_10_lines = yrule_for_rate_plot("Target 10", 0.5)
# target_10_lab = yrule_annotation_for_rate_plot("Target 10")

# target_8_fill = rect_plot_for_rate_plot("Target 8.3", 'blue')
# target_8_lines = yrule_for_rate_plot("Target 8.3", 0.5)
# target_8_lab = yrule_annotation_for_rate_plot("Target 8.3")

# target_7_fill = rect_plot_for_rate_plot("Target 7", 'blue')
# target_7_lines = yrule_for_rate_plot("Target 7", 0.5)
# target_7_lab = yrule_annotation_for_rate_plot("Target 7")

# target_4_fill = rect_plot_for_rate_plot("Target 4.1", 'blue')
# target_4_lines = yrule_for_rate_plot("Target 4.1", 0.5)
# target_4_lab = yrule_annotation_for_rate_plot("Target 4.1")

# target_3_fill = rect_plot_for_rate_plot("Target 3", 'blue')
# target_3_lines = yrule_for_rate_plot("Target 3", 0.5)
# target_3_lab = yrule_annotation_for_rate_plot("Target 3")




# sample = "DUDE"
# coverage_area = (alt.Chart(df).mark_area(color="#1B9E77").encode(
#     x = alt.X('seq_index:Q', axis=alt.Axis(
#         labels=False, 
#         ticks=False, 
#         title="Sequence Position", titlePadding=30)),
#     y = alt.Y("coverage:Q", 
#               axis=alt.Axis(title="Coverage"),
#               scale=alt.Scale(domain=[0, (df['coverage'].max() + 100)])),
#     tooltip=[
#         alt.Tooltip("seq_index", title="Position"), 
#         alt.Tooltip("coverage", title="Coverage")])
#         )


# regions = all_target_region_highlights()

# (regions + coverage_area).properties(title = f"Coverage Map for {sample}")
# ) + target_14_fill + target_14_lines + target_14_lab \
# + target_12_fill + target_12_lines + target_12_lab \
# + target_10_fill + target_10_lines + target_10_lab \
# + target_8_fill + target_8_lines + target_8_lab \
# + target_7_fill + target_7_lines + target_7_lab \
# + target_4_fill + target_4_lines + target_4_lab \
# + target_3_fill + target_3_lines + target_3_lab).properties(width=600)


def coverage_area_chart(coverage_df, sample):
    # sample = "DUDE"
    coverage_area = (alt.Chart(coverage_df).mark_area(color="#1B9E77").encode(
        x = alt.X('seq_index:Q', axis=alt.Axis(
            labels=False, 
            ticks=False, 
            title="Sequence Position", titlePadding=30)),
        y = alt.Y("coverage:Q", 
                  axis=alt.Axis(title="Coverage"),
                  scale=alt.Scale(domain=[0, (coverage_df['coverage'].max() + 100)])),
        tooltip=[
            alt.Tooltip("seq_index", title="Position"), 
            alt.Tooltip("coverage", title="Coverage")])
            )
    regions = all_target_region_highlights()

    return (regions + coverage_area).properties(
        title = f"Coverage Map for {sample.split('_coverage_plot')[0].split('-24_')[-1].title()}",
        width=700)



#%%
def main():
    parser = argparse.ArgumentParser(description='Makes plotly area chart showing coverage')
    parser.add_argument('--coverage_csv', type=str, help='Input csv file path with coverage stats')
    parser.add_argument('--plot_name', type=str, help='Name of plot when saving')

    try:
        args = parser.parse_args()
        # Your main script logic here, using args.input_file and args.output
        # print("Input file:", args.input_bam)
        # print("Output file:", args.output)
        coverage_df = pd.read_csv(args.coverage_csv)
        coverage_df.columns = ["reference", "seq_index", "coverage"]
        coverage_chart = coverage_area_chart(coverage_df, args.plot_name)
        coverage_chart.save(args.plot_name)


    except argparse.ArgumentError as e:
        print("Error parsing arguments:", e)
        # Optionally, print usage message or other help
        parser.print_usage()

if __name__ == "__main__":
    main()
