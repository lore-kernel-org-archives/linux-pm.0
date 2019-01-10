From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v1 2/7] drivers: cpufreq: Add thermal_cooling_device
 pointer to struct cpufreq_policy
Date: Wed, 9 Jan 2019 17:01:57 -0800
Message-ID: <20190110010157.GU261387@google.com>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <aadc9cff04dc310138b41979239ce51938afedce.1547078153.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <aadc9cff04dc310138b41979239ce51938afedce.1547078153.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, viresh.kumar@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org, dianders@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 10, 2019 at 05:30:51AM +0530, Amit Kucheria wrote:
> Several cpufreq drivers register themselves as thermal cooling devices.
> Adding a pointer to struct cpufreq_policy removes the need for them to
> store this pointer in a private data structure.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  include/linux/cpufreq.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index c86d6d8bdfed..2496549d7573 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -95,6 +95,8 @@ struct cpufreq_policy {
>  	struct cpufreq_frequency_table	*freq_table;
>  	enum cpufreq_table_sorting freq_table_sorted;
>  
> +	struct thermal_cooling_device *cooldev; /* Pointer to the cooling
> +						 * device if used for thermal mitigation */
>  	struct list_head        policy_list;
>  	struct kobject		kobj;
>  	struct completion	kobj_unregister;

I've mixed feelings about this. It's definitely desirable to avoid
code duplication and tying the cooling device to the cpufreq_policy is
a convenient way to achieve that. However semantically it seems a bit
odd that a CPU cooling device is part of the cpufreq policy.

Anyway, unless there are better ideas we probably want to be pragmatic
here, so if Viresh is fine with it who am I to complain ;-)

Cheers

Matthias
