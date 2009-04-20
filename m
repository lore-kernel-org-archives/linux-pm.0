From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM/Suspend: Introduce two new platform
	callbacks to avoid breakage (Re: 900af0d breaks some embedded
	suspend/resume)
Date: Mon, 20 Apr 2009 02:50:10 +0200
Message-ID: <200904200250.11279.rjw__1188.03690788827$1240189002$gmane$org@sisk.pl>
References: <20090417231009.GB6900@flint.arm.linux.org.uk>
	<200904182047.48009.rjw@sisk.pl>
	<1240183907.8867.22.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1240183907.8867.22.camel@nigel-laptop>
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
To: ncunningham-lkml@crca.org.au
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Linux Kernel List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 20 April 2009, Nigel Cunningham wrote:
> Hi.
> 
> On Sat, 2009-04-18 at 20:47 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: PM/Suspend: Introduce two new platform callbacks to avoid breakage
> > 
> > Commit 900af0d973856d6feb6fc088c2d0d3fde57707d3 (PM: Change suspend
> > code ordering) changed the ordering of suspend code in such a way
> > that the platform .prepare() callback is now executed after the
> > device drivers' late suspend callbacks have run.  Unfortunately, this
> > turns out to break ARM platforms that need to talk via I2C to power
> > control devices during the .prepare() callback.
> > 
> > For this reason introduce two new platform suspend callbacks,
> > .prepare_late() and .wake(), that will be called just prior to
> > disabling non-boot CPUs and right after bringing them back on line,
> > respectively, and use them instead of .prepare() and .finish() for
> > ACPI suspend.  Make the PM core execute the .prepare() and .finish()
> > platform suspend callbacks where they were executed previously (that
> > is, right after calling the regular suspend methods provided by
> > device drivers and right before executing their regular resume
> > methods, respectively).
> > 
> > It is not necessary to make analogous changes to the hibernation
> > code and data structures at the moment, because they are only used
> > by ACPI platforms.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  drivers/acpi/sleep.c    |    8 ++++----
> >  include/linux/suspend.h |   36 ++++++++++++++++++++++++++----------
> >  kernel/power/main.c     |   24 +++++++++++++++++-------
> >  3 files changed, 47 insertions(+), 21 deletions(-)
> > 
> > Index: linux-2.6/kernel/power/main.c
> > ===================================================================
> > --- linux-2.6.orig/kernel/power/main.c
> > +++ linux-2.6/kernel/power/main.c
> > @@ -291,20 +291,26 @@ static int suspend_enter(suspend_state_t
> >  
> >  	device_pm_lock();
> >  
> > +	if (suspend_ops->prepare) {
> > +		error = suspend_ops->prepare();
> > +		if (error)
> > +			goto Done;
> > +	}
> > +
> >  	error = device_power_down(PMSG_SUSPEND);
> >  	if (error) {
> >  		printk(KERN_ERR "PM: Some devices failed to power down\n");
> > -		goto Done;
> > +		goto Platfrom_finish;
> 
> s/Platfrom/Platform
> 
> Why retain the typo in multiple places?
> 
> >  	}
> >  
> > -	if (suspend_ops->prepare) {
> > -		error = suspend_ops->prepare();
> > +	if (suspend_ops->prepare_late) {
> > +		error = suspend_ops->prepare_late();
> >  		if (error)
> >  			goto Power_up_devices;
> >  	}
> 
> Doesn't this invalidate testing that's already been done? Drivers
> implementing prepare() (arm omap1, pxa, omap2, s3c and powerpc mpc52xx
> and lite5200) are now going to have it called pre device_power_down. Why
> not call the new prepare() "prepare_early" and leave the current prepare
> as it is in the place where it's already called?

Well, I wanted to avoid modifying platforms that were broken by the ordering
change.

> The name is also very confusing. Prepare matches with Finish and
> Prepare_late with wake. How about prepare and unprepare?

The names could be better as usual, but I'm going to revisit that shortly.

> Reviewed-by: Nigel Cunningham <nigel@tuxonice.net>

Thanks!

Best,
Rafael
