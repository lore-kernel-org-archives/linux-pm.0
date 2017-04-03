From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC PATCH v2 4/4] ARM: sun8i: h3: add support for
 the thermal sensor in H3
Date: Mon, 3 Apr 2017 08:42:08 +0200
Message-ID: <20170403064208.llk6usgtkbg5ejzw@lukather>
References: <20170402133304.56824-1-icenowy@aosc.io>
 <20170402133304.56824-5-icenowy@aosc.io>
 <3f13c07d-be6a-0350-6d86-de1a4d4e33a8@free-electrons.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j5sdxdc32svkkqg5"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBQO5Q7DQKGQE2SOA54Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <3f13c07d-be6a-0350-6d86-de1a4d4e33a8-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: icenowy-h8G6r0blFSE@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--j5sdxdc32svkkqg5
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Sun, Apr 02, 2017 at 04:34:55PM +0200, Quentin Schulz wrote:
> Hi Icenowy,
> 
> On 02/04/2017 15:33, Icenowy Zheng wrote:
> > As we have gained the support for the thermal sensor in H3, we can now
> > add its device nodes to the device tree.
> > 
> > Add them to the H3 device tree.
> > 
> > The H5 thermal sensor has some differences, and will be added furtherly.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/sun8i-h3.dtsi | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> > index b36f9f423c39..552217bb9266 100644
> > --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> > @@ -72,6 +72,32 @@
> >  		};
> >  	};
> >  
> > +	iio-hwmon {
> > +		compatible = "iio-hwmon";
> > +		io-channels = <&ths>;
> > +	};
> > +
> > +	soc {
> > +		ths: ths@01c25000 {
> > +			compatible = "allwinner,sun8i-h3-ths";
> > +			reg = <0x01c25000 0x100>;
> > +			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
> > +			clock-names = "bus", "ths";
> > +			resets = <&ccu RST_BUS_THS>;
> > +			#thermal-sensor-cells = <0>;
> > +			#io-channel-cells = <0>;
> > +		};
> > +	};
> > +
> > +	thermal-zones {
> > +		cpu_thermal {
> > +			/* milliseconds */
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +			thermal-sensors = <&ths>;
> > +		};
> 
> Would it make sense to add the CPU temp trip points in this patch?

No.

This is a separate, unrelated, change that has nothing to do with what
is described either in the commit title or the commit log.

The thermal zone itself shouldn't even be in this patch.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--j5sdxdc32svkkqg5--
