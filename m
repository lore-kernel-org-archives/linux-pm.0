From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Prevent waiting forever on asynchronous
	resume after abort
Date: Thu, 2 Sep 2010 23:05:08 +0200
Message-ID: <201009022305.09187.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1009020946580.1513-100000@iolanthe.rowland.org>
	<201009022146.03359.rjw@sisk.pl>
	<AANLkTi=s3_kFvRY9Afzku82gUgW7YKYXDBZvTkxQsMP8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=s3_kFvRY9Afzku82gUgW7YKYXDBZvTkxQsMP8@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@android.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 02, 2010, Colin Cross wrote:
> On Thu, Sep 2, 2010 at 12:46 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Thursday, September 02, 2010, Alan Stern wrote:
> >> On Wed, 1 Sep 2010, Colin Cross wrote:
> >>
> >> > Only wait on a parent device during resume if the parent device is
> >> > suspended.
> >> >
> >> > Consider three drivers, A, B, and C.  The parent of A is C, and C
> >> > has async_suspend set.  On boot, C->power.completion is initialized
> >> > to 0.
> >> >
> >> > During the first suspend:
> >> > suspend_devices_and_enter(...)
> >> >  dpm_resume(...)
> >> >   device_suspend(A)
> >> >   device_suspend(B) returns error, aborts suspend
> >> >  dpm_resume_end(...)
> >> >    dpm_resume(...)
> >> >     device_resume(A)
> >> >      dpm_wait(A->parent == C)
> >> >       wait_for_completion(C->power.completion)
> >> >
> >> > The wait_for_completion will never complete, because
> >> > complete_all(C->power.completion) will only be called from
> >> > device_suspend(C) or device_resume(C), neither of which is called
> >> > if suspend is aborted before C.
> >>
> >> This would work okay if C->power.completion had been initialized to the
> >> completed state during boot, right?
> >>
> >> > After a successful suspend->resume cycle, where B doesn't abort
> >> > suspend, C->power.completion is left in the completed state by the
> >> > call to device_resume(C), and the same call path will work if B
> >> > aborts suspend.
> >> >
> >> > Signed-off-by: Colin Cross <ccross@android.com>
> >> > ---
> >> >  drivers/base/power/main.c |    3 ++-
> >> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >> >
> >> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> >> > index cb784a0..e159910 100644
> >> > --- a/drivers/base/power/main.c
> >> > +++ b/drivers/base/power/main.c
> >> > @@ -526,7 +526,8 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
> >> >     TRACE_DEVICE(dev);
> >> >     TRACE_RESUME(0);
> >> >
> >> > -   dpm_wait(dev->parent, async);
> >> > +   if (dev->parent && dev->parent->power.status >= DPM_OFF)
> >> > +           dpm_wait(dev->parent, async);
> >> >     device_lock(dev);
> >> >
> >> >     dev->power.status = DPM_RESUMING;
> >>
> >> I think it would be better to change device_pm_init() and add a
> >> complete_all().
> >
> > I agree.
> That would work, and was my first solution, but it increases the
> reliance on the completion variable being left completed between state
> transitions, which is undocumented and unnecessary.

In fact it is necessary, because dpm_wait() may be called by external code
through device_pm_wait_for_dev() which is exported for a reason.  That may
lead to problems analogous to the one you described if the completion
variables are not completed initially.

> It seems more straightforward to me to only wait on the parent if the parent is
> suspended.
> 
> > Who's writing the patch?
> I'll write it if you still don't like this one.

Yes, please.

Thanks,
Rafael
