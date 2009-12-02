From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: allow for usage_count > 0 in
	pm_runtime_get()
Date: Wed, 2 Dec 2009 10:13:02 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912021012270.11361-100000@iolanthe.rowland.org>
References: <200912020001.28666.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912020001.28666.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2 Dec 2009, Rafael J. Wysocki wrote:

> On Tuesday 01 December 2009, Alan Stern wrote:
> > Rafael:
> 
> Hi,
> 
> > One other thing I just noticed.  The power.timer_expires field is 
> > supposed to be nonzero when the timer is scheduled.  But the code at 
> > the end of pm_schedule_suspend() doesn't check for the possibility that 
> > the expiration time might just happen to be 0.  If it is, the 
> > timer_expires value should be bumped up to 1 before the mod_timer() 
> > call.
> 
> Do you mean something like the patch below?
> 
> Rafael
> 
> ---
>  drivers/base/power/runtime.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux-2.6/drivers/base/power/runtime.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/power/runtime.c
> +++ linux-2.6/drivers/base/power/runtime.c
> @@ -625,6 +625,8 @@ int pm_schedule_suspend(struct device *d
>  		goto out;
>  
>  	dev->power.timer_expires = jiffies + msecs_to_jiffies(delay);
> +	if (!dev->power.timer_expires)
> +		dev->power.timer_expires = 1;
>  	mod_timer(&dev->power.suspend_timer, dev->power.timer_expires);

Yes, that's exactly what I meant.

Alan Stern
