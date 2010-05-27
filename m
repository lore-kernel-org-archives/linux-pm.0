From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 18:31:18 +0100
Message-ID: <20100527173118.GE2468__11419.9470998303$1274982415$gmane$org@srcf.ucam.org>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1005271915540.3032@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005271915540.3032@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, May 27, 2010 at 07:24:02PM +0200, Thomas Gleixner wrote:

> Oh no. They paper over a short coming. If there is a pending event,
> the kernel knows that. It just does not make use of this
> information. Blockers just paper over this by sprinkling
> do_not_suspend() calls all over the place. What a sensible solution.

Even if we could use suspend-via-deep-idle-state on PCs, we still need 
to be able to enter suspend while the system isn't idle. There's two 
ways to do that:

1) Force the system to be idle. Doing this race-free is difficult.

2) Enter suspend even though the system isn't idle. Since we can't rely 
on the scheduler, we need drivers to know whether userspace has consumed 
all wakeup events before allowing the transition to occur. Doing so 
requires either in-kernel suspend blockers or something that's almost 
identical.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
