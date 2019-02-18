include "roboy_indoor.lua"

TRAJECTORY_BUILDER.pure_localization = true
--TRAJECTORY_BUILDER.pure_localization_trimmer = {
--	max_submaps_to_keep = 3,
--}

TRAJECTORY_BUILDER_2D.submaps.num_range_data = 12

POSE_GRAPH.constraint_builder.sampling_ratio = 1
POSE_GRAPH.constraint_builder.global_localization_min_score = 0.55
--POSE_GRAPH.constraint_builder.min_score = 0.55


-- global_sampling_ratio

POSE_GRAPH.constraint_builder.max_constraint_distance = 15
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher.linear_search_window = 25
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher.angular_search_window = math.rad(45.0)

POSE_GRAPH.optimize_every_n_nodes = 1
POSE_GRAPH.max_num_final_iterations = 1

return options
