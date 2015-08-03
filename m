From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle/coupled: Init cpuidle_device::safe_state_index
Date: Mon, 03 Aug 2015 18:22:54 +0200
Message-ID: <55BF955E.1030801@linaro.org>
References: <1437654681-20893-1-git-send-email-xlpang@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33082 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433AbbHCQW6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2015 12:22:58 -0400
Received: by wicmv11 with SMTP id mv11so142359722wic.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2015 09:22:57 -0700 (PDT)
In-Reply-To: <1437654681-20893-1-git-send-email-xlpang@126.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Xunlei Pang <xlpang@126.com>, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Xunlei Pang <pang.xunlei@zte.com.cn>

On 07/23/2015 02:31 PM, Xunlei Pang wrote:
> From: Xunlei Pang <pang.xunlei@zte.com.cn>
>
> cpuidle_device::safe_state_index need to be initialized before use,
> so assign the driver's safe_state_index to it.
>
> Signed-off-by: Xunlei Pang <pang.xunlei@zte.com.cn>
> ---
>   drivers/cpuidle/cpuidle.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index e8e2775..ed5c8efe 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -585,6 +585,8 @@ int cpuidle_register(struct cpuidle_driver *drv,
>   		 */
>   		if (coupled_cpus)
>   			device->coupled_cpus =3D *coupled_cpus;
> +
> +		device->safe_state_index =3D drv->safe_state_index;

Hey, good catch. We are lucky the safe_state_index is always zero.

I think we can simplify the code by removing the safe_state_index from=20
the cpuidle_device structure and use the one in the cpuidle_driver=20
structure in coupled.c




--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

