From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 1/2] PPC: powernv: remove redundant cpuidle_idle_call()
Date: Fri, 7 Feb 2014 01:17:57 +0000 (GMT)
Message-ID: <alpine.LFD.2.11.1402070105170.1906@knanqh.ubzr>
References: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
 <CAKnoXLxCAqKaniGOwegNcOarS4FpoNKDY5PxOhe6j4wdtUAkLQ@mail.gmail.com>
 <52F3BCFE.3010703@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <52F3BCFE.3010703@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Linux ARM Kernel ML <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 6 Feb 2014, Preeti U Murthy wrote:

> Hi Daniel,
> 
> On 02/06/2014 09:55 PM, Daniel Lezcano wrote:
> > Hi Nico,
> > 
> > 
> > On 6 February 2014 14:16, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > 
> >> The core idle loop now takes care of it.
> >>
> >> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> >> ---
> >>  arch/powerpc/platforms/powernv/setup.c | 13 +------------
> >>  1 file changed, 1 insertion(+), 12 deletions(-)
> >>
> >> diff --git a/arch/powerpc/platforms/powernv/setup.c
> >> b/arch/powerpc/platforms/powernv/setup.c
> >> index 21166f65c9..a932feb290 100644
> >> --- a/arch/powerpc/platforms/powernv/setup.c
> >> +++ b/arch/powerpc/platforms/powernv/setup.c
> >> @@ -26,7 +26,6 @@
> >>  #include <linux/of_fdt.h>
> >>  #include <linux/interrupt.h>
> >>  #include <linux/bug.h>
> >> -#include <linux/cpuidle.h>
> >>
> >>  #include <asm/machdep.h>
> >>  #include <asm/firmware.h>
> >> @@ -217,16 +216,6 @@ static int __init pnv_probe(void)
> >>         return 1;
> >>  }
> >>
> >> -void powernv_idle(void)
> >> -{
> >> -       /* Hook to cpuidle framework if available, else
> >> -        * call on default platform idle code
> >> -        */
> >> -       if (cpuidle_idle_call()) {
> >> -               power7_idle();
> >> -       }
> >>
> > 
> > The cpuidle_idle_call is called from arch_cpu_idle in
> > arch/powerpc/kernel/idle.c between a ppc64_runlatch_off|on section.
> > Shouldn't the cpuidle-powernv driver call these functions when entering
> > idle ?
> 
> Yes they should, I will send out a patch that does that ontop of this.
> There have been cpuidle driver cleanups for powernv and pseries in this
> merge window. While no change would be required in the pseries cpuidle
> driver as a result of Nicolas's cleanup, we would need to add the
> ppc64_runlatch_on and off functions before and after the entry into the
> powernv idle states.

What about creating arch_cpu_idle_enter() and arch_cpu_idle_exit() in 
arch/powerpc/kernel/idle.c and calling ppc64_runlatch_off() and 
ppc64_runlatch_on() respectively from there instead?  Would that work?  
That would make the idle consolidation much easier afterwards.


Nicolas
