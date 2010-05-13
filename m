From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 17:37:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005131729510.1731-100000__23710.3070169271$1273786671$gmane$org@iolanthe.rowland.org>
References: <20100513191717.GA3428@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100513191717.GA3428@atomide.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Linus Walleij <linus.walleij@ericsson.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 13 May 2010, Tony Lindgren wrote:

> * Alan Stern <stern@rowland.harvard.edu> [100513 07:11]:
> > On Wed, 12 May 2010, Paul Walmsley wrote:
> > 
> > > Hello,
> > > 
> > > Some general comments on the suspend blockers/wakelock/opportunistic
> > > suspend v6 patch series, posted here:
> > > 
> > >     https://lists.linux-foundation.org/pipermail/linux-pm/2010-April/025146.html
> > > 
> > > The comments below are somewhat telegraphic in the interests of 
> > > readability - more specific comments to follow in later E-mails. I am 
> > > indebted to those of us who discussed these issues at LPC last year and 
> > > ELC this year for several stimulating discussions.
> > > 
> > > There are several general problems with the design of opportunistic
> > > suspend and suspend-blocks.
> > > 
> > > 1. The opportunistic suspend code bypasses existing Linux kernel code,
> > >    such as timers and the scheduler, that indicates when code
> > >    needs to run, and when the system is idle.
> > 
> > Whoa!  That's not my understanding at all.
> > 
> > As I see it, opportunistic suspend doesn't bypass any code that isn't 
> > already bypassed by the existing suspend code.  Users can do
> > 
> > 	echo mem >/sys/power/state
> > 
> > whenever they want, without regard to kernel timers and the scheduler 
> > (other than the fact that the user's thread must be running in order to 
> > carry out the write, of course).
> 
> The difference between echo mem > /sys/power/state and suspend blocks
> is that with suspend blocks the system keeps running.

Irrelevant.  Paul wasn't talking about the suspend blockers; he was 
talking about opportunistic suspend.  So what's the difference between 
opportunistic suspend and "echo mem >/sys/power/state"?  Especially 
when suspend blockers aren't being used?

> And that's why 
> it should be handled by runtime power management instead.

Runtime PM is not capable of freezing userspace and shutting down CPUs.  
More or less by definition -- if it could then it wouldn't be "runtime" 
any more, since the processor wouldn't be running.

> The suspend blocks seems like a hack to spam filter good and bad
> apps from timer usage point of view. Applications are categorized
> as good or bad depending if they grab a susped blocker or not.

You're referring just to the userspace part of the suspend blocker 
API.  What about the kernel part?

> I believe categorizing the apps should be instead done with some
> timer flags or cgroups instead.

That would be compatible with using suspend blockers.

Alan Stern
