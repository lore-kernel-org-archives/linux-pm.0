From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH] thermal: step_wise: set throttle target within thermal
 instance limits
Date: Tue, 9 Apr 2013 11:00:49 -0400
Message-ID: <51642D21.2060705@ti.com>
References: <1365465371-24652-1-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38380 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936004Ab3DIPA5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Apr 2013 11:00:57 -0400
In-Reply-To: <1365465371-24652-1-git-send-email-abrestic@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Bresticker <abrestic@chromium.org>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, eduardo.valentin@ti.com

Hi Andrew,

On 08-04-2013 19:56, Andrew Bresticker wrote:
> When selecting a target cooling state in get_target_state(), make sure
> that the state is at least as high as the minimum when the temperature
> is rising and at least as low as the maximum when the temperature is
> falling.  Previously the cooling level would only be incremented or
> decremented by one in these cases.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>   drivers/thermal/step_wise.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index 0cd5e9f..49992a4 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -47,9 +47,13 @@ static unsigned long get_target_state(struct thermal_instance *instance,
>   	if (trend == THERMAL_TREND_RAISING) {
>   		cur_state = cur_state < instance->upper ?
>   			    (cur_state + 1) : instance->upper;
> +		if (cur_state < instance->lower)
> +			cur_state = instance->lower;
>   	} else if (trend == THERMAL_TREND_DROPPING) {
>   		cur_state = cur_state > instance->lower ?
>   			    (cur_state - 1) : instance->lower;
> +		if (cur_state > instance->upper)
> +			cur_state = instance->upper;
>   	}


In which situations cur_state will be out of the [lower;upper] 
boundaries? I mean at this point while temperature is rising, and we are 
rising the cooling level, we should be already above lower (and 
vice-versa). Can you please describe better the situation you are trying 
to cover/ that you have identified?

>
>   	return cur_state;
>

