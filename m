From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 13:32:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005271329460.3239-100000__47613.4205390283$1274982237$gmane$org@iolanthe.rowland.org>
References: <1274980391.27810.5552.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274980391.27810.5552.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Thu, 27 May 2010, Peter Zijlstra wrote:

> On Thu, 2010-05-27 at 18:07 +0100, Matthew Garrett wrote:
> > On Thu, May 27, 2010 at 07:04:38PM +0200, Thomas Gleixner wrote:

> > > Opportunistic suspend is just a deep idle state, nothing else.
> > 
> > No. The useful property of opportunistic suspend is that nothing gets 
> > scheduled. That's fundamentally different to a deep idle state.
> 
> I think Alan and Thomas but certainly I am saying is that you can get to
> the same state without suspend.
> 
> Either you suspend (forcefully don't schedule stuff), or you end up
> blocking all tasks on QoS/resource limits and end up with an idle system
> that goes into a deep idle state (aka suspend).
> 
> So why isn't blocking every task on a QoS/resource good enough for you?

On some platforms (like those with ACPI), deeper power-savings are
available by using forced suspend than by using idle.  That used to be
the case on Android.  Arve has said that it isn't necessarily true any
more, but that's the way their software is set up.

Alan Stern
