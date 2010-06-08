From: mark gross <640e9920@gmail.com>
Subject: Re: PM QoS dynamic resource manager
Date: Mon, 7 Jun 2010 20:33:33 -0700
Message-ID: <20100608033333.GA23066@gvim.org>
References: <alpine.DEB.2.00.1005211533530.25765@pchidamb-lnx.qualcomm.com>
	<20100525145223.GA4974@gvim.org>
	<AANLkTikLgu2c1GPE3glHLlaznOM59SVeCj2NHzDjyjZR@mail.gmail.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikLgu2c1GPE3glHLlaznOM59SVeCj2NHzDjyjZR@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mike Chan <mike@android.com>
Cc: linux-pm@lists.linux-foundation.org, mark gross <640e9920@gmail.com>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 07, 2010 at 05:18:25PM -0700, Mike Chan wrote:
> On Tue, May 25, 2010 at 7:52 AM, mark gross <640e9920@gmail.com> wrote:
> > On Fri, May 21, 2010 at 03:37:39PM -0600, Chidambaram, Praveen wrote:
> >> Hi,
> >>
> >> I am looking for some extensible features for PM QoS. Specifically,
> >> dynamic runtime parameters that my architecture could define at
> >> runtime and the drivers can make use of.
> >>
> >> What are the plans in this regard?
> >
> > we've talked about it a few times in the past.
> >
> > It's come down to how do we prevent platform independent code from
> > depending on such platform independent dynamic prarams in a sane manner.
> >
> > I've alway's pushed for coming up with more reasonable abstractions that
> > could be re-used and adding them (like the bus thing) as opposed to
> > having drivers make / use new parrameters dynamically.
> >
> 
> Would it be possible to elaborate on the bus resource ideas you had? I
> couldn't find anything in the archives. Sounds like a similar that we
> (Android / embedded world) are having (or will) on multiple platforms
> (omap / msm/ tegra).
> 
> -- Mike

Its been 5 months since the last time this basic discussion happened,
and I'll do some searching for the thread later but;

But the bus thing we did post a patch to get the code aurora idea
included, but for some reason that patch didn't stick.
http://lkml.org/lkml/2010/4/22/213  (I guess the details are in the
archives)  I'm happy to re-visit it.

WRT ideas I've had, that went unsupported (well, rejected) by the domain
experts at that time, where around throttling the GPU and / or it access
to the memory it used.

Most of the ideas where around clock throttling of buses and memory.
Things like throttling the graphics BW to whatever memory it was using,
or clocking down the GPU when idle.  My thought was a pm_qos hint could
be handy, but I was assured that modern hardware auto-throttled and
didn't need this.  So I dropped it.  (At that time I also thought it
would apply to HD audio to allow better DAC throttling.  I also dropped
this one too for the same reasons.)

One problem was what type of units to use when talking about the qos of
the graphics was not obvious.  It needs to be something meaningful to
be portable or provide a good abstraction.

Bus bandwidth in KBS is ok for somethings but its not meaningful to an
application that wants to request a specific minimum graphics
performance.  As I type this I suppose a bandwidth for blts per
second would work for the current Android graphics but for os stacks
that more fully use the GL engine or games running on android I don't
think that its a meaningful metric for describing GPU performance
throttling. 

what ideas do you have?  I would like to seem more pm_qos users.

--mgross
