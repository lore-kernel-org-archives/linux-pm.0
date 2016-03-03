From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] PM: Fix crash on graph trace through x86 suspend
Date: Wed, 2 Mar 2016 21:07:50 -0500
Message-ID: <20160302210750.147efd34@grimm.local.home>
References: <1456963529-4962-1-git-send-email-todd.e.brandt@linux.intel.com>
	<CAJZ5v0gX+FEHryK=dJvQ1kXO19Addk5nr4jid012CpZzVdE_tA@mail.gmail.com>
	<1456965812.5488.4.camel@linux.intel.com>
	<CAJZ5v0g2nwVO6=K=_=kJ83dCdA=A1V1fODfygFsrW3UxwjoMxw@mail.gmail.com>
	<CAJZ5v0g9uy=Ne5-+dKEphyhF6tZP-sVeKaPeE7utCOK27Xnxag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g9uy=Ne5-+dKEphyhF6tZP-sVeKaPeE7utCOK27Xnxag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Todd Brandt <todd.e.brandt@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, todd.e.brandt@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, x86@kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 3 Mar 2016 02:36:26 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> > OK, applied, but let Steven and the x86 folks see it.

The below patch looks fine to me. Anything else I should look at?

-- Steve

> >  
> >>>  
> >>> > ---
> >>> >  arch/x86/kernel/acpi/sleep.c | 7 +++++++
> >>> >  1 file changed, 7 insertions(+)
> >>> >
> >>> > diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
> >>> > index d1daead..311360e 100644
> >>> > --- a/arch/x86/kernel/acpi/sleep.c
> >>> > +++ b/arch/x86/kernel/acpi/sleep.c
> >>> > @@ -16,6 +16,7 @@
> >>> >  #include <asm/cacheflush.h>
> >>> >  #include <asm/realmode.h>
> >>> >
> >>> > +#include <linux/ftrace.h>
> >>> >  #include "../../realmode/rm/wakeup.h"
> >>> >  #include "sleep.h"
> >>> >
> >>> > @@ -107,7 +108,13 @@ int x86_acpi_suspend_lowlevel(void)
> >>> >         saved_magic = 0x123456789abcdef0L;
> >>> >  #endif /* CONFIG_64BIT */
> >>> >
> >>> > +       /*
> >>> > +        * Pause/unpause graph tracing around do_suspend_lowlevel as it has
> >>> > +        * inconsistent call/return info after it jumps to the wakeup vector
> >>> > +        */
> >>> > +       pause_graph_tracing();
> >>> >         do_suspend_lowlevel();
> >>> > +       unpause_graph_tracing();
> >>> >         return 0;
> >>> >  }
> >>> >
> >>> > --
> >>> > 2.1.4
> >>> >
> >>> > --  
> >
> >
> > Thanks,
> > Rafael  
