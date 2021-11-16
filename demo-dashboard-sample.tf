# signalfx_single_value_chart.demo-dashboard-sample_0:
resource "signalfx_single_value_chart" "demo-dashboard-sample_0" {
    color_by                = "Dimension"
    description             = "Total no. hosts seen by load balancers."
    is_timestamp_hidden     = false
    max_precision           = 0
    name                    = "Total no. hosts"
    program_text            = "A = data('demo.lb.hosts').sum().publish(label='A')"
    secondary_visualization = "None"
    show_spark_line         = false
    unit_prefix             = "Metric"

    viz_options {
        display_name = "Hosts seen by load balancers"
        label        = "A"
    }
}
# signalfx_single_value_chart.demo-dashboard-sample_1:
resource "signalfx_single_value_chart" "demo-dashboard-sample_1" {
    color_by                = "Dimension"
    description             = "Moving average of total transactions over previous 10 minutes. Plot color specified in plot actions menu."
    is_timestamp_hidden     = false
    max_precision           = 0
    name                    = "Total no. transactions"
    program_text            = "A = data('demo.trans.count',rollup='rate').mean(over='10m').sum().publish(label='A')"
    secondary_visualization = "None"
    show_spark_line         = false
    unit_prefix             = "Metric"

    viz_options {
        color        = "purple"
        display_name = "Total transactions (-10m)"
        label        = "A"
    }
}
# signalfx_list_chart.demo-dashboard-sample_2:
resource "signalfx_list_chart" "demo-dashboard-sample_2" {
    color_by                = "Dimension"
    description             = "Updated every 10s"
    disable_sampling        = false
    max_precision           = 1
    name                    = "Top hosts by transactions per second"
    program_text            = "A = data('demo.trans.count',rollup='rate').sum(by=['demo_host']).publish(label='A')"
    secondary_visualization = "Sparkline"
    sort_by                 = "-value"
    time_range              = 900
    unit_prefix             = "Metric"

    legend_options_fields {
        enabled  = true
        property = "demo_host"
    }
    legend_options_fields {
        enabled  = false
        property = "sf_originatingMetric"
    }
    legend_options_fields {
        enabled  = false
        property = "sf_metric"
    }

    viz_options {
        display_name = "No. transactions per sec"
        label        = "A"
    }
}
# signalfx_time_chart.demo-dashboard-sample_3:
resource "signalfx_time_chart" "demo-dashboard-sample_3" {
    axes_include_zero  = false
    axes_precision     = 0
    color_by           = "Metric"
    description        = "Comparison in max, min and P50 latencies."
    disable_sampling   = false
    minimum_resolution = 0
    name               = "Max, P50 and min latency"
    plot_type          = "LineChart"
    program_text       = <<-EOF
        A = data('demo.trans.latency').max().publish(label='A')
        B = data('demo.trans.latency').percentile(pct=50).publish(label='B')
        C = data('demo.trans.latency').min().publish(label='C')
    EOF
    show_data_markers  = false
    show_event_lines   = false
    stacked            = false
    time_range         = 300
    unit_prefix        = "Metric"

    axis_left {
        label          = "Latency (ms)"
    }

    histogram_options {
        color_theme = "red"
    }

    viz_options {
        axis         = "left"
        display_name = "50th percentile latency"
        label        = "B"
    }
    viz_options {
        axis         = "left"
        display_name = "Max latency"
        label        = "A"
    }
    viz_options {
        axis         = "left"
        display_name = "Min latency"
        label        = "C"
    }
}
# signalfx_time_chart.demo-dashboard-sample_4:
resource "signalfx_time_chart" "demo-dashboard-sample_4" {
    axes_include_zero  = false
    axes_precision     = 0
    color_by           = "Dimension"
    description        = "Total transactions, visualized as stacked column charts with minimum resolution of 10s."
    disable_sampling   = false
    minimum_resolution = 10
    name               = "Total no. transactions"
    plot_type          = "ColumnChart"
    program_text       = "A = data('demo.trans.count',rollup='rate').publish(label='A')"
    show_data_markers  = false
    show_event_lines   = false
    stacked            = true
    time_range         = 300
    unit_prefix        = "Metric"

    axis_left {
        label          = "Transactions"
    }

    histogram_options {
        color_theme = "red"
    }

    viz_options {
        axis         = "left"
        display_name = "No. transactions"
        label        = "A"
    }
}
# signalfx_heatmap_chart.demo-dashboard-sample_5:
resource "signalfx_heatmap_chart" "demo-dashboard-sample_5" {
    description        = "Red = above 250ms, green = below 220ms"
    disable_sampling   = false
    group_by           = []
    hide_timestamp     = false
    minimum_resolution = 0
    name               = "Latency heatmap"
    program_text       = "A = data('demo.trans.latency').publish(label='A')"
    unit_prefix        = "Metric"

    color_scale {
        color = "green"
        gt    = 340282346638528860000000000000000000000
        gte   = 340282346638528860000000000000000000000
        lt    = 340282346638528860000000000000000000000
        lte   = 220
    }
    color_scale {
        color = "red"
        gt    = 250
        gte   = 340282346638528860000000000000000000000
        lt    = 340282346638528860000000000000000000000
        lte   = 340282346638528860000000000000000000000
    }
    color_scale {
        color = "vivid_yellow"
        gt    = 220
        gte   = 340282346638528860000000000000000000000
        lt    = 340282346638528860000000000000000000000
        lte   = 250
    }
}
# signalfx_time_chart.demo-dashboard-sample_6:
resource "signalfx_time_chart" "demo-dashboard-sample_6" {
    axes_include_zero  = false
    axes_precision     = 0
    color_by           = "Dimension"
    description        = "Spread of latency values across time."
    disable_sampling   = false
    minimum_resolution = 0
    name               = "Latency histogram"
    plot_type          = "Histogram"
    program_text       = "A = data('demo.trans.latency').publish(label='A')"
    show_data_markers  = false
    show_event_lines   = false
    stacked            = false
    time_range         = 300
    unit_prefix        = "Metric"

    axis_left {
        label          = "Latency (ms)"
    }

    histogram_options {
        color_theme = "red"
    }

    viz_options {
        axis         = "left"
        display_name = "Latency"
        label        = "A"
    }
}
# signalfx_time_chart.demo-dashboard-sample_7:
resource "signalfx_time_chart" "demo-dashboard-sample_7" {
    axes_include_zero  = false
    axes_precision     = 0
    color_by           = "Dimension"
    description        = "Latency vs. transaction count on separate axes. Custom plot and chart type selected in plot B's plot actions menu."
    disable_sampling   = false
    minimum_resolution = 10
    name               = "Latency vs. transction count"
    plot_type          = "AreaChart"
    program_text       = <<-EOF
        A = data('demo.trans.latency').mean().publish(label='A')
        B = data('demo.trans.count',rollup='rate').sum().publish(label='B')
    EOF
    show_data_markers  = false
    show_event_lines   = false
    stacked            = false
    time_range         = 900
    unit_prefix        = "Metric"

    axis_left {
        label          = "Latency (ms)"
        min_value      = 0
    }

    axis_right {
        label          = "Transactions"
        max_value      = 4000
        min_value      = 0
    }

    histogram_options {
        color_theme = "red"
    }

    viz_options {
        axis         = "left"
        color        = "azure"
        display_name = "Average latency"
        label        = "A"
    }
    viz_options {
        axis         = "right"
        color        = "blue"
        display_name = "Total transactions"
        label        = "B"
        plot_type    = "ColumnChart"
    }
}
# signalfx_time_chart.demo-dashboard-sample_8:
resource "signalfx_time_chart" "demo-dashboard-sample_8" {
    axes_include_zero  = false
    axes_precision     = 0
    color_by           = "Dimension"
    disable_sampling   = false
    minimum_resolution = 0
    name               = "Latency per transaction by customer"
    plot_type          = "LineChart"
    program_text       = <<-EOF
        A = data('demo.trans.latency').sum(by=['demo_customer']).publish(label='A', enable=False)
        B = data('demo.trans.count',rollup='rate').sum(by=['demo_customer']).publish(label='B', enable=False)
        C = (A/B).publish(label='C')
    EOF
    show_data_markers  = false
    show_event_lines   = false
    stacked            = false
    time_range         = 300
    unit_prefix        = "Metric"

    axis_left {
        label          = "Latency (ms)"
    }

    histogram_options {
        color_theme = "red"
    }

    viz_options {
        axis         = "left"
        display_name = "Latency per transaction"
        label        = "C"
    }
    viz_options {
        axis         = "left"
        display_name = "demo.trans.count - Sum by demo_customer"
        label        = "B"
    }
    viz_options {
        axis         = "left"
        display_name = "demo.trans.latency - Sum by demo_customer"
        label        = "A"
    }
}
# signalfx_time_chart.demo-dashboard-sample_9:
resource "signalfx_time_chart" "demo-dashboard-sample_9" {
    axes_include_zero  = false
    axes_precision     = 0
    color_by           = "Dimension"
    description        = "Total transactions by customer, with smoothing function applied (mean:transformation 1m)."
    disable_sampling   = false
    minimum_resolution = 0
    name               = "No. transactions per customer (1m mean)"
    plot_type          = "LineChart"
    program_text       = "A = data('demo.trans.count',rollup='rate').sum(by=['demo_customer']).mean(over='1m').publish(label='A')"
    show_data_markers  = false
    show_event_lines   = false
    stacked            = false
    time_range         = 900
    unit_prefix        = "Metric"

    histogram_options {
        color_theme = "red"
    }

    viz_options {
        axis         = "left"
        display_name = "Total transactions by customer"
        label        = "A"
    }
}
# signalfx_dashboard.demo-dashboard-sample:
resource "signalfx_dashboard" "demo-dashboard-sample" {
    charts_resolution = "default"
    dashboard_group   = "ELs1vZyA4AE"
    description       = "A dashboard full of charts using sample data."
    name              = "Sample charts"

    chart {
        chart_id = signalfx_time_chart.demo-dashboard-sample_6.id
        column   = 6
        height   = 1
        row      = 2
        width    = 6
    }
    chart {
        chart_id = signalfx_heatmap_chart.demo-dashboard-sample_5.id
        column   = 0
        height   = 1
        row      = 2
        width    = 6
    }
    chart {
        chart_id = signalfx_time_chart.demo-dashboard-sample_3.id
        column   = 0
        height   = 1
        row      = 1
        width    = 6
    }
    chart {
        chart_id = signalfx_time_chart.demo-dashboard-sample_4.id
        column   = 6
        height   = 1
        row      = 1
        width    = 6
    }
    chart {
        chart_id = signalfx_single_value_chart.demo-dashboard-sample_0.id
        column   = 0
        height   = 1
        row      = 0
        width    = 4
    }
    chart {
        chart_id = signalfx_time_chart.demo-dashboard-sample_9.id
        column   = 0
        height   = 1
        row      = 4
        width    = 6
    }
    chart {
        chart_id = signalfx_single_value_chart.demo-dashboard-sample_1.id
        column   = 4
        height   = 1
        row      = 0
        width    = 4
    }
    chart {
        chart_id = signalfx_list_chart.demo-dashboard-sample_2.id
        column   = 8
        height   = 1
        row      = 0
        width    = 4
    }
    chart {
        chart_id = signalfx_time_chart.demo-dashboard-sample_7.id
        column   = 0
        height   = 1
        row      = 3
        width    = 6
    }
    chart {
        chart_id = signalfx_time_chart.demo-dashboard-sample_8.id
        column   = 6
        height   = 2
        row      = 3
        width    = 6
    }
}

provider "signalfx" {
    auth_token="${var.signalfx_auth_token}"
    api_url = "https://api.us1.signalfx.com"
}
