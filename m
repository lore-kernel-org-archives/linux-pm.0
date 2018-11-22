From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 5/6] drivers: power: suspend: call devfreq
 suspend/resume
Date: Thu, 22 Nov 2018 12:08:56 +0900
Message-ID: <5BF61DC8.7010809@samsung.com>
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180206eucas1p265865226e3938a28e842e8367233dc2e@eucas1p2.samsung.com>
        <1542823301-23563-6-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1542823301-23563-6-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org, krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi,

On 2018년 11월 22일 03:01, Lukasz Luba wrote:
> Devfreq framework supports suspend of its devices.
> Call the the devfreq interface and allow devfreq devices preserve/restore
> their states during suspend/resume.
> 
> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
> solve issue with devfreq device's frequency during suspend/resume.
> During the discussion on LKML some corner cases and comments appeared
> related to the design. This patch address them keeping in mind suggestions
> from Chanwoo Choi.

Please remove the duplicate information about patch history
because you already explained it on cover-letter.

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

> 
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/base/power/main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index a690fd4..0992e67 100644
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
> @@ -1078,6 +1079,7 @@ void dpm_resume(pm_message_t state)
>  	dpm_show_time(starttime, state, 0, NULL);
>  
>  	cpufreq_resume();
> +	devfreq_resume();
>  	trace_suspend_resume(TPS("dpm_resume"), state.event, false);
>  }
>  
> @@ -1852,6 +1854,7 @@ int dpm_suspend(pm_message_t state)
>  	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
>  	might_sleep();
>  
> +	devfreq_suspend();
>  	cpufreq_suspend();
>  
>  	mutex_lock(&dpm_list_mtx);
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
