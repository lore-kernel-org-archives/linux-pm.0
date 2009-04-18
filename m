From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: 900af0d breaks some embedded suspend/resume
Date: Sat, 18 Apr 2009 19:09:07 +0100
Message-ID: <20090418180907.GD7148__43770.8800462589$1240245365$gmane$org@flint.arm.linux.org.uk>
References: <20090417231009.GB6900@flint.arm.linux.org.uk>
	<200904181626.10388.rjw@sisk.pl>
	<20090418144132.GC7148@flint.arm.linux.org.uk>
	<200904181709.47480.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200904181709.47480.rjw@sisk.pl>
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

On Sat, Apr 18, 2009 at 05:09:46PM +0200, Rafael J. Wysocki wrote:
> On Saturday 18 April 2009, Russell King wrote:
> > No, sysdevs are shut down after IRQs are turned off and the I2C driver
> > has been shut down.  The I2C driver needs IRQs to work in slave mode,
> > and we need slave mode to work.
> 
> Hm, but up to and including 2.6.29 we called the late suspend callbacks with
> interrupts off.

That's not related to the problem - since all that the I2C drivers
late suspend callback does is shut the I2C driver down.

It's what happens between the normal suspend callback (which occurs
with IRQs on) and the late suspend callback which I'm interested in,
which is when the platform's 'prepare' method is called.

> Hmm, what about redefining platform_suspend_ops in the following way:
> 
> struct platform_suspend_ops {
> 	int (*valid)(suspend_state_t state);
> 	int (*begin)(suspend_state_t state);
> 	int (*devices_suspended)(void);
> 	int (*prepare)(void);
> 	int (*enter)(suspend_state_t state);
> 	void (*wake)(void);
> 	int (*resume_devices)(void);
> 	void (*end)(void);
> 	void (*recover)(void);
> };
> 
> where:
> 
> * begin() will be called before suspending devices (no change)
> * devices_suspended() will be called after suspending devices (before
>   suspend_device_irqs())
> * prepare() will be callled after the late suspend callbacks
> * enter() will be called to enter the sleep state (no change)
> * wake() will be called before the early resume callbacks
> * resume_devices() will be called before resuming devices (after
>   resume_device_irqs()
> * end() will be called after resuming devices (no change)
> 
> I don't think we'll need more platform hooks than that.

I'd be happy with that.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
