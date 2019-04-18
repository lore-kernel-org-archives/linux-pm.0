From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 0/4] Exynos Performance Monitoring Counters enhancements
Date: Thu, 18 Apr 2019 15:38:28 +0200
Message-ID: <1555594712-18341-1-git-send-email-l.luba@partner.samsung.com>
References: <CGME20190418133849eucas1p11666819084daed6e9585a4f6faa124ed@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org, l.luba@partner.samsung.com, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi all,

This patch set extends PPMU on Samsung Exynos by choosing type of data
which shell be counter in the PPMU registers.
It is possible to count e.g. read or write requests, read or write data
or latency.
A new field has been added in the DT 'event' node called 'event-data-type'.
It is them used during the setup of the counter. In the prevoius
implementation there was always one option used: count read+write data.
Sometimes we need more precised information and this patch set tries to
address it.

Changes:
v2:
 - removed new entry in MAINTAINERS file as suggested by Bartek Zolnierkiewicz
   and added new file to existing list for devfreq events
 - added in the dt-bindings/pmu/exynos_ppmu.h 2 new entries for RO and WO for
   counters in Exynos5433
 - changed initialization with default values when data_type is not provided
   in DT (as sugessted by Chanwoo)
 - added 4th patch which adds 'event-data-type' to 'event' node for Exynos4412
   PPMU events (asked by Chanwoo)

Regards,
Lukasz Luba

Lukasz Luba (4):
  include: dt-bindings: add Performance Monitoring Unit for Exynos
  drivers: devfreq: events: extend events by type of counted data
  Documentation: devicetree: add PPMU events description
  DT: arm: exynos4412: add event data type which is monitored

 .../bindings/devfreq/event/exynos-ppmu.txt         | 18 +++++++
 MAINTAINERS                                        |  1 +
 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi      | 10 ++++
 drivers/devfreq/event/exynos-ppmu.c                | 61 +++++++++++++++-------
 include/dt-bindings/pmu/exynos_ppmu.h              | 26 +++++++++
 include/linux/devfreq-event.h                      |  6 +++
 6 files changed, 103 insertions(+), 19 deletions(-)
 create mode 100644 include/dt-bindings/pmu/exynos_ppmu.h

-- 
2.7.4
