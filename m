From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [STLinux Kernel] [PATCH] thermal: sti: Ignore suspend/resume
 functions when !PM
Date: Wed, 19 Nov 2014 15:43:30 +0100
Message-ID: <546CAC92.3020504@st.com>
References: <1416404939-365-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50698 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753459AbaKSOoI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Nov 2014 09:44:08 -0500
In-Reply-To: <1416404939-365-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: edubezval@gmail.com, kernel@stlinux.com, linux-pm@vger.kernel.org


On 11/19/2014 02:48 PM, Lee Jones wrote:
> Prevents build warning:
>
> st_thermal.c:278:12:
>      warning: =E2=80=98st_thermal_suspend=E2=80=99 defined but not us=
ed [-Wunused-function]
> st_thermal.c:286:12:
>      warning: =E2=80=98st_thermal_resume=E2=80=99 defined but not use=
d [-Wunused-function]
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
You can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime

> ---
>   drivers/thermal/st/st_thermal.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_=
thermal.c
> index 90163b3..9841488 100644
> --- a/drivers/thermal/st/st_thermal.c
> +++ b/drivers/thermal/st/st_thermal.c
> @@ -275,6 +275,7 @@ int st_thermal_unregister(struct platform_device =
*pdev)
>   }
>   EXPORT_SYMBOL_GPL(st_thermal_unregister);
>  =20
> +#ifdef CONFIG_PM
>   static int st_thermal_suspend(struct device *dev)
>   {
>   	struct platform_device *pdev =3D to_platform_device(dev);
> @@ -305,6 +306,8 @@ static int st_thermal_resume(struct device *dev)
>  =20
>   	return 0;
>   }
> +#endif
> +
>   SIMPLE_DEV_PM_OPS(st_thermal_pm_ops, st_thermal_suspend, st_thermal=
_resume);
>   EXPORT_SYMBOL_GPL(st_thermal_pm_ops);
>  =20

