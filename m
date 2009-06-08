From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM:
	Rearrange core suspend code)
Date: Mon, 8 Jun 2009 20:34:30 +0200
Message-ID: <200906082034.31091.rjw__33730.5291126997$1244486207$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org>
	<200906081329.27047.rjw@sisk.pl>
	<200906081404.04118.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906081404.04118.oliver@neukum.org>
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
To: Oliver Neukum <oliver@neukum.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 08 June 2009, Oliver Neukum wrote:
> Am Montag, 8. Juni 2009 13:29:26 schrieb Rafael J. Wysocki:
> 
> > But I need to be able to call __pm_schedule_resume() (at least) from
> > interrupt context and I can't use a mutex from there.  Otherwise I'd have
> > used a mutex. :-)
> 
> I see.
> 
> > Anyway, below is a version with synchronous resume.
> 
> You are assuming autosuspend should always be with a delay. Why?

I couldn't invent a valid case for doing it without a delay.  Perhaps my
imagination is constrained too much. ;-)

> Secondly, you are not using a counter. Therefore only one driver can
> control the PM state of a device at a given time. Is that wise?

I didn't think about it to be honest.  Obviously this patch doesn't cover all
of the possible cases and I'm not even sure it's worth trying to cover them
upfront.

> > + * __pm_schedule_suspend - Schedule run-time suspend of given device.
> > + * @dev: Device to suspend.
> > + * @delay: Time to wait before attempting to suspend the device.
> 
> In which unit of time? If this is to go into kerneldoc that must be specified.

That's in jiifies.  Yes, I should have documented it.

> > + * @autocancel: If set, the request will be cancelled during a resume from
> > a + *	system-wide sleep state if it happens before @delay elapses.
> 
> Why is this needed?

In some subsystems, like PCI, devices will be resumed by the BIOS
unconditionally in the majority of cases and then it's not worth trying to
complete run-time PM requests from before the suspend.

> > + */
> > +void __pm_schedule_suspend(struct device *dev, unsigned long delay,
> > +			   bool autocancel)
> 
> [..]
> 
> 
> > +
> > +/**
> > + * __pm_schedule_resume - Schedule run-time resume of given device.
> > + * @dev: Device to resume.
> > + * @autocancel: If set, the request will be cancelled during a resume from
> > a + *	system-wide sleep state if it happens before pm_autoresume() can be
> > run. + */
> 
> Eeek! This is a bad idea. You never want to a resume to be cancelled.

Sometimes I do (see above).

> > +void __pm_schedule_resume(struct device *dev, bool autocancel)
> 
> [..]
> > +int pm_resume_sync(struct device *dev)
> > +{
> > +	int error = 0;
> > +
> > +	pm_lock_device(dev);
> > +	if (dev->power.runtime_status == RPM_IDLE) {
> > +		/* ->autosuspend() hasn't started yet, no need to resume. */
> > +		pm_cancel_suspend(dev);
> > +		goto out;
> > +	}
> > +
> > +	if (dev->power.runtime_status == RPM_SUSPENDING) {
> > +		/*
> > +		 * The ->autosuspend() callback is being executed right now,
> > +		 * wait for it to complete.
> > +		 */
> > +		pm_unlock_device(dev);
> > +		cancel_delayed_work_sync(&dev->power.suspend_work);
> 
> That is the most glorious abuse of an API I've seen this year :-)

Heh.

OK, what would you do instead?

Rafael
