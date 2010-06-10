From: Bryan Huntsman <bryanh@codeaurora.org>
Subject: Re: PM QoS dynamic resource manager
Date: Wed, 09 Jun 2010 18:22:39 -0700
Message-ID: <4C103E5F.9060600@codeaurora.org>
References: <alpine.DEB.2.00.1005211533530.25765@pchidamb-lnx.qualcomm.com>	<20100525145223.GA4974@gvim.org>	<AANLkTikLgu2c1GPE3glHLlaznOM59SVeCj2NHzDjyjZR@mail.gmail.com>	<20100608033333.GA23066@gvim.org>	<AANLkTinGBvZm870CsjocsCV1SmQ-FCCbJLtKWR1juB1Q@mail.gmail.com>	<4C0ECC38.2000003@codeaurora.org>	<20100609030525.GD26668@gvim.org>
	<AANLkTimu7-8CZUbA2lNuYauZDoOuiBJI_v3cSIF9qqul@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimu7-8CZUbA2lNuYauZDoOuiBJI_v3cSIF9qqul@mail.gmail.com>
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

> Are you thinking of having a (possible) pm qos constraint for each
> struct device_driver? Or struct bus_type ? This would probably work if
> for something like i2c. I'm not sure how this would work for memory
> bus. If you did not want to tie memory bus performance to cpu speeds,
> since (at least from what I"ve seen in omap / msm / tegra) there's no
> device_driver for a memory bus clock, but I could be wrong so someone
> correct me if I'm mistaken.

I'm imagining QoS classes similar to pm_qos.  Bandwidth, cpu latency, 
etc.  Each driver decides what to do for each type, if anything.  This 
gets passed up the tree and aggregated by a parent, which I think would 
be a bus driver but could be anyone who cares.  The QoS sink, for lack 
of a better term, decides what it wants to do with that data.  For a 
memory bus, it would be possible to add up all bandwidth requests and 
scale the bus clock accordingly.  It could also look at the active 
status of it's children, decide that the bus is inactive, and completely 
shut it off.  This is where having arch-specific bus drivers is 
necessary.  What each QoS sink does will vary drastically from platform 
to platform, but the input data should be somewhat consistent.  That's 
why I'm looking into extending runtime_pm in this manner.

> Typically I've seen (on msm / tegra / omap) if cpu is running at
> frequency X, then set mem bus clock to Y. Which leads to a bunch of
> hacks with drivers requesting frequency X, when really they need the
> faster memory speed.

Picking the right QoS constraints will always be a problem.  It's 
possible to abuse pm_qos today in the same manner.

> Perhaps both per bus-type pm qos parameter as well as a new global
> memory bus (per cpu for numa systems?) parameter.
> 
> I'm worried about trying to over-engineer a solution here for
> non-existing (or non-interested) customers. Ideally something that
> will fit our needs with Android on msm / omap / tegra platforms but
> still flexible enough for non-SOC.
> 
> -- Mike

In general, I share your dislike for over-engineering.  This doesn't 
feel like that quite yet.  From a high level at least, it would seem to 
fit in nicely with runtime_pm.  From Mark's comments it sounds like 
others are having similar thoughts.

- Bryan
