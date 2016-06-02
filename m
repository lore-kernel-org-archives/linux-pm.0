From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 1/8] ARM: s3c24xx: Sort cpufreq tables
Date: Thu, 02 Jun 2016 08:34:38 +0200
Message-ID: <574FD37E.3090706@samsung.com>
References: <cover.1464776797.git.viresh.kumar@linaro.org>
 <872a8b970ce7eabb06b988680eaf6b1154fe99fa.1464776797.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <872a8b970ce7eabb06b988680eaf6b1154fe99fa.1464776797.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/01/2016 12:34 PM, Viresh Kumar wrote:
> Some later changes in cpufreq core require these tables to be sorted
> based on ascending order of their frequencies. There was only one
> offender. Fix it and add comments over the arrays.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/mach-s3c24xx/pll-s3c2410.c          | 3 ++-
>  arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c | 1 +
>  arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 

Thanks, applied.

Best regards,
Krzysztof
