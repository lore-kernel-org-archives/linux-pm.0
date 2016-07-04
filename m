From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 5/7] PM / Hibernate: Allow arch code to influence CPU
 hotplug during hibernate
Date: Mon, 04 Jul 2016 14:04:53 +0200
Message-ID: <5024161.npQD1be5Q1@vostro.rjw.lan>
References: <1467125510-18758-1-git-send-email-james.morse@arm.com>
 <7811260.OWJXivZiAP@vostro.rjw.lan> <577A269A.6060307@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <577A269A.6060307@arm.com>
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

On Monday, July 04, 2016 10:04:26 AM James Morse wrote:
> Hi Rafael,
> 
> On 29/06/16 01:10, Rafael J. Wysocki wrote:
> > On Tuesday, June 28, 2016 03:51:48 PM James Morse wrote:
> >> Architecture code may need to do extra work when secondary CPUs are
> >> disabled during hibernate and resume. This may include pushing sleeping
> >> CPUs into a deeper power-saving state, or influencing which CPU resume
> >> occurs on.
> >>
> >> Define a macro arch_hibernation_disable_cpus(), which defaults to calling
> >> disable_nonboot_cpus() if undefined. Architectures that need to do extra
> >> work around these calls can use this to influence disable_nonboot_cpus()
> >> behaviour. The macro should be defined in asm/suspend.h, and
> >> ARCH_HIBERNATION_CPUHP should be added to Kconfig.
> 
> > As you noted, this could be used to address the x86 issue that Yu is working on,
> > so I'd like it to go in as the first patch in the series and through the PM tree.
> 
> Sure, I will split the series here, and group the later patches so there are no
> dependencies.
> 
> 
> > 
> >> ---
> >> Changes since v2:
> >>  * Added CONFIG_ARCH_HIBERNATION_CPUHP include guard allowing
> > 
> > What about calling it CONFIG_ARCH_HIBERNATION_CPU_OFFLINE?  It's not
> > hotplug really.
> 
> Even with the enable calls added? CONFIG_ARCH_HIBERNATION_CPU_HOOKS?

Fine by me. :-)

> >> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> >> index fca9254280ee..338745e78f7e 100644
> >> --- a/kernel/power/hibernate.c
> >> +++ b/kernel/power/hibernate.c
> >> @@ -31,8 +31,16 @@
> >>  #include <linux/ktime.h>
> >>  #include <trace/events/power.h>
> >>  
> >> +#ifdef CONFIG_ARCH_HIBERNATION_CPUHP
> >> +/* Arch definition of the arch_hibernation_disable_cpus() macro? */
> >> +#include <asm/suspend.h>
> >> +#endif
> >> +
> >>  #include "power.h"
> >>  
> >> +#ifndef arch_hibernation_disable_cpus
> >> +#define arch_hibernation_disable_cpus(x) disable_nonboot_cpus()
> > 
> > For the x86 case we'll also need the complementary "enable", so why don't
> > you add it here and then use it instead of the enable_nonboot_cpus()?
> 
> Done. I've added the 'in_suspend' argument so that it's symmetrical, this may be
> slightly different to the behaviour of your 'in_resume_hibernate' flag.

Well, it turns out that I was wrong, we don't need the "enable" thing, so
I guess it can stay the way it was.

Thanks,
Rafael
