Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F641C84D0;
	Tue, 13 Oct 2026 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899722; cv=none; b=Js2XoJZSyZHpwpo9g+VUBSRVEQmCMCH7ZVLvGv80H0owx2vU+mefMaZVpOm+3WnlabXSdKOc1RxEqjEeS7k1jUxdSvekhqgQHCiRmMNkGsBdwVG01AiNdZHw86CanSVvLlrZlDE79e2LrnCuEaEoze+XmPyCcMbZKYL2jwxh0cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899722; c=relaxed/simple;
	bh=AgKaO5oj2G5T8PgCmiTKNVpyRf28uiyD8lDozK/iYXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BjtShXR3m+HjKIIUyBPD8j+S3JJk9+LYbRqWwiS3ovnjENZz1sP3ytqCXkSGz1gzs6EDtktmRR4uhcA0QtTOX8w4Tlhk3Hv2n+KAjq1Yt4yQkcoQtjdc20wwdXVANBmLG1XzNyQWiKLTsbufDuKFjeAmuBhz8HAtu8655m5JefQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=p3QSWiVo; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="p3QSWiVo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=3CfLPi3EYkogGa8SEiZ9IfC7GfR+WvoRaeDU2ttb0Xs=; b=p3QSWiVo3orvc+HNnn8MQoVopj
	ACXWgnwlP7JH2JjfXyQeCx4x6Smqy4weGRtscULCso6BQuhkp4PSZZpLFkUImx8fNSvvZxqgGJTti
	T2sjGsF986wxfaT9ZkRd7hKyFk8AB9FQyBYytwuKyaqAo5cbmDYTSzJct5e09pvEcfdvf2tMPIzVy
	o7B4qfCzrhaIcPh1T5/V/4iGyb7KwG8alK90ZlhksmOWrzlOypvYyTtBrwBU3bCoDGTatHQWjLcAm
	csG2GNb12n+eM9Z0XKD1FkypfAObmehO9tCdTkViQloAkEGa23xHzFaOouYmUZ78E002nv/mA2O5R
	pnyf7BWg==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xGcyE-00H6ZZ-5T; Tue, 13 Oct 2026 15:55:10 +0200
Message-ID: <d99331fb-2e8c-457d-ad56-a3d52ff4fb97@igalia.com>
Date: Tue, 13 Oct 2026 10:55:02 -0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] drm: Discard pm_runtime_put_autosuspend() return
 values
To: Brian Norris <briannorris@chromium.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
 linux-kernel@vger.kernel.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Melissa Wen <mwen@igalia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org
References: <20261006231900.3230373-1-briannorris@chromium.org>
 <20261006161337.2.If1822f9a34be06cf5939be44ac6465c543087c75@changeid>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20261006161337.2.If1822f9a34be06cf5939be44ac6465c543087c75@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Brian,

On 06/10/26 20:13, Brian Norris wrote:
> Several DRM drivers use or propagate the pm_runtime_put_autosuspend()
> return value, which is not particularly useful.
> 
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
> 
> For this reason, modify these drivers to simply discard the
> pm_runtime_put_autosuspend() return value, and change the return type of
> v3d_pm_runtime_put() (whose return value is never used) to void.  Also
> drop the redundant pm_runtime_mark_last_busy() calls right before
> pm_runtime_put_autosuspend().
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

For V3D,

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best regards,
- Maíra

> ---
> This patch is independent of the rest of the series, except for the end
> (changing the return type). I expect it can be applied by individual
> maintainers, and we pick up the end once the dust is settled.
> 
>   drivers/gpu/drm/panel/panel-simple.c | 8 +-------
>   drivers/gpu/drm/tidss/tidss_drv.c    | 7 +------
>   drivers/gpu/drm/v3d/v3d_drv.h        | 4 ++--
>   3 files changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index c95964ba25a9..193d1b2b0ba5 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -318,12 +318,7 @@ static int panel_simple_suspend(struct device *dev)
>   
>   static int panel_simple_unprepare(struct drm_panel *panel)
>   {
> -	int ret;
> -
> -	pm_runtime_mark_last_busy(panel->dev);
> -	ret = pm_runtime_put_autosuspend(panel->dev);
> -	if (ret < 0)
> -		return ret;
> +	pm_runtime_put_autosuspend(panel->dev);
>   
>   	return 0;
>   }
> @@ -389,7 +384,6 @@ static int panel_simple_get_modes(struct drm_panel *panel,
>   
>   		num += drm_edid_connector_add_modes(connector);
>   
> -		pm_runtime_mark_last_busy(panel->dev);
>   		pm_runtime_put_autosuspend(panel->dev);
>   	}
>   
> diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
> index 1c8cc18bc53c..44b0b009c29a 100644
> --- a/drivers/gpu/drm/tidss/tidss_drv.c
> +++ b/drivers/gpu/drm/tidss/tidss_drv.c
> @@ -40,12 +40,7 @@ int tidss_runtime_get(struct tidss_device *tidss)
>   
>   void tidss_runtime_put(struct tidss_device *tidss)
>   {
> -	int r;
> -
> -	pm_runtime_mark_last_busy(tidss->dev);
> -
> -	r = pm_runtime_put_autosuspend(tidss->dev);
> -	WARN_ON(r < 0);
> +	pm_runtime_put_autosuspend(tidss->dev);
>   }
>   
>   static int __maybe_unused tidss_pm_runtime_suspend(struct device *dev)
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index 29fa14be130b..eb002048ae9c 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -669,9 +669,9 @@ static __always_inline int v3d_pm_runtime_get(struct v3d_dev *v3d)
>   	return pm_runtime_resume_and_get(v3d->drm.dev);
>   }
>   
> -static __always_inline int v3d_pm_runtime_put(struct v3d_dev *v3d)
> +static __always_inline void v3d_pm_runtime_put(struct v3d_dev *v3d)
>   {
> -	return pm_runtime_put_autosuspend(v3d->drm.dev);
> +	pm_runtime_put_autosuspend(v3d->drm.dev);
>   }
>   
>   /* v3d_sched.c */

