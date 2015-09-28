From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH 1/3] Thermal: initialize thermal zone device correctly
Date: Mon, 28 Sep 2015 15:28:13 +0100
Message-ID: <20150928142812.GA8359@e104805>
References: <1443332908-13948-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:56431 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756584AbbI1O2S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2015 10:28:18 -0400
Content-Disposition: inline
In-Reply-To: <1443332908-13948-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

On Sun, Sep 27, 2015 at 06:48:28AM +0100, Chen Yu wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> After thermal zone device registered, as we have not read any
> temperature before, thus tz->temperature should not be 0,
> which actually means 0C, and thermal trend is not available.
> In this case, we need specially handling for the first
> thermal_zone_device_update().
> 
> Both thermal core framework and step_wise governor is
> enhanced to handle this.

It may be worth pointing out that the step_wise governor is the only
one that uses trends, so it's the only thermal governor that needs to
be updated.

> CC: <stable@vger.kernel.org> #3.18+
> Tested-by: Manuel Krause <manuelkrause@netscape.net>
> Tested-by: szegad <szegadlo@poczta.onet.pl>
> Tested-by: prash <prash.n.rao@gmail.com>
> Tested-by: amish <ammdispose-arch@yahoo.com>
> Tested-by: Matthias <morpheusxyz123@yahoo.de>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

One minor nit below, other than that,

Reviewed-by: Javi Merino <javi.merino@arm.com>

> ---
>  drivers/thermal/step_wise.c    | 18 ++++++++++++++++--
>  drivers/thermal/thermal_core.c | 19 +++++++++++++++++--
>  drivers/thermal/thermal_core.h |  1 +
>  include/linux/thermal.h        |  3 +++
>  4 files changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index 2f9f708..405de04 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -63,6 +63,19 @@ static unsigned long get_target_state(struct thermal_instance *instance,
>  	next_target = instance->target;
>  	dev_dbg(&cdev->device, "cur_state=%ld\n", cur_state);
>  
> +	if (!instance->initialized) {
> +		if (throttle) {
> +			next_target = (cur_state + 1) >= instance->upper ?
> +					instance->upper :
> +					((cur_state + 1) < instance->lower ?
> +					instance->lower : (cur_state + 1));
> +		} else {
> +			next_target = THERMAL_NO_TARGET;
> +		}
> +
> +		return next_target;
> +	}
> +
>  	switch (trend) {
>  	case THERMAL_TREND_RAISING:
>  		if (throttle) {
> @@ -149,7 +162,8 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>  		dev_dbg(&instance->cdev->device, "old_target=%d, target=%d\n",
>  					old_target, (int)instance->target);
>  
> -		if (old_target == instance->target)
> +		if (instance->initialized &&
> +		    old_target == instance->target)

nit: it fits in one line,

		if (instance->initialized && old_target == instance->target)

is 77 characters.

Cheers,
Javi
