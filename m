From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [RFC PATCH] ARM hibernation / suspend-to-disk
	support code
Date: Mon, 23 May 2011 11:01:32 +0100
Message-ID: <20110523100132.GC2370__35990.6757287264$1306145036$gmane$org@arm.com>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<alpine.DEB.2.00.1105181257370.2374@localhost6.localdomain6>
	<20110520113758.GA3141@arm.com>
	<20110520180510.GE7445@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110520180510.GE7445@n2100.arm.linux.org.uk>
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

On Fri, May 20, 2011 at 07:05:10PM +0100, Russell King - ARM Linux wrote:
> On Fri, May 20, 2011 at 12:37:58PM +0100, Dave Martin wrote:
> > Where do we save/restore r8_FIQ..r13_FIQ, r13_IRQ, r13_UND and r13_ABT?
> > (I'm assuming there's no reason to save/restore r14 or SPSR for any
> > exception mode, since we presumably aren't going to suspend/resume
> > from inside an exception handler (?))
> 
> There is absolutely no need to save r13 for _any_ of the abort modes.  As
> we have to set them up at boot time to fixed values, we keep that code
> around, and in the resume paths we re-execute that initialization code.
> cpu_init().

That seemed a sensible possibility, but I'm still not familiar with some
of the details.  It was, as I suspected, a dumb question from me...

> Out of the list you mention above, the only thing which isn't saved are the
> FIQ registers, and that's a problem for S2RAM too, and should be done by
> arch/arm/kernel/fiq.c hooking into the suspend paths.

The alternative view is that the driver using FIQ owns the state in the FIQ
mode registers and is therefore responsible for saving and restoring it
across suspend/resume.  If so, then any additional globally implemented
state save/restore of the FIQ mode state is unnecessary.

Do you have an opinion on which is the better model?

Requiring the driver to take responsibility might encourage the driver
writers to think about all the implications of save/restore on their
driver: saving/restoring the FIQ mode registers is unlikely to be enough
by itself.  Depending on the state of the driver, it might also be
unnecessary (though it's only a few words of state, so not necessarily
worth optimising).

Cheers
---Dave
