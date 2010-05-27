From: Neil Brown <neilb@suse.de>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Thu, 27 May 2010 17:23:54 +1000
Message-ID: <20100527172354.43e46cef__42266.6444014341$1274973864$gmane$org@notabene.brown>
References: <Pine.LNX.4.44L0.1005251647530.1634-100000@iolanthe.rowland.org>
	<201005252344.37639.rjw@sisk.pl>
	<AANLkTimL5rU5lALezEZVCwdcZL85tVahhsTibdpq9s-Y@mail.gmail.com>
	<1274863342.5882.4850.camel@twins>
	<1274863987.5882.4892.camel@twins>
	<20100526124929.GA32580@srcf.ucam.org>
	<1274878665.27810.354.camel@twins>
	<20100526132051.GA1834@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100526132051.GA1834@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Greg KH <gregkh@suse.de>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, James Bottomley <James.Bottomley@suse.de>, tytso@mit.edu, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 May 2010 14:20:51 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Wed, May 26, 2010 at 02:57:45PM +0200, Peter Zijlstra wrote:
> 
> > I fail to see why. In both cases the woken userspace will contact a
> > central governing task, either the kernel or the userspace suspend
> > manager, and inform it there is work to be done, and please don't
> > suspend now.
> 
> Thinking about this, you're right - we don't have to wait, but that does 
> result in another problem. Imagine we get two wakeup events 
> approximately simultaneously. In the kernel-level universe the kernel 
> knows when both have been handled. In the user-level universe, we may 
> have one task schedule, bump the count, handle the event, drop the count 
> and then we attempt a suspend again because the second event handler 
> hasn't had an opportunity to run yet. We'll then attempt a suspend and 
> immediately bounce back up. That's kind of wasteful, although it'd be 
> somewhat mitigated by checking that right at the top of suspend entry 
> and returning -EAGAIN or similar.
> 

(I'm coming a little late to this party, so excuse me if I say something that
has already been covered however...)

The above triggers a sequence of thoughts which (When they settled down) look
a bit like this.

At the hardware level, there is a thing that we could call a "suspend
blocker".  It is an interrupt (presumably level-triggered) that causes the
processor to come out of suspend, or not to go into it.

Maybe it makes sense to export a similar thing from the kernel to user-space.
When any event happens that would wake the device (and drivers need to know
about these already), it would present something to user-space to say that
the event happened.

When user-space processes the event, it clears the event indicator.

When there are no more current event indicators, userspace is allowed to
request a suspend.  Obviously this could fail as an event could happen at any
moment, but the same is true when the kernel asks the device to suspend, an
interrupt might happen immediately to stop it.  But in either case an event
will be reported.  So when userspace requests a suspend and it fails, it
will see events reported and so will wait for them to be handled.

I imagine a sysfs directory with files that appear when events are pending.
We could have some separate mechanism for user-space processes to request
that the suspend-daemon not suspend.  Then it suspends whenever there are no
pending requests from user-space or from the kernel.

The advantage of this model of suspend-blockers is that it is a close
analogue for something that already exists in hardware so it isn't really
creating new concepts, just giving the Linux virtual-machine features that
have proved themselves in physical machines.

The cost is that any wake-up event needs to not only be handled, but also
explicitly acknowledged by clearing the relevant suspend-blocker (i.e.
removing the file from sysfs, or whatever interface was ultimately chosen).
I'm hoping that isn't a big cost.

NeilBrown
