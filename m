From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v14 2/5] dt-bindings: document Rockchip thermal
Date: Mon, 27 Oct 2014 17:37:38 -0700
Message-ID: <4038023.8IINY8khj6@dtor-glaptop>
References: <1414377588-2237-1-git-send-email-caesar.wang@rock-chips.com> <20141028002915.GJ7594@dtor-ws> <544EE42D.3030208@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:43715 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbaJ1Ahl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Oct 2014 20:37:41 -0400
In-Reply-To: <544EE42D.3030208@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <caesar.wang@rock-chips.com>
Cc: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com, zyf@rock-chips.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, cf@rock-chips.com, dbasehore@chromium.org, huangtao@rock-chips.com, cjf@rock-chips.com, zhengsq@rock-chips.com

On Tuesday, October 28, 2014 08:32:45 AM Caesar Wang wrote:
> Dmitry,
>=20
> =E5=9C=A8 2014=E5=B9=B410=E6=9C=8828=E6=97=A5 08:29, Dmitry Torokhov =
=E5=86=99=E9=81=93:
> > On Mon, Oct 27, 2014 at 10:39:45AM +0800, Caesar Wang wrote:
> >> This add the necessary binding documentation for the thermal
> >> found on Rockchip SoCs
> >>=20
> >> Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
> >> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> >> ---
> >>=20
> >>   .../bindings/thermal/rockchip-thermal.txt          | 53
> >>   ++++++++++++++++++++++ 1 file changed, 53 insertions(+)
> >>   create mode 100644
> >>   Documentation/devicetree/bindings/thermal/rockchip-thermal.txt>>=
=20
> >> diff --git
> >> a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> >> b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt n=
ew
> >> file mode 100644
> >> index 0000000..d5b1401
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.t=
xt
> >> @@ -0,0 +1,53 @@
> >> +* Temperature Sensor ADC (TSADC) on rockchip SoCs
> >> +
> >> +Required properties:
> >> +- compatible : "rockchip,rk3288-tsadc"
> >> +- reg : physical base address of the controller and length of mem=
ory
> >> mapped +	region.
> >> +- interrupts : The interrupt number to the cpu. The interrupt spe=
cifier
> >> format +	       depends on the interrupt controller.
> >> +- clocks : Must contain an entry for each entry in clock-names.
> >> +- clock-names : Shall be "tsadc" for the converter-clock, and "ap=
b_pclk"
> >> for +		the peripheral clock.
> >> +- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a
> >> description.>=20
> > I think you are missing description of hw-shut-temp, tsadc-tshut-mo=
de
> > and tsadc-tshut-mode
> >=20
> >   and optional pinctrl settings.
>=20
> If it's really need,we just have hw-shut-temp,tsadc-tshut-mode
> and tsadc-tshut-mode,no need  pinctrl setting,I think.

This is more question to DeviceTree guys, but I can see us not document=
ing
pinctrl since it is generic property used by every driver out there. We=
 should
definitely document driver-specific properties.

Thanks.

--=20
Dmitry
