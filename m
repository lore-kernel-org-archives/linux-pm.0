From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 0/3] Exynos Performance Monitoring Counters enhancements
Date: Wed, 17 Apr 2019 09:48:05 +0200
Message-ID: <1555487288-4777-1-git-send-email-l.luba@partner.samsung.com>
References: <CGME20190417074829eucas1p234e664f9bf295eca8d2fad6ba953f37c@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org, l.luba@partner.samsung.com
List-Id: linux-pm@vger.kernel.org

Hi all,

This patch set extends PPMU on Samsung Exynos by choosing type of data
which shell be counter in the PPMU registers.
It is possible to count e.g. read or write requests, read or write data.
A new field has been added in the DT 'event' node called 'event-data-type'.
It is them used during the setup of the counter. In the prevoius
implementation there was always one option used: count read+write data.
Sometimes we need more precised information and this patch set tries to
address it.

Regards,
Lukasz Luba

Lukasz Luba (3):
  include: dt-bindings: add Performance Monitoring Unit for Exynos
  drivers: devfreq: events: extend events by type of counted data
  Documentation: devicetree: add PPMU events description

 .../bindings/devfreq/event/exynos-ppmu.txt         | 18 ++++++++++
 MAINTAINERS                                        |  5 +++
 drivers/devfreq/event/exynos-ppmu.c                | 38 +++++++++++++++-------
 include/dt-bindings/pmu/exynos_ppmu.h              | 24 ++++++++++++++
 include/linux/devfreq-event.h                      |  6 ++++
 5 files changed, 79 insertions(+), 12 deletions(-)
 create mode 100644 include/dt-bindings/pmu/exynos_ppmu.h

-- 
2.7.4
