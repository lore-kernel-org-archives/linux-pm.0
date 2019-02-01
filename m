From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v4 8/8] ARM: exynos_defconfig: enable DMC driver
Date: Fri,  1 Feb 2019 17:46:52 +0100
Message-ID: <1549039612-28905-9-git-send-email-l.luba@partner.samsung.com>
References: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190201164723eucas1p1ec009489584e1c85fd0d62270796e003@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>, Russell King <linux@armlinux.org.uk>, Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Enable driver for Dynamic Memory Controller dynamic frequency and
voltage scaling in Exynos5422 SoCs.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index d635edf..b5dddcc 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -291,6 +291,7 @@ CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
 CONFIG_DEVFREQ_GOV_USERSPACE=y
 CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
+CONFIG_ARM_EXYNOS5422_DMC_DEVFREQ=y
 CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
 CONFIG_EXYNOS_IOMMU=y
 CONFIG_EXTCON=y
-- 
2.7.4
