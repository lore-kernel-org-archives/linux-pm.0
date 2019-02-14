From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 7/7] drivers: devfreq: add tracing for scheduling
 work
Date: Thu, 14 Feb 2019 13:57:54 +0900
Message-ID: <971cee25-cb3c-97b0-087e-97551dc066ad@samsung.com>
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222438eucas1p27e020c2b36f2e5a2188e4df6fb18488b@eucas1p2.samsung.com>
        <1550010238-24002-8-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550010238-24002-8-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On 19. 2. 13. 오전 7:23, Lukasz Luba wrote:
> This patch add basic tracing of the devfreq workqueue and delayed work.
> It aims to capture changes of the polling intervals and device state.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 29e99ce..c1d0d8c 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -29,6 +29,9 @@
>  #include <linux/of.h>
>  #include "governor.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/devfreq.h>
> +
>  /* The ~30% load threshold used for load calculation (due to fixed point
>   * arithmetic) */
>  #define LOAD_THRESHOLD_IN_DEVICE_USAGE (300)
> @@ -418,6 +421,7 @@ static void devfreq_monitor(struct work_struct *work)
>  	struct devfreq *devfreq = container_of(work,
>  					struct devfreq, work.work);
>  	unsigned int polling_ms;
> +	const char *df_name = dev_name(&devfreq->dev);

nit: You can use 'dev_name(&devfreq->dev)' directly
without defining the separate df_name.

>  
>  	mutex_lock(&devfreq->lock);
>  	polling_ms = devfreq_get_polling_delay(devfreq);
> @@ -429,6 +433,10 @@ static void devfreq_monitor(struct work_struct *work)
>  	schedule_delayed_work(&devfreq->work,
>  			      msecs_to_jiffies(polling_ms));
>  	mutex_unlock(&devfreq->lock);
> +
> +	trace_devfreq_monitor(df_name, devfreq->previous_freq, polling_ms,
> +			      devfreq->last_status.busy_time,
> +			      devfreq->last_status.total_time);

Regardless of type of work,
I think that trace point is necessary for devfreq framework.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

>  }
>  
>  /**
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
