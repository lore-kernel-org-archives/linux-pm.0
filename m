From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC 0/3] devfreq: exynos: Add driver for Exynos3250
Date: Fri, 05 Dec 2014 17:46:25 +0100
Message-ID: <1417797988-29225-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:29124 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbaLEQqj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Dec 2014 11:46:39 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

Hi,

The aim of patchset is to gather feedback about adding new devfreq driver for
Exynos 3250, along with the bindings.

Chanwoo,
You were the author of our initial exynos3_bus.c driver so do you
want me to add your Signed-off-by?

Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  devfreq: dt-bindings: Document Exynos3250 devfreq driver
  devfreq: exynos: Add driver for Exynos3250
  ARM: dts: Add devfreq to Exynos3250 and Rinato board

 .../bindings/arm/samsung/exynos3250-devfreq.txt    |  66 ++
 arch/arm/boot/dts/exynos3250-rinato.dts            |  10 +
 arch/arm/boot/dts/exynos3250.dtsi                  |  32 +
 drivers/devfreq/Kconfig                            |  12 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/exynos/Makefile                    |   1 +
 drivers/devfreq/exynos/exynos3_bus.c               | 842 +++++++++++++++++++++
 7 files changed, 964 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos3250-devfreq.txt
 create mode 100644 drivers/devfreq/exynos/exynos3_bus.c

-- 
1.9.1

