From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: Re: [PATCH 3/5] cpufreq: dt: Add support for some new
 Allwinner SoCs
Date: Tue, 11 Apr 2017 15:18:50 +0800
Message-ID: <58ec8370.5746810a.152e4.1205SMTPIN_ADDED_MISSING@gmr-mx.google.com>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDS6XAN6ZADRB4MGWLDQKGQE2AYYRPY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org


2017=E5=B9=B44=E6=9C=8811=E6=97=A5 15:03=E4=BA=8E Viresh Kumar <viresh.kuma=
r@linaro.org>=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Apr 9, 2017 at 12:20 AM, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org> wrote:=
=20
> > Some new Allwinner SoCs get supported in the kernel after the=20
> > compatibles are added to cpufreq-dt-platdev driver.=20
> >=20
> > Add their compatible strings in the cpufreq-dt-platdev driver.=20
> >=20
> > Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>=20
> > ---=20
> >=C2=A0 drivers/cpufreq/cpufreq-dt-platdev.c | 5 +++++=20
> >=C2=A0 1 file changed, 5 insertions(+)=20
> >=20
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpu=
freq-dt-platdev.c=20
> > index 921b4a6c3d16..2180e509e383 100644=20
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c=20
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c=20
> > @@ -24,7 +24,12 @@ static const struct of_device_id machines[] __initco=
nst =3D {=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .compatible =3D "allw=
inner,sun8i-a23", },=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .compatible =3D "allw=
inner,sun8i-a33", },=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .compatible =3D "allw=
inner,sun8i-a83t", },=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .compatible =3D "allwinner,sun8=
i-h2-plus", },=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .compatible =3D "allw=
inner,sun8i-h3", },=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .compatible =3D "allwinner,sun8=
i-v3s", },=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .compatible =3D "allwinner,sun5=
0i-a64", },=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .compatible =3D "allwinner,sun5=
0i-h5", },=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .compatible =3D "nextthing,gr8"=
, },=20
>
>
> This needs to be in alphabetical order and please cc cpufreq=20

However I prefer these sequence -- sun50i is later than sun8i.

Place sun50i between sun4i and sun5i is meaningless, as sun50i in fact have=
 a deep relationship with sun8i, but not sun4/5i.

> maintainers next time.=20
>
> _______________________________________________=20
> linux-arm-kernel mailing list=20
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org=20
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel=20

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
