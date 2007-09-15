From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Resend][PATCH -mm] Hibernation: Enter platform
	hibernation state in a consistent way (rev. 4)
Date: Sat, 15 Sep 2007 02:30:36 +0200
Message-ID: <200709150230.37615.rjw__5479.81458153135$1189815630$gmane$org@sisk.pl>
References: <200709121314.09676.rjw@sisk.pl>
	<20070914163717.8a0cb637.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070914163717.8a0cb637.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Stefan Becker <Stefan.Becker@nokia.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 15 September 2007 01:37, Andrew Morton wrote:
> On Wed, 12 Sep 2007 13:14:08 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > +	if (!hibernation_ops)
> > +		return -ENOSYS;
> > +
> > +	/*
> > +	 * We have cancelled the power transition by running
> > +	 * hibernation_ops->finish() before saving the image, so we should let
> > +	 * the firmware know that we're going to enter the sleep state after all
> > +	 */
> > +	error = hibernation_ops->start();
> > +	if (error)
> > +		return error;
> > +
> > +	suspend_console();
> > +	error = device_suspend(PMSG_SUSPEND);
> > +	if (error)
> > +		return error;
> > +
> > +	error = hibernation_ops->prepare();
> > +	if (error)
> > +		goto Resume_devices;
> > +
> > +	error = disable_nonboot_cpus();
> > +	if (error)
> > +		goto Finish;
> > +
> > +	local_irq_disable();
> > +	error = device_power_down(PMSG_SUSPEND);
> > +	if (!error) {
> > +		hibernation_ops->enter();
> > +		/* We should never get here */
> > +		while (1);
> >  	}
> > +	local_irq_enable();
> > +
> 
> Confused.  afacit there's no way for the caller of this function to know
> whether or not suspend_console() was called, so the error recovery doesn't
> know whether or not to run resume_console().  How does all that work?

Well, if this fails, we try to power off and if that fails, we halt.

Resuming devices in case of an error is needed so that kernel_power_off()
can work, but the consoles need not be resumed for that.

Still, now that I think of it, the resuming of consoles in case of an error
will probably be useful in diagnostics.  I'll post a fix on top of this patch.
