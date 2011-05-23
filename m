From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [RFC PATCH] ARM hibernation / suspend-to-disk
	support code
Date: Mon, 23 May 2011 12:16:31 +0100
Message-ID: <20110523111631.GD3769__21081.2207930305$1306149554$gmane$org@arm.com>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<alpine.DEB.2.00.1105181257370.2374@localhost6.localdomain6>
	<20110520113758.GA3141@arm.com>
	<20110520180510.GE7445@n2100.arm.linux.org.uk>
	<20110523100132.GC2370@arm.com>
	<20110523101220.GH17672@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110523101220.GH17672@n2100.arm.linux.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Frank Hofmann <frank.hofmann@tomtom.com>, linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, May 23, 2011 at 11:12:20AM +0100, Russell King - ARM Linux wrote:
> On Mon, May 23, 2011 at 11:01:32AM +0100, Dave Martin wrote:
> > On Fri, May 20, 2011 at 07:05:10PM +0100, Russell King - ARM Linux wrote:
> > > Out of the list you mention above, the only thing which isn't saved are the
> > > FIQ registers, and that's a problem for S2RAM too, and should be done by
> > > arch/arm/kernel/fiq.c hooking into the suspend paths.
> > 
> > The alternative view is that the driver using FIQ owns the state in the FIQ
> > mode registers and is therefore responsible for saving and restoring it
> > across suspend/resume.  If so, then any additional globally implemented
> > state save/restore of the FIQ mode state is unnecessary.
> 
> This seems to be most sensible - if the FIQ is being used as a software-DMA,
> then the hardware side of that needs to be cleanly shutdown (eg, waiting for
> the DMA to complete before proceeding) to ensure no loss of data.  That
> can't happen from within the FIQ code.

OK.  Frank suggested putting comments to this effect in <asm/fiq.h>.

I think something along these lines might be appropriate:

/*
 * The FIQ mode registers are not magically preserved across suspend/resume.
 *
 * Drivers which require these registers to be preserved across power
 * management operations must implement appropriate suspend/resume handlers
 * to save and restore them.
 */

Is the header file a good place for this, or is there some other better
place to put it?

> I also wonder about issues of secure/non-secure stuff here too - what
> that means is that if we have a driver using FIQ mode, then we have
> FIQ state to save, but if not there's probably no point (or even any
> way) to save that state ourselves anyway.

That argument may apply to a ton of state in the Secure World, not just
the FIQ registers

The likely model there is that the Secure World must hook somewhere into
Linux suspend/resume too, so that its hooks can be called at the
appropriate times.  This could involve a driver which saves/restores the
state of the Secure World, or low-level hooks which get called from
the platform power management code.

Either way, Linux doesn't need to be doing anything special except for
calling those hooks, just as for any other driver.

Cheers
---Dave
