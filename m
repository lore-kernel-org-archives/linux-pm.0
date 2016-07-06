From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/3] PM / Hibernate: Allow arch code to influence CPUs disabled during hibernate
Date: Wed, 06 Jul 2016 02:38:51 +0200
Message-ID: <54369969.i5TPzUzNII@vostro.rjw.lan>
References: <1467643950-11034-1-git-send-email-james.morse@arm.com> <1467643950-11034-2-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62587 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751157AbcGFAeQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2016 20:34:16 -0400
In-Reply-To: <1467643950-11034-2-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Pavel Machek <pavel@ucw.cz>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Chen Yu C <yu.c.chen@intel.com>

On Monday, July 04, 2016 03:52:28 PM James Morse wrote:
> Architecture code may need to do extra work when secondary CPUs are
> disabled during hibernate and resume. This may include pushing sleeping
> CPUs into a deeper power-saving state, or influencing which CPU resume
> occurs on.
> 
> Define a macro arch_hibernation_disable_cpus(), which defaults to
> calling disable_nonboot_cpus() if undefined. Architectures that
> need to do extra work around these calls can use this to influence
> the CPU down calls.
> The macros should be defined in asm/suspend.h, and
> ARCH_HIBERNATION_CPU_HOOKS should be added to Kconfig.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> ---
> Changes since v3:
>  * Changed kconfig name to CONFIG_ARCH_HIBERNATION_CPU_HOOKS
> 
> Changes since v2:
>  * Added CONFIG_ARCH_HIBERNATION_CPUHP include guard allowing
>  * Switch to macro approach.
> 
>  kernel/power/hibernate.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index fca9254280ee..855a3a2374c8 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -31,8 +31,16 @@
>  #include <linux/ktime.h>
>  #include <trace/events/power.h>
>  
> +#ifdef CONFIG_ARCH_HIBERNATION_CPU_HOOKS
> +/* Arch definition of the arch_hibernation_disable_cpus() macros? */
> +#include <asm/suspend.h>
> +#endif
> +
>  #include "power.h"
>  
> +#ifndef arch_hibernation_disable_cpus
> +#define arch_hibernation_disable_cpus(x) disable_nonboot_cpus()
> +#endif
>  
>  static int nocompress;
>  static int noresume;
> @@ -279,7 +287,7 @@ static int create_image(int platform_mode)
>  	if (error || hibernation_test(TEST_PLATFORM))
>  		goto Platform_finish;
>  
> -	error = disable_nonboot_cpus();
> +	error = arch_hibernation_disable_cpus(true);
>  	if (error || hibernation_test(TEST_CPUS))
>  		goto Enable_cpus;
>  
> @@ -433,7 +441,7 @@ static int resume_target_kernel(bool platform_mode)
>  	if (error)
>  		goto Cleanup;
>  
> -	error = disable_nonboot_cpus();
> +	error = arch_hibernation_disable_cpus(false);

Why "false"?

>  	if (error)
>  		goto Enable_cpus;
>  
> @@ -551,7 +559,7 @@ int hibernation_platform_enter(void)
>  	if (error)
>  		goto Platform_finish;
>  
> -	error = disable_nonboot_cpus();
> +	error = arch_hibernation_disable_cpus(true);

I have the same question about this hunk I had before.

Is it really necessary to do the arch thing here?

It shouldn't really matter AFAICS.

>  	if (error)
>  		goto Enable_cpus;

Thanks,
Rafael

