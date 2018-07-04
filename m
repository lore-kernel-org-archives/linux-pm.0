From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 08/12] cpufreq: Add stub for cpufreq_update_policy()
Date: Wed, 4 Jul 2018 16:14:34 +0530
Message-ID: <20180704104434.subvhwvnkkiv255c@vireshk-i7>
References: <20180703234705.227473-1-mka@chromium.org>
 <20180703234705.227473-9-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180703234705.227473-9-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

On 03-07-18, 16:47, Matthias Kaehlcke wrote:
> cpufreq stubs out some functions when CONFIG_CPU_FREQ=n , but
> cpufreq_update_policy() is not among them. The throttler driver
> (https://patchwork.kernel.org/patch/10453351/) uses cpufreq as one
> possible throttling mechanism, but it can still be useful without
> cpufreq. Stubbing out cpufreq_update_policy() allows the throttler
> driver to be built without ugly #ifdef'ery when cpufreq is disabled.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> ---
> Changes in v5:
> - none
> 
> Changes in v4:
> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> 
> Changes in v3:
> - patch added to series
> ---
>  include/linux/cpufreq.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 882a9b9e34bc..dba8c4951e2e 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -210,6 +210,7 @@ static inline unsigned int cpufreq_quick_get_max(unsigned int cpu)
>  	return 0;
>  }
>  static inline void disable_cpufreq(void) { }
> +static inline void cpufreq_update_policy(unsigned int cpu) { }
>  #endif
>  
>  #ifdef CONFIG_CPU_FREQ_STAT

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
