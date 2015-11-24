From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: Re: [PATCH v2 1/5] ARM: dts: sun8i: Add SID node
Date: Tue, 24 Nov 2015 10:32:02 +0100
Message-ID: <20151124093202.GL32142@lukather>
References: <cover.1448263428.git.atx@atx.name>
 <b897b1c8741c8a871163b84d01b480f99329536d.1448263428.git.atx@atx.name>
 <20151123124356.GW32142@lukather>
 <a7d4e538-db64-476d-b5de-5222419229a2@googlegroups.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9RXjJcDGNuBviZqz"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBM652CZAKGQEM2XQ73A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a7d4e538-db64-476d-b5de-5222419229a2-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Sugar Wu <shugelinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, atx-MwjtXicnQwU@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gpatchesrdh-I1/eAgTnXDYAvxtiuMwx3w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--9RXjJcDGNuBviZqz
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Nov 23, 2015 at 10:51:15PM -0800, Sugar Wu wrote:
> On Monday, November 23, 2015 at 8:43:59 PM UTC+8, Maxime Ripard wrote:
> >
> > Hi, 
> >
> > On Mon, Nov 23, 2015 at 09:02:48AM +0100, Josef Gajdusek wrote: 
> > > Add a node describing the Security ID memory to the 
> > > Allwinner H3 .dtsi file. 
> > > 
> > > Signed-off-by: Josef Gajdusek <a...-MwjtXicnQwU@public.gmane.org <javascript:>> 
> > > --- 
> > >  arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++ 
> > >  1 file changed, 7 insertions(+) 
> > > 
> > > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi 
> > b/arch/arm/boot/dts/sun8i-h3.dtsi 
> > > index 0faa38a..58de718 100644 
> > > --- a/arch/arm/boot/dts/sun8i-h3.dtsi 
> > > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi 
> > > @@ -359,6 +359,13 @@ 
> > >                          #size-cells = <0>; 
> > >                  }; 
> > >   
> > > +                sid: eeprom@01c14000 { 
> > > +                        compatible = "allwinner,sun4i-a10-sid"; 
> > > +                        reg = <0x01c14000 0x400>; 
> >
> > The datasheet says it's 256 bytes wide, while the size here is of 1kB, 
> > is it intentional? 
> 
> SID memory map is 0x01c14000 ~ 0x01c143FF, include 2048bits efuse space.
> H3 efuse space is SID_SRAM, its range is  0x01c14200 ~ +0x100.

Interesting, what is below the 0x200 registers?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--9RXjJcDGNuBviZqz--
