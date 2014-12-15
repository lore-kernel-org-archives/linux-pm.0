From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v2 0/3] devfreq: exynos: Add driver for Exynos3250
Date: Mon, 15 Dec 2014 15:56:50 +0100
Message-ID: <1418655413-25410-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi,


Changes since v1
================
1. Patch 1/3, bindings: fixes after review from Mark Rutland.
2. Patch 2/3, driver: update perf benchmarks.
3. Rebase on Chanwoo's devfreq-event class patches v3 [1].


Description
===========
The aim of patchset is to gather feedback about adding new devfreq driver for
Exynos 3250, along with the bindings.

The patchset uses devfreq-event class posted recently [1].

Chanwoo,
You were the author of our initial exynos3_bus.c driver so do you
want me to add your Signed-off-by?

[1] [RFC PATCHv3 0/7] devfreq: Add devfreq-event class to provide
    raw data for devfreq device
    https://lkml.org/lkml/2014/12/12/219


Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  devfreq: dt-bindings: Document bindings for Exynos3250 bus DVFS driver
  devfreq: exynos: Add driver for Exynos3250
  ARM: dts: Add devfreq to Exynos3250 and Rinato board

 .../bindings/arm/samsung/exynos3250-devfreq.txt    |  62 ++
 arch/arm/boot/dts/exynos3250-rinato.dts            |  12 +
 arch/arm/boot/dts/exynos3250.dtsi                  |  26 +
 drivers/devfreq/Kconfig                            |  12 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/exynos/Makefile                    |   1 +
 drivers/devfreq/exynos/exynos3_bus.c               | 847 +++++++++++++++++++++
 7 files changed, 961 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos3250-devfreq.txt
 create mode 100644 drivers/devfreq/exynos/exynos3_bus.c

-- 
1.9.1
