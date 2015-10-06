From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [RFC 1/7] arm64: pm/domains: try mutualize CPU domains init
 between arm/arm64
Date: Mon, 5 Oct 2015 20:27:02 -0600
Message-ID: <20151006022702.GA78570@linaro.org>
References: <1443186249-14596-1-git-send-email-mtitinger+renesas@baylibre.com>
 <1443186249-14596-2-git-send-email-mtitinger+renesas@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34844 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbbJFC1H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2015 22:27:07 -0400
Received: by pacfv12 with SMTP id fv12so198177606pac.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2015 19:27:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1443186249-14596-2-git-send-email-mtitinger+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marc Titinger <mtitinger@baylibre.com>
Cc: khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ahaslam@baylibre.com, bcousson@baylibre.com

On Fri, Sep 25 2015 at 07:04 -0600, Marc Titinger wrote:
>From: Marc Titinger <mtitinger@baylibre.com>
>
>fake path to start testing, eventually move this out of /arch/.
>incidently enable PM_GENERIC_DOMAINS for VExpress.
>
In fact, this could be moved out of ARM. My last series moved it to
drivers/base/power/.

-- Lina

>Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
>---
> arch/arm/common/domains.c       | 4 ++--
> arch/arm64/Kconfig              | 1 +
> arch/arm64/include/asm/arm-pd.h | 1 +
> arch/arm64/kernel/Makefile      | 6 ++++++
> arch/arm64/kernel/domains.c     | 1 +
> 5 files changed, 11 insertions(+), 2 deletions(-)
> create mode 120000 arch/arm64/include/asm/arm-pd.h
> create mode 120000 arch/arm64/kernel/domains.c
>
>diff --git a/arch/arm/common/domains.c b/arch/arm/common/domains.c
>index d3207da..68908d4 100644
>--- a/arch/arm/common/domains.c
>+++ b/arch/arm/common/domains.c
>@@ -20,7 +20,7 @@
>
> #include <asm/arm-pd.h>
>
>-#define NAME_MAX 36
>+#define GENPD_NAME_MAX 36
>
> struct arm_pm_domain {
> 	struct generic_pm_domain genpd;
>@@ -182,7 +182,7 @@ static int __init arm_domain_init(void)
> 		}
>
> 		/* Initialize rest of CPU PM domain specifics */
>-		pd->genpd.name = kstrndup(np->name, NAME_MAX, GFP_KERNEL);
>+		pd->genpd.name = kstrndup(np->name, GENPD_NAME_MAX, GFP_KERNEL);
> 		pd->genpd.power_off = arm_pd_power_down;
> 		pd->genpd.power_on = arm_pd_power_up;
> 		pd->genpd.flags |= GENPD_FLAG_IRQ_SAFE;
>diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>index 7c55a63..d35f213 100644
>--- a/arch/arm64/Kconfig
>+++ b/arch/arm64/Kconfig
>@@ -250,6 +250,7 @@ config ARCH_VEXPRESS
> 	select COMMON_CLK_VERSATILE
> 	select POWER_RESET_VEXPRESS
> 	select VEXPRESS_CONFIG
>+	select PM_GENERIC_DOMAINS if PM
> 	help
> 	  This enables support for the ARMv8 software model (Versatile
> 	  Express).
>diff --git a/arch/arm64/include/asm/arm-pd.h b/arch/arm64/include/asm/arm-pd.h
>new file mode 120000
>index 0000000..ecc5437
>--- /dev/null
>+++ b/arch/arm64/include/asm/arm-pd.h
>@@ -0,0 +1 @@
>+../../../arm/include/asm/arm-pd.h
>\ No newline at end of file
>diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>index 426d076..4689565 100644
>--- a/arch/arm64/kernel/Makefile
>+++ b/arch/arm64/kernel/Makefile
>@@ -30,6 +30,12 @@ arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
> arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
> arm64-obj-$(CONFIG_CPU_PM)		+= sleep.o suspend.o
> arm64-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
>+
>+# CPU domains: try mutualize for arm/arm64 in a first step.
>+# Eventually make this more generic.
>+#
>+arm64-obj-$(CONFIG_PM_GENERIC_DOMAINS)	+= domains.o
>+
> arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
> arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
> arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
>diff --git a/arch/arm64/kernel/domains.c b/arch/arm64/kernel/domains.c
>new file mode 120000
>index 0000000..bf17c69
>--- /dev/null
>+++ b/arch/arm64/kernel/domains.c
>@@ -0,0 +1 @@
>+../../arm/common/domains.c
>\ No newline at end of file
>-- 
>1.9.1
>
