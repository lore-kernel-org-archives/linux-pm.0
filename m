From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend_delay implementation
Date: Fri, 10 Sep 2010 22:55:13 +0200
Message-ID: <201009102255.13387.rjw__16752.4714059711$1284152257$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1009101122330.1651-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1009101122330.1651-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.de>, USB list <linux-usb@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, September 10, 2010, Alan Stern wrote:
> Rafael:

Hi Alan,

First, I think we should CC linux-pm at least with this.

> It turns out that the existing "from_wq" arguments can be subsumed into 
> an "rpmflags" variable, along with the other things we've been talking 
> about.  Even better, one of the flag bits can be used to indicate 
> whether a call should be synchronous.
> 
> Which leads to the possibility of merging the __pm_runtime_X and
> __pm_request_X pairs of routines.  They all make similar checks when
> they start; this is needlessly duplicated code.  Unfortunately, they
> are slightly inconsistent in a few obscure respects:
> 
> 	If the current status is RPM_RESUMING then __rpm_request_suspend
> 	succeeds but __rpm_runtime_suspend fails.  Similarly for idle.

That was intentional.   __rpm_runtime_suspend has to fail in that case, but
__rpm_request_suspend need not, because __rpm_runtime_suspend is going to
be called after it anyway.  So, the decision whether or not to suspend the
device is always made by __rpm_runtime_suspend and I'd like that to stay this
way.

> 	The routines in each pair sometimes differ in whether they
> 	cancel other pending requests first vs. check for invalid 
> 	conditions (such as wrong usage_count) first.

That might be intentional as well, at least in some cases.

> It seems to me that the __pm_runtime_X and __pm_request_X functions
> should behave the same, as nearly as possible.
>
> To make everything more uniform, we should agree on some fixed scheme like
> this:
> 
> 	First check for things that make the function impossible:
> 	power.runtime_error set, usage_count or child_count set
> 	wrong, or disable_depth > 0.  If these checks fail, return
> 	immediately.

OK

> 	Then check the current status and the pending requests to
> 	see if they rule out the current function:
> 
> 		idle is allowed only in RPM_ACTIVE and when there
> 		are no pending requests (but the suspend timer can
> 		be running);
> 
> 		suspend is not allowed if the status is RPM_SUSPENDED
> 		or RPM_RESUMING, or if there is a pending resume
> 		(either a request or a deferred resume);
> 
> 		resume is not allowed if the status is RPM_ACTIVE.

OK, but that need not apply to the _ldle() variants.

> 	If this check succeeds, then cancel any pending requests
> 	(exception: doing an idle should not cause the suspend timer to 
> 	be cancelled) and either carry out the action, put it on the
> 	workqueue, defer it, or start the timer.
> 
> This almost agrees with the rules laid out in
> Documentation/power/runtime.txt.  The only difference I can see is what
> should happen if __pm_{runtime|request}_resume is called while the
> status is RPM_ACTIVE and there is a pending idle or suspend request or
> a scheduled suspend.  Under these conditions I think we probably
> shouldn't cancel a pending idle request.

That would be fine.

> I'm not sure about pending or scheduled suspends.

I actually think we may try not to cancel any pending/scheduled operations
at all and let things work out.  If the caller is not careful enough to use the
reference counting, so be it.

> (This scheme is a little peculiar because it means that scheduling a
> suspend will cancel a pending idle, but idle requests are then allowed
> after the suspend has been scheduled.  I guess we can live with this.)

Well, see above. :-)

> This differs a little from what we do now, in that it doesn't allow a
> suspend to be requested while the device is resuming.  I think this
> makes sense for two reasons: When the resume finishes there will be an
> idle notification anyway, and if the workqueue tries to carry out the
> suspend too soon (before the resume has finished) then it will fail.

Idle notification need not imply suspend and the resume winning the race
with a pending suspend is totally fine by me.
 
> Does this all seem reasonable?

Generally, it does, but I'm not sure about the "request suspend" case.  In
fact I think it's better to let the resulting __rpm_runtime_suspend() run.

Thanks,
Rafael
