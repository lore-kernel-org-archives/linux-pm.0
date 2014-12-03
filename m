From: "Javi Merino" <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: lock the thermal zone when switching governors
Date: Wed, 3 Dec 2014 19:11:09 +0000
Message-ID: <20141203191109.GA22781@e104805>
References: <1416931233-14650-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:52077 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbaLCTLP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 14:11:15 -0500
In-Reply-To: <1416931233-14650-1-git-send-email-javi.merino@arm.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Ping

On Tue, Nov 25, 2014 at 04:00:33PM +0000, Javi Merino wrote:
> Currently, userspace can request a governor change while the governor
> itself is running.  Grab the thermal zone lock when changing the
> governor to prevent this race.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> ---
>  drivers/thermal/thermal_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 43b90709585f..c1901961f8c0 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -757,6 +757,7 @@ policy_store(struct device *dev, struct device_attribute *attr,
>  	snprintf(name, sizeof(name), "%s", buf);
>  
>  	mutex_lock(&thermal_governor_lock);
> +	mutex_lock(&tz->lock);
>  
>  	gov = __find_governor(strim(name));
>  	if (!gov)
> @@ -766,6 +767,7 @@ policy_store(struct device *dev, struct device_attribute *attr,
>  	ret = count;
>  
>  exit:
> +	mutex_unlock(&tz->lock);
>  	mutex_unlock(&thermal_governor_lock);
>  	return ret;
>  }
> -- 
> 1.9.1
> 

