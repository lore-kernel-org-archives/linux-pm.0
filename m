From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v8 00/18] Tegra124 CL-DVFS / DFLL clocksource + cpufreq
Date: Tue, 14 Apr 2015 19:21:08 +0200
Message-ID: <20150414192108.6a376ce8@bbrezillon>
References: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
	<20150311100741.GK19577@ulmo.nvidia.com>
	<20150410211157.14369.51754@quantum>
	<552CF947.9030609@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:48991 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755756AbbDNRVN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2015 13:21:13 -0400
In-Reply-To: <552CF947.9030609@kapsi.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc: Michael Turquette <mturquette@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, swarren@wwwdotorg.org, gnurou@gmail.com, pdeschrijver@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi

Hi Mikko,

On Tue, 14 Apr 2015 14:25:59 +0300
Mikko Perttunen <mikko.perttunen@kapsi.fi> wrote:

> On 04/11/2015 12:11 AM, Michael Turquette wrote:
> > Quoting Thierry Reding (2015-03-11 03:07:43)
> >> Hi Mike,
> >>
> >> Have you had a chance to look at these changes to the Tegra clock
> >> driver? If you're fine with it, I'd like to take these patches through
> >> the Tegra tree because the rest of the series depends on them. I can
> >> provide a stable branch in case we need to base other Tegra clock
> >> changes on top of this.
> >
> > Hi Thierry,
> >
> > Clock patches (and corresponding DT binding descriptions and changes to
> > DTS) look fine to me. Please add:
> >
> > Acked-by: Michael Turquette <mturquette@linaro.org>
> >
> > I did have a question about the beahvior of clk_put in one of Mikko's
> > patches but it should not gate this series. I'm just trying to find out
> > if we have a bug in the framework or if the Tegra driver is a special
> > case.
> >
> > Also I do not think a stable branch is necessary.
> >
> > Regards,
> > Mike
> >
> 
> Looks like in the meantime, this has been partially broken by
> 03bc10ab5b0f "clk: check ->determine/round_rate() return value in 
> clk_calc_new_rates". The highest rates supported by the DFLL clock have 
> 1 in the MSB, so those cannot be entered after the aforementioned patch, 
> as the return value of round_rate is interpreted as an error. Avenues 
> that I can see: 1) revert the above patch 2) restrict the cpu clock rate 
> to those with 0 in the MSB 3) move to 64-bit clock rates.

How about changing ->determine_rate() and ->round_rate() prototypes so
that they always return 0 or an error code and passing the adjusted_rate
as an argument ?

Something like that:

	int (*round_rate)(struct clk_hw *hw, unsigned long *rate,
			  unsigned long *parent_rate);
	int (*determine_rate)(struct clk_hw *hw, unsigned long *rate,
			      unsigned long min_rate,
			      unsigned long max_rate,
			      unsigned long *best_parent_rate,
			      struct clk_hw **best_parent_hw);

I know this implies a lot of changes (in all clock drivers and in the
core infrastructure), but I really think we should not mix error codes
and clock frequencies (even if we decide to move to a 64 bits rate
approach).

Anyway, IMHO the only alternative to this solution is solution #3,
because #1 implies re-introducing another bug where
->round_rate()/->determine_rate() are silently ignored, and #2 implies
lying about your DFLL capabilities.

Mike, what's your opinion ?

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
