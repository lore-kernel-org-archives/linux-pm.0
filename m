From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpu-idle: cpuidle-ux500: fixed a coding style issue
Date: Thu, 07 Nov 2013 10:25:34 +0100
Message-ID: <527B5C8E.6030102@linaro.org>
References: <1382167729-21232-1-git-send-email-saumyakuanr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:42883 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379Ab3KGJZh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2013 04:25:37 -0500
Received: by mail-bk0-f48.google.com with SMTP id u10so108341bkz.21
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2013 01:25:36 -0800 (PST)
In-Reply-To: <1382167729-21232-1-git-send-email-saumyakuanr@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saumya Ranjan Kuanr <saumyakuanr@gmail.com>, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/19/2013 09:28 AM, Saumya Ranjan Kuanr wrote:
> Fixed a coding style issue
>
> Signed-off-by: Saumya Ranjan Kuanr<saumyakuanr@gmail.com>

Applied for 3.14.

Changed the subject to:

ux500: cpuidle: Fix indentation

Thanks
   -- Daniel

> ---
>   drivers/cpuidle/cpuidle-ux500.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-ux500.c b/drivers/cpuidle/cpuidl=
e-ux500.c
> index e056465..746d716 100644
> --- a/drivers/cpuidle/cpuidle-ux500.c
> +++ b/drivers/cpuidle/cpuidle-ux500.c
> @@ -102,7 +102,7 @@ static struct cpuidle_driver ux500_idle_driver =3D=
 {
>   			.exit_latency	  =3D 70,
>   			.target_residency =3D 260,
>   			.flags		  =3D CPUIDLE_FLAG_TIME_VALID |
> -			                    CPUIDLE_FLAG_TIMER_STOP,
> +						CPUIDLE_FLAG_TIMER_STOP,
>   			.name		  =3D "ApIdle",
>   			.desc		  =3D "ARM Retention",
>   		},
> --
> 1.7.9.5
>
>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

