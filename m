From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 1/5] ARM: dts: sun8i: Add SID node
Date: Tue, 24 Nov 2015 08:26:13 +0100
Message-ID: <20151124072613.GF32142@lukather>
References: <cover.1448263428.git.atx@atx.name>
 <b897b1c8741c8a871163b84d01b480f99329536d.1448263428.git.atx@atx.name>
 <20151123124356.GW32142@lukather>
 <CAGb2v65qfaTdQqXHD=-FHz1M1sHCTro97QETZUH=vA2BbRS+7A@mail.gmail.com>
 <20151124063808.GB32142@lukather>
 <CAGb2v67aS+2vM8CLB=4ynFOvb14t+kiWjJvAa60U2nq22S8ZEw@mail.gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h6w+13shfCQ8v2Yw"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBCFS2CZAKGQEHLD7VOA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v67aS+2vM8CLB=4ynFOvb14t+kiWjJvAa60U2nq22S8ZEw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, gpatchesrdh-I1/eAgTnXDYAvxtiuMwx3w@public.gmane.org, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--h6w+13shfCQ8v2Yw
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Tue, Nov 24, 2015 at 02:42:26PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 24, 2015 at 2:38 PM, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > On Tue, Nov 24, 2015 at 11:13:13AM +0800, Chen-Yu Tsai wrote:
> >> Hi,
> >>
> >> On Mon, Nov 23, 2015 at 8:43 PM, Maxime Ripard
> >> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> >> > Hi,
> >> >
> >> > On Mon, Nov 23, 2015 at 09:02:48AM +0100, Josef Gajdusek wrote:
> >> >> Add a node describing the Security ID memory to the
> >> >> Allwinner H3 .dtsi file.
> >> >>
> >> >> Signed-off-by: Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org>
> >> >> ---
> >> >>  arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
> >> >>  1 file changed, 7 insertions(+)
> >> >>
> >> >> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> >> >> index 0faa38a..58de718 100644
> >> >> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> >> >> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> >> >> @@ -359,6 +359,13 @@
> >> >>                       #size-cells = <0>;
> >> >>               };
> >> >>
> >> >> +             sid: eeprom@01c14000 {
> >> >> +                     compatible = "allwinner,sun4i-a10-sid";
> >> >> +                     reg = <0x01c14000 0x400>;
> >> >
> >> > The datasheet says it's 256 bytes wide, while the size here is of 1kB,
> >> > is it intentional?
> >>
> >> My H3 datasheet (v1.1) says its 1 kB wide.
> >
> > Is it? in the Security ID section, it is said to be 2kb == 256B wide.
> 
> Right. I was looking at the memory map. Maybe it's sparsely mapped?
> I guess we'll know soon.

If it is just like the A20, I think there's a few registers at the end
to control the writes (that we don't use).

Which means that the size of the fuses is smaller than the size of the
mapped area (which also measn that our driver is broken making that
assumption).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--h6w+13shfCQ8v2Yw--
