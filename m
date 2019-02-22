From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v2 00/13] QorIQ TMU multi-sensor and HWMON support
Date: Fri, 22 Feb 2019 12:04:55 -0800
Message-ID: <20190222200508.26325-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Everyone:

This series contains patches adding support for HWMON integration, bug
fixes and general improvements (hopefully) for TMU driver I made while
working on it on i.MX8MQ.

Feedback is welcome!

Thanks,
Andrey Smirnov

Changes since [v1]

    - Rebased on "linus" branch of
      git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
      that included latest chagnes adding multi-sensors support

    - Dropped

	thermal: qoriq: Add support for multiple thremal sites
	thermal: qoriq: Be more strict when parsing
	thermal: qoriq: Simplify error handling in qoriq_tmu_get_sensor_id()

      since they are no longer relevant

    - Added

	thermal: qoriq: Don't store struct thermal_zone_device reference
	thermal: qoriq: Add local struct qoriq_sensor pointer
	thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
	thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly

      to simplify latest codebase

    - Changed "thermal: qoriq: Do not report invalid temperature
      reading" to use regmap_read_poll_timeout() to make sure that
      tmu_get_temp() waits for fist sample to be ready before
      reporting it. This case is triggered on my setup if
      qoriq_thermal is compiled as a module

[v1] lore.kernel.org/lkml/20190218191141.3729-1-andrew.smirnov@gmail.com


Andrey Smirnov (13):
  thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
  thermal: qoriq: Remove unnecessary DT node is NULL check
  thermal: qoriq: Add local struct device pointer
  thermal: qoriq: Don't store struct thermal_zone_device reference
  thermal: qoriq: Add local struct qoriq_sensor pointer
  thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
  thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
  thermal: qoriq: Pass data to qoriq_tmu_calibration() directly
  thermal: qoriq: Convert driver to use devm_ioremap()
  thermal: qoriq: Convert driver to use regmap API
  thermal: qoriq: Enable all sensors before registering them
  thermal: qoriq: Do not report invalid temperature reading
  thermal: qoriq: Add hwmon support

 drivers/thermal/qoriq_thermal.c | 274 ++++++++++++++++----------------
 drivers/thermal/thermal_hwmon.c |  28 ++++
 drivers/thermal/thermal_hwmon.h |   7 +
 3 files changed, 169 insertions(+), 140 deletions(-)

-- 
2.20.1
