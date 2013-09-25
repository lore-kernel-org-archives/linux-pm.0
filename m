From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 09/21] cpuidle: merge two if() statements for checking
 error cases
Date: Wed, 25 Sep 2013 23:52:55 +0200
Message-ID: <52435B37.1040304@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org> <63116bb9adaf7336a019ce087fbe17c4ace81cea.1379779777.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:48705 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495Ab3IYVw6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2013 17:52:58 -0400
Received: by mail-wi0-f172.google.com with SMTP id hn9so6152489wib.11
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 14:52:57 -0700 (PDT)
In-Reply-To: <63116bb9adaf7336a019ce087fbe17c4ace81cea.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/22/2013 03:21 AM, Viresh Kumar wrote:
> Both return same error message and so better write them in a single l=
ine.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

modulo the comment on patch 08/21:

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/cpuidle/cpuidle.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index aec9029..b8c63cb 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -119,10 +119,7 @@ int cpuidle_idle_call(void)
>  	struct cpuidle_driver *drv;
>  	int next_state, entered_state;
> =20
> -	if (cpuidle_disabled())
> -		return -ENODEV;
> -
> -	if (!initialized)
> +	if (cpuidle_disabled() || !initialized)
>  		return -ENODEV;
> =20
>  	/* check if the device is ready */
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

