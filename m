From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 20:08:53 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1005272006560.3032__5.71989589861488$1274985175$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.1005271334560.3239-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005271334560.3239-100000@iolanthe.rowland.org>
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
> > Crap. Stop beating on those lost wakeup events. If we lose them then
> > the drivers are broken and do not handle the switch over correctly. Or
> > the suspend mechanism is broken as it does not evaluate the system
> > state correctly. Blockers are just papering over that w/o tackling the
> > real problem.
> 
> That's the point -- suspend does not evaluate the system state 
> correctly because it doesn't have the necessary information.  Suspend 
> blockers are a way of providing it that information.  They don't paper 
> over the problem; they solve it.

Nonsense. The system state is well defined when a event is pending and
we just have to say good bye to the idea that forced suspend is a good
solution. It's not as it does not guarantee the event processing in
badly written apps and it does move the power consumption to a later
point in time for those apps which acquire/drop the blockers.

Thanks,

	tglx
