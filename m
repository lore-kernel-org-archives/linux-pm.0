From: Kukjin Kim <kgene@kernel.org>
Subject: RE: [PATCH V2 Resend 27/92] cpufreq: s3cx4xx: Use generic cpufreq
 routines
Date: Sat, 05 Oct 2013 11:27:45 +0900
Message-ID: <0d8a01cec172$7a008510$6e018f30$@org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
 <d43483a3c36ca89e75975485762f7ae9f75c8538.1380783079.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <d43483a3c36ca89e75975485762f7ae9f75c8538.1380783079.git.viresh.kumar@linaro.org>
Content-language: ko
Sender: cpufreq-owner@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@linaro.org>, rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Viresh Kumar wrote:
> 
> Most of the CPUFreq drivers do similar things in .exit() and .verify()
> routines
> and .attr. So its better if we have generic routines for them which can be
> used
> by cpufreq drivers then.
> 
> This patch uses these generic routines for this driver.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

BTW, would be helpful to me if you could add regarding maintainers in cc on
the common stuff of this changes :-)

Thanks,
Kukjin

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/s3c2416-cpufreq.c | 19 ++-----------------
>  drivers/cpufreq/s3c24xx-cpufreq.c |  9 ---------
>  drivers/cpufreq/s3c64xx-cpufreq.c | 10 +---------
>  3 files changed, 3 insertions(+), 35 deletions(-)

