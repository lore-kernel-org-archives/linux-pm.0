From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Subject: Re: [PATCH 2/4] power: add axp20x-battery driver
Date: Tue, 5 Jul 2016 14:45:11 +0200
Message-ID: <20160705144511.7c10c4a6@pluto.restena.lu>
References: <20160701092926.32005-1-icenowy@aosc.xyz>
	<20160701092926.32005-2-icenowy@aosc.xyz>
	<577B44FD.6040404@mailbox.org>
	<4101467707611@web7h.yandex.ru>
	<20160705092510.GL7643@lukather>
Reply-To: bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDCZ5GUK4UNRBV6X525QKGQE3SFNHTQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160705092510.GL7643@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Michael Haas <michael.haas-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>, wens-jdAy2FN1RRM@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, 5 Jul 2016 11:25:10 +0200 Maxime Ripard wrote:
> On Tue, Jul 05, 2016 at 04:33:31PM +0800, Icenowy Zheng wrote:
> >=20
> >=20
> > 05.07.2016, 13:26, "Michael Haas" <michael.haas-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>: =20
> > > Hi,
> > >
> > > nice work! Is this in any way related to Bruno Pr=C3=A9monts driver f=
or the
> > > axp20x?
> > >
> > > I've got a reworked version of that lying around, but it's not quite
> > > ready for submission. Do you know what pieces are missing in your dri=
ver
> > > for axp20x support - as opposed to axp22x, which is already working? =
=20
> >=20
> > Therotically, it can run on axp20x. However, I have currently no
> > test device. (Still waiting for my C.H.I.P.)  So I can only promise
> > it to run on axp22x. =20
>=20
> Still, it looks like you just took Bruno's driver, stripped out the
> axp20x parts and added the one to deal with axp22x.
>=20
> This makes the driver look weird, by being called axp20x, without
> actually supporting those PMICs, but having some axp22x variables
> right in the middle. And that's awfully inconsistent.
>=20
> I'd rather have you add the AXP20x driver directly, and then add the
> needed stuff for the AXP22x.

>From a very quick look at the patch it looks like only basic
"monitoring" features have been retained, and yes, claiming the driver
to be for axp22x and having the functions named axp20x feels weird.

Missing parts are OCV, charge control (be it as interaction with
USB-power where charge current must be limited to not over-drain
USB power source or manual control when user knows more about the USB
power plug than the device).

Proper capacity measurement is a completely different story which I
did not implement (it exists in 3.4 sunxi kernel but is not
straight-forward and makes use of extra registers for data keeping).

Bruno

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
