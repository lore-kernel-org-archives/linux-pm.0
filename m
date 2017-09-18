From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq(-dt) with two clocks but one regulator
Date: Sun, 17 Sep 2017 18:24:16 -0700
Message-ID: <20170918012416.GB17030@ubuntu>
References: <1515316.mHJbnBRRvK@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:43519 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbdIRBYS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Sep 2017 21:24:18 -0400
Received: by mail-pf0-f177.google.com with SMTP id y29so4017584pff.0
        for <linux-pm@vger.kernel.org>; Sun, 17 Sep 2017 18:24:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1515316.mHJbnBRRvK@phil>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, Klaus Goger <klaus.goger@theobroma-systems.com>, vincent.guittot@linaro.org

Hi Heiko,

On 15-09-17, 00:53, Heiko Stuebner wrote:
> Hi Viresh,
> 
> if possible I'd like a pointer in the right direction for the following
> situation:
> 
> The rk3368 has two cpu clusters of 4 Cortex-A53 cores each, with separate
> clock supplies

These must be represented by two cpufreq policies no matter what. That's how the
hardware is.

> but sharing its supplying regulator.

That should be fine.

> It looks like it was
> originally meant for some switched big-little system, with the little
> cluster maxing out at 1.2GHz while the big cluster can reach 1.5GHz.

So, right now all can go to 1.5 GHz?

> This of course fails miserably with current cpufreq, as the two sets
> of operating points fight over control of the regulator

Why so? I am not sure I understood this part yet. Both the clusters should try
to set their constraints and the intersection should be selected by the
regulator core? Can you share the OPP tables, so that we can discuss more.

> and after talking
> with real-life users of the soc it seems most desireable to have all
> 8 cores available at 1.2GHz than only 4 at 1.5GHz max.

What's wrong with all at 1.5 GHz?

> But as the clock seems to be bound to the opp table itself simply sharing
> the table of course also doesn't work

No, the OPP table shouldn't be shared at all. Its something to be shared by a
cluster only.

> as only the first clock would be set.
> 
> 
> I'm currently only seeing somehow hacky options to solve this, so if you
> have some direction on how to solve something like this I would be really
> grateful :-)

I think it should just work, but otherwise as well we can update some framework
to make it work. Lets just get on the same line first and help me understand it
better.

-- 
viresh
