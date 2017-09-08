From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH resend v2] power: supply: bq27xxx: enable writing capacity
 values for bq27421
Date: Fri, 8 Sep 2017 13:57:20 -0700
Message-ID: <CAKvHMgSQduvA6MFgNMgaYejep74OfJPUnCGJ3cKeHty=OAabPg@mail.gmail.com>
References: <be410e440d889b2e46208b523bdb890e860c5046.1504037446.git.hns@goldelico.com>
 <CAKvHMgQDcgabM3UogXE3L07n9yiHgD3FfJ5GCOqkAk1=SA2A=Q@mail.gmail.com>
 <7428DD60-FE09-41C4-9DBC-FFDCB9D0B591@goldelico.com> <CAKvHMgT8MDpussUYJ_AKELXzCbQxz2BYrF0ZM-S_on=9+oatEQ@mail.gmail.com>
 <3A487394-3755-4EA0-86C6-6855DA0AC547@goldelico.com> <CAKvHMgT6AHfjnXvD5jeWP_9wAm_GQNJxm=Nm1jH32NeaVZjdYw@mail.gmail.com>
 <A3715C96-BA15-4F3F-B0F1-017A5D31FFB0@goldelico.com> <CAKvHMgTGDb=JVCMpTo4ZXwRVc9s4BweAFzwGGNoewZwaT3=4LA@mail.gmail.com>
 <9903AE74-6BAA-4051-ADFC-0DB5972AF26E@goldelico.com> <CAKvHMgRKO4wSWr_XU5wCM6-yadz4kY++zq96w-RSRrzBjQF1zQ@mail.gmail.com>
 <13B50F41-D8AC-46E5-B57C-274CFB4DAD75@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <13B50F41-D8AC-46E5-B57C-274CFB4DAD75@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F. Davis" <afd@ti.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
List-Id: linux-pm@vger.kernel.org

Howdy,

On Fri, Sep 8, 2017 at 1:28 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> Hi Liam,
>
>> Am 08.09.2017 um 22:19 schrieb Liam Breck <liam@networkimprov.net>:
>>
>> Hi Nikolaus,
>>
>> On Fri, Sep 8, 2017 at 10:38 AM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>> Hi Liam,
>>> I finally continues testing on OpenPandora.
>>>
>>>> Am 31.08.2017 um 22:19 schrieb Liam Breck <liam@networkimprov.net>:
>>>>
>>>> Hi,
>>>>
>>>> This may be a fix that allows >0 input from DT, but won't try to
>>>> program the register since the first 3 fields aren't compatible:
>>>>
>>>> ... bq27500_dm_regs[] = {
>>>> ...
>>>> [bq27xxx_dm_design_energy] = {  0,  0, 0,    0, 65535 }, /* missing on chip */
>>>> NB: align columns with other rows
>>>
>>> I have tried with this DT
>>>
>>>        bat: battery {
>>>                compatible = "simple-battery", "openpandora-battery";
>>>                voltage-min-design-microvolt = <3250000>;
>>>                energy-full-design-microwatt-hours = <14800000>;
>>>                charge-full-design-microamp-hours = <4100000>;
>>>        };
>>>
>>> and here is the result:
>>>
>>>> root@letux:~# dmesg|fgrep bq27
>>>> [   10.391235] bq27xxx_battery_setup
>>>> [   10.391265] bq27xxx_battery_setup: dm_regs=bf0520e0
>>>> [   10.393798] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name attribute, please fix
>>>> [   10.432678] bq27xxx_battery_settings
>>>> [   10.432952] bq27xxx_battery_set_config
>>>> [   10.432952] bq27xxx_battery_unseal
>>>> [   10.485168] bq27xxx_battery_update_dm_block
>>>> [   10.485198] bq27xxx-battery 2-0055: update design-capacity to 4100
>>>
>>> looks good
>>>
>>>> [   10.485229] bq27xxx_battery_update_dm_block
>>>> [   10.485229] bq27xxx-battery 2-0055: buffer does not match design-energy dm spec
>>>
>>> ok, ignored
>>>
>>>> [   10.511718] bq27xxx_battery_update_dm_block
>>>> [   10.511749] bq27xxx-battery 2-0055: update terminate-voltage to 3250
>>>
>>> looks good
>>>
>>>> [   10.826446] bq27xxx_battery_seal
>>>> [   12.150939] bq27xxx_battery_platform_probe
>>>> [   12.151031] bq27xxx_battery_setup
>>>> [   12.151062] bq27xxx_battery_setup: dm_regs=  (null)
>>>> [   12.153411] (NULL device *): hwmon: 'bq27000-battery' is not a valid name attribute, please fix
>>>> [   12.154327] bq27xxx_battery_settings
>>>> [   12.154357] power_supply bq27000-battery: power_supply_get_battery_info currently only supports devicetree
>>>> [   12.154388] bq27xxx_battery_settings: power_supply_get_battery_info failed ret=-6
>>
>> Is there also a bq27000 chip on this device, or a battery with it
>> embedded? If so, it doesn't appear to have a DT node (correct for
>> embedded), hence that warning, which isn't useful in that case. Prob
>> battery_settings() should do:
>>    if (!di->dev->of_node || power_supply_get_battery_info(...) < 0) return;
>> altho that would be wrong once get_battery_info() supports ACPI config...
>
> No it is not available, but could be. The bq27000 can be connected through
> HDQ to an OMAP3 and therefore there is no auto-detection. If it is configured
> the driver will be loaded. Even if there is no battery_info.
>
> In fact we use the same defconfig for several devices and there is one (GTA04)
> which only has a bq27000 inside the battery.

Any idea why the driver detects a non-present bq27000 and calls
probe() for it? defconfig with battery_bq27xxx=y ?
