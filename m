From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 5/7] PM / Hibernate: Allow arch code to influence CPU
 hotplug during hibernate
Date: Wed, 29 Jun 2016 02:10:56 +0200
Message-ID: <7811260.OWJXivZiAP@vostro.rjw.lan>
References: <1467125510-18758-1-git-send-email-james.morse@arm.com>
 <1467125510-18758-6-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467125510-18758-6-git-send-email-james.morse@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Chen Yu C <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 28, 2016 03:51:48 PM James Morse wrote:
> Architecture code may need to do extra work when secondary CPUs are
> disabled during hibernate and resume. This may include pushing sleeping
> CPUs into a deeper power-saving state, or influencing which CPU resume
> occurs on.
> 
> Define a macro arch_hibernation_disable_cpus(), which defaults to calling
> disable_nonboot_cpus() if undefined. Architectures that need to do extra
> work around these calls can use this to influence disable_nonboot_cpus()
> behaviour. The macro should be defined in asm/suspend.h, and
> ARCH_HIBERNATION_CPUHP should be added to Kconfig.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>

As you noted, this could be used to address the x86 issue that Yu is working on,
so I'd like it to go in as the first patch in the series and through the PM tree.

A couple of nits below. 

> ---
> Changes since v2:
>  * Added CONFIG_ARCH_HIBERNATION_CPUHP include guard allowing

What about calling it CONFIG_ARCH_HIBERNATION_CPU_OFFLINE?  It's not
hotplug really.

>  * Switch to macro approach.
> 
>  kernel/power/hibernate.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index fca9254280ee..338745e78f7e 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -31,8 +31,16 @@
>  #include <linux/ktime.h>
>  #include <trace/events/power.h>
>  
> +#ifdef CONFIG_ARCH_HIBERNATION_CPUHP
> +/* Arch definition of the arch_hibernation_disable_cpus() macro? */
> +#include <asm/suspend.h>
> +#endif
> +
>  #include "power.h"
>  
> +#ifndef arch_hibernation_disable_cpus
> +#define arch_hibernation_disable_cpus(x) disable_nonboot_cpus()

For the x86 case we'll also need the complementary "enable", so why don't
you add it here and then use it instead of the enable_nonboot_cpus()?

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
>  	if (error)
>  		goto Enable_cpus;
>  
> @@ -551,7 +559,7 @@ int hibernation_platform_enter(void)
>  	if (error)
>  		goto Platform_finish;
>  
> -	error = disable_nonboot_cpus();
> +	error = arch_hibernation_disable_cpus(true);

Does this one here actually matter?

>  	if (error)
>  		goto Enable_cpus;
>  
> 

Thanks,
Rafael
