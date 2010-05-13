From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 00:04:02 +0200
Message-ID: <201005140004.02456.rjw__2673.7900138416$1273788513$gmane$org@sisk.pl>
References: <20100513191717.GA3428@atomide.com>
	<Pine.LNX.4.44L0.1005131729510.1731-100000@iolanthe.rowland.org>
	<20100513214739.GM3428@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100513214739.GM3428@atomide.com>
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
Cc: Arve@smtp1.linux-foundation.org, Kernel development list <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@ericsson.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 13 May 2010, Tony Lindgren wrote:
> * Alan Stern <stern@rowland.harvard.edu> [100513 14:32]:
> > On Thu, 13 May 2010, Tony Lindgren wrote:
> > 
> > > The difference between echo mem > /sys/power/state and suspend blocks
> > > is that with suspend blocks the system keeps running.
> > 
> > Irrelevant.  Paul wasn't talking about the suspend blockers; he was 
> > talking about opportunistic suspend.  So what's the difference between 
> > opportunistic suspend and "echo mem >/sys/power/state"?  Especially 
> > when suspend blockers aren't being used?
> 
> Opportunistic suspend is really trying to do runtime PM, see below.

NO, IT IS NOT!  What it does is to detect situations in which it is desirable
to put the _entire_ _system_ to sleep, while runtime PM works on a per-device
basis.

> > > And that's why 
> > > it should be handled by runtime power management instead.
> > 
> > Runtime PM is not capable of freezing userspace and shutting down CPUs.  
> > More or less by definition -- if it could then it wouldn't be "runtime" 
> > any more, since the processor wouldn't be running.
> 
> Not true. We are already powering off CPUs and rebooting them for
> at least omaps in every idle loop using cpuidle. The memory stays on.

What about user space, though?  Do you freeze it?

> > > The suspend blocks seems like a hack to spam filter good and bad
> > > apps from timer usage point of view. Applications are categorized
> > > as good or bad depending if they grab a susped blocker or not.
> > 
> > You're referring just to the userspace part of the suspend blocker 
> > API.  What about the kernel part?
> 
> IMHO some timer flags should be used in the kernel too. Currently
> there's no way of knowing which timers are good or bad from suspend
> point of view.

How is that answering the Alan's question?

Rafael
