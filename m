From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 23:21:59 +0200
Message-ID: <201005132321.59245.rjw__1604.31104382059$1273785772$gmane$org@sisk.pl>
References: <alpine.DEB.2.00.1005122118530.7624@utopia.booyaka.com>
	<20100513202320.GF3428@atomide.com>
	<20100513203412.GA21244@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100513203412.GA21244@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 13 May 2010, Matthew Garrett wrote:
> On Thu, May 13, 2010 at 01:23:20PM -0700, Tony Lindgren wrote:
> > * Matthew Garrett <mjg@redhat.com> [100513 13:03]:
> > > On Thu, May 13, 2010 at 01:00:04PM -0700, Tony Lindgren wrote:
> > > 
> > > > The system stays running because there's something to do. The system
> > > > won't suspend until all the processors hit the kernel idle loop and
> > > > the next_timer_interrupt_critical() returns nothing.
> > > 
> > > At which point an application in a busy loop cripples you.
> > 
> > Maybe you could deal with the misbehaving untrusted apps in the userspace
> > by sending kill -STOP to them when the screen blanks? Then continue
> > when some event wakes up the system again.
> 
> And if that's the application that's listening to the network socket 
> that you want to get a wakeup event from? This problem is hard. I'd love 
> there to be an elegant solution based on using the scheduler, but I 
> really don't know what it is.

I agree and I don't understand the problem that people have with the
opportunistic suspend feature.

It solves a practical issue that _at_ _the_ _moment_ cannot be solved
differently, while there's a growing number of out-of-tree drivers depending
on this framework.  We need those drivers in and because we don't have any
viable alternative at hand, we have no good reason to reject it.

Rafael
