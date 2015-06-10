From: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 0/8] mfd/power/phy: Add support for otg vbus
 detection via axp pmic
Date: Wed, 10 Jun 2015 09:15:46 +0300
Message-ID: <1433916946.6086.9.camel@plaes.org>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
Reply-To: plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDJLTBEBXENBBTFN36VQKGQER7GAYPQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1433885881-19809-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Bruno =?ISO-8859-1?Q?Pr=E9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2015-06-09 at 23:37 +0200, Hans de Goede wrote:
> Hi All,
>=20
> Here is a series which adds the beginning of power-supply support to
> the axp20x pmic code. My primary reason for working on this is to
> enable the use of the usb power-supply bits in the pmic to for vbus
> detection on boards which do not have a vbus-det gpio, and instead
> rely on the pmic for vbus detection.
>=20
> After I had written most of the vbus power-supply driver code I
> became aware of Bruno Pr=C3=A9mont's (in the CC) previous work on this
> our drivers are mostly the same, and I've borrowed some code from
> his driver to add support for min-volt / max-curr properties.

This is one of the reasons why we try to keep our Mainlining Effort
page up-to-date:
http://linux-sunxi.org/Linux_mainlining_effort


>=20
> The big difference between our 2 drivers is that mine driver uses
> a devicetree child node / mfd cell per power-supply, so one for
> each of the usb-power, ac-power / battery-charger and rtc-backup-bat
> -charger
> bits.
>=20
> Depending on the board each of those must be enabled / disabled=20
> separately
> in devicetree as most boards do not use all 4. So in dt each one=20
> needs its
> own child-node of the axp20x node. Another reason for using separate=20
> child
> nodes for each is so that other devicetree nodes can have a power
> -supply
> property with a phandle referencing a node representing a single
> power-supply.
>=20
> Regards,
>=20
> Hans
>=20

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
