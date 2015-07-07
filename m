From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH v3 3/4] mfd: axp20x: Add a cell for the
 usb power_supply part of the axp20x PMICs
Date: Tue, 7 Jul 2015 11:42:25 +0100
Message-ID: <20150707104225.GS3182@x1>
References: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
 <1435316357-26606-3-git-send-email-hdegoede@redhat.com>
 <20150707070128.GI3182@x1>
 <559BA0BC.9060409@redhat.com>
Reply-To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDA7X7F2WUEBBFW252WAKGQEX7IFZ3I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <559BA0BC.9060409-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, 07 Jul 2015, Hans de Goede wrote:
> On 07-07-15 09:01, Lee Jones wrote:
> >On Fri, 26 Jun 2015, Hans de Goede wrote:
> >
> >>Add a cell for the usb power_supply part of the axp20x PMICs.
> >>
> >>Note that this cell is only for the usb power_supply part and not the
> >>ac-power / battery-charger / rtc-backup-bat-charger bits.
> >>
> >>Depending on the board each of those must be enabled / disabled separat=
ely
> >>in devicetree as most boards do not use all 4. So in dt each one needs =
its
> >>own child-node of the axp20x node. Another reason for using separate ch=
ild
> >>nodes for each is so that other devicetree nodes can have a power-suppl=
y
> >>property with a phandle referencing a node representing a single
> >>power-supply.
> >>
> >>The decision to use a separate devicetree node for each is reflected on
> >>the kernel side by each getting its own mfd-cell / platform_device and
> >>platform-driver.
> >>
> >>Note this commit also makes some whitespace changes to the intializatio=
n
> >>of existing cells in axp20x_cells, these are pure whitespace changes,
> >>functionally nothing changes.
> >>
> >>Cc: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
> >>Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>Signed-off-by: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
> >>Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >>---
> >>Changes in v2:
> >>-Use DEFINE_RES_IRQ_NAMED
> >>-Change indentation of axp20x_cells initializers to avoid line wrapping
> >>Changes in v3:
> >>-Improve commit message
> >>-Add Bruno's S-o-b
> >>---
> >>  drivers/mfd/axp20x.c | 20 ++++++++++++++++----
> >>  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> >For my own reference:
> >   Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >
> >Are these two patches tied to any other in the set, or can I apply
> >them separately?
>=20
> You can apply them seperately, thanks.
>=20
> I'm wondering who will take care of upstreaming the first patch of this
> set: "ARM: dts: Add binding documentation for AXP20x pmic usb power suppl=
y"
>=20
> If you can take that one too that would be great.

I can do, but I need an Ack from these guys:

POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
M:      Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
M:      Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
M:      David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
L:      linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
T:      git git://git.infradead.org/battery-2.6.git
S:      Maintained
F:      include/linux/power_supply.h
F:      drivers/power/

... failing that, they should take it.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
