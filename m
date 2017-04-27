From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH V2] cpuidle: check dev before usage in
 cpuidle_use_deepest_state
Date: Thu, 27 Apr 2017 12:39:24 +0300
Message-ID: <1493285964.24567.225.camel@linux.intel.com>
References: <BEC9F67575FA1E429CA7CF5AE9BE363432A457C3@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BEC9F67575FA1E429CA7CF5AE9BE363432A457C3@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Li, Fei" <fei.li@intel.com>, "Shi, FengX" <fengx.shi@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Koul, Vinod" <vinod.koul@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2017-04-27 at 01:47 +0000, Li, Fei wrote:
> In case of there is no cpuidle devices registered, dev will be null,
> and
> panic will be triggered like below;
> In this patch, add checking of dev before usage, like that done in
> cpuidle_idle_call.
> 
> Panic without fix:
> [  184.961328] BUG: unable to handle kernel NULL pointer dereference
> at
>   (null)
> [  184.961328] IP: cpuidle_use_deepest_state+0x30/0x60
> ...
> [  184.961328]  play_idle+0x8d/0x210
> [  184.961328]  ? __schedule+0x359/0x8e0
> [  184.961328]  ? _raw_spin_unlock_irqrestore+0x28/0x50
> [  184.961328]  ? kthread_queue_delayed_work+0x41/0x80
> [  184.961328]  clamp_idle_injection_func+0x64/0x1e0

FWIW:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

P.S. V2 is mistakenly left from internal review AFAIU.

> 
> Fixes: bb8313b603eb8 ("cpuidle: Allow enforcing deepest idle state
> selection")
> Signed-off-by: Li, Fei <fei.li@intel.com>
> Tested-by: Shi, Feng <fengx.shi@intel.com>
> ---
>  drivers/cpuidle/cpuidle.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 548b90b..2706be7 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -111,7 +111,8 @@ void cpuidle_use_deepest_state(bool enable)
>  
>  	preempt_disable();
>  	dev = cpuidle_get_device();
> -	dev->use_deepest_state = enable;
> +	if (dev)
> +		dev->use_deepest_state = enable;
>  	preempt_enable();
>  }
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
