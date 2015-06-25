From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 7/9] ARM: multi_v7_defconfig: Enable support for PWM
 Regulators
Date: Thu, 25 Jun 2015 09:42:04 +0100
Message-ID: <20150625084204.GW15013@x1>
References: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
 <1435154348-28840-8-git-send-email-lee.jones@linaro.org>
 <CABxcv==J2hi0y+=s3nK_U=-jkjTW3L9jCC2JfebnWwRfpDGLAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABxcv==J2hi0y+=s3nK_U=-jkjTW3L9jCC2JfebnWwRfpDGLAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ajit Pal Singh <ajitpal.singh@st.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 24 Jun 2015, Javier Martinez Canillas wrote:

> Hello Lee,
>=20
> On Wed, Jun 24, 2015 at 3:59 PM, Lee Jones <lee.jones@linaro.org> wro=
te:
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/configs/multi_v7_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs=
/multi_v7_defconfig
> > index f632af0..6666973 100644
> > --- a/arch/arm/configs/multi_v7_defconfig
> > +++ b/arch/arm/configs/multi_v7_defconfig
> > @@ -365,6 +365,7 @@ CONFIG_REGULATOR_MAX8907=3Dy
> >  CONFIG_REGULATOR_MAX8973=3Dy
> >  CONFIG_REGULATOR_MAX77686=3Dy
> >  CONFIG_REGULATOR_PALMAS=3Dy
> > +CONFIG_REGULATOR_PWM=3Dy
>=20
> The current policy is to build as much as possible as a module in
> multi_v7_defconfig. Since this is a tristate Kconfig symbol, could yo=
u
> please change it to =3Dm ?

I would prefer that it stays built-in.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
