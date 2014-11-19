From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] thermal: sti: Ignore suspend/resume functions when !PM
Date: Wed, 19 Nov 2014 15:49:54 +0000
Message-ID: <20141119154954.GB1875@x1>
References: <1416404939-365-1-git-send-email-lee.jones@linaro.org>
 <CAOMZO5Dz-vz=zV1r3O_Pv0=WS+_Pk=kaBiK1hb2ttxy_BPwLnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5Dz-vz=zV1r3O_Pv0=WS+_Pk=kaBiK1hb2ttxy_BPwLnQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, edubezval@gmail.com, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 19 Nov 2014, Fabio Estevam wrote:

> On Wed, Nov 19, 2014 at 11:48 AM, Lee Jones <lee.jones@linaro.org> wr=
ote:
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
> >  drivers/thermal/st/st_thermal.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/s=
t_thermal.c
> > index 90163b3..9841488 100644
> > --- a/drivers/thermal/st/st_thermal.c
> > +++ b/drivers/thermal/st/st_thermal.c
> > @@ -275,6 +275,7 @@ int st_thermal_unregister(struct platform_devic=
e *pdev)
> >  }
> >  EXPORT_SYMBOL_GPL(st_thermal_unregister);
> >
> > +#ifdef CONFIG_PM
>=20
> Actually this should be #ifdef CONFIG_PM_SLEEP instead

You're right, someone already pointed this out, thanks.

I will re-submit in ~1min.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
