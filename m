From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 13:36:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005271334560.3239-100000__7456.47849184952$1274982000$gmane$org@iolanthe.rowland.org>
References: <alpine.LFD.2.00.1005271905000.3032@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1005271905000.3032@localhost.localdomain>
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
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 27 May 2010, Thomas Gleixner wrote:

> Crap. Stop beating on those lost wakeup events. If we lose them then
> the drivers are broken and do not handle the switch over correctly. Or
> the suspend mechanism is broken as it does not evaluate the system
> state correctly. Blockers are just papering over that w/o tackling the
> real problem.

That's the point -- suspend does not evaluate the system state 
correctly because it doesn't have the necessary information.  Suspend 
blockers are a way of providing it that information.  They don't paper 
over the problem; they solve it.

Alan Stern
