From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: 900af0d breaks some embedded suspend/resume
Date: Sat, 18 Apr 2009 15:41:32 +0100
Message-ID: <20090418144132.GC7148__14962.7042156228$1240245298$gmane$org@flint.arm.linux.org.uk>
References: <20090417231009.GB6900@flint.arm.linux.org.uk>
	<200904181523.36010.rjw@sisk.pl>
	<20090418135323.GA7148@flint.arm.linux.org.uk>
	<200904181626.10388.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200904181626.10388.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Apr 18, 2009 at 04:26:09PM +0200, Rafael J. Wysocki wrote:
> On Saturday 18 April 2009, Russell King wrote:
> > On Sat, Apr 18, 2009 at 03:23:35PM +0200, Rafael J. Wysocki wrote:
> > > The patchset in question had been discussed quite extensively before it was
> > > merged and it's a pity none of the people caring for the affected platforms
> > > took part in those discussions.  That would allow us to avoid the breakage.
> > 
> > Maybe on some list, but not everyone is subscribed to a million and one
> > mailing lists.  I don't have enough time to read those which I'm currently
> > subscribed to, so I definitely don't want any more.
> > 
> > > > or provide alternative equivalent functionality where the platform code is
> > > > notified of the PM event prior to the late suspend callback being issued.
> > > 
> > > There is the .begin() callback that could be used, but if you need the
> > > platform to be notified _just_ prior to the late suspend callback, then the
> > > only thing I can think of at the moment is the appended patch.
> > > 
> > > It shouldn't break anything in theory, because the majority of drivers put
> > > their devices into low power states in the "regular" suspend callbacks anyway.
> > 
> > Okay, my requirement is:
> > 
> > What I need to be able to do is to suspend most devices on the host side
> > which may involve talking to a separate microcontroller via I2C to shut
> > down power to peripherals.
> > 
> > Once that's complete, I then need to inform this microcontroller via I2C
> > that we're going to be entering suspend mode, and wait for it to acknowledge
> > that (after it's done its own suspend preparations).  At that point I can
> > shutdown the I2C controller, and enter suspend mode.
> 
> Would it be an option to use a sysdev for that?

No, sysdevs are shut down after IRQs are turned off and the I2C driver
has been shut down.  The I2C driver needs IRQs to work in slave mode,
and we need slave mode to work.

> This patch undoes some previous changes, but I'm not too comfortable with
> it, because I think that putting devices into low power states after
> .prepare() may not work on some ACPI systems.  Since devices should
> generally be put into low power states during the "late" suspend (ie.
> when their interrupt handlers are not invoked), it may be quite
> inconvenient.

Maybe we need yet more levels of callbacks? :P

Realistically, not all platforms are going to have the same requirements,
so I don't think imposing ACPI requirements (by changing what is a
currently working suspend ordering) on everyone else is not the way
to go.

Maybe we need a way to allow hooks to be placed into the suspend/resume
mechanism in a dynamic way.  Eg, define the suspend order as:

- early device suspend
- normal device suspend
- irqs off
- late device suspend
- sysdev suspend

and allow hooks into that order to be added.  Maybe something like:

struct pm_hook {
	struct list_head node;
	unsigned int priority;
	int (*suspend)(suspend_state_t);
	int (*resume)(suspend_state_t);
};

static int early_device_suspend(suspend_state_t state)
{
	return device_suspend(PMSG_SUSPEND);
}

static int early_device_resume(suspend_state_t state)
{
	return device_resume(PMSG_RESUME);
}

static struct pm_hook early_device_hook = {
	.priority = SUSP_EARLY_DEVICE,
	.suspend = early_device_suspend,
	.resume = early_device_resume,
};


int suspend(suspend_state_t state)
{
	struct pm_hook *hook;
	int err;

	list_for_each(hook, &suspend_hooks, node) {
		err = hook->suspend(state);
		if (err) {
			list_for_each_entry_continue_reverse(hook, &suspend_hooks, node)
				hook->resume(state);
			break;
		}
	}

	return err;
}

where suspend_hooks is an ordered list according to 'priority'.

This would allow dynamic insertion of platforms suspend/resume requirements
into the PM system.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
