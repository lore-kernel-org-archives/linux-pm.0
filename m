From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH V2 Resend 41/92] cpufreq: cpu0: don't initialize part of
 policy that is set by core too
Date: Sat, 5 Oct 2013 16:00:23 +0800
Message-ID: <20131005080021.GI2734@S2101-09.ap.freescale.net>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
 <fbb20ba98d8b17473c34e6798f1ab0ac8d9b5c0d.1380783079.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fbb20ba98d8b17473c34e6798f1ab0ac8d9b5c0d.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 03, 2013 at 08:28:35PM +0530, Viresh Kumar wrote:
> Many common initializations of struct policy are moved to core now and hence
> this driver doesn't need to do it. This patch removes such code.
> 
> Most recent of those changes is to call ->get() in the core after calling
> ->init().
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

For cpu0 and imx6q changes,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

