From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 2/2] PM / sleep: don't suspend parent when async child
 suspend_{noirq,late} fails
Date: Mon, 31 Oct 2016 22:22:20 -0700
Message-ID: <20161101052217.GA132958@google.com>
References: <1476923170-111986-2-git-send-email-briannorris@chromium.org>
 <1477584334-39956-1-git-send-email-briannorris@chromium.org>
 <8017823.VJuZzSqtaY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8017823.VJuZzSqtaY@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, linux-pm@vger.kernel.org, Chuansheng Liu <chuansheng.liu@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Tue, Nov 01, 2016 at 05:25:39AM +0100, Rafael J. Wysocki wrote:
> On Thursday, October 27, 2016 09:05:34 AM Brian Norris wrote:
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index c58563581345..eaf6b53463a5 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -1040,6 +1040,9 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
> >  
> >  	dpm_wait_for_children(dev, async);
> >  
> > +	if (async_error)
> > +		goto Complete;
> > +
> 
> This is a second chech for async_error in this routine and is the first one
> really needed after adding this?

Maybe not? I confess I'm not 100% sure on all the reasons for the code
structure as-is, but it looks like we're trying to catch pending wakeups
early, and because that procedure utilizes 'async_error' to stash the
-EBUSY, it seemingly makes sense to check if it's non-zero before
overwriting it.

But then, that's all kind of racy, since there can be multiple writers
to that variable, no? So it can't matter *that* much if we clobber the
error, as long as we abort somewhere.

Anyway, maybe it's best if dpm_wait_for_children() just moves to be
first thing in this function (after the tracepoints). That seems just as
correct to me, and shouldn't waste any additional time suspending
devices for a failed system suspend attempt -- as long as we're still
catching wakeups before we suspend the current device. (That also
incidentally matches the structure of __device_suspend() more closely.
Why did this all get out of sync (pun unintended) when copied from the
suspend() to the suspend_{late,noirq}() phase?)

All in all, the short response is that I wrote the smallest patch that
fixes the bug, AFAICT. But actually I think the above would be both
shorter and better. I'll give that a go.

> >  	if (dev->pm_domain) {
> >  		info = "noirq power domain ";
> >  		callback = pm_noirq_op(&dev->pm_domain->ops, state);
> > @@ -1187,6 +1190,9 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
> >  
> >  	dpm_wait_for_children(dev, async);
> >  
> > +	if (async_error)
> > +		goto Complete;
> > +
> 
> Same question.

Same answer :)

Brian

> >  	if (dev->pm_domain) {
> >  		info = "late power domain ";
> >  		callback = pm_late_early_op(&dev->pm_domain->ops, state);
> > 
> 
> Thanks,
> Rafael
> 
