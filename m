From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 2/2] drivers: devfreq: add tracing for scheduling
 work
Date: Mon, 18 Feb 2019 14:36:38 +0900
Message-ID: <0c03a781-5a81-46ab-9e92-9534e72c4201@samsung.com>
References: <1550235913-5189-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190215130555eucas1p297d048d01902e2bb88e6db158d53fd88@eucas1p2.samsung.com>
        <1550235913-5189-3-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550235913-5189-3-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On 19. 2. 15. 오후 10:05, Lukasz Luba wrote:
> This patch add basic tracing of the devfreq workqueue and delayed work.
> It aims to capture changes of the polling intervals and device state.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de7..660365a 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -29,6 +29,9 @@
>  #include <linux/of.h>
>  #include "governor.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/devfreq.h>
> +
>  static struct class *devfreq_class;
>  
>  /*
> @@ -394,6 +397,8 @@ static void devfreq_monitor(struct work_struct *work)
>  	queue_delayed_work(devfreq_wq, &devfreq->work,
>  				msecs_to_jiffies(devfreq->profile->polling_ms));
>  	mutex_unlock(&devfreq->lock);
> +
> +	trace_devfreq_monitor(devfreq);
>  }
>  
>  /**
> 

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
