From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 15:22:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005271520070.3239-100000__26718.5143814006$1274988346$gmane$org@iolanthe.rowland.org>
References: <1274982447.27810.5684.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274982447.27810.5684.camel@twins>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 27 May 2010, Peter Zijlstra wrote:

> On Thu, 2010-05-27 at 18:40 +0100, Matthew Garrett wrote:
> > On Thu, May 27, 2010 at 07:34:40PM +0200, Peter Zijlstra wrote:
> > > > we still need to be able to enter suspend while the system isn't idle.
> > > 
> > > _WHY_!?
> > 
> > Because if I'm running a kernel build in a tmpfs and I hit the sleep 
> > key, I need to go to sleep. Blocking processes on driver access isn't 
> > sufficient.
> 
> But that's a whole different issue. I agree that a forced suspend for
> things like that make sense, just not for power managing a running
> system.

Why not?  Or rather, why shouldn't it?

> PC style hardware like that doesn't wake up from suspend for
> funny things like a keypress either (good thing too).

Yes it does.  If I close the lid of my laptop, wait a few seconds for 
it to suspend, then open the lid (which does not wake it up), and hit a 
key -- it wakes up.

> Anyway all that already works (more or less), so I don't see the
> problem.

The "less" part is the problem.  It would be nice to have a forced 
suspend mode that is more dicriminating: Instead of activating 
immediately it would wait until all pending events were handled.

Alan Stern
