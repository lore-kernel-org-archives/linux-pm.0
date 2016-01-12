From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH] thermal: common: free the mem allocated when out of use
Date: Tue, 12 Jan 2016 12:00:36 +0000
Message-ID: <87wprf0zyz.fsf@e105922-lin.cambridge.arm.com>
References: <1452595043-7239-1-git-send-email-ping.bai@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:57819 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S964974AbcALMAo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 07:00:44 -0500
In-Reply-To: <1452595043-7239-1-git-send-email-ping.bai@nxp.com> (Bai Ping's
	message of "Tue, 12 Jan 2016 18:37:23 +0800")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bai Ping <ping.bai@nxp.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org

Bai Ping <ping.bai@nxp.com> writes:

> The memory resource allocated for thermal_zone_device
> should be freed when thermal_zone_device registers failed
> or the thermal_zone_device unregistered.
>
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> ---
>  drivers/thermal/thermal_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Good catch!

     Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>

I hope Rui can pick this up for the rc releases.

Thanks!

> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 7f7a3ca..1a9cf31 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -2012,6 +2012,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>  unregister:
>  	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
>  	device_unregister(&tz->device);
> +	kfree(tz);
>  	return ERR_PTR(result);
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_device_register);
> @@ -2081,6 +2082,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  	idr_destroy(&tz->idr);
>  	mutex_destroy(&tz->lock);
>  	device_unregister(&tz->device);
> +	kfree(tz);
>  	return;
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
