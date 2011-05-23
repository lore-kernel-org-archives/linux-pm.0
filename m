From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH] ARM hibernation / suspend-to-disk
	support code
Date: Mon, 23 May 2011 11:12:20 +0100
Message-ID: <20110523101220.GH17672__45208.1027011902$1306145619$gmane$org@n2100.arm.linux.org.uk>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<alpine.DEB.2.00.1105181257370.2374@localhost6.localdomain6>
	<20110520113758.GA3141@arm.com>
	<20110520180510.GE7445@n2100.arm.linux.org.uk>
	<20110523100132.GC2370@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110523100132.GC2370@arm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Frank Hofmann <frank.hofmann@tomtom.com>, linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, May 23, 2011 at 11:01:32AM +0100, Dave Martin wrote:
> On Fri, May 20, 2011 at 07:05:10PM +0100, Russell King - ARM Linux wrote:
> > Out of the list you mention above, the only thing which isn't saved are the
> > FIQ registers, and that's a problem for S2RAM too, and should be done by
> > arch/arm/kernel/fiq.c hooking into the suspend paths.
> 
> The alternative view is that the driver using FIQ owns the state in the FIQ
> mode registers and is therefore responsible for saving and restoring it
> across suspend/resume.  If so, then any additional globally implemented
> state save/restore of the FIQ mode state is unnecessary.

This seems to be most sensible - if the FIQ is being used as a software-DMA,
then the hardware side of that needs to be cleanly shutdown (eg, waiting for
the DMA to complete before proceeding) to ensure no loss of data.  That
can't happen from within the FIQ code.

I also wonder about issues of secure/non-secure stuff here too - what
that means is that if we have a driver using FIQ mode, then we have
FIQ state to save, but if not there's probably no point (or even any
way) to save that state ourselves anyway.
