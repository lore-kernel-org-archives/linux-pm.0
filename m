From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/6] cpuidle: calxeda: add cpu_pm_enter/exit calls
Date: Fri, 27 Sep 2013 10:45:38 +0200
Message-ID: <524545B2.7000608@linaro.org>
References: <1380248694-13388-1-git-send-email-robherring2@gmail.com> <1380248694-13388-3-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:46608 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab3I0Ipl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2013 04:45:41 -0400
Received: by mail-wg0-f46.google.com with SMTP id k14so2291522wgh.13
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2013 01:45:40 -0700 (PDT)
In-Reply-To: <1380248694-13388-3-git-send-email-robherring2@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

On 09/27/2013 04:24 AM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Wnen powergating the core, we need to call cpu pm notifiers to save V=
=46P
> state (!SMP only) and resetting the breakpoint h/w.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Shouldn't this patch be the first in the series ?

> ---
>   drivers/cpuidle/cpuidle-calxeda.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpui=
dle-calxeda.c
> index 01cfecf3..b04767a 100644
> --- a/drivers/cpuidle/cpuidle-calxeda.c
> +++ b/drivers/cpuidle/cpuidle-calxeda.c
> @@ -21,6 +21,7 @@
>    */
>
>   #include <linux/cpuidle.h>
> +#include <linux/cpu_pm.h>
>   #include <linux/init.h>
>   #include <linux/of.h>
>   #include <asm/cpuidle.h>
> @@ -39,7 +40,10 @@ static int calxeda_pwrdown_idle(struct cpuidle_dev=
ice *dev,
>   				struct cpuidle_driver *drv,
>   				int index)
>   {
> +	cpu_pm_enter();
>   	cpu_suspend(0, calxeda_idle_finish);
> +	cpu_pm_exit();
> +
>   	return index;
>   }
>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

