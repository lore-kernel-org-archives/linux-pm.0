From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC] Revert "cpufreq: dt: Identify cpu-sharing for
 platforms without operating-points-v2"
Date: Thu, 16 Jun 2016 12:05:29 +0530
Message-ID: <20160616063529.GA5726@vireshk-i7>
References: <20160616053524.19921-1-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160616053524.19921-1-acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

+Rafael

On 16-06-16, 14:35, Alexandre Courbot wrote:
> This is not an actual request for revert, but rather for comments about
> the observed behavior since I am not really familiar with cpufreq.
> 
> I am observing a serious performance regression on Jetson TK1 since 4.7-rc1:
> namely, moving windows under X would become unsufferably slow, and graphical
> performance under X in general is seriously degraded. After bisecting, I
> found the regression to be visible since commit 1530b9963eeb ("cpufreq: dt: 
> Identify cpu-sharing for platforms without operating-points-v2")
> 
> If I revert this commit, I noticed that the CPU frequency immediately jumps to
> a higher frequency once I start moving windows (resulting in a smooth and
> responsive action), whereas enabling this commit causes the CPU frequency to
> remain low (typically 204 Mhz) in that case, resulting in CPU-bound slowness.
> 
> What happens is that with 1530b9963eeb applied, dev_pm_opp_get_sharing_cpus()
> returns zero causing the fallback variable to remain false, whereas without it
> opp_v1 is set to true.
> 
> It is not clear to me whether this is a cpufreq issue or a Tegra issue, so I am
> posting this in the hope to get clarifications from either side.
> 
> Thanks!

Yeah, you just hit a corner case. Sorry about that :(

Can you try a patch that I sent to you instead? Its subject is:

[PATCH] PM / OPP: 'UNKNOWN' status of opp-table->shared

Also I would like to know one more thing. You can hit this bug only if
some other piece of code for your platform is creating OPP table for
the CPUs. Which code is doing that ?

-- 
viresh
