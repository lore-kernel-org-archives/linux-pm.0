From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: arm_big_little: fix module license spec
Date: Fri, 1 Aug 2014 14:52:49 +0530
Message-ID: <CAKohpokVOZhZ3j+mxkX0ogP_Dk=WtmfgJavzMV1EZ3WWgi-AiA@mail.gmail.com>
References: <mvmmwbqateb.fsf@hawking.suse.de>
	<1406792216-827-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33338 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbaHAJWu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Aug 2014 05:22:50 -0400
Received: by mail-oi0-f48.google.com with SMTP id h136so2560296oig.7
        for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2014 02:22:49 -0700 (PDT)
In-Reply-To: <1406792216-827-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andreas Schwab <schwab@suse.de>, Sudeep Holla <sudeep.holla@arm.com>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 31 July 2014 13:06, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutron=
ix.de> wrote:
> Having no license specification in a module taints the kernel during =
load
> with:
>
>         arm_big_little: module license 'unspecified' taints kernel.
>
> and also the linker doesn't allow it to make use of GPL-exported symb=
ols
> which in this case also results in errors like:
>
>         arm_big_little: Unknown symbol cpufreq_register_driver (err 0=
)
>
> . The header of the driver specifies a GPL v2 license, so note that
> accordingly. While at it also add a description and an author and fix
> the license in a companion file to explicit v2.
>
> Reported-by: Andreas Schwab <schwab@suse.de>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/cpufreq/arm_big_little.c    | 4 ++++
>  drivers/cpufreq/arm_big_little_dt.c | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_b=
ig_little.c
> index 1f4d4e315057..b600f3107bef 100644
> --- a/drivers/cpufreq/arm_big_little.c
> +++ b/drivers/cpufreq/arm_big_little.c
> @@ -593,3 +593,7 @@ void bL_cpufreq_unregister(struct cpufreq_arm_bL_=
ops *ops)
>         arm_bL_ops =3D NULL;
>  }
>  EXPORT_SYMBOL_GPL(bL_cpufreq_unregister);
> +
> +MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
> +MODULE_DESCRIPTION("Generic ARM big LITTLE cpufreq driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/ar=
m_big_little_dt.c
> index 8d9d59108906..4550f6976768 100644
> --- a/drivers/cpufreq/arm_big_little_dt.c
> +++ b/drivers/cpufreq/arm_big_little_dt.c
> @@ -114,4 +114,4 @@ module_platform_driver(generic_bL_platdrv);
>
>  MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
>  MODULE_DESCRIPTION("Generic ARM big LITTLE cpufreq driver via DT");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");

Thanks..

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
