From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] drivers: cpuidle: add driver/device checks in cpuidle_enter_freeze()
Date: Wed, 25 Feb 2015 15:30:49 +0100
Message-ID: <54EDDC99.40208@linaro.org>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com> <1424800730-32059-3-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:51643 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbbBYOax (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Feb 2015 09:30:53 -0500
Received: by mail-wi0-f173.google.com with SMTP id bs8so33824064wib.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2015 06:30:52 -0800 (PST)
In-Reply-To: <1424800730-32059-3-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 02/24/2015 06:58 PM, Lorenzo Pieralisi wrote:
> The changes in commit:
>
> 381063133246 ("PM / sleep: Re-implement suspend-to-idle handling")
>
> let suspend-to-idle code bypass the cpuidle_select() function to
> enter the deepest idle state. The sanity checks carried out in
> cpuidle_select() are bypassed too and this can cause breakage
> on systems that try to suspend-to-idle with no registered cpuidle
> driver.
>
> This patch factors out a function cpuidle_device_disabled() that
> is used to carry out sanity checks (ie CPUidle is disabled on the
> cpu executing the code) in both cpuidle_select() and cpuidle_enter_fr=
eeze()
> so that the checks are unified and carried out in both control paths.
>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>   drivers/cpuidle/cpuidle.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index f47edc6c..344fe6c 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -44,6 +44,12 @@ void disable_cpuidle(void)
>   	off =3D 1;
>   }
>
> +static bool cpuidle_device_disabled(struct cpuidle_driver *drv,
> +				    struct cpuidle_device *dev)
> +{
> +	return (off || !initialized || !drv || !dev || !dev->enabled);
> +}

This is getting a bit fuzzy IMO. What means disabled ? :)

>   /**
>    * cpuidle_play_dead - cpu off-lining
>    *
> @@ -124,6 +130,11 @@ void cpuidle_enter_freeze(void)
>   	struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
>   	int index;

I think this is exploding before because of dev =3D=3D NULL in the line=
 above.

> +	if (cpuidle_device_disabled(drv, dev)) {
> +		arch_cpu_idle();
> +		return;
> +	}
> +
>   	/*
>   	 * Find the deepest state with ->enter_freeze present, which guara=
ntees
>   	 * that interrupts won't be enabled when it exits and allows the t=
ick to
> @@ -202,11 +213,8 @@ int cpuidle_enter_state(struct cpuidle_device *d=
ev, struct cpuidle_driver *drv,
>    */
>   int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_devic=
e *dev)
>   {
> -	if (off || !initialized)
> -		return -ENODEV;
> -
> -	if (!drv || !dev || !dev->enabled)
> -		return -EBUSY;
> +	if (cpuidle_device_disabled(drv, dev))
> +		return -1;
>
>   	return cpuidle_curr_governor->select(drv, dev);
>   }
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

