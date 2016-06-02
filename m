From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 2/8] cpufreq: s3c24xx: Remove useless checks
Date: Thu, 02 Jun 2016 08:49:57 +0200
Message-ID: <574FD715.3000106@samsung.com>
References: <cover.1464776797.git.viresh.kumar@linaro.org>
 <59631fdb5720381c8831ab90c0b6d05e7bcacc0c.1464776797.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <59631fdb5720381c8831ab90c0b6d05e7bcacc0c.1464776797.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/01/2016 12:34 PM, Viresh Kumar wrote:
> These aren't required at all, remove them.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/s3c24xx-cpufreq.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Do you wish me to take it through samsung-soc tree?

Best regards,
Krzysztof
