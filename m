From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 09:32:46 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE896716203771DD342__33751.7986227342$1234886087$gmane$org@dlee02.ent.ti.com>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<13B9B4C6EF24D648824FF11BE896716203771DD01B@dlee02.ent.ti.com>
	<20090216145948.6fea81c3@infradead.org>	<200902170019.40599.rjw@sisk.pl>
	<20090216232329.GA15678@srcf.ucam.org>
	<20090217142001.GB12378@bulgaria.corp.google.com>
	<20090217064630.688bf639@infradead.org>
	<20090217145141.GA26158@srcf.ucam.org>
	<20090217065622.3e0a9956@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090217065622.3e0a9956@infradead.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Kyle Moffett <kyle@moffetthome.net>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, LKML <linux-kernel@vger.kernel.org>, Uli Luckas <u.luckas@road.de>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> From: Arjan van de Ven [mailto:arjan@infradead.org]
> Sent: Tuesday, February 17, 2009 8:56 AM

> On Tue, 17 Feb 2009 14:51:41 +0000
> Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> > On Tue, Feb 17, 2009 at 06:46:30AM -0800, Arjan van de Ven wrote:
> >
> > > actually with powertop... on the open source side things are
> > > actually won. It took all of 6 months...
> > > I don't see that as a valid excuse. In fact, if this kind of
> > > solution makes real userspace scheduled timers to be missed then I
> > > consider it a serious functionality misfeature.

Maybe for the optimization time scales x86 is targeting.  User space across OS still throws off our MHz a good distance from ideal estimates.

I still hear complaints about frequent wakes even when using a bare minimum user space which can get 95+% lowest C-state residency with average 700mS.  If you frequency scale in lowest C-State YMMV if your external power chip is slow.  Waiting on voltage ramp times is lost power.

One of our Application people (application is low level here) went though and tweaked kernel in a few spots with minimum user space and could get (this is with out a meaningful UI on NFS root mounted system):

1st set of hacks got:
Cn Avg residency
C0 (cpu running) ( 0.0%)
C1 0.0ms ( 0.0%)
C2 0.0ms ( 0.0%)
C3 217.2ms ( 1.8%)
C4 0.0ms ( 0.0%)
C5 0.0ms ( 0.0%)
C6 354.9ms ( 0.3%)
C7 1953.4ms (97.8%)

Second set got:
# powertop -d -t 300
PowerTOP 1.10 (C) 2007 Intel Corporation
Collecting data for 300 seconds
Cn Avg residency
C0 (cpu running) ( 0.0%)
C1 0.0ms ( 0.0%)
C2 0.2ms ( 0.0%)
C3 3.8ms ( 0.0%)
C4 0.0ms ( 0.0%)
C5 0.0ms ( 0.0%)
C6 0.0ms ( 0.0%)
C7 73165.9ms (100.0%)

I'll see about posting his change write up.  Not all probably can be done but several could.

> > Remember that Android has an open marketplace designed to appeal to
> > Java programmers - users are going to end up downloading code from
> > there and then blaming the platform if their battery life heads
> > towards zero. I think "We can't trust our userland not to be dumb" is
> > a valid concern.
>
> so use range timers / timer slack for those apps that you do not trust.
> That is not a big deal, and solves the issue of timer wakeups...

I not so sure it is that straight forward in practice.  End systems integrate a lot of 3rd party software who view performance 1st and have no thought of power.

It might be android has a better chance to control more of those api's being exported but its coverage isn't complete and others gluing pieces together won't.

Regards,
Richard W.
