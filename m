From: Vince Hsu <vinceh@nvidia.com>
Subject: [PATCH v2 16/17] ARM: tegra: select PM_GENERIC_DOMAINS
Date: Thu, 12 Mar 2015 20:15:17 +0800
Message-ID: <1426162518-7405-17-git-send-email-vinceh@nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, pdeschrijver@nvidia.com, swarren@wwwdotorg.org, gnurou@gmail.com, jroedel@suse.de, p.zabel@pengutronix.de, mturquette@linaro.org, pgaikwad@nvidia.com, sboyd@codeaurora.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tbergstrom@nvidia.com, airlied@linux.ie, bhelgaas@google.com, tj@kernel.org, arnd@arndb.de, robh@kernel.org, will.deacon@arm.com
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, Vince Hsu <vinceh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

We have added generic power domain support for Tegra SoCs. So now the option
PM_GENERIC_DOMAINS must be enabled by default to have proper power sequence.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 5d1a318f1302..193d5b2da8ba 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -8,6 +8,7 @@ menuconfig ARCH_TEGRA
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select PINCTRL
+	select PM_GENERIC_DOMAINS if PM
 	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
 	select SOC_BUS
-- 
2.1.4
