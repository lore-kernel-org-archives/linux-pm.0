From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] suspend: add initcall_debug style timing for
	suspend/resume
Date: Sat, 12 Dec 2009 19:29:06 +0100
Message-ID: <200912121929.06330.rjw@sisk.pl>
References: <20091206123552.7be316b2@infradead.org>
	<200912121927.55186.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912121927.55186.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 12 December 2009, Rafael J. Wysocki wrote:
> On Sunday 06 December 2009, Arjan van de Ven wrote:
> > 
> > From fcd52b97aa02f19baa570e4a62dfdfab0faed976 Mon Sep 17 00:00:00 2001
> > From: Arjan van de Ven <arjan@linux.intel.com>
> > Date: Sun, 6 Dec 2009 12:32:28 -0800
> > Subject: [PATCH] suspend: add initcall_debug style timing for suspend/resume
> > 
> > In order to diagnose overall suspend/resume times, we need
> > basic instrumentation to break down the total time into per
> > device timing, similar to initcall_debug.
> > 
> > This patch adds the basic timing instrumentation, needed
> > for a scritps/bootgraph.pl equivalent or humans.
> > The bootgraph.pl program is still a work in progress, but
> > is far enough along to know that this patch is sufficient.
> > 
> > Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> > ---
> >  drivers/base/power/main.c |   29 +++++++++++++++++++++++++++++
> >  include/linux/init.h      |    2 ++
> >  2 files changed, 31 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 8aa2443..2ad345c 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/resume-trace.h>
> >  #include <linux/rwsem.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/sched.h>
> >  
> >  #include "../base.h"
> >  #include "power.h"
> > @@ -172,6 +173,12 @@ static int pm_op(struct device *dev,
> >  		 pm_message_t state)
> >  {
> >  	int error = 0;
> > +	ktime_t calltime, delta, rettime;
> > +
> > +	if (initcall_debug) {
> > +		printk("calling  %s+ @ %i\n", dev_name(dev), task_pid_nr(current));
> > +		calltime = ktime_get();
> > +	}
> >  
> >  	switch (state.event) {
> >  #ifdef CONFIG_SUSPEND
> > @@ -219,6 +226,14 @@ static int pm_op(struct device *dev,
> >  	default:
> >  		error = -EINVAL;
> >  	}
> > +
> > +	if (initcall_debug) {
> > +		rettime = ktime_get();
> > +		delta = ktime_sub(rettime, calltime);
> > +		printk("initcall %s+ returned %d after %Ld usecs\n", dev_name(dev),
> > +			error, (unsigned long long) ktime_to_ns(delta) >> 10);
> 
> I've changed that "initcall" to "call".  Hopefully that won't break your scripts. ;-)

In addition to that I've changed printk to pr_infor everywhere in the patch,
is that fine with you?

Rafael
