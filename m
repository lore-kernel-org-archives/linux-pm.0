From: <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 2/4] power: reset: at91-poweroff: move shdwc related data
 to one structure
Date: Thu, 6 Dec 2018 09:48:10 +0000
Message-ID: <a0db3b8a-3c2b-02fd-64cc-b490a75b8b7c@microchip.com>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
 <1541416443-4321-3-git-send-email-claudiu.beznea@microchip.com>
 <20181106210933.GU24212@piout.net>
 <6719a808-e704-3c63-f592-3b90d44ccbfe@microchip.com>
 <20181107172340.GF21694@piout.net>
 <20181205224052.34o3cmh3y3htchcj@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205224052.34o3cmh3y3htchcj@earth.universe>
Content-Language: en-US
Content-ID: <D84CF29545773F4AB1BEAA5C00B72BA2@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sebastian.reichel@collabora.com, alexandre.belloni@bootlin.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Sebastian,

On 06.12.2018 00:40, Sebastian Reichel wrote:
> Hi,
>=20
> On Wed, Nov 07, 2018 at 06:23:40PM +0100, Alexandre Belloni wrote:
>> On 07/11/2018 14:54:17+0000, Claudiu.Beznea@microchip.com wrote:
>>> Hi Alexandre,
>>>
>>> On 06.11.2018 23:09, Alexandre Belloni wrote:
>>>> Hi Claudiu,
>>>>
>>>> On 05/11/2018 11:14:26+0000, Claudiu.Beznea@microchip.com wrote:
>>>>>  static int __init at91_poweroff_probe(struct platform_device *pdev)
>>>>> @@ -154,16 +160,22 @@ static int __init at91_poweroff_probe(struct pl=
atform_device *pdev)
>>>>>  	u32 ddr_type;
>>>>>  	int ret;
>>>>> =20
>>>>> +	at91_shdwc =3D devm_kzalloc(&pdev->dev, sizeof(*at91_shdwc), GFP_KE=
RNEL);
>>>>> +	if (!at91_shdwc)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>
>>>> Is there any real benefit that will offset the time lost for that
>>>> allocation at boot time?
>>>
>>> No, I haven't run benchmarks on this. I only wanted to have them groupe=
d in
>>> one structure. Please let me know if you have some tests in mind.
>>>
>>
>> Well, it is probably not much but small things adds up. Having it as a
>> global structure is probably good enough.
>=20
> I suppose I will get a new patch with this change?

Yes, I will send a new version for this one.

Thank you,
Claudiu Beznea

>=20
> -- Sebastian
>=20
>>
>>>>
>>>> I understand you are then testing at91_shdwc to know whether the drive=
r
>>>> already probed once. But, the driver will never probe twice as there i=
s
>>>> only one shutdown controller on the SoC and anyway, If it was to probe
>>>> twice, it will still work as expected.
>>>
>>> I had in mind the scenario where the driver would be compiled as module=
. I
>>> know insmod already does this checking. I'm ok to remove this checking.=
 I
>>> will do it in next version. With this I will also remove devm_kzalloc()=
 of
>>> at91_shdwc.
>>>
>>
>> Thanks,
>>
>> --=20
>> Alexandre Belloni, Bootlin
>> Embedded Linux and Kernel engineering
>> https://bootlin.com
