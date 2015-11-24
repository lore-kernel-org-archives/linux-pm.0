From: Sugar Wu <shugelinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/5] ARM: dts: sun8i: Add SID node
Date: Mon, 23 Nov 2015 19:24:40 -0800 (PST)
Message-ID: <077cd975-1f91-40fe-ab05-2381e4fb6448@googlegroups.com>
References: <cover.1448263428.git.atx@atx.name> <b897b1c8741c8a871163b84d01b480f99329536d.1448263428.git.atx@atx.name>
 <20151123124356.GW32142@lukather>
 <CAGb2v65qfaTdQqXHD=-FHz1M1sHCTro97QETZUH=vA2BbRS+7A@mail.gmail.com>
Reply-To: shugelinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_7547_2088280689.1448335481093"
Return-path: <linux-sunxi+bncBCYY37UO6AHRB6VQZ6ZAKGQERTTPXSY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAGb2v65qfaTdQqXHD=-FHz1M1sHCTro97QETZUH=vA2BbRS+7A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Cc: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, atx-MwjtXicnQwU@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gpatchesrdh-I1/eAgTnXDYAvxtiuMwx3w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

------=_Part_7547_2088280689.1448335481093
Content-Type: multipart/alternative;
	boundary="----=_Part_7548_1988214271.1448335481094"

------=_Part_7548_1988214271.1448335481094
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I will give you the right widths as soon.

=E5=9C=A8 2015=E5=B9=B411=E6=9C=8824=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=8C UT=
C+8=E4=B8=8A=E5=8D=8811:13:41=EF=BC=8CChen-Yu Tsai=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Hi,=20
>
> On Mon, Nov 23, 2015 at 8:43 PM, Maxime Ripard=20
> <maxime...-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org <javascript:>> wrote:=20
> > Hi,=20
> >=20
> > On Mon, Nov 23, 2015 at 09:02:48AM +0100, Josef Gajdusek wrote:=20
> >> Add a node describing the Security ID memory to the=20
> >> Allwinner H3 .dtsi file.=20
> >>=20
> >> Signed-off-by: Josef Gajdusek <a...-MwjtXicnQwU@public.gmane.org <javascript:>>=20
> >> ---=20
> >>  arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++=20
> >>  1 file changed, 7 insertions(+)=20
> >>=20
> >> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi=20
> b/arch/arm/boot/dts/sun8i-h3.dtsi=20
> >> index 0faa38a..58de718 100644=20
> >> --- a/arch/arm/boot/dts/sun8i-h3.dtsi=20
> >> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi=20
> >> @@ -359,6 +359,13 @@=20
> >>                       #size-cells =3D <0>;=20
> >>               };=20
> >>=20
> >> +             sid: eeprom@01c14000 {=20
> >> +                     compatible =3D "allwinner,sun4i-a10-sid";=20
> >> +                     reg =3D <0x01c14000 0x400>;=20
> >=20
> > The datasheet says it's 256 bytes wide, while the size here is of 1kB,=
=20
> > is it intentional?=20
>
> My H3 datasheet (v1.1) says its 1 kB wide.=20
>
> It'd be nice if Allwinner actually listed the "usable" E-fuse offsets=20
> and widths, instead of having us dig through the SDK code.=20
>
> Regards=20
> ChenYu=20
>

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

------=_Part_7548_1988214271.1448335481094
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I will give you the right=C2=A0widths as soon.<br><br>=E5=
=9C=A8 2015=E5=B9=B411=E6=9C=8824=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=8C UTC+8=
=E4=B8=8A=E5=8D=8811:13:41=EF=BC=8CChen-Yu Tsai=E5=86=99=E9=81=93=EF=BC=9A<=
blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;bord=
er-left: 1px #ccc solid;padding-left: 1ex;">Hi,
<br>
<br>On Mon, Nov 23, 2015 at 8:43 PM, Maxime Ripard
<br>&lt;<a href=3D"javascript:" target=3D"_blank" gdf-obfuscated-mailto=3D"=
aUmWyDPHCAAJ" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;javascript:&=
#39;;return true;" onclick=3D"this.href=3D&#39;javascript:&#39;;return true=
;">maxime...@free-electrons.<wbr>com</a>&gt; wrote:
<br>&gt; Hi,
<br>&gt;
<br>&gt; On Mon, Nov 23, 2015 at 09:02:48AM +0100, Josef Gajdusek wrote:
<br>&gt;&gt; Add a node describing the Security ID memory to the
<br>&gt;&gt; Allwinner H3 .dtsi file.
<br>&gt;&gt;
<br>&gt;&gt; Signed-off-by: Josef Gajdusek &lt;<a href=3D"javascript:" targ=
et=3D"_blank" gdf-obfuscated-mailto=3D"aUmWyDPHCAAJ" rel=3D"nofollow" onmou=
sedown=3D"this.href=3D&#39;javascript:&#39;;return true;" onclick=3D"this.h=
ref=3D&#39;javascript:&#39;;return true;">a...-MwjtXicnQwU@public.gmane.org</a>&gt;
<br>&gt;&gt; ---
<br>&gt;&gt; =C2=A0arch/arm/boot/dts/sun8i-h3.<wbr>dtsi | 7 +++++++
<br>&gt;&gt; =C2=A01 file changed, 7 insertions(+)
<br>&gt;&gt;
<br>&gt;&gt; diff --git a/arch/arm/boot/dts/sun8i-h3.<wbr>dtsi b/arch/arm/b=
oot/dts/sun8i-h3.<wbr>dtsi
<br>&gt;&gt; index 0faa38a..58de718 100644
<br>&gt;&gt; --- a/arch/arm/boot/dts/sun8i-h3.<wbr>dtsi
<br>&gt;&gt; +++ b/arch/arm/boot/dts/sun8i-h3.<wbr>dtsi
<br>&gt;&gt; @@ -359,6 +359,13 @@
<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 #size-cells =3D &lt;0&gt;;
<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };
<br>&gt;&gt;
<br>&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sid: eeprom@01c140=
00 {
<br>&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 compatible =3D &quot;allwinner,sun4i-a10-sid&quot;;
<br>&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 reg =3D &lt;0x01c14000 0x400&gt;;
<br>&gt;
<br>&gt; The datasheet says it&#39;s 256 bytes wide, while the size here is=
 of 1kB,
<br>&gt; is it intentional?
<br>
<br>My H3 datasheet (v1.1) says its 1 kB wide.
<br>
<br>It&#39;d be nice if Allwinner actually listed the &quot;usable&quot; E-=
fuse offsets
<br>and widths, instead of having us dig through the SDK code.
<br>
<br>Regards
<br>ChenYu
<br></blockquote></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_7548_1988214271.1448335481094--

------=_Part_7547_2088280689.1448335481093--
