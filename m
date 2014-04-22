From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/4] driver: cpuidle: cpuidle-big-little: init driver
 for Exynos5420
Date: Tue, 22 Apr 2014 13:12:00 +0200
Message-ID: <53564E80.1050006@linaro.org>
References: <1398080958-21677-1-git-send-email-chander.kashyap@linaro.org> <1398080958-21677-3-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:52055 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932225AbaDVLMH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Apr 2014 07:12:07 -0400
Received: by mail-wg0-f51.google.com with SMTP id k14so3790283wgh.10
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2014 04:12:05 -0700 (PDT)
In-Reply-To: <1398080958-21677-3-git-send-email-chander.kashyap@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, kgene.kim@samsung.com, Chander Kashyap <k.chander@samsung.org>

On 04/21/2014 01:49 PM, Chander Kashyap wrote:
> Add "samsung,exynos5420" compatible string to initialize generic
> big-little cpuidle driver for Exynos5420.
>
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> Signed-off-by: Chander Kashyap <k.chander@samsung.org>
> ---
>   drivers/cpuidle/cpuidle-big_little.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/c=
puidle-big_little.c
> index b45fc62..d0fac53 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -170,7 +170,8 @@ static int __init bl_idle_init(void)
>   	/*
>   	 * Initialize the driver just for a compliant set of machines
>   	 */
> -	if (!of_machine_is_compatible("arm,vexpress,v2p-ca15_a7"))
> +	if (!of_machine_is_compatible("arm,vexpress,v2p-ca15_a7") &&
> +		(!of_machine_is_compatible("samsung,exynos5420")))
>   		return -ENODEV;
>   	/*
>   	 * For now the differentiation between little and big cores

BTW, are the latencies the same than the TC2 ?


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

