From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/6] Hibernation: Move low level resume to
	disk.c
Date: Tue, 27 Nov 2007 17:06:04 +0100
Message-ID: <200711271706.05259.rjw@sisk.pl>
References: <200711270025.08128.rjw@sisk.pl> <200711270029.11185.rjw@sisk.pl>
	<20071127002929.GF9759@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071127002929.GF9759@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 27 of November 2007, Pavel Machek wrote:
> Hi!
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Move the low level restore code to kernel/power/disk.c , since the
> > corresponding low level hibernation code is already there.
> > 
> > Make restore fail if device_power_down(PMSG_PRETHAW) returns an
> > error.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Move looks ok to me.
> 
> 
> >  /**
> > + *	resume_target_kernel - prepare devices that need to be suspended with
> > + *	interrupts off, restore the contents of highmem that have not been
> > + *	restored yet from the image and run the low level code that will restore
> > + *	the remaining contents of memory and switch to the just restored target
> > + *	kernel.
> > + */
> > +
> > +static int resume_target_kernel(void)
> > +{
> > +	int error;
> > +
> > +	local_irq_disable();
> > +	error = device_power_down(PMSG_PRETHAW);
> > +	if (error) {
> > +		printk(KERN_ERR "Some devices failed to power down, "
> > +			KERN_ERR "aborting resume\n");
> > +		goto Enable_irqs;
> 
> Too many KERN_ERR's ;-)

Yeah, will fix.

> . Plus... are you sure this does the right 
> thing? ... .. ... yes, it does. If one device fails,
> device_power_down() powers up the rest using dpm_power_up(). Good.
> 
> ACK... modulo double KERN_ERR.

OK, thanks!

Rafael
