From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] thermal: sti: Ignore suspend/resume functions when !PM
Date: Wed, 19 Nov 2014 16:40:40 +0000
Message-ID: <20141119164040.GG1875@x1>
References: <1416412231-2752-1-git-send-email-lee.jones@linaro.org>
 <CAOMZO5CwFSRUoVb2j=X=fzaqVN1gUyRki70ewrGrwqLWSHMoAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:62614 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439AbaKSQks (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Nov 2014 11:40:48 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so846351ier.4
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2014 08:40:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5CwFSRUoVb2j=X=fzaqVN1gUyRki70ewrGrwqLWSHMoAg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, edubezval@gmail.com, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, 19 Nov 2014, Fabio Estevam wrote:

> On Wed, Nov 19, 2014 at 1:50 PM, Lee Jones <lee.jones@linaro.org> wro=
te:
> > Prevents build warning:
> >
> > st_thermal.c:278:12:
> >     warning: =E2=80=98st_thermal_suspend=E2=80=99 defined but not u=
sed [-Wunused-function]
> > st_thermal.c:286:12:
> >     warning: =E2=80=98st_thermal_resume=E2=80=99 defined but not us=
ed [-Wunused-function]
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >
> > v1 =3D> v2:
> >  - CONFIG_PM =3D> CONFIG_PM_SLEEP suggested by David Paris.
>=20
> You should also update the Subject to 'when !PM_SLEEP'

I guess we should, yes.

Zhang, Eduardo,

Are you happy to do that, or would you like me to re-spin again?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
