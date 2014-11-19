From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] thermal: sti: Ignore suspend/resume functions when !PM
Date: Wed, 19 Nov 2014 12:57:44 -0200
Message-ID: <CAOMZO5Dz-vz=zV1r3O_Pv0=WS+_Pk=kaBiK1hb2ttxy_BPwLnQ@mail.gmail.com>
References: <1416404939-365-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:53535 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627AbaKSO5p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Nov 2014 09:57:45 -0500
In-Reply-To: <1416404939-365-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, edubezval@gmail.com, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Nov 19, 2014 at 11:48 AM, Lee Jones <lee.jones@linaro.org> wrot=
e:
> Prevents build warning:
>
> st_thermal.c:278:12:
>     warning: =E2=80=98st_thermal_suspend=E2=80=99 defined but not use=
d [-Wunused-function]
> st_thermal.c:286:12:
>     warning: =E2=80=98st_thermal_resume=E2=80=99 defined but not used=
 [-Wunused-function]
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/thermal/st/st_thermal.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_=
thermal.c
> index 90163b3..9841488 100644
> --- a/drivers/thermal/st/st_thermal.c
> +++ b/drivers/thermal/st/st_thermal.c
> @@ -275,6 +275,7 @@ int st_thermal_unregister(struct platform_device =
*pdev)
>  }
>  EXPORT_SYMBOL_GPL(st_thermal_unregister);
>
> +#ifdef CONFIG_PM

Actually this should be #ifdef CONFIG_PM_SLEEP instead
