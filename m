From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4/7] dt-bindings: power: supply: Add docs for Ingenic
 JZ47xx SoCs battery.
Date: Thu, 28 Feb 2019 15:56:04 -0300
Message-ID: <1551380164.10612.0@crapouillou.net>
References: <20190217142914.17433-1-contact@artur-rojek.eu>
        <20190217142914.17433-4-contact@artur-rojek.eu>
        <20190228184822.GA17624@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190228184822.GA17624@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Artur Rojek <contact@artur-rojek.eu>, Sebastian Reichel <sre@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rob,

Le jeu. 28 f=E9vr. 2019 =E0 15:48, Rob Herring <robh@kernel.org> a =E9crit=20
:
> On Sun, Feb 17, 2019 at 03:29:13PM +0100, Artur Rojek wrote:
>>  Add documentation for the ingenic-battery driver, used on JZ47xx=20
>> SoCs.
>>=20
>>  Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>>  ---
>>   .../bindings/power/supply/ingenic,battery.txt | 31=20
>> +++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>   create mode 100644=20
>> Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
>>=20
>>  diff --git=20
>> a/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt=20
>> b/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
>>  new file mode 100644
>>  index 000000000000..66430bf73815
>>  --- /dev/null
>>  +++=20
>> b/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
>>  @@ -0,0 +1,31 @@
>>  +* Ingenic JZ47xx battery bindings
>>  +
>>  +Required properties:
>>  +
>>  +- compatible: Must be "ingenic,jz4740-battery".
>>  +- io-channels: phandle and IIO specifier pair to the IIO device.
>>  +  Format described in iio-bindings.txt.
>>  +- monitored-battery: phandle to a "simple-battery" compatible node.
>>  +
>>  +The "monitored-battery" property must be a phandle to a node using=20
>> the format
>>  +described in battery.txt, with the following properties being=20
>> required:
>>  +
>>  +- voltage-min-design-microvolt: Drained battery voltage.
>>  +- voltage-max-design-microvolt: Fully charged battery voltage.
>>  +
>>  +Example:
>>  +
>>  +#include <dt-bindings/iio/adc/ingenic,adc.h>
>>  +
>>  +simple_battery: battery {
>>  +	compatible =3D "simple-battery";
>>  +	voltage-min-design-microvolt =3D <3600000>;
>>  +	voltage-max-design-microvolt =3D <4200000>;
>>  +};
>>  +
>>  +ingenic_battery {
>>  +	compatible =3D "ingenic,jz4740-battery";
>>  +	io-channels =3D <&adc INGENIC_ADC_BATTERY>;
>>  +	io-channel-names =3D "battery";
>>  +	monitored-battery =3D <&simple_battery>;
>=20
> Isn't this just an ADC monitored battery? What's specific to JZ4740?
>=20
> Maybe a generic binding is appropriate here?
>=20
> Rob

There is no generic driver, is there? The generic-adc-battery driver
isn't OF-compatible and looks like dead code (nothing uses it).

-Paul
=
