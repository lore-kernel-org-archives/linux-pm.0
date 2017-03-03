From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v19 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Fri, 03 Mar 2017 13:23:14 +1100
Message-ID: <87zih3m73h.fsf@notabene.neil.brown.name>
References: <cover.1487578977.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1487578977.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: robh@kernel.org, jun.li@nxp.com, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, john.stultz@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20 2017, Baolin Wang wrote:

> Currently the Linux kernel does not provide any standard integration of t=
his
> feature that integrates the USB subsystem with the system power regulation
> provided by PMICs meaning that either vendors must add this in their kern=
els
> or USB gadget devices based on Linux (such as mobile phones) may not beha=
ve
> as they should. Thus provide a standard framework for doing this in kerne=
l.
>
> Now introduce one user with wm831x_power to support and test the usb char=
ger.
> Another user introduced to support charger detection by Jun Li:
> https://www.spinics.net/lists/linux-usb/msg139425.html
> Moreover there may be other potential users will use it in future.=20
>
> 1. Before v19 patchset we've fixed below issues in extcon subsystem and u=
sb
> phy driver, now all were merged. (Thanks for Neil's suggestion)
> (1) Have fixed the inconsistencies with USB connector types in extcon sub=
system
> by following links:
> https://lkml.org/lkml/2016/12/21/13
> https://lkml.org/lkml/2016/12/21/15
> https://lkml.org/lkml/2016/12/21/79
> https://lkml.org/lkml/2017/1/3/13
>
> (2) Instead of using 'set_power' callback in phy drivers, we will introdu=
ce
> USB charger to set PMIC current drawn from USB configuration, moreover so=
me
> 'set_power' callbacks did not implement anything to set PMIC current, thus
> remove them by following links:
> https://lkml.org/lkml/2017/1/18/436
> https://lkml.org/lkml/2017/1/18/439
> https://lkml.org/lkml/2017/1/18/438
> Now only two phy drivers (phy-isp1301-omap.c and phy-gpio-vbus-usb.c) sti=
ll
> used 'set_power' callback to set current, we can remove them in future. (I
> have no platform with enabling these two phy drivers, so I can not test t=
hem
> if I converted 'set_power' callback to USB charger.)
>
> 2. Some issues pointed by Neil Brown were sill kept in this v19 patchset,=
 and
> I expalined each issue and may be need discuss again:
> (1) Change all usb phys to register an extcon and to send appropriate not=
ifications.
> Firstly, now only 3 USB phy drivers (phy-qcom-8x16-usb.c, phy-omap-otg.c =
and
> phy-msm-usb.c) had registered an extcon, mostly did not. I can not change=
 all
> usb phys to register an extcon, since there are no extcon device to regis=
ter
> for these different phy drivers.

You don't have to change every driver.  You just need to make it easy
and obvious how to change drivers in a consistent coherent way.
For a start you would add a 'struct extcon_dev' to 'struct usb_phy', and
possibly add or extend some 'static inline's in linux/usb/phy.h to send
notification on that extcon (if it is non-NULL).
e.g. usb_phy_vbus_on() could send an extcon notification.

Then any phy driver which adds support for setting phy->extcon_dev
appropriately, immediately gets the relevant notifications sent.


> Secondly, I also agreed with Peter's comments: Not only USB PHY to regist=
er
> an extcon, but also for the drivers which can detect USB charger type, it=
 may
> be USB controller driver, USB type-c driver, pmic driver, and these drive=
rs
> may not have an extcon device since the internal part can finish the vbus
> detect.

Whichever part can detect vbus, the driver for that part must be able to
find the extcon and trigger a notification.
Maybe one part can detect VBUS, another can measure the resistance on ID
and a third can work through the state machine to determine if D+ and D-
are shorted together.
Somehow these three need to work together to determine what is plugged
in to the external connection port.  Somewhere there much an 'extcon'
device which represents that port and which the three devices can find
and can interact with.
I think it makes sense for the usb_phy to be the connection point.  Each
of the devices can get to the phy, and the phy can get to the extcon.
It doesn't matter very much if the usb phy driver creates the extcon, or
if something else creates the extcon and the phy driver performs a
lookup to find it (e.g. based on devicetree info).

The point is that there is obviously an external physical connection,
and so there should be an 'extcon' device that represents it.


>
> (2) Change the notifier of usb_phy to be used consistently.
> Now only 3 phy drivers (phy-generic.c, phy-ab8500-usb.c and phy-gpio-vbus=
-usb.c)
> used the notifier of usb_phy. phy-generic.c and phy-gpio-vbus-usb.c were =
used to
> send out the connect events, and phy-ab8500-usb.c also was used to send o=
ut the
> MUSB connect events. There are no phy drivers will notify 'vbus_draw' inf=
ormation
> by the notifier of usb_phy, which was used consistently now.
> Moreover it is difficult to change the notifier of usb_phy to be used onl=
y to
> communicate the 'vbus_draw' information, since we need to refactor and te=
st these
> related phy drivers, power drivers or some mfd drivers, which is a
> huge workload.

You missed drivers/usb/musb/omap2430.c in you list, but that hardly
matters.
phy-ab8500-usb.c appears to send vbus_draw information.

I understand your reluctance to change drivers that you cannot test.
An alternative it do change all the
  atomic_notifier_call_chain(.*notifier,
calls that don't pass a pointer to vbus_draw to pass NULL, and to
declare the passing of NULL to be deprecated (so hopefully people won't
use it in new code).
Then any notification callback that expects a current can just ignore
calls where the pointer is NULL.

The one difficulty with this is drivers/usb/gadget/udc/pxa27x_udc.c
It is the only driver which expects a 'gadget', and it doesn't really
need to as it already knows the gadget.
The patch below fixes this.
With that in place, phy-generic and phy-gpio-vbus-usb can be changed to
pass NULL.  When we can safely use the notifier to pass vbus_draw
information uniformly.

>
> (3) Still keep charger_type_show() API.
> Firstly I think we should combine all charger related information into one
> place for users, which is convenient.

convenience is very much a secondary issue.

> Secondly not only we get charger type from extcon, but also in some scena=
rios
> we can get charger type from USB controller driver, USB type-c driver, pm=
ic
> driver, we should also need one place to export the charger type.

As I have said, all of these sources of information should feed into the
extcon.

There are ultimately two possible sources of information about the
current available from the usb port.
One is the physical properties of the cable, such as resistance of ID,
any short between D+ and D- etc.  Being properties of the cable, they
should be reported through the extcon.

The other is information gathered during the USB protocol handshake.
For USB2, this is the requested current of the profile that the host
activates.  This should be reported though the USB gadget device.

I don't know how USB3 and/or type-C work but I would be surprised if they
don't fit into the two cases above.  If you think otherwise, please
surprise me.  I'm always keen to learn.

If the extcon reports the type of cable detected, and the gadget reports
the result of any negotiation, then that is enough to determine the
charger type.  It doesn't need to be more convenient than that.


Thanks,
NeilBrown



From=2075a77246d2e9224f579ab996640a435a1c587d5f Mon Sep 17 00:00:00 2001
From: NeilBrown <neilb@suse.com>
Date: Fri, 3 Mar 2017 13:05:17 +1100
Subject: [PATCH] usb: gadget: pxa27x: change event handler to not expect
 gadget.

We are planning to change the usb notifier to not pass a gadget,
as different drivers pass different things and consistency would
be nice.

The only driver to expect a gadget is pxa27x.
Unlike other drivers that register a usb notifier, pxa27x uses a static
notifier_block.  Other drivers embed a notifer_block in their data
struct so that struct can be access from the notifer callback.

So change pxa27x to use as embedded notifer_block, and to use that
to find the target gadget.
With this, it can ignore that pointer that is passed.  This will
allow us to change all calls that pass a gadget, to instead pass
NULL.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 drivers/usb/gadget/udc/pxa27x_udc.c | 14 ++++++--------
 drivers/usb/gadget/udc/pxa27x_udc.h |  2 ++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/p=
xa27x_udc.c
index e1335ad5bce9..885a6c80fd08 100644
=2D-- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -1669,7 +1669,8 @@ static int pxa_udc_vbus_draw(struct usb_gadget *_gadg=
et, unsigned mA)
 static int pxa_udc_phy_event(struct notifier_block *nb, unsigned long acti=
on,
 			     void *data)
 {
=2D	struct usb_gadget *gadget =3D data;
+	struct pxa_udc *udc =3D container_of(nb, struct pxa_udc, nb);
+	struct usb_gadget *gadget =3D &udc->gadget;
=20
 	switch (action) {
 	case USB_EVENT_VBUS:
@@ -1683,10 +1684,6 @@ static int pxa_udc_phy_event(struct notifier_block *=
nb, unsigned long action,
 	}
 }
=20
=2Dstatic struct notifier_block pxa27x_udc_phy =3D {
=2D	.notifier_call =3D pxa_udc_phy_event,
=2D};
=2D
 static int pxa27x_udc_start(struct usb_gadget *g,
 		struct usb_gadget_driver *driver);
 static int pxa27x_udc_stop(struct usb_gadget *g);
@@ -2504,8 +2501,9 @@ static int pxa_udc_probe(struct platform_device *pdev)
 		goto err;
 	}
=20
+	udc->nb.notifier_call =3D pxa_udc_phy_event;
 	if (!IS_ERR_OR_NULL(udc->transceiver))
=2D		usb_register_notifier(udc->transceiver, &pxa27x_udc_phy);
+		usb_register_notifier(udc->transceiver, &udc->nb);
 	retval =3D usb_add_gadget_udc(&pdev->dev, &udc->gadget);
 	if (retval)
 		goto err_add_gadget;
@@ -2517,7 +2515,7 @@ static int pxa_udc_probe(struct platform_device *pdev)
=20
 err_add_gadget:
 	if (!IS_ERR_OR_NULL(udc->transceiver))
=2D		usb_unregister_notifier(udc->transceiver, &pxa27x_udc_phy);
+		usb_unregister_notifier(udc->transceiver, &udc->nb);
 err:
 	clk_unprepare(udc->clk);
 	return retval;
@@ -2535,7 +2533,7 @@ static int pxa_udc_remove(struct platform_device *_de=
v)
 	pxa_cleanup_debugfs(udc);
=20
 	if (!IS_ERR_OR_NULL(udc->transceiver))
=2D		usb_unregister_notifier(udc->transceiver, &pxa27x_udc_phy);
+		usb_unregister_notifier(udc->transceiver, &udc->nb);
 	usb_put_phy(udc->transceiver);
=20
 	udc->transceiver =3D NULL;
diff --git a/drivers/usb/gadget/udc/pxa27x_udc.h b/drivers/usb/gadget/udc/p=
xa27x_udc.h
index cea2cb79b30c..acefb07427bd 100644
=2D-- a/drivers/usb/gadget/udc/pxa27x_udc.h
+++ b/drivers/usb/gadget/udc/pxa27x_udc.h
@@ -461,6 +461,8 @@ struct pxa_udc {
 	struct gpio_desc			*gpiod;
 	struct usb_phy				*transceiver;
=20
+	struct notifier_block			nb;
+
 	enum ep0_state				ep0state;
 	struct udc_stats			stats;
=20
=2D-=20
2.11.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAli405IACgkQOeye3VZi
gbnHxA/8CZwd7OjLGsGOZg+UbOecx32KfuN2yRtYKBjh8cJhWCqxIbEEe87pHVOA
+bXm0VBrSXWn082v4u67n+ubWHO8mzWWH/wmkvk3j7inGjAA/7joJf/uAtqOZQfk
/art6/6dJrzpv8eybRdy7+rRcOqnAoGjJloTzY8n2B22GxtGyI0uaMfLdE4RBLBc
KMhYXLRxB9FnkcBih8q+Qr86yqMX5PvGzRaTnXIRjl07jdCRXcjluOcyPdH8gZMY
oov67zAwr38fzKEufHR0dSr5f1kcm8hy06vfcbFt8rNhfk4/6K+W4kGDuxbpCyDo
Y2vrTNUXm2pXD4SR5to3pgqMDds6x9GgJqcKbIKZd34a6VfUAUcUMDqLZaMVdr+B
s57KMcaELkc90wqxwOCSJ/pBoF/o67m7HFoUx2Fx02vYwd7jE84fq7YHB9AglX9r
BB+pdP07/fwBpOe3ysdbSgPZTNcTemtvFc01CLOYdrndXj4zbieZDcU77OEtS5yd
cfb0Zmw5Lrr01LkNy9+OwkvR1i9L+kgwVgSgsLuBJDjT2ANBo78UER6pMi8IUJSA
thGybFVtU0HDmQMGRUnNGSpo0lOtCQYjkq9HtDK6MpgfJ2+X5FhhOPyvwyiA8fjg
5FXZ7p8TIJnQeljvIEe4StwwJZvdaKnSuSgGqyYiobOHOW3+IeA=
=RHYo
-----END PGP SIGNATURE-----
--=-=-=--
