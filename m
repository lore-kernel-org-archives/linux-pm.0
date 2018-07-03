From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 00/12] Add throttler driver for non-thermal throttling
Date: Tue,  3 Jul 2018 16:46:53 -0700
Message-ID: <20180703234705.227473-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

This series adds the throttler driver, for non-thermal throttling of
CPUs and devfreq devices. A use case for non-thermal throttling could
be the detection of a high battery discharge current, close to the
over-current protection (OCP) limit of the battery.

To support throttling of devfreq devices the series introduces the
concept of a devfreq policy and the DEVFREQ_ADJUST notifier (similar
to CPUFREQ_ADJUST). Further it includes some related devfreq bugfixes
and improvements that change some of the code that is also touched
by the policy changes.

Matthias Kaehlcke (12):
  PM / devfreq: Init user limits from OPP limits, not viceversa
  PM / devfreq: Fix handling of min/max_freq == 0
  PM / devfreq: Don't adjust to user limits in governors
  PM / devfreq: Add struct devfreq_policy
  PM / devfreq: Add support for policy notifiers
  PM / devfreq: Make update_devfreq() public
  PM / devfreq: export devfreq_class
  cpufreq: Add stub for cpufreq_update_policy()
  dt-bindings: misc: add bindings for throttler
  misc: throttler: Add core support for non-thermal throttling
  misc: throttler: Add Chrome OS EC throttler
  mfd: cros_ec: Add throttler sub-device

 .../devicetree/bindings/misc/throttler.txt    |  13 +
 MAINTAINERS                                   |   7 +
 drivers/devfreq/devfreq.c                     | 222 +++---
 drivers/devfreq/governor.h                    |   6 +-
 drivers/devfreq/governor_passive.c            |   4 +-
 drivers/devfreq/governor_performance.c        |   5 +-
 drivers/devfreq/governor_powersave.c          |   2 +-
 drivers/devfreq/governor_simpleondemand.c     |  12 +-
 drivers/devfreq/governor_userspace.c          |  16 +-
 drivers/mfd/cros_ec_dev.c                     |  19 +
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/throttler/Kconfig                |  33 +
 drivers/misc/throttler/Makefile               |   2 +
 drivers/misc/throttler/core.c                 | 697 ++++++++++++++++++
 drivers/misc/throttler/cros_ec_throttler.c    | 111 +++
 include/linux/cpufreq.h                       |   1 +
 include/linux/devfreq.h                       | 113 ++-
 include/linux/throttler.h                     |  21 +
 19 files changed, 1161 insertions(+), 125 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/throttler.txt
 create mode 100644 drivers/misc/throttler/Kconfig
 create mode 100644 drivers/misc/throttler/Makefile
 create mode 100644 drivers/misc/throttler/core.c
 create mode 100644 drivers/misc/throttler/cros_ec_throttler.c
 create mode 100644 include/linux/throttler.h

-- 
2.18.0.203.gfac676dfb9-goog
