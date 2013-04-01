From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] cpufreq: cpufreq-cpu0: Call CPUFREQ_POSTCHANGE notifier
 for failure cases too
Date: Mon, 1 Apr 2013 14:53:26 +0800
Message-ID: <20130401065324.GF1693@S2101-09.ap.freescale.net>
References: <cbaaebaef94c13405888bc150e12d62754fc266d.1364653063.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cbaaebaef94c13405888bc150e12d62754fc266d.1364653063.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com
List-Id: linux-pm@vger.kernel.org

On Sat, Mar 30, 2013 at 07:48:07PM +0530, Viresh Kumar wrote:
> Currently we are simply returning from target() if we encounter some error after
> broadcasting CPUFREQ_PRECHANGE notifier. Which looks to be wrong as others might
> depend on POSTCHANGE notifier for their functioning.
> 
> So, better broadcast CPUFREQ_POSTCHANGE notifier for these failure cases too,
> but with old frequency.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

