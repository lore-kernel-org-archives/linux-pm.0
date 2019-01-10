From: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: mfd: max8998: Add charger subnode binding
Date: Thu, 10 Jan 2019 21:11:35 +0100
Message-ID: <7002692.meb5AFBGDJ@acerlaptop>
References: <1524844982-4714-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <2089055.mctyXeETjz@acerlaptop> <5765349a-c94d-49c1-45b5-ab7ac09f9923@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5765349a-c94d-49c1-45b5-ab7ac09f9923@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi

On Thursday, 10 January 2019 18:47:11 CET Sylwester Nawrocki wrote:
> Hi,
>=20
> On 5/1/18 16:43, Pawe=C5=82 Chmiel wrote:
> > On Tuesday, May 1, 2018 2:45:40 PM CEST Sebastian Reichel wrote:
> >> On Fri, Apr 27, 2018 at 06:03:02PM +0200, Pawe=C5=82 Chmiel wrote:
> >>> This patch adds devicetree bindings documentation for
> >>> battery charging controller as the subnode of MAX8998 PMIC.
> >>> It's based on current behavior of driver.
> >>>
> >>> Fixes: ee999fb3f17f ("mfd: max8998: Add support for Device Tree")
> >>> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/mfd/max8998.txt | 22 +++++++++++++=
+++++++++
> >>>  1 file changed, 22 insertions(+)
>=20
> >>> --- a/Documentation/devicetree/bindings/mfd/max8998.txt
> >>> +++ b/Documentation/devicetree/bindings/mfd/max8998.txt
> >>> @@ -50,6 +50,21 @@ Additional properties required if max8998,pmic-buc=
k2-dvs-gpio is defined:
> >>>  - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in mi=
crovolts
> >>>    for buck2 regulator that can be selected using dvs gpio.
> >>> =20
> >>> +Charger: Configuration for battery charging controller should be add=
ed
> >>> +inside a child node named 'charger'.
> >>> +  Required properties:
> >>> +  - max8998,charge-eoc: Setup "End of Charge". If value equals 0,
> >>> +    remain value set from bootloader or default value will be used.
> >>> +    Valid values: 0, 10 - 45
> >>> +
> >>> +  - max8998,charge-restart: Setup "Charge Restart Level". If value e=
quals 0,
> >>> +    remain value set from bootloader or default value will be used.
> >>> +    Valid values: -1, 0, 100, 150, 200
>=20
> Perhaps change the property name to max8998,charge-restart-threshold,=20
> in include/linux/mfd/max8998.h we have:
>=20
>  * @restart: Restart Level in mV: 100, 150, 200, and -1 for disable.
>  *   If it equals 0, leave it unchanged.
>=20
> Then we could make it an optional property:
>=20
>  - max8998,charge-restart-threshold: Charge restart threshold in millivol=
ts.=20
>    Valid values are: 0, 100, 150, 200. If the value equals 0 the charger=
=20
>    restart will be disabled.
>=20
> If the property is missing the charger restart threshold configuration wo=
uld
> be left unchanged.
>=20
Strange, i've looked at max8998 and didn't saw information that those value=
s are in mV (maybe it was from vendor sources).

> >>> +  - max8998,charge-timeout: Setup "Charge Full Timeout". If value eq=
uals 0,
> >>> +    remain value set from bootloader or default value will be used.
> >>> +    Valid values: -1, 0, 5, 6, 7
> >>
> >> What are those values? seconds?
> >>
> > Honestly i don't know. I've just documented values accepted currently=20
> > by charger driver, so we can use it from devicetree.
> > I couldn't find any max8998 datasheet with this information (units, pos=
sible=20
> > values etc for those properties).
>=20
> The charge timeout is in hours, as described in include/linux/mfd/max8998=
=2Eh:
>=20
>=20
> "* @timeout: Full Timeout in hours: 5, 6, 7, and -1 for disable.
>  *   If it equals 0, leave it unchanged.
>  *   Otherwise, leave it unchanged."
>=20
> We could change description of the property to something along the lines =
of:
>=20
> Optional properties:
>=20
>   - max8998,charge-timeout: Charge timeout in hours. Valid values are:
>     0, 5, 6, 7. If the value is 0 the charge timer will be disabled.
>=20
> Then if the property is missing the driver will leave charge timer config=
uration
> unchanged.
>=20
>=20
Thanks Sylwester Nawrocki for all those hints (mostly regarding units of th=
ose magic numbers/values). I'll prepare new version of those patches with a=
ll hints included.
