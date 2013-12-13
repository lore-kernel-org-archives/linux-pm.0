From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM/cpuidle: remove __init tag from Calxeda cpuidle probe
 function
Date: Fri, 13 Dec 2013 22:57:33 +0100
Message-ID: <52AB82CD.3040100@linaro.org>
References: <1386967759-12952-1-git-send-email-andre.przywara@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:59741 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609Ab3LMV5e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Dec 2013 16:57:34 -0500
Received: by mail-wi0-f176.google.com with SMTP id hq4so1729559wib.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2013 13:57:33 -0800 (PST)
In-Reply-To: <1386967759-12952-1-git-send-email-andre.przywara@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andre Przywara <andre.przywara@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: rob.herring@calxeda.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/13/2013 09:49 PM, Andre Przywara wrote:
> Commit 60a66e370007e8535b7a561353b07b37deaf35ba changed the Calxeda
> cpuidle driver to a platform driver, copying the __init tag from the
> _init() to the newly used _probe() function. However, "probe should
> not be __init." (Rob said ;-)
> Remove the __init tag to fix a section mismatch in the Calxeda
> cpuidle driver.
>
> Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
> ---

Applied to my tree for 3.14.

Thanks for the fix.

   -- Daniel

>   drivers/cpuidle/cpuidle-calxeda.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpui=
dle-calxeda.c
> index 3679563..6e51114 100644
> --- a/drivers/cpuidle/cpuidle-calxeda.c
> +++ b/drivers/cpuidle/cpuidle-calxeda.c
> @@ -65,7 +65,7 @@ static struct cpuidle_driver calxeda_idle_driver =3D=
 {
>   	.state_count =3D 2,
>   };
>
> -static int __init calxeda_cpuidle_probe(struct platform_device *pdev=
)
> +static int calxeda_cpuidle_probe(struct platform_device *pdev)
>   {
>   	return cpuidle_register(&calxeda_idle_driver, NULL);
>   }
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

