From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH] PM: Fix crash on graph trace through x86 suspend
Date: Wed, 02 Mar 2016 16:43:32 -0800
Message-ID: <1456965812.5488.4.camel@linux.intel.com>
References: <1456963529-4962-1-git-send-email-todd.e.brandt@linux.intel.com>
	 <CAJZ5v0gX+FEHryK=dJvQ1kXO19Addk5nr4jid012CpZzVdE_tA@mail.gmail.com>
Reply-To: todd.e.brandt@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33000 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755079AbcCCAne (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 2 Mar 2016 19:43:34 -0500
In-Reply-To: <CAJZ5v0gX+FEHryK=dJvQ1kXO19Addk5nr4jid012CpZzVdE_tA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, todd.e.brandt@intel.com

On Thu, 2016-03-03 at 01:19 +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 3, 2016 at 1:05 AM, Todd Brandt
> <todd.e.brandt@linux.intel.com> wrote:
> > Pause/unpause graph tracing around do_suspend_lowlevel as it has
> > inconsistent call/return info after it jumps to the wakeup vector.
> > The graph trace buffer will otherwise become misaligned and
> > may eventually crash and hang on suspend.
> >
> > To reproduce the issue and test the fix:
> > Run a function_graph trace over suspend/resume and set the graph
> > function to suspend_devices_and_enter. This consistently hangs the
> > system without this fix.
> >
> > Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> 
> OK
> 
> I guess we'll need that in -stable, right?

Sure, it's pretty important. The new analyze_suspend features are going
to rely pretty heavily on full graph trace of suspend (all we can do is
standby and freeze now because of the bug). Thanks!

> 
> > ---
> >  arch/x86/kernel/acpi/sleep.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
> > index d1daead..311360e 100644
> > --- a/arch/x86/kernel/acpi/sleep.c
> > +++ b/arch/x86/kernel/acpi/sleep.c
> > @@ -16,6 +16,7 @@
> >  #include <asm/cacheflush.h>
> >  #include <asm/realmode.h>
> >
> > +#include <linux/ftrace.h>
> >  #include "../../realmode/rm/wakeup.h"
> >  #include "sleep.h"
> >
> > @@ -107,7 +108,13 @@ int x86_acpi_suspend_lowlevel(void)
> >         saved_magic = 0x123456789abcdef0L;
> >  #endif /* CONFIG_64BIT */
> >
> > +       /*
> > +        * Pause/unpause graph tracing around do_suspend_lowlevel as it has
> > +        * inconsistent call/return info after it jumps to the wakeup vector
> > +        */
> > +       pause_graph_tracing();
> >         do_suspend_lowlevel();
> > +       unpause_graph_tracing();
> >         return 0;
> >  }
> >
> > --
> > 2.1.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html


