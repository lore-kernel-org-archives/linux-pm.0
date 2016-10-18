From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 5/6] clk: pxa: transfer CPU clock setting from
 pxa2xx-cpufreq
Date: Tue, 18 Oct 2016 16:48:55 -0700
Message-ID: <20161018234855.GO8871@codeaurora.org>
References: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
 <1476130149-31834-6-git-send-email-robert.jarzmik@free.fr>
 <87zim23zw3.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87zim23zw3.fsf@belgarion.home>
Sender: linux-clk-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Michael Turquette <mturquette@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/18, Robert Jarzmik wrote:
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> 
> > This is the initial stage to transfer the pxa25x and pxa27x CPU clocks
> > handling from cpufreq to the clock API. More precisely, the clocks
> > transferred are :
> >  - cpll : core pll, known also as the CPU core turbo frequency
> >  - core : core, known also as the CPU actual frequency, being either the
> >           CPU core turbo frequency or the CPU core run frequency
> >
> > This transfer is a prequel to shrink the code in pxa2xx-cpufreq.c, so
> > that it can become, at least in devicetree builds, the casual cpufreq-dt
> > driver.
> 
> Hi Michael and Stephen,
> 
> I'm planing on sending a v2 next week with minor corrections, mostly in the data
> tables (pxa25x_freqs and pxa27x_freqs), as testing prooved some values were wrong.
> 
> If you want me modify this serie, will you have time to review for next week or
> should I delay the v2 posting ?
> 

No need to delay. clk patches look fine with a quick glance. It
would be really neat if we could make cpufreq-dt work without DT.
What's blocking that? OPP tables?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
