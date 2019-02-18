include "roboy_indoor.lua"

TRAJECTORY_BUILDER.pure_localization = true
--TRAJECTORY_BUILDER.pure_localization_trimmer = {
--	max_submaps_to_keep = 3,
--}

POSE_GRAPH.global_constraint_search_after_n_seconds = 0

POSE_GRAPH.global_sampling_ratio = 0.001
POSE_GRAPH.constraint_builder.sampling_ratio = 0.1

POSE_GRAPH.constraint_builder.global_localization_min_score = 0.4
--POSE_GRAPH.constraint_builder.min_score = 0.5


-- global_sampling_ratio

POSE_GRAPH.constraint_builder.max_constraint_distance = 5
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher.linear_search_window = 10
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher.angular_search_window = math.rad(20.0)

POSE_GRAPH.optimize_every_n_nodes = 5
POSE_GRAPH.max_num_final_iterations = 1

return options
