From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 00/24] thermal: tsens: Refactor to use regmap_field
Date: Thu,  7 Feb 2019 16:19:18 +0530
Message-ID: <cover.1549525708.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Short term bandaid fixes to add support for more versions of the TSENS IP
is not proving to be very scalable. Here is a series to finally convert the
driver's core to use regmap_fields so that register addresses and bitfields
can be abstracted away from the code.

This series is posted as one to give a complete view of where I'm going
with this refactor. We can probably split it into smaller sets if required.
Currently it consists of the following parts:

- Patch 01-06: Style changes to make code easier to read (mostly naming
  related). This has no functional change in the driver, it is a series of
  search and replace operations. Ideally this will get merged first,
  otherwise everything else will become painful :-)

- Patch 07-09: Merge the 8916 and 8974 source files into a single one
  called v0_1.c denoting the version of the IP and open up more
  opportunities for reuse.

- Patch 10: This is the core patch that adds IP-specific data based on two
  data structures: tsens_features has bit flags to identify if a certain
  feature is available in a version or not and an array of reg_field
  pointers.

  regfield_ids list the important fields across IP versions and are used as
  an index.

  This patch converts over all platforms except 8960 which currently
  doesn't use DT data for tsens and has custom functions for everything. We
  will get to it eventually, but it's conversion is not a necessity for
  this series to be merged.

- Patch 11-16: Clean ups and new functionality based on regmap_field

- Patch 17-19: Refactor the get_temp routine. We expect to have a single
  get_temp routine once all the conversion is finished.

- Patch 20-23: Introduce qcs404 support using new regmap infrastructure.

Testing
-------

Since these changes affect every platform using TSENS, it should be
clarified that I have only been focussing on developing/testing this on
sdm845 and qcs404. I will test this more thoroughly on msm8916, msm8996,
msm8998 but it is still pending.

Future work
-----------

a. Get rid of get_temp_common in favour of get_temp_tsens_valid
b. irq support
c. Convert over 8960 to use regmap_field and as a result common functions

Regards,
Amit

Amit Kucheria (24):
  drivers: thermal: tsens: Document the data structures
  drivers: thermal: tsens: Rename tsens_data
  drivers: thermal: tsens: Rename tsens_device
  drivers: thermal: tsens: Rename variable tmdev
  drivers: thermal: tsens: Use consistent names for variables
  drivers: thermal: tsens: Function prototypes should have argument
    names
  drivers: thermal: tsens: Rename tsens-8916 to prepare to merge with
    tsens-8974
  drivers: thermal: tsens: Rename constants to prepare to merge with
    tsens-8974
  drivers: thermal: tsens: Merge tsens-8974 into tsens-v0_1
  drivers: thermal: tsens: Introduce reg_fields to deal with register
    description
  drivers: thermal: tsens: Save reference to the device pointer and use
    it
  drivers: thermal: tsens: Don't print error message on -EPROBE_DEFER
  drivers: thermal: tsens: Print IP version
  drivers: thermal: tsens: Add new operation to check if a sensor is
    enabled
  drivers: thermal: tsens: change data type for sensor IDs
  drivers: thermal: tsens: Introduce IP-specific max_sensor count
  drivers: thermal: tsens: simplify get_temp_tsens_v2 routine
  drivers: thermal: tsens: Move get_temp_tsens_v2 to allow sharing
  drivers: thermal: tsens: Common get_temp() learns to do ADC conversion
  dt: thermal: tsens: Add bindings for qcs404
  drivers: thermal: tsens: Add generic support for TSENS v1 IP
  arm64: dts: qcom: qcs404: Add tsens controller
  arm64: dts: qcom: qcs404: Add thermal zones for each sensor
  drivers: thermal: tsens: Move calibration constants to header file

 .../bindings/thermal/qcom-tsens.txt           |  14 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 263 ++++++++++++++++++
 drivers/thermal/qcom/Makefile                 |   4 +-
 drivers/thermal/qcom/tsens-8916.c             | 105 -------
 drivers/thermal/qcom/tsens-8960.c             |  84 +++---
 drivers/thermal/qcom/tsens-common.c           | 172 +++++++++---
 .../qcom/{tsens-8974.c => tsens-v0_1.c}       | 167 ++++++++++-
 drivers/thermal/qcom/tsens-v1.c               | 229 +++++++++++++++
 drivers/thermal/qcom/tsens-v2.c               | 148 ++++++----
 drivers/thermal/qcom/tsens.c                  | 100 ++++---
 drivers/thermal/qcom/tsens.h                  | 238 ++++++++++++++--
 11 files changed, 1191 insertions(+), 333 deletions(-)
 delete mode 100644 drivers/thermal/qcom/tsens-8916.c
 rename drivers/thermal/qcom/{tsens-8974.c => tsens-v0_1.c} (55%)
 create mode 100644 drivers/thermal/qcom/tsens-v1.c

-- 
2.17.1
