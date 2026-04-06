Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3F539C64C;
	Mon,  6 Apr 2026 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775511644; cv=none; b=tNEC7a6o6NDyNL3PXgK2Q8i8Ra879/jlaq1z2rbffZXVRW6xh5zkH1A3hSutjPjm2bEuXxWGOsCS+hMkcg9lZQraKG5zZEvg6kiNoLho2fZc0ciCqaApEOTCEHXfk4Ad4xO3KsYPkRkDOk6grqxJFolDVuYEN7HP+y01CoUPd2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775511644; c=relaxed/simple;
	bh=16PmrK0kcbS8A5RljjU+UY5ApOOqtLfbpoWZUnCwD2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ei8XvPY2aDSVuhTG1KkA+X00dRdjfZn7gVfvJtmrq4Rj4VmSBPmdDcCwbHSgNDYS9f93w0gOhB3i+FipiWDwDsJsxWqEBP5wLFl0kPc+QcgvJTOv4gH6vEtrtmbkCNr8Jb0k5gAHpREIbd90gs5zQ3aKq229oaSmnikzXGlV9AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Tb/QqIzP; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Tb/QqIzP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775511640; x=1776116440; i=w_armin@gmx.de;
	bh=uMgHJcPduGDn+6ihzsLWMun/YIuNWTx/2HSiLr2j+Wo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Tb/QqIzPkhbrkcx6MYpu5/3KAsSQArn3D+GOUJUBJei45aiPCgecHK8G7I9wn2Cp
	 hZKh1YSjv2zhTMeWVLaFrqPpHn+whuTqCVjTdHTCD4lmhkyrYaF5yicgOFjsbyqC6
	 b5bXKTpvpmnglk5CSVBF4DjsBSWH7Bx+7H2DWbRmId71aAzBn4PlDtwKC6SbqLkDN
	 4eHao1Omzf5xhkqvlRZVG/JqMBTyoUt92OtpxKbH5DjWHdt0LAxM6TWrvavsXxR/O
	 sqBFp0tgUHgPWXbYfTalZ4OJIQwY0sqDQ4XSEwkyw1Ot/dwlc31sTUSvPMSRpt16y
	 wnod9QNEhC4r5m9UwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MlNtP-1vkwTC3yzF-00jgio; Mon, 06
 Apr 2026 23:40:39 +0200
Message-ID: <2e1869fb-cebc-4d53-a355-632a4d562bc1@gmx.de>
Date: Mon, 6 Apr 2026 23:40:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] thermal: core: Suspend thermal zones later and
 resume them earlier
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <5119690.31r3eYUQgx@rafael.j.wysocki>
 <3715915.iIbC2pHGDl@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <3715915.iIbC2pHGDl@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ubKIly0a2Tdb3k0BvmGBsqxneCItBV857q69QK0LF6NXGM140f+
 lGYLUvaoAYjjTa3gi63FIAgpHUmMh66RAS6/mciodlNQ4NV51sycWHYJ9Ypzzfg2Hp9abOn
 uFPXb0w/FQl21gxYryp5jE8jiordhbSU+Xjta+ynfeCZiH7hGPisehQ3JcCvFa98LnUOc/p
 U/93xWknv0M3GYWvSzW/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X0I/suQ/aPo=;HCuLaglDCheMcBuw/UKKFBaiXCk
 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
 3I

Am 06.04.26 um 18:16 schrieb Rafael J. Wysocki:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> To avoid some undesirable interactions between thermal zone suspend
> and resume with user space that is running when those operations are
> carried out, move them closer to the suspend and resume of devices,
> respectively, by updating dpm_prepare() to carry out thermal zone
> suspend and dpm_complete() to start thermal zone resume (that will
> continue asynchronously).
>
> This also makes the code easier to follow by removing one, arguably
> redundant, level of indirection represented by the thermal PM notifier.

