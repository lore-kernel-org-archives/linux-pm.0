From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM:
	Rearrange core suspend code)
Date: Mon, 8 Jun 2009 14:04:03 +0200
Message-ID: <200906081404.04118.oliver__20967.4651072875$1244462739$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org>
	<200906080005.23304.oliver@neukum.org>
	<200906081329.27047.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906081329.27047.rjw@sisk.pl>
Content-Disposition: inline
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Am Montag, 8. Juni 2009 13:29:26 schrieb Rafael J. Wysocki:

> But I need to be able to call __pm_schedule_resume() (at least) from
> interrupt context and I can't use a mutex from there.  Otherwise I'd have
> used a mutex. :-)

I see.

> Anyway, below is a version with synchronous resume.

You are assuming autosuspend should always be with a delay. Why?

Secondly, you are not using a counter. Therefore only one driver can
control the PM state of a device at a given time. Is that wise?

> + * __pm_schedule_suspend - Schedule run-time suspend of given device.
> + * @dev: Device to suspend.
> + * @delay: Time to wait before attempting to suspend the device.

In which unit of time? If this is to go into kerneldoc that must be specified.

> + * @autocancel: If set, the request will be cancelled during a resume from
> a + *	system-wide sleep state if it happens before @delay elapses.

Why is this needed?

> + */
> +void __pm_schedule_suspend(struct device *dev, unsigned long delay,
> +			   bool autocancel)

[..]


> +
> +/**
> + * __pm_schedule_resume - Schedule run-time resume of given device.
> + * @dev: Device to resume.
> + * @autocancel: If set, the request will be cancelled during a resume from
> a + *	system-wide sleep state if it happens before pm_autoresume() can be
> run. + */

Eeek! This is a bad idea. You never want to a resume to be cancelled.

> +void __pm_schedule_resume(struct device *dev, bool autocancel)

[..]
> +int pm_resume_sync(struct device *dev)
> +{
> +	int error = 0;
> +
> +	pm_lock_device(dev);
> +	if (dev->power.runtime_status == RPM_IDLE) {
> +		/* ->autosuspend() hasn't started yet, no need to resume. */
> +		pm_cancel_suspend(dev);
> +		goto out;
> +	}
> +
> +	if (dev->power.runtime_status == RPM_SUSPENDING) {
> +		/*
> +		 * The ->autosuspend() callback is being executed right now,
> +		 * wait for it to complete.
> +		 */
> +		pm_unlock_device(dev);
> +		cancel_delayed_work_sync(&dev->power.suspend_work);

That is the most glorious abuse of an API I've seen this year :-)

	Regards
		Oliver
