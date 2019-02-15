From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH 4/4] PM / devfreq: Handle monitor start/stop in the
 devfreq core
Date: Fri, 15 Feb 2019 14:07:38 +0100
Message-ID: <194a0fba-3e39-d577-810d-de300e8b4edd@partner.samsung.com>
References: <20190214013042.254790-1-mka@chromium.org>
        <CGME20190214013154epcas1p31326fdc127b3a75d566426e4f785121b@epcas1p3.samsung.com>
        <20190214013042.254790-5-mka@chromium.org>
        <1771fe9e-c107-f133-7b39-f4d7dbb004c5@partner.samsung.com>
        <20190214190741.GC117604@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214190741.GC117604@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Matthias,

On 2/14/19 8:07 PM, Matthias Kaehlcke wrote:
> Hi Lukasz,
> 
> On Thu, Feb 14, 2019 at 07:01:36PM +0100, Lukasz Luba wrote:
>> Hi Matthias,
>>
>> I have compiled and run your changes on Odroid xu3 and v5.0-rc6.
>> There are kernel warnings because of mutex not held in function
>> devfreq_monitor_[start|stop]() in use cases:
>>    1) a few times during registration of new devices devfreq_add_device()
>>    2) poking the device from sysfs
> 
> Thanks testing!
> 
> I messed up carrying over changes from my v4.19 device kernel
> to the tree used for upstreaming :(
> 
> Do you still see warnings with the below patch?
No, the warnings are no longer present in the log. The patch solves it.

Regards,
Lukasz
> 
> Thanks
> 
> Matthias
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index a42c37543c190..866fe711b43ca 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -440,7 +440,6 @@ static void devfreq_monitor_stop(struct devfreq *devfreq)
> 
>          mutex_lock(&devfreq->lock);
>          devfreq->monitor_state = DEVFREQ_MONITOR_STOPPED;
> -       mutex_unlock(&devfreq->lock);
>   }
> 
>   /**
> @@ -596,7 +595,9 @@ static int governor_start(struct devfreq *devfreq)
>                  return err;
>          }
> 
> +       mutex_lock(&devfreq->lock);
>          devfreq_monitor_start(devfreq);
> +       mutex_unlock(&devfreq->lock);
> 
>          return 0;
>   }
> @@ -614,7 +615,9 @@ static int governor_stop(struct devfreq *devfreq)
>                   "mutex must *not* be held by the caller\n"))
>                  return -EINVAL;
> 
> +       mutex_lock(&devfreq->lock);
>          devfreq_monitor_stop(devfreq);
> +       mutex_unlock(&devfreq->lock);
> 
>          err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_STOP, NULL);
>          if (err) {
> 
> 
