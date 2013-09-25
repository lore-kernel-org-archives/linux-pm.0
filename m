From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 03/21] cpuidle: make __cpuidle_get_cpu_driver() inline
Date: Wed, 25 Sep 2013 23:27:43 +0200
Message-ID: <5243554F.8000909@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org> <0868fef3eca7cc04dc879da73f06e29e322c695b.1379779777.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:53745 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754787Ab3IYV1q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2013 17:27:46 -0400
Received: by mail-wg0-f54.google.com with SMTP id m15so280564wgh.9
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 14:27:45 -0700 (PDT)
In-Reply-To: <0868fef3eca7cc04dc879da73f06e29e322c695b.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/22/2013 03:20 AM, Viresh Kumar wrote:
> __cpuidle_get_cpu_driver() is a single line function and so deserves =
to be
> marked inline.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/cpuidle/driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index ced1df6..25455e8 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -29,7 +29,7 @@ static DEFINE_PER_CPU(struct cpuidle_driver *, cpui=
dle_drivers);
>   * Returns a pointer to struct cpuidle_driver or NULL if no driver h=
as been
>   * registered for @cpu.
>   */
> -static struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
> +static inline struct cpuidle_driver *__cpuidle_get_cpu_driver(int cp=
u)
>  {
>  	return per_cpu(cpuidle_drivers, cpu);
>  }
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

