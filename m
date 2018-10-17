From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH v2 3/3] thermal: da9062/61: Prevent hardware access
 during system suspend
Date: Wed, 17 Oct 2018 08:57:05 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7021C4CCFCB@SW-EX-MBX02.diasemi.com>
References: <20181012072017.10765-1-geert+renesas@glider.be>
 <20181012072017.10765-4-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012072017.10765-4-geert+renesas@glider.be>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Support Opensource <Support.Opensource@diasemi.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Geert,

Many thanks for looking at this.

On 12 October 2018 08:20 Geert Uytterhoeven wrote:

> Subject: [PATCH v2 3/3] thermal: da9062/61: Prevent hardware access during
> system suspend
> 
> The workqueue used for monitoring the hardware may run while the device
> is already suspended.  Fix this by using the freezable system workqueue
> instead, cfr. commit 51e20d0e3a60cf46 ("thermal: Prevent polling from
> happening during system suspend").

My thinking was:  this device is a PMIC and it will power the system. So when
the device is turned off, the S/W will also not be running.

Although my assumption only works if the PMIC device is the primary system
power -- this has always been the case so far. And although I don't have any
evidence this will change, it may become untrue in the future of course.

> Fixes: 608567aac3206ae8 ("thermal: da9062/61: Thermal junction temperature
> monitoring driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Untested due to lack of hardware.

So, I have not been able to make any time to test this patch yet -- and with
current workloads this might take a bit of time before I get to it.

Regards,
Steve

> v2:
>   - No changes.
> ---
>  drivers/thermal/da9062-thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-
> thermal.c
> index dd8dd947b7f0737c..01b0cb9944577851 100644
> --- a/drivers/thermal/da9062-thermal.c
> +++ b/drivers/thermal/da9062-thermal.c
> @@ -106,7 +106,7 @@ static void da9062_thermal_poll_on(struct work_struct
> *work)
>  					   THERMAL_EVENT_UNSPECIFIED);
> 
>  		delay = msecs_to_jiffies(thermal->zone->passive_delay);
> -		schedule_delayed_work(&thermal->work, delay);
> +		queue_delayed_work(system_freezable_wq, &thermal->work,
> delay);
>  		return;
>  	}
> 
> @@ -125,7 +125,7 @@ static irqreturn_t da9062_thermal_irq_handler(int irq,
> void *data)
>  	struct da9062_thermal *thermal = data;
> 
>  	disable_irq_nosync(thermal->irq);
> -	schedule_delayed_work(&thermal->work, 0);
> +	queue_delayed_work(system_freezable_wq, &thermal->work, 0);
> 
>  	return IRQ_HANDLED;
>  }
> --
> 2.17.1
