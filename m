From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [STLinux Kernel] [PATCH] thermal: sti: Ignore suspend/resume
 functions when !PM
Date: Wed, 19 Nov 2014 15:52:01 +0000
Message-ID: <20141119155201.GC1875@x1>
References: <1416404939-365-1-git-send-email-lee.jones@linaro.org>
 <546CAC92.3020504@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36321 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480AbaKSPwI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Nov 2014 10:52:08 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so1188907igb.11
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2014 07:52:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <546CAC92.3020504@st.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Maxime Coquelin <maxime.coquelin@st.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, edubezval@gmail.com, kernel@stlinux.com, linux-pm@vger.kernel.org

On Wed, 19 Nov 2014, Maxime Coquelin wrote:

>=20
> On 11/19/2014 02:48 PM, Lee Jones wrote:
> >Prevents build warning:
> >
> >st_thermal.c:278:12:
> >     warning: =E2=80=98st_thermal_suspend=E2=80=99 defined but not u=
sed [-Wunused-function]
> >st_thermal.c:286:12:
> >     warning: =E2=80=98st_thermal_resume=E2=80=99 defined but not us=
ed [-Wunused-function]
> >
> >Signed-off-by: Lee Jones <lee.jones@linaro.org>
> You can add my:
> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Sorry Maxime, I made a booboo!

Resubmitted.

> >---
> >  drivers/thermal/st/st_thermal.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> >diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st=
_thermal.c
> >index 90163b3..9841488 100644
> >--- a/drivers/thermal/st/st_thermal.c
> >+++ b/drivers/thermal/st/st_thermal.c
> >@@ -275,6 +275,7 @@ int st_thermal_unregister(struct platform_device=
 *pdev)
> >  }
> >  EXPORT_SYMBOL_GPL(st_thermal_unregister);
> >+#ifdef CONFIG_PM
> >  static int st_thermal_suspend(struct device *dev)
> >  {
> >  	struct platform_device *pdev =3D to_platform_device(dev);
> >@@ -305,6 +306,8 @@ static int st_thermal_resume(struct device *dev)
> >  	return 0;
> >  }
> >+#endif
> >+
> >  SIMPLE_DEV_PM_OPS(st_thermal_pm_ops, st_thermal_suspend, st_therma=
l_resume);
> >  EXPORT_SYMBOL_GPL(st_thermal_pm_ops);
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
