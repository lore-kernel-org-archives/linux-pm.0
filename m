From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: cpufreq(-dt) with two clocks but one regulator
Date: Tue, 19 Sep 2017 00:40:23 +0200
Message-ID: <2224473.GjtbWfbYHk@phil>
References: <1515316.mHJbnBRRvK@phil> <20170918012416.GB17030@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:56436 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750783AbdIRWkZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 Sep 2017 18:40:25 -0400
In-Reply-To: <20170918012416.GB17030@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, Klaus Goger <klaus.goger@theobroma-systems.com>, vincent.guittot@linaro.org

Hi Viresh,

Am Sonntag, 17. September 2017, 18:24:16 CEST schrieb Viresh Kumar:
> On 15-09-17, 00:53, Heiko Stuebner wrote:
> > if possible I'd like a pointer in the right direction for the following
> > situation:
> > 
> > The rk3368 has two cpu clusters of 4 Cortex-A53 cores each, with separate
> > clock supplies
> 
> These must be represented by two cpufreq policies no matter what. That's how the
> hardware is.
> 
> > but sharing its supplying regulator.
> 
> That should be fine.
> 
> > It looks like it was
> > originally meant for some switched big-little system, with the little
> > cluster maxing out at 1.2GHz while the big cluster can reach 1.5GHz.
> 
> So, right now all can go to 1.5 GHz?

No, the little cluster of 4 cores is rated at 1.2GHz max, while the big
cluster of 4 cores is rated at 1.5Ghz


> > This of course fails miserably with current cpufreq, as the two sets
> > of operating points fight over control of the regulator
> 
> Why so? I am not sure I understood this part yet. Both the clusters should try
> to set their constraints and the intersection should be selected by the
> regulator core? Can you share the OPP tables, so that we can discuss more.

Current submitted OPPs can be found at
https://patchwork.kernel.org/patch/9908519/

There were still issues with higher frequencies, so they don't list the
1.2 or 1.5GHz yet.

But opp sets pretty tight constraints. I.e. OPPs have of course one
preferred voltage, so you end up with u_volt_min = u_volt_max for each
operating point, thus the regulator also gets set in this way, removing any
intersection and thus making the regulator framework fail to set a voltage
for one of the clusters.

So for example, you have one cluster running at 600MHz@0.95V and the
other cluster running at 1008MHz@1.05V this results in regulator
constraints being
	0.95V-0.95V
and
	1.05V-1.05V
thus no intersection and whoever comes second looses.


> > and after talking
> > with real-life users of the soc it seems most desireable to have all
> > 8 cores available at 1.2GHz than only 4 at 1.5GHz max.
> 
> What's wrong with all at 1.5 GHz?

Only one of the two clusters can do that, see above.


> > But as the clock seems to be bound to the opp table itself simply sharing
> > the table of course also doesn't work
> 
> No, the OPP table shouldn't be shared at all. Its something to be shared by a
> cluster only.

Yeah, with dt (and OPPs) being a hardware description that is true.


> > as only the first clock would be set.
> > 
> > 
> > I'm currently only seeing somehow hacky options to solve this, so if you
> > have some direction on how to solve something like this I would be really
> > grateful :-)
> 
> I think it should just work, but otherwise as well we can update some framework
> to make it work. Lets just get on the same line first and help me understand it
> better.


Heiko
