From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: Delays, clocks, timers, hrtimers, etc
Date: Wed, 11 Feb 2015 10:45:15 -0800
Message-ID: <20150211184515.GB11190@codeaurora.org>
References: <54C8E125.3070905@free.fr>
 <e028a4eb604a491f4438557f4a1373ef@agner.ch>
 <54D52F84.9050600@free.fr>
 <266c7b1ff2d1a8ba0ae4866f4fb4eca5@agner.ch>
 <54D576B1.4000001@free.fr>
 <54D903F6.3050608@codeaurora.org>
 <54D93556.9050008@free.fr>
 <54D93FFA.3090506@codeaurora.org>
 <54D947B4.4080401@free.fr>
 <54DB94B0.8020000@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54DB94B0.8020000@free.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Mason <mpeg.blue@free.fr>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, cpufreq <cpufreq@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Stefan Agner <stefan@agner.ch>, Shawn Guo <shawn.guo@linaro.org>, Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 02/11, Mason wrote:
> Mason wrote:
> 
> 
> Also, you wrote "I don't see any problem with the TWD dropping the
> dependency on SMP." Would something as simple as this be acceptable?
> (Most probably NOT; there are a lot of smp* occurrences in smp_twd.c
> even the file name.) What is the rationale for the dependency?
> 
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a34698d..47b02c8 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1565,7 +1565,6 @@ config HAVE_ARM_ARCH_TIMER
>  config HAVE_ARM_TWD
>         bool
> -       depends on SMP
>         select CLKSRC_OF if OF
>         help
>           This options enables support for the ARM timer and watchdog unit
> 

Hmm it looks like we would also need to add this to the patch. It
looks like a holdover from when the local timer APIs were around.
Back then twd_local_timer_common_register() would fail if
is_smp() was false or setup_max_cpus was 0. Now it will just
register a clockevent that may or may not be used depending on
what other clockevents are in the system and the ratings of those
other clockevents.

----8<----
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 172c6a05d27f..e8f6d241881f 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -23,7 +23,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 
-#include <asm/smp_plat.h>
 #include <asm/smp_twd.h>
 
 /* set up by the platform code */
@@ -388,9 +387,6 @@ static void __init twd_local_timer_of_register(struct device_node *np)
 {
 	int err;
 
-	if (!is_smp() || !setup_max_cpus)
-		return;
-
 	twd_ppi = irq_of_parse_and_map(np, 0);
 	if (!twd_ppi) {
 		err = -EINVAL;


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
