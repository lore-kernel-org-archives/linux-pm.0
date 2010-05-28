From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 10:26:24 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1005281024290.3116__23841.7662716985$1275035265$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.1005271744130.3239-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005271744130.3239-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 27 May 2010, Alan Stern wrote:

> On Thu, 27 May 2010, Thomas Gleixner wrote:
> 
> > > The two of you are talking at cross purposes.  Thomas is referring to 
> > > idle-based suspend and Matthew is talking about forced suspend.
> > 
> > Yes, and forced suspend to disk is the same as force suspend to disk,
> > which has both nothing to do with sensible resource management.
> 
> If I understand correctly, you are saying that all the untrusted 
> applications should run with QoS(NONE).  Then they could do whatever 
> they wanted without causing any interference.
> 
> And with idle-based power management (rather than forced suspend), 
> there would be no issue with wakeup events getting unduly delayed.
> 
> Unless one of those events was meant for an untrusted application.  Is 
> that the source of the difficulty?

Probably, but that's not solved by suspend blockers either as I
explained several times now. Because those untrusted apps either lack
blocker calls or are not allowed to use them, so the blocker does not
help for those either.

Thanks,

	tglx
