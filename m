From: <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH 6/8] power: reset: at91-reset: add support for sam9x60 SoC
Date: Thu, 24 Jan 2019 10:34:50 +0000
Message-ID: <a74956fc-6085-eec2-c1b8-ed116b2297d8@microchip.com>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <7e68a0298b8802edaead1f9c011f9c2e191ecf6a.1547629763.git.nicolas.ferre@microchip.com>
 <20190123183443.ppxdfstmau2xtodi@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190123183443.ppxdfstmau2xtodi@earth.universe>
Content-Language: en-US
Content-ID: <642BCDF518A7F14D94401399BB09A101@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, linux-usb@vger.kernel.org, stern@rowland.harvard.edu, gregkh@linuxfoundation.org, robh+dt@kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Sebastian,

On 23/01/2019 at 19:34, Sebastian Reichel wrote:
> Hi,
>=20
> On Wed, Jan 16, 2019 at 10:57:42AM +0100, Nicolas Ferre wrote:
>> Add support for additional reset causes and the proper compatibility
>> string for sam9x60 SoC. The restart function is the same as the samx7.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>> ---
>>   drivers/power/reset/at91-reset.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91=
-reset.c
>> index f44a9ffcc2ab..44ca983a49a1 100644
>> --- a/drivers/power/reset/at91-reset.c
>> +++ b/drivers/power/reset/at91-reset.c
>> @@ -44,6 +44,9 @@ enum reset_type {
>>   	RESET_TYPE_WATCHDOG	=3D 2,
>>   	RESET_TYPE_SOFTWARE	=3D 3,
>>   	RESET_TYPE_USER		=3D 4,
>> +	RESET_TYPE_CPU_FAIL	=3D 6,
>> +	RESET_TYPE_XTAL_FAIL	=3D 7,
>> +	RESET_TYPE_ULP2		=3D 8,
>=20
> what happened to 5? :)

That a good question ;-)

It's marked as "Reserved"... which opens up a whole new field of=20
speculation :-)

[..]

>>   	{ .compatible =3D "atmel,samx7-rstc", .data =3D samx7_restart },
>> +	{ .compatible =3D "microchip,sam9x60-rstc", .data =3D samx7_restart },
>>   	{ /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, at91_reset_of_match);
>=20
> Patch looks fine to me. But I will wait a bit with merging, so that
> Alexandre or Ludovic have a chance to provide feedback.

What about merging this patch with the whole series through the at91=20
then arm-soc trees?

Best regards,
--=20
Nicolas Ferre
