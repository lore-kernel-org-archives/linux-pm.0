From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Subject: Re: [PATCH 6/8] ARM: dts: axp209: Add usb_power_supply
 child node to the ax209 node
Date: Fri, 31 Jul 2015 07:51:04 +0200
Message-ID: <20150731075104.48c467e6@pluto.restena.lu>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
	<1433885881-19809-7-git-send-email-hdegoede@redhat.com>
	<CAGb2v66X79dK84hG8NVTho-kPPMNcKXQspvT2pCM8Zbmnme53A@mail.gmail.com>
Reply-To: bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDCZ5GUK4UNRBSUZ5SWQKGQESFLA4ZA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAGb2v66X79dK84hG8NVTho-kPPMNcKXQspvT2pCM8Zbmnme53A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi ChenYu,

On Fri, 31 Jul 2015 13:31:53 +0800 Chen-Yu Tsai wrote:
> Hi Hans,
> 
> On Wed, Jun 10, 2015 at 5:37 AM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > Add a node representing the usb power supply part of the axp209 pmic, note
> > that the usb power supply and the (to be added later) ac power supply will
> > each have their own child-node, so that they can be separately specified
> > as power-supply for other nodes using a power-supply property with a
> > phandle pointing to the right axp209 child-node.
> >
> > Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/axp209.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
> > index 24c935c..051ab3b 100644
> > --- a/arch/arm/boot/dts/axp209.dtsi
> > +++ b/arch/arm/boot/dts/axp209.dtsi
> > @@ -89,4 +89,9 @@
> >                         regulator-name = "ldo5";
> >                 };
> >         };
> > +
> > +       usb_power_supply: usb_power_supply {
> > +               compatible = "x-powers,axp202-usb-power-supply";
> > +               status = "disabled";
> 
> Is there any reason to have this disabled by default?
> AFAIK this is not something configurable in hardware,
> and the driver just gives readouts and status updates.

There are some devices that only have 'AC-IN' instead of usb/otg power
(set-top boxes) so having the devices tell what power sources they
have makes sense (otherwise those that have ac-in instead of otg would
have to disable usb_power_supply) and avoids confusion by explicitly
stating presence in device dts.

NB: I should hopefully get my battery supply driver ported this WE,
ac-in/rtc are done, this WE. I'm going to default-off for them as well
(note that for some extra details should be provided in dts).

Bruno

> ChenYu
> 
> > +       };
> >  };
> > --
> > 2.3.6
