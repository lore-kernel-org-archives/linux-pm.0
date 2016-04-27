From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Use IS_ENABLED() instead of checking for
 built-in or module
Date: Wed, 27 Apr 2016 07:31:40 +0530
Message-ID: <20160427020140.GU17047@vireshk-i7>
References: <1461716053-17722-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461716053-17722-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 26-04-16, 20:14, Javier Martinez Canillas wrote:
> The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
> built-in or as a module, use that macro instead of open coding the same.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  drivers/cpufreq/e_powersaver.c    | 14 +++++++-------
>  drivers/cpufreq/ppc_cbe_cpufreq.h |  2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
