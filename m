From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 00/11] Add throttler driver for non-thermal throttling
Date: Thu,  7 Jun 2018 11:12:03 -0700
Message-ID: <20180607181214.30338-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

This series adds the throttler driver, for non-thermal throttling of
CPUs and devfreq devices. A use case for non-thermal throttling could
be the detection of a high battery discharge voltage, close to the
over-current protection (OCP) limit of the battery.

To support throttling of devfreq devices the series introduces the
concept of a devfreq policy and the DEVFREQ_ADJUST notifier (similar
to CPUFREQ_ADJUST). Further it includes some related devfreq bugfixes
and improvements that change some of the code that is also touched
by the policy changes.

Matthias Kaehlcke (11):
  PM / devfreq: Init user limits from OPP limits, not viceversa
  PM / devfreq: Fix handling of min/max_freq == 0
  PM / devfreq: Don't adjust to user limits in governors
  PM / devfreq: Add struct devfreq_policy
  PM / devfreg: Add support for policy notifiers
  PM / devfreq: Make update_devfreq() public
  PM / devfreq: export devfreq_class
  dt-bindings: PM / OPP: add opp-throttlers property
  misc: throttler: Add core support for non-thermal throttling
  dt-bindings: misc: add bindings for cros_ec_throttler
  misc: throttler: Add Chrome OS EC throttler

 .../bindings/misc/cros_ec_throttler.txt       |   4 +
 Documentation/devicetree/bindings/opp/opp.txt |   3 +
 MAINTAINERS                                   |   7 +
 drivers/devfreq/devfreq.c                     | 222 +++---
 drivers/devfreq/governor.h                    |   6 +-
 drivers/devfreq/governor_passive.c            |   4 +-
 drivers/devfreq/governor_performance.c        |   5 +-
 drivers/devfreq/governor_powersave.c          |   2 +-
 drivers/devfreq/governor_simpleondemand.c     |  12 +-
 drivers/devfreq/governor_userspace.c          |  16 +-
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/throttler/Kconfig                |  28 +
 drivers/misc/throttler/Makefile               |   2 +
 drivers/misc/throttler/core.c                 | 642 ++++++++++++++++++
 drivers/misc/throttler/cros_ec_throttler.c    | 116 ++++
 include/linux/devfreq.h                       | 113 ++-
 include/linux/throttler.h                     |  11 +
 18 files changed, 1070 insertions(+), 125 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/cros_ec_throttler.txt
 create mode 100644 drivers/misc/throttler/Kconfig
 create mode 100644 drivers/misc/throttler/Makefile
 create mode 100644 drivers/misc/throttler/core.c
 create mode 100644 drivers/misc/throttler/cros_ec_throttler.c
 create mode 100644 include/linux/throttler.h

-- 
2.18.0.rc1.242.g61856ae69a-goog
