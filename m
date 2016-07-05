From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH 2/4] power: add axp20x-battery driver
Date: Tue, 05 Jul 2016 18:09:17 +0800
Message-ID: <2030991467713357@web30j.yandex.ru>
References: <20160701092926.32005-1-icenowy@aosc.xyz>
	 <20160701092926.32005-2-icenowy@aosc.xyz>
	 <577B44FD.6040404@mailbox.org>
	 <4101467707611@web7h.yandex.ru> <20160705092510.GL7643@lukather>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBUUO525QKGQECQGEHHY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160705092510.GL7643@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Michael Haas <michael.haas-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>, "wens-jdAy2FN1RRM@public.gmane.org" <wens-jdAy2FN1RRM@public.gmane.org>, "sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org" <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



05.07.2016, 17:25, "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard@free-e=
lectrons.com>:
> On Tue, Jul 05, 2016 at 04:33:31PM +0800, Icenowy Zheng wrote:
>> =C2=A005.07.2016, 13:26, "Michael Haas" <michael.haas-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>:
>> =C2=A0> Hi,
>> =C2=A0>
>> =C2=A0> nice work! Is this in any way related to Bruno Pr=C3=A9monts dri=
ver for the
>> =C2=A0> axp20x?
>> =C2=A0>
>> =C2=A0> I've got a reworked version of that lying around, but it's not q=
uite
>> =C2=A0> ready for submission. Do you know what pieces are missing in you=
r driver
>> =C2=A0> for axp20x support - as opposed to axp22x, which is already work=
ing?
>>
>> =C2=A0Therotically, it can run on axp20x. However, I have currently no
>> =C2=A0test device. (Still waiting for my C.H.I.P.) So I can only promise
>> =C2=A0it to run on axp22x.
>
> Still, it looks like you just took Bruno's driver, stripped out the
> axp20x parts and added the one to deal with axp22x.
>
> This makes the driver look weird, by being called axp20x, without
> actually supporting those PMICs, but having some axp22x variables
> right in the middle. And that's awfully inconsistent.
>
> I'd rather have you add the AXP20x driver directly, and then add the
> needed stuff for the AXP22x.
>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

I modified axp20x_usb_power.c to suite the battery.

No axp22x-specified register is used in this driver.
I think this driver may now also work properly on axp20x, however
I have currently no device with axp20x.
(I didn't enter linux-sunxi when A10/13/20 is popular... So I'm waiting for
my CHIP)

This driver didn't implement OCV value tweak.

In fact, OCV value tweaking is even not documented in the datasheet
of both axp20x and axp22x.

Can you test it with axp20x? (It seems that the shipment of CHIP is so slow=
)

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
