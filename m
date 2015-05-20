From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: [PATCH 05/15] thermal: Add comment explaining test for critical
 temperature
Date: Wed, 20 May 2015 10:18:30 +0300
Message-ID: <555C3546.5070808@kapsi.fi>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de> <1431507163-19933-6-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:55331 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbbETHTE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 May 2015 03:19:04 -0400
In-Reply-To: <1431507163-19933-6-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>

On 05/13/15 11:52, Sascha Hauer wrote:
> The code testing if a temperature should be emulated or not is
> not obvious. Add a comment explaining why this test is done.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>   drivers/thermal/thermal_core.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 3e0fe55..e204deb 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -435,6 +435,11 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>   			}
>   		}
>
> +		/*
> +		 * Only allow emulating a temperature when the real temperature
> +		 * is below the critical temperature so that the emulation code
> +		 * cannot hide critical conditions.
> +		 */
>   		if (!ret && *temp < crit_temp)
>   			*temp = tz->emul_temperature;
>   	}
>

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

