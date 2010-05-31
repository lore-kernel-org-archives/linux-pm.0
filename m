From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Tue, 1 Jun 2010 00:05:19 +0200
Message-ID: <201006010005.19554.rjw__49980.2270126112$1275343562$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1005272334040.3478@localhost.localdomain>
	<20100531143339.249ae1f4@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100531143339.249ae1f4@notabene.brown>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Neil Brown <neilb@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Monday 31 May 2010, Neil Brown wrote:
> On Thu, 27 May 2010 23:40:29 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Thu, 27 May 2010, Rafael J. Wysocki wrote:
> > 
> > > On Thursday 27 May 2010, Thomas Gleixner wrote:
> > > > On Thu, 27 May 2010, Alan Stern wrote:
> > > > 
> > > > > On Thu, 27 May 2010, Felipe Balbi wrote:
> > > > > 
> > > > > > On Thu, May 27, 2010 at 05:06:23PM +0200, ext Alan Stern wrote:
> > > > > > >If people don't mind, here is a greatly simplified summary of the
> > > > > > >comments and objections I have seen so far on this thread:
> > > > > > >
> > > > > > >	The in-kernel suspend blocker implementation is okay, even
> > > > > > >	beneficial.
> > > > > > 
> > > > > > I disagree here. I believe expressing that as QoS is much better. Let 
> > > > > > the kernel decide which power state is better as long as I can say I 
> > > > > > need 100us IRQ latency or 100ms wakeup latency.
> > > > > 
> > > > > Does this mean you believe "echo mem >/sys/power/state" is bad and
> > > > > should be removed?  Or "echo disk >/sys/power/state"?  They pay no
> > > > 
> > > > mem should be replaced by an idle suspend to ram mechanism
> > > 
> > > Well, what about when I want the machine to suspend _regardless_ of whether
> > > or not it's idle at the moment?  That actually happens quite often to me. :-)
> > 
> > Fair enough. Let's agree on a non ambigous terminology then:
> > 
> >      forced:
> > 
> > 	     suspend which you enforce via user interaction, which
> >      	     also implies that you risk losing wakeups depending on
> >      	     the hardware properties
> 
> Reasonable definition I think.  However the current implementation doesn't
> exactly match it.
> With the current implementation you risk losing wakeups *independent* of the
> hardware properties.

Define "losing", please.

Currently, we simply don't regard hardware signals occuring _during_ the
suspend operation itself as wakeups (unless they are wakeup interrupts to be
precise, because these _are_ taken into account by our current code).

The reason is that the meaning of given event may be _different_ at run time
and after the system has been suspended.  For example, consider a power button
on a PC box.  If it's pressed at run time, it usually means "power off the
system" to the kernel.  After the system has been suspended, however, it means
"wake up".  So, you have to switch from one interpretation of the event to the
other and that's not an atomic operaition (to put it lightly).

> Even with ideal hardware events can be lost - by which I mean that they will
> not be seen until some other event effects a wake-up.
> e.g. the interrupt which signals the event happens immediately before the
> suspend is requested (or maybe at the same time as), but the process which
> needs to handle the event doesn't get a chance to see it before the suspend
> procedure freezes that process, and even if it did it would have no way to
> abort the suspend.
> 
> So I submit that the current implementation doesn't match your description of
> "forced", is therefore buggy, and that if it were fixed, that would be
> sufficient to meet the immediate needs of android.

I don't really think it may be fixed with respect to every possible kind of
hardware.  On platforms where I/O interrupts are wakeup events it should
work right now.  On other platforms it may be impossible to overcome hardware
limitations.

Thanks,
Rafael
