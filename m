From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 13/44] cpufreq: cpu0: Use generic cpufreq routines
Date: Mon, 12 Aug 2013 15:58:24 +0800
Message-ID: <20130812075822.GF25061@S2101-09.ap.freescale.net>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
 <3978525eb8c4b042fd399bb506d3d59960680538.1376116345.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3978525eb8c4b042fd399bb506d3d59960680538.1376116345.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 10, 2013 at 12:14:09PM +0530, Viresh Kumar wrote:
> Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
> and .attr. So its better if we have generic routines for them which can be used
> by cpufreq drivers then.
> 
> This patch uses these generic routines for this driver.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

