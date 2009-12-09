From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async suspend-resume patch w/ rwsems (was: Re: [GIT
 PULL] PM updates for 2.6.33)
Date: Wed, 9 Dec 2009 15:15:01 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912091451250.4120-100000__34255.5279181854$1260389896$gmane$org@iolanthe.rowland.org>
References: <200912082355.00711.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912082355.00711.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 8 Dec 2009, Rafael J. Wysocki wrote:

> For completness, below is the full async suspend/resume patch with rwlocks,
> that has been (very slightly) tested and doesn't seem to break things.
> 
> [Note to Alan: lockdep doesn't seem to complain about the not annotated nested
> locks.]

I can't imagine why not.  And wouldn't lockdep get confused by the fact
that in the async case, the rwsems are released by a different process
from the one that acquired them?


> Index: linux-2.6/drivers/base/power/main.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/power/main.c
> +++ linux-2.6/drivers/base/power/main.c

Should we have an attribute under /sys/power to disable async
suspend/resume?  It would make testing easier and give people a way to
work around problems.

> @@ -334,25 +337,53 @@ static void pm_dev_err(struct device *de
>   * The driver of @dev will not receive interrupts while this function is being
>   * executed.
>   */
> -static int device_resume_noirq(struct device *dev, pm_message_t state)
> +static int __device_resume_noirq(struct device *dev, pm_message_t state)
>  {

Do you want to use async tasks in the late-suspend/early-resume stages?  
I know that USB won't use it, not even for the PCI host controllers --
not unless the PCI core specifically wants it.  Doing just the regular
suspend/resume stages may be enough.

> +static int device_resume_noirq(struct device *dev)
> +{
> +	down_write(&dev->power.rwsem);
> +
> +	if (dev->power.async_suspend && !pm_trace_is_enabled()) {

If the sysfs attribute exists, then maybe we _should_ allow async with 
PM tracing enabled.  I don't know; it's your decision.

			atomic_set(&async_error, error);
	}


> @@ -683,10 +835,12 @@ static int dpm_suspend(pm_message_t stat
>  
>  	INIT_LIST_HEAD(&list);
>  	mutex_lock(&dpm_list_mtx);
> +	pm_transition = state;
>  	while (!list_empty(&dpm_list)) {
>  		struct device *dev = to_device(dpm_list.prev);
>  
>  		get_device(dev);
> +		dev->power.status = DPM_OFF;

What's that for?  dev->power.status is supposed to be DPM_SUSPENDING 
until the suspend method is successfully completed.

>  		mutex_unlock(&dpm_list_mtx);
>  
>  		error = device_suspend(dev, state);
> @@ -694,16 +848,22 @@ static int dpm_suspend(pm_message_t stat
>  		mutex_lock(&dpm_list_mtx);
>  		if (error) {
>  			pm_dev_err(dev, state, "", error);
> +			dev->power.status = DPM_SUSPENDING;

And then this isn't needed.

>  			put_device(dev);
>  			break;
>  		}
> -		dev->power.status = DPM_OFF;

This line has to be moved into __device_suspend(), even though it won't 
be protected by dpm_list_mtx.  The same sort of thing applies to 
dpm_suspend_noirq() (although nothing needs to be moved if you don't 
make it async).

The rest looks okay.

How about exporting a wait_for_device_to_resume() routine?  Drivers
could call it for non-tree resume constraints:

	void wait_for_device_to_resume(struct device *other)
	{
		down_read(&other->power.rwsem);
		up_read(&other->power.rwsem);
	}

Unfortunately there is no equivalent for non-tree suspend constraints.

Alan Stern
