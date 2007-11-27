From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/6] Hibernation: Move low level resume to
	disk.c
Date: Tue, 27 Nov 2007 01:29:29 +0100
Message-ID: <20071127002929.GF9759__5456.78815474293$1196123399$gmane$org@elf.ucw.cz>
References: <200711270025.08128.rjw@sisk.pl> <200711270029.11185.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200711270029.11185.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Move the low level restore code to kernel/power/disk.c , since the
> corresponding low level hibernation code is already there.
> 
> Make restore fail if device_power_down(PMSG_PRETHAW) returns an
> error.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Move looks ok to me.


>  /**
> + *	resume_target_kernel - prepare devices that need to be suspended with
> + *	interrupts off, restore the contents of highmem that have not been
> + *	restored yet from the image and run the low level code that will restore
> + *	the remaining contents of memory and switch to the just restored target
> + *	kernel.
> + */
> +
> +static int resume_target_kernel(void)
> +{
> +	int error;
> +
> +	local_irq_disable();
> +	error = device_power_down(PMSG_PRETHAW);
> +	if (error) {
> +		printk(KERN_ERR "Some devices failed to power down, "
> +			KERN_ERR "aborting resume\n");
> +		goto Enable_irqs;

Too many KERN_ERR's ;-). Plus... are you sure this does the right
thing? ... .. ... yes, it does. If one device fails,
device_power_down() powers up the rest using dpm_power_up(). Good.

ACK... modulo double KERN_ERR.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
