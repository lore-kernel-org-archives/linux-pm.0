From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/3] thermal: step_wise: fix: Prevent from binary
 overflow when trend is dropping
Date: Thu, 09 Oct 2014 11:14:18 +0800
Message-ID: <1412824458.13621.5.camel@rzhang1-toshiba>
References: <1411547232-21493-1-git-send-email-l.majewski@samsung.com>
	 <1411547232-21493-2-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63299 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbaJIDOW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 8 Oct 2014 23:14:22 -0400
In-Reply-To: <1411547232-21493-2-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org

On Wed, 2014-09-24 at 10:27 +0200, Lukasz Majewski wrote:
> It turns out that some boards can have instance->lower greater than 0 and
> when thermal trend is dropping it results with next_target equal to -1.
> 
> Since the next_target is defined as unsigned long it is interpreted as
> 0xFFFFFFFF and larger than instance->upper.
> As a result the next_target is set to instance->upper which ramps up to
> maximal cooling device target when the temperature is steadily decreasing.
> 
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>

applied.

thanks,
rui
> ---
>  drivers/thermal/step_wise.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index 3b54c2c..fdd1f52 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -77,7 +77,7 @@ static unsigned long get_target_state(struct thermal_instance *instance,
>  			next_target = instance->upper;
>  		break;
>  	case THERMAL_TREND_DROPPING:
> -		if (cur_state == instance->lower) {
> +		if (cur_state <= instance->lower) {
>  			if (!throttle)
>  				next_target = THERMAL_NO_TARGET;
>  		} else {


