From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dt: add Socionext UniPhier SoCs support
Date: Thu, 27 Oct 2016 08:57:15 +0530
Message-ID: <20161027032715.GO9162@vireshk-i7>
References: <1477500093-12796-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477500093-12796-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 27-10-16, 01:41, Masahiro Yamada wrote:
> Add compatible strings for Pro5, PXs2, LD6b, LD11, LD20 SoCs to use
> the generic cpufreq driver.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/cpufreq/cpufreq-dt-platdev.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
