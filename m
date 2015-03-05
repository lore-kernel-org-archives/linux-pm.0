From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC/PATCH 4/6] ARM: shmobile: r8a7791: Add Core-Standby CPUIdle
 support for r8a7791
Date: Thu, 5 Mar 2015 09:29:31 +0900
Message-ID: <20150305002931.GB4558@verge.net.au>
References: <1425444946-3084-1-git-send-email-keita.kobayashi.ym@renesas.com>
 <1425444946-3084-5-git-send-email-keita.kobayashi.ym@renesas.com>
 <CAKDJKT6vx8xhHtxCerXen0NqRao5d5hzZdj8LtSJ4hiMjhZXdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKDJKT6vx8xhHtxCerXen0NqRao5d5hzZdj8LtSJ4hiMjhZXdA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Manish Badarkhe <badarkhe.manish@gmail.com>
Cc: Keita Kobayashi <keita.kobayashi.ym@renesas.com>, rjw@rjwysocki.net, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 04, 2015 at 11:03:03AM +0530, Manish Badarkhe wrote:
> Hi,
> 
> On Wed, Mar 4, 2015 at 10:25 AM, Keita Kobayashi <
> keita.kobayashi.ym@renesas.com> wrote:
> 
> > This patch Add the wfi and Core-Standby for CPUIdle power states
> > support for the r8a7791 SoC.
> >
> > Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
> > ---
> >  arch/arm/mach-shmobile/pm-r8a7791.c | 41
> > +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/arch/arm/mach-shmobile/pm-r8a7791.c
> > b/arch/arm/mach-shmobile/pm-r8a7791.c
> > index 25f107b..6c00d37 100644
> > --- a/arch/arm/mach-shmobile/pm-r8a7791.c
> > +++ b/arch/arm/mach-shmobile/pm-r8a7791.c
> > @@ -10,8 +10,13 @@
> >   * for more details.
> >   */
> >
> > +#include <linux/cpuidle.h>
> >  #include <linux/kernel.h>
> >  #include <linux/smp.h>
> > +#include <linux/platform_data/renesas-cpuidle.h>
> > +#include <linux/pm.h>
> > +#include <asm/cpuidle.h>
> > +#include <asm/cputype.h>
> >  #include <asm/io.h>
> >  #include "common.h"
> >  #include "pm-rcar.h"
> > @@ -43,6 +48,41 @@ static inline void r8a7791_sysc_init(void) {}
> >
> >  #endif /* CONFIG_SMP */
> >
> > +#ifdef CONFIG_ARM_RENESAS_CPUIDLE
> > +static struct cpuidle_driver r8a7791_cpuidle_driver = {
> > +       .name = "rcar_r8a7791_cpuidle",
> > +       .owner = THIS_MODULE,
> > +       .states = {
> > +               [0] = ARM_CPUIDLE_WFI_STATE,
> > +               [1] = {
> > +                       .name = "Core-Standby",
> > +                       .desc = "Core Standby Mode",
> > +                       .exit_latency = 2800,
> > +                       .target_residency = 2800,
> > +                       .enter = shmobile_smp_apmu_enter_cpuidle,
> > +               },
> > +       },
> > +       .state_count = 2,
> > +};
> > +
> > +static struct renesas_cpuidle_driver r8a7791_cpuidle = {
> > +       .target_cpu     = ARM_CPU_PART_CORTEX_A15,
> > +       .renesas_drv    = &r8a7791_cpuidle_driver,
> > +};
> > +
> > +static struct renesas_cpuidle r8a7791_data = {
> > +       .num_drvs       = 1,
> > +       .rcd            = &r8a7791_cpuidle,
> > +};
> > +
> > +static void __init r8a7791_cpuidle_init(void)
> > +{
> > +       shmobile_cpuidle_set_driver(&r8a7791_data);
> > +}
> > +#else
> > +static void __init r8a7791_cpuidle_init(void) {}
> > +#endif
> >
> 
> You can use 'IS_ENABLED' instead of this '#ifdef' during calling of
> function 'r8a7791_cpuidle_init' to avoid empty function in '#else' part
> of the code.
> 
> May be it is possible to replace all '#ifdef' with 'IS_ENABLED' call
> in this file and also rest of patches in this series.

Kobayashi-san,

it seems likely that Manish's suggestion will likely lead
to cleaner code. Could you look into it?
