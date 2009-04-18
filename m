From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: 900af0d breaks some embedded suspend/resume
Date: Sat, 18 Apr 2009 14:53:23 +0100
Message-ID: <20090418135323.GA7148__14910.3625248701$1240244356$gmane$org@flint.arm.linux.org.uk>
References: <20090417231009.GB6900@flint.arm.linux.org.uk>
	<200904181523.36010.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200904181523.36010.rjw@sisk.pl>
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

On Sat, Apr 18, 2009 at 03:23:35PM +0200, Rafael J. Wysocki wrote:
> The patchset in question had been discussed quite extensively before it was
> merged and it's a pity none of the people caring for the affected platforms
> took part in those discussions.  That would allow us to avoid the breakage.

Maybe on some list, but not everyone is subscribed to a million and one
mailing lists.  I don't have enough time to read those which I'm currently
subscribed to, so I definitely don't want any more.

> > or provide alternative equivalent functionality where the platform code is
> > notified of the PM event prior to the late suspend callback being issued.
> 
> There is the .begin() callback that could be used, but if you need the
> platform to be notified _just_ prior to the late suspend callback, then the
> only thing I can think of at the moment is the appended patch.
> 
> It shouldn't break anything in theory, because the majority of drivers put
> their devices into low power states in the "regular" suspend callbacks anyway.

Okay, my requirement is:

What I need to be able to do is to suspend most devices on the host side
which may involve talking to a separate microcontroller via I2C to shut
down power to peripherals.

Once that's complete, I then need to inform this microcontroller via I2C
that we're going to be entering suspend mode, and wait for it to acknowledge
that (after it's done its own suspend preparations).  At that point I can
shutdown the I2C controller, and enter suspend mode.

Upon resume (which is activated by this microcontroller, including jtagging
the boot code across to the host CPU), we need to tell this microcontroller
that we're going back to 'run' mode again via I2C, and then resume the
devices.

This is why we hooked the PXA I2C driver into the late suspend and
early resume methods, so the I2C driver would be the last to suspend and
the first to resume, thus allowing it to be used to talk to this micro-
controller when required.  This worked out nicely because the late suspend
used to before the platform prepare and platform finish used to happen
after the early resume methods were called.

So, it looks like your patch to kernel/power/main.c will allow me to
continue to achieve this.  (Don't know about the disk.c bits, I've
never used suspend-to-disk.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
