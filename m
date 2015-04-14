From: Michael Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v8 00/18] Tegra124 CL-DVFS / DFLL clocksource + cpufreq
Date: Tue, 14 Apr 2015 14:06:52 -0700
Message-ID: <20150414210652.19585.10463@quantum>
References: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
 <20150311100741.GK19577@ulmo.nvidia.com>
 <20150410211157.14369.51754@quantum> <552CF947.9030609@kapsi.fi>
 <20150414192108.6a376ce8@bbrezillon> <552D6D34.2030806@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:32897 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050AbbDNVHC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2015 17:07:02 -0400
Received: by iecrt8 with SMTP id rt8so13369569iec.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2015 14:07:00 -0700 (PDT)
In-Reply-To: <552D6D34.2030806@kapsi.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, swarren@wwwdotorg.org, gnurou@gmail.com, pdeschrijver@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi

Quoting Mikko Perttunen (2015-04-14 12:40:36)
> On 04/14/2015 08:21 PM, Boris Brezillon wrote:
> > Hi Mikko,
> >
> > On Tue, 14 Apr 2015 14:25:59 +0300
> > Mikko Perttunen <mikko.perttunen@kapsi.fi> wrote:
> >
> >> On 04/11/2015 12:11 AM, Michael Turquette wrote:
> >>> Quoting Thierry Reding (2015-03-11 03:07:43)
> >>>> Hi Mike,
> >>>>
> >>>> Have you had a chance to look at these changes to the Tegra clock
> >>>> driver? If you're fine with it, I'd like to take these patches through
> >>>> the Tegra tree because the rest of the series depends on them. I can
> >>>> provide a stable branch in case we need to base other Tegra clock
> >>>> changes on top of this.
> >>>
> >>> Hi Thierry,
> >>>
> >>> Clock patches (and corresponding DT binding descriptions and changes to
> >>> DTS) look fine to me. Please add:
> >>>
> >>> Acked-by: Michael Turquette <mturquette@linaro.org>
> >>>
> >>> I did have a question about the beahvior of clk_put in one of Mikko's
> >>> patches but it should not gate this series. I'm just trying to find out
> >>> if we have a bug in the framework or if the Tegra driver is a special
> >>> case.
> >>>
> >>> Also I do not think a stable branch is necessary.
> >>>
> >>> Regards,
> >>> Mike
> >>>
> >>
> >> Looks like in the meantime, this has been partially broken by
> >> 03bc10ab5b0f "clk: check ->determine/round_rate() return value in
> >> clk_calc_new_rates". The highest rates supported by the DFLL clock have
> >> 1 in the MSB, so those cannot be entered after the aforementioned patch,
> >> as the return value of round_rate is interpreted as an error. Avenues
> >> that I can see: 1) revert the above patch 2) restrict the cpu clock rate
> >> to those with 0 in the MSB 3) move to 64-bit clock rates.
> >
> > How about changing ->determine_rate() and ->round_rate() prototypes so
> > that they always return 0 or an error code and passing the adjusted_rate
> > as an argument ?
> >
> > Something like that:
> >
> >       int (*round_rate)(struct clk_hw *hw, unsigned long *rate,
> >                         unsigned long *parent_rate);
> >       int (*determine_rate)(struct clk_hw *hw, unsigned long *rate,
> >                             unsigned long min_rate,
> >                             unsigned long max_rate,
> >                             unsigned long *best_parent_rate,
> >                             struct clk_hw **best_parent_hw);
> >
> > I know this implies a lot of changes (in all clock drivers and in the
> > core infrastructure), but I really think we should not mix error codes
> > and clock frequencies (even if we decide to move to a 64 bits rate
> > approach).
> 
> This sounds like a good idea, too.

I've had this idea as well, which is to never return rates but only
error codes, and rates are passed by reference like in your example
above. Clearly the *best_parent_rate stuff already functions this way.
Would be cool to use a programming language that supported complex
return types ;-)

> 
> >
> > Anyway, IMHO the only alternative to this solution is solution #3,
> > because #1 implies re-introducing another bug where
> > ->round_rate()/->determine_rate() are silently ignored, and #2 implies
> > lying about your DFLL capabilities.
> >
> 
> Yeah, #1 and #2 weren't really meant as realistic options to end up with :)

Yes, seems that we're heading towards #3. In the mean time option #1.5
(the one where we change the round_rate/determine_rate semantics) is
probably a good idea and can resolve this issue in the shorter term
compared to signed 64-bit rates (and will be necessary anyhow if we use
unsigned 64-bit rates).

I'll add this to the high priority todo list since the Tegra EMC stuff
won't go for 4.1 but will very likely go for 4.2.

Regards,
Mike

> 
> > Mike, what's your opinion ?
> >
> > Best Regards,
> >
> > Boris
> >
> 
> Cheers,
> Mikko.
> 
