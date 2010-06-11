From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suspend blockers & Android integration
Date: Fri, 11 Jun 2010 16:48:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006111638040.19894-100000__10731.6342335709$1276289406$gmane$org@netrider.rowland.org>
References: <1276268539.2862.92.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1276268539.2862.92.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: tytso@mit.edu, Peter Zijlstra <a.p.zijlstra@chello.nl>, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Fri, 11 Jun 2010, Mark Brown wrote:

> On Fri, Jun 11, 2010 at 10:46:27AM -0400, Alan Stern wrote:
> > On Fri, 11 Jun 2010, James Bottomley wrote:
> 
> > > The one thing that does look difficult is that these power constraints
> > > are device (and sometimes SoC) specific.  Expressing them in a generic
> > > way for the cpu govenors to make sense of might be hard.
> 
> > Doesn't the clock framework already handle this sort of thing?
> 
> The clock framework is implemented independantly for each CPU.

That's not an impediment, since drivers' requirements regarding which 
clocks remain running in which power states are necessarily 
platform-dependent also.


On Fri, 11 Jun 2010, James Bottomley wrote:

> Well, there are two elements to "this sort of thing":
> 
>      1. Allow a driver to request that a given clock not be turned off.
>      2. Make the cpuidle governors aware of a pending "don't turn off X
>         clock source" so they can keep the system in a state where the
>         clock doesn't get powered down.
> 
> As far as I can tell from the code, neither currently exists at the
> moment.

Well then, can (or should) the clock framework interact with the
pm-qos subsystem so that drivers don't have to worry about it?

Alan Stern
