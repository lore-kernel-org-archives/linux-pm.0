From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 1/7] drivers: devfreq: change deferred work into
 delayed
Date: Thu, 14 Feb 2019 13:10:26 +0900
Message-ID: <85f58e8e-53f7-c622-59f7-82f7e04ab6ac@samsung.com>
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222430eucas1p1ad7992e29d224790c1e20ef7442e62fe@eucas1p1.samsung.com>
        <1550010238-24002-2-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550010238-24002-2-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On 19. 2. 13. 오전 7:23, Lukasz Luba wrote:
> This patch changes deferred work to delayed work, which is now not missed
> when timer is put on CPU that entered idle state.
> The devfreq framework governor was not called, thus changing the device's
> frequency did not happen.
> Benchmarks for stressing Dynamic Memory Controller show x2 (in edge cases
> even x5) performance boost with this patch when 'simpleondemand_governor'
> is responsible for monitoring the device load and frequency changes.
> 
> With this patch, the delayed work is done no mater CPUs' idle.
> All of the drivers in devfreq which rely on periodic, guaranteed wakeup
> intervals should benefit from it.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de7..0c9bff8 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -407,7 +407,7 @@ static void devfreq_monitor(struct work_struct *work)
>   */
>  void devfreq_monitor_start(struct devfreq *devfreq)
>  {
> -	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
> +	INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);

As I commented, I can't agree that just changing the type of work
from deferrable to delayed for the always periodic timer.

Instead, if devfreq framework supports both deferrable
and delayed work according to selecting the kind of work
by user, I agree.

>  	if (devfreq->profile->polling_ms)
>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
