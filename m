From: Sugar Wu <shugelinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/5] ARM: dts: sun8i: Add SID node
Date: Mon, 23 Nov 2015 22:51:15 -0800 (PST)
Message-ID: <a7d4e538-db64-476d-b5de-5222419229a2@googlegroups.com>
References: <cover.1448263428.git.atx@atx.name>
 <b897b1c8741c8a871163b84d01b480f99329536d.1448263428.git.atx@atx.name>
 <20151123124356.GW32142@lukather>
Reply-To: shugelinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_7799_1307141804.1448347875675"
Return-path: <linux-sunxi+bncBCYY37UO6AHRBZER2CZAKGQET2JJELA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20151123124356.GW32142@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Cc: atx-MwjtXicnQwU@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gpatchesrdh-I1/eAgTnXDYAvxtiuMwx3w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

------=_Part_7799_1307141804.1448347875675
Content-Type: multipart/alternative;
	boundary="----=_Part_7800_1893462329.1448347875675"

------=_Part_7800_1893462329.1448347875675
Content-Type: text/plain; charset=UTF-8



On Monday, November 23, 2015 at 8:43:59 PM UTC+8, Maxime Ripard wrote:
>
> Hi, 
>
> On Mon, Nov 23, 2015 at 09:02:48AM +0100, Josef Gajdusek wrote: 
> > Add a node describing the Security ID memory to the 
> > Allwinner H3 .dtsi file. 
> > 
> > Signed-off-by: Josef Gajdusek <a...-MwjtXicnQwU@public.gmane.org <javascript:>> 
> > --- 
> >  arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++ 
> >  1 file changed, 7 insertions(+) 
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi 
> b/arch/arm/boot/dts/sun8i-h3.dtsi 
> > index 0faa38a..58de718 100644 
> > --- a/arch/arm/boot/dts/sun8i-h3.dtsi 
> > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi 
> > @@ -359,6 +359,13 @@ 
> >                          #size-cells = <0>; 
> >                  }; 
> >   
> > +                sid: eeprom@01c14000 { 
> > +                        compatible = "allwinner,sun4i-a10-sid"; 
> > +                        reg = <0x01c14000 0x400>; 
>
> The datasheet says it's 256 bytes wide, while the size here is of 1kB, 
> is it intentional? 

SID memory map is 0x01c14000 ~ 0x01c143FF, include 2048bits efuse space.
H3 efuse space is SID_SRAM, its range is  0x01c14200 ~ +0x100.

>  
>
Thanks, 
> Maxime 
>
> -- 
> Maxime Ripard, Free Electrons 
> Embedded Linux, Kernel and Android engineering 
> http://free-electrons.com 
>

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

------=_Part_7800_1893462329.1448347875675
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, November 23, 2015 at 8:43:59 PM UTC+8, Maxime Ripard wro=
te:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;=
border-left: 1px #ccc solid;padding-left: 1ex;">Hi,
<br>
<br>On Mon, Nov 23, 2015 at 09:02:48AM +0100, Josef Gajdusek wrote:
<br>&gt; Add a node describing the Security ID memory to the
<br>&gt; Allwinner H3 .dtsi file.
<br>&gt;=20
<br>&gt; Signed-off-by: Josef Gajdusek &lt;<a href=3D"javascript:" target=
=3D"_blank" gdf-obfuscated-mailto=3D"C2JONr6XCAAJ" rel=3D"nofollow" onmouse=
down=3D"this.href=3D&#39;javascript:&#39;;return true;" onclick=3D"this.hre=
f=3D&#39;javascript:&#39;;return true;">a...-MwjtXicnQwU@public.gmane.org</a>&gt;
<br>&gt; ---
<br>&gt; =C2=A0arch/arm/boot/dts/sun8i-h3.<wbr>dtsi | 7 +++++++
<br>&gt; =C2=A01 file changed, 7 insertions(+)
<br>&gt;=20
<br>&gt; diff --git a/arch/arm/boot/dts/sun8i-h3.<wbr>dtsi b/arch/arm/boot/=
dts/sun8i-h3.<wbr>dtsi
<br>&gt; index 0faa38a..58de718 100644
<br>&gt; --- a/arch/arm/boot/dts/sun8i-h3.<wbr>dtsi
<br>&gt; +++ b/arch/arm/boot/dts/sun8i-h3.<wbr>dtsi
<br>&gt; @@ -359,6 +359,13 @@
<br>&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0#<wbr>size-cells =3D &lt;0&gt;;
<br>&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
<br>&gt; =C2=A0
<br>&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sid: eeprom@01c14000 {
<br>&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0<wbr>compatible =3D &quot;allwinner,sun4i-a10-sid&quot;;
<br>&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0reg =3D &lt;0x01c14000 0x400&gt;;
<br>
<br>The datasheet says it&#39;s 256 bytes wide, while the size here is of 1=
kB,
<br>is it intentional? </blockquote><div>SID memory map is 0x01c14000 ~ 0x0=
1c143FF, include 2048bits efuse space.</div><div>H3 efuse space is SID_SRAM=
, its range is =C2=A00x01c14200 ~ +0x100.</div><blockquote class=3D"gmail_q=
uote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;pad=
ding-left: 1ex;">=C2=A0<br></blockquote><blockquote class=3D"gmail_quote" s=
tyle=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-le=
ft: 1ex;">Thanks,
<br>Maxime
<br>
<br>--=20
<br>Maxime Ripard, Free Electrons
<br>Embedded Linux, Kernel and Android engineering
<br><a href=3D"http://free-electrons.com" target=3D"_blank" rel=3D"nofollow=
" onmousedown=3D"this.href=3D&#39;http://www.google.com/url?q\75http%3A%2F%=
2Ffree-electrons.com\46sa\75D\46sntz\0751\46usg\75AFQjCNGC8C9pT7xKJEabITLGL=
5cqtolifQ&#39;;return true;" onclick=3D"this.href=3D&#39;http://www.google.=
com/url?q\75http%3A%2F%2Ffree-electrons.com\46sa\75D\46sntz\0751\46usg\75AF=
QjCNGC8C9pT7xKJEabITLGL5cqtolifQ&#39;;return true;">http://free-electrons.c=
om</a>
<br></blockquote>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_7800_1893462329.1448347875675--

------=_Part_7799_1307141804.1448347875675--
