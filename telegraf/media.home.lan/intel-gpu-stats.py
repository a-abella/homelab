#!/usr/bin/env python3

"""
This script gets run by the Docker host cron (_not_ inside telegraf container),
and outputs json to be consumed by telegraf. Cron redirects the json to the
`telegraf/custom-metrics` directory which gets mounted into telegraf
"""

import json
import subprocess

#output = subprocess.run(["timeout", "--preserve-status", "--foreground", "0.25", "intel_gpu_top", "-J"], capture_output=True, text=True)
output = subprocess.run(["timeout", "--preserve-status", "--foreground", "1", "intel_gpu_top", "-s", "499", "-J"], capture_output=True, text=True)

out_dict = json.loads(f"[{output.stdout}]")[-1]["engines"]
points = []

for metric, stats in out_dict.items():
  gpu_id = metric[-1]
  metric_name = metric[:-2].lower()
  j_frame = {
              "gpu": gpu_id,
              "engine": metric_name,
              "metrics": {}
            }
  for stat, value in stats.items():
    if stat != "unit":
        j_frame["metrics"][f"{stat}_percent"] = value

  points.append(j_frame)

print(json.dumps(points, indent=2))