The patch looks good to me. In the future maybe we could track PM dependen=
cies
between thermal zones and cooling devices using device links instead, but =
for
now keeping the already existing logic looks fine to me.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v2 -> v3:
>     * Rebase on top of the v3 of the previous patch
>
> v1 -> v2:
>     * Reorder with respect to the previous patch
>     * Use thermal_class_unavailable() to avoid running code that should
>       not run without the thermal class
>     * Suspend thermal zones after disabling device probing and resume
>       them before enabling device probing for better synchronization
>
> ---
>   drivers/base/power/main.c      |    5 +++
>   drivers/thermal/thermal_core.c |   60 ++++++++++++--------------------=
=2D--------
>   include/linux/thermal.h        |    6 ++++
>   3 files changed, 29 insertions(+), 42 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -33,6 +33,7 @@
>   #include <trace/events/power.h>
>   #include <linux/cpufreq.h>
>   #include <linux/devfreq.h>
> +#include <linux/thermal.h>
>   #include <linux/timer.h>
>   #include <linux/nmi.h>
>  =20
> @@ -1282,6 +1283,8 @@ void dpm_complete(pm_message_t state)
>   	list_splice(&list, &dpm_list);
>   	mutex_unlock(&dpm_list_mtx);
>  =20
> +	/* Start resuming thermal control */
> +	thermal_pm_complete();
>   	/* Allow device probing and trigger re-probing of deferred devices */
>   	device_unblock_probing();
>   	trace_suspend_resume(TPS("dpm_complete"), state.event, false);
> @@ -2225,6 +2228,8 @@ int dpm_prepare(pm_message_t state)
>   	 * instead. The normal behavior will be restored in dpm_complete().
>   	 */
>   	device_block_probing();
> +	/* Suspend thermal control. */
> +	thermal_pm_prepare();
>  =20
>   	mutex_lock(&dpm_list_mtx);
>   	while (!list_empty(&dpm_list) && !error) {
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1838,7 +1838,7 @@ static void thermal_zone_pm_prepare(stru
>   	cancel_delayed_work(&tz->poll_queue);
>   }
>  =20
> -static void thermal_pm_notify_prepare(void)
> +static void __thermal_pm_prepare(void)
>   {
>   	struct thermal_zone_device *tz;
>  =20
> @@ -1850,6 +1850,19 @@ static void thermal_pm_notify_prepare(vo
>   		thermal_zone_pm_prepare(tz);
>   }
>  =20
> +void thermal_pm_prepare(void)
> +{
> +	if (thermal_class_unavailable)
> +		return;
> +
> +	__thermal_pm_prepare();
> +	/*
> +	 * Allow any leftover thermal work items already on the worqueue to
> +	 * complete so they don't get in the way later.
> +	 */
> +	flush_workqueue(thermal_wq);
> +}
> +
>   static void thermal_zone_pm_complete(struct thermal_zone_device *tz)
>   {
>   	guard(thermal_zone)(tz);
> @@ -1866,10 +1879,13 @@ static void thermal_zone_pm_complete(str
>   	mod_delayed_work(thermal_wq, &tz->poll_queue, 0);
>   }
>  =20
> -static void thermal_pm_notify_complete(void)
> +void thermal_pm_complete(void)
>   {
>   	struct thermal_zone_device *tz;
>  =20
> +	if (thermal_class_unavailable)
> +		return;
> +
>   	guard(mutex)(&thermal_list_lock);
>  =20
>   	thermal_pm_suspended =3D false;
> @@ -1878,41 +1894,6 @@ static void thermal_pm_notify_complete(v
>   		thermal_zone_pm_complete(tz);
>   }
>  =20
> -static int thermal_pm_notify(struct notifier_block *nb,
> -			     unsigned long mode, void *_unused)
> -{
> -	switch (mode) {
> -	case PM_HIBERNATION_PREPARE:
> -	case PM_RESTORE_PREPARE:
> -	case PM_SUSPEND_PREPARE:
> -		thermal_pm_notify_prepare();
> -		/*
> -		 * Allow any leftover thermal work items already on the
> -		 * worqueue to complete so they don't get in the way later.
> -		 */
> -		flush_workqueue(thermal_wq);
> -		break;
> -	case PM_POST_HIBERNATION:
> -	case PM_POST_RESTORE:
> -	case PM_POST_SUSPEND:
> -		thermal_pm_notify_complete();
> -		break;
> -	default:
> -		break;
> -	}
> -	return 0;
> -}
> -
> -static struct notifier_block thermal_pm_nb =3D {
> -	.notifier_call =3D thermal_pm_notify,
> -	/*
> -	 * Run at the lowest priority to avoid interference between the therma=
l
> -	 * zone resume work items spawned by thermal_pm_notify() and the other
> -	 * PM notifiers.
> -	 */
> -	.priority =3D INT_MIN,
> -};
> -
>   static int __init thermal_init(void)
>   {
>   	int result;
> @@ -1939,11 +1920,6 @@ static int __init thermal_init(void)
>  =20
>   	thermal_class_unavailable =3D false;
>  =20
> -	result =3D register_pm_notifier(&thermal_pm_nb);
> -	if (result)
> -		pr_warn("Thermal: Can not register suspend notifier, return %d\n",
> -			result);
> -
>   	return 0;
>  =20
>   unregister_governors:
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -273,6 +273,9 @@ bool thermal_trip_is_bound_to_cdev(struc
>   int thermal_zone_device_enable(struct thermal_zone_device *tz);
>   int thermal_zone_device_disable(struct thermal_zone_device *tz);
>   void thermal_zone_device_critical(struct thermal_zone_device *tz);
> +
> +void thermal_pm_prepare(void);
> +void thermal_pm_complete(void);
>   #else
>   static inline struct thermal_zone_device *thermal_zone_device_register=
_with_trips(
>   					const char *type,
> @@ -350,6 +353,9 @@ static inline int thermal_zone_device_en
>  =20
>   static inline int thermal_zone_device_disable(struct thermal_zone_devi=
ce *tz)
>   { return -ENODEV; }
> +
> +static inline void thermal_pm_prepare(void) {}
> +static inline void thermal_pm_complete(void) {}
>   #endif /* CONFIG_THERMAL */
>  =20
>   #endif /* __THERMAL_H__ */
>
>
>
