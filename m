From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RFC 2/4] PM / devfreq: suspend subsystem on system
 suspend/hibernate
Date: Thu, 24 Nov 2016 10:35:08 +0900
Message-ID: <583643CC.1050504@samsung.com>
References: <1479909087-22659-1-git-send-email-tjakobi@math.uni-bielefeld.de>
 <CGME20161123135214epcas2p2f8456e0bbaa844132a84efea1293187b@epcas2p2.samsung.com>
 <1479909087-22659-3-git-send-email-tjakobi@math.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1479909087-22659-3-git-send-email-tjakobi@math.uni-bielefeld.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, m.reichl@fivetechno.de, myungjoo.ham@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Tobias,

Looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Best Regards,
Chanwoo Choi

On 2016년 11월 23일 22:51, Tobias Jakobi wrote:
> On the Exynos4412 SoC the DevFreq subsystem adjusts frequency
> of the various internal busses and corresponding voltages.
> 
> E.g. the clock of the DMC (dynamic memory controller) bus
> together with the voltage of the MIF regulator are controlled
> by this.
> 
> If DMC activity is low and DevFreq has set a lower OPP, the
> following can happen.
> 
> If the system is restarted or goes into a suspend/resume-cycle,
> the first-stage (BL0) bootloader takes over, which also
> initializes clocks to default values. Since the PMIC is an
> external component and not part of the SoC, the BL0 doesn't
> set any default voltages. Upon setting the default clocks
> for the DMC bus, the BL0 hangs because the corresponding
> voltage is too low.
> 
> To fix this, we make sure to only go into suspend with a 'safe'
> DevFreq configuration.
> 
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> ---
>  drivers/base/power/main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 5a94dfa..9cd7e06 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -32,6 +32,7 @@
>  #include <trace/events/power.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpuidle.h>
> +#include <linux/devfreq.h>
>  #include <linux/timer.h>
>  
>  #include "../base.h"
> @@ -943,6 +944,7 @@ void dpm_resume(pm_message_t state)
>  	dpm_show_time(starttime, state, NULL);
>  
>  	cpufreq_resume();
> +	devfreq_resume();
>  	trace_suspend_resume(TPS("dpm_resume"), state.event, false);
>  }
>  
> @@ -1582,6 +1584,7 @@ int dpm_suspend(pm_message_t state)
>  	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
>  	might_sleep();
>  
> +	devfreq_suspend();
>  	cpufreq_suspend();
>  
>  	mutex_lock(&dpm_list_mtx);
> 
