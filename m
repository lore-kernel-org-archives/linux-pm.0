From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM: ux500: u8500_defconfig: add missing cpuidle option
Date: Mon, 07 Oct 2013 16:52:05 +0200
Message-ID: <5252CA95.8000405@linaro.org>
References: <1380540996-18521-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:58894 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823Ab3JGOwG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Oct 2013 10:52:06 -0400
Received: by mail-wg0-f53.google.com with SMTP id x12so7473646wgg.32
        for <linux-pm@vger.kernel.org>; Mon, 07 Oct 2013 07:52:04 -0700 (PDT)
In-Reply-To: <1380540996-18521-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linus.walleij@linaro.org, olof@lixom.net
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, patches@linao.org

On 09/30/2013 01:36 PM, Daniel Lezcano wrote:
> With the commit d3f2950f2adeea3da0317e952914b59adaa4cdb3, the option
> ARM_U8500_CPUIDLE was added to the Kconfig but not reflected in the
> default config file, hence the cpuidle driver is no longer enabled
> since this commit.
>
> Enable it again by adding the missing option in the default config fi=
le.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Hi Olof, Linus,

any comment on this patch ? Are you willing to pick it in your tree ?

Thanks
   -- Daniel

>   arch/arm/configs/u8500_defconfig |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u850=
0_defconfig
> index a0025dc..4bd93bf 100644
> --- a/arch/arm/configs/u8500_defconfig
> +++ b/arch/arm/configs/u8500_defconfig
> @@ -20,6 +20,7 @@ CONFIG_CMDLINE=3D"root=3D/dev/ram0 console=3DttyAMA=
2,115200n8"
>   CONFIG_CPU_FREQ=3Dy
>   CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=3Dy
>   CONFIG_CPU_IDLE=3Dy
> +CONFIG_ARM_U8500_CPUIDLE=3Dy
>   CONFIG_VFP=3Dy
>   CONFIG_NEON=3Dy
>   CONFIG_PM_RUNTIME=3Dy
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

