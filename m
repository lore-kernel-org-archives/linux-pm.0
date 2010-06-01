From: mark gross <640e9920@gmail.com>
Subject: Re: [RFC] lp_events: an lternitive to suspend blocker
 user mode and kernel API
Date: Mon, 31 May 2010 22:09:14 -0700
Message-ID: <20100601050914.GG31155__35117.1842114583$1275368998$gmane$org@gvim.org>
References: <20100530200409.GA21632@gvim.org>
	<20100531095753.4c174f2d@notabene.brown>
	<20100531221035.GB31155@gvim.org> <201006010045.21382.rjw@sisk.pl>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201006010045.21382.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: mark.gross@intel.com, markgross@thegnar.org, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Arve@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 01, 2010 at 12:45:21AM +0200, Rafael J. Wysocki wrote:
> On Tuesday 01 June 2010, mark gross wrote:
> > On Mon, May 31, 2010 at 09:57:53AM +1000, Neil Brown wrote:
> ...
> > > So I would suggest modifying your proposal to simply create a new 'input'
> > > device.  Any driver that supports wake-from-suspend queues an event to that
> > > device when a wakeup event occurs.  If the device is open and has any queued
> > > events, then a suspend request such as 'echo mem > /sys/power/state' completes
> > > without going into full suspend.
> > 
> > /me likes.
> >  
> > > Then you just need to convince us that this mechanism can be used without any
> > > race problems.  If it can, then it would certainly be a simple and
> > > unobtrusive approach.
> > 
> > Lets find out.
> 
> Simple question: how is that better than the Alan Stern's proposed approach?
>
I just saw Alan Stern's proposal, and have gotten some input form some
others.  I can't say my patch represents a better Idea than what Alan
proposed.  However; what Alan (and Thomas) are talking about is
effectively the same as the kenrel mode wakelock/suspend blocker thing,
and although it reuses existing infrastructure, it doesn't solve the
problem of needing overlapping blocking sections of code from ISR to
user mode.

(which to be fair, I seem to be the only one that feels thats a problem.
so perhaps I'm making that a bigger issue than it is...)

Also my current patch may be better in that it makes it explicit that we
need wake event notification up to user mode, where this Alan's leaves
it as an exercise for the integrator.

(wake events are not just key presses or lid events,  there is modem,
UI, network, usb, block device insertion, RTC and likely a few other
wake events that need to be handled effectively before re-suspending.

so to answer your question: I'm not sure.  I need to stub out what Alan
is proposing and hash it out with some folks.  I'm sorry I can't be
decisive on this yet.

I'll stub out a new pm_qos class for "qos_eventually" (perhaps with a
better name.) some modes to the input event mechanism to see how that
feels.


--mgross
