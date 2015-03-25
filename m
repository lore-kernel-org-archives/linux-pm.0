From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 08/09] tick/xen: Provide and use tick_suspend_local() and tick_resume_local()
Date: Wed, 25 Mar 2015 21:57:18 +0100
Message-ID: <3797850.XzqKU1ZfKa@vostro.rjw.lan>
References: <20150216121435.203983131@infradead.org> <1698741.eezk9tnXtG@vostro.rjw.lan> <20150325201309.GR25884@l.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56614 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751797AbbCYUdQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2015 16:33:16 -0400
In-Reply-To: <20150325201309.GR25884@l.oracle.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, Linux PM list <linux-pm@vger.kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, David Vrabel <david.vrabel@citrix.com>

On Wednesday, March 25, 2015 04:13:09 PM Konrad Rzeszutek Wilk wrote:
> On Wed, Mar 25, 2015 at 01:11:04PM +0100, Rafael J. Wysocki wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > Xen calls on every cpu into tick_resume() which is just wrong.
> > tick_resume() is for the syscore global suspend/resume invocation.
> > What XEN really wants is a per cpu local resume function.
> > 
> > Provide a tick_resume_local() function and use it in XEN.
> > 
> > Also provide a complementary tick_suspend_local() and modify
> > tick_unfreeze() and tick_freeze(), respectively, to use the
> > new local tick resume/suspend functions.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: David Vrabel <david.vrabel@citrix.com>
> > [ rjw: Combined two patches, rebased, modified subject/changelog ]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  arch/x86/xen/suspend.c       |    2 -
> >  include/linux/tick.h         |    6 ++--
> >  kernel/time/tick-broadcast.c |   24 ++++++++++++------
> >  kernel/time/tick-common.c    |   57 +++++++++++++++++++++++++++++--------------
> >  kernel/time/tick-internal.h  |    8 ++++--
> >  5 files changed, 66 insertions(+), 31 deletions(-)
> > 
> > Index: linux-pm/arch/x86/xen/suspend.c
> > ===================================================================
> > --- linux-pm.orig/arch/x86/xen/suspend.c
> > +++ linux-pm/arch/x86/xen/suspend.c
> > @@ -85,7 +85,7 @@ static void xen_vcpu_notify_restore(void
> >  	if (smp_processor_id() == 0)
> >  		return;
> >  
> > -	tick_resume();
> > +	tick_resume_local();
> 
> I am looking at Linus's tree and I see:
> 
> 82 static void xen_vcpu_notify_restore(void *data)                                 
>  83 {                                                                               
>  84         unsigned long reason = (unsigned long)data;                             
>  85                                                                                 
>  86         /* Boot processor notified via generic timekeeping_resume() */          
>  87         if ( smp_processor_id() == 0)                                           
>  88                 return;                                                         
>  89                                                                                 
>  90         clockevents_notify(reason, NULL);                                       
>  91 }                             
> 
> So there must be another patch that altered the clockevents_notify?

Yes, there is.  It is the [06/09] in this series
(https://patchwork.kernel.org/patch/6090631/).

I should have CCed it to you too, sorry about that.

> Is there an git tree with all of these patches?

Not yet, but they all are in the linux-pm patchwork at

https://patchwork.kernel.org/project/linux-pm/list/

I can create a branch in the linux-pm.git tree for them if that helps,
please let me know.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
