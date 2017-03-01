From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v8 7/9] power: bq27xxx_battery: Add power_supply_battery_info
 support
Date: Wed, 1 Mar 2017 15:09:00 -0800
Message-ID: <CAKvHMgQXZZowPiLYsE7wz=L3F7T2bGtemh5XmkMm0jj84_kGPQ@mail.gmail.com>
References: <20170227071117.18934-1-liam@networkimprov.net>
 <20170227071117.18934-8-liam@networkimprov.net> <164968b9-e809-d7fc-176b-cbeded20d43d@ti.com>
 <CAKvHMgR8Ly9GYYmE5BgPsayQmd7_gwTV1_4NfdEfU3Giacdqcg@mail.gmail.com>
 <4a6622a3-5fea-ac37-c906-4073ef655983@ti.com> <CAKvHMgSouKi=NU-R3fWXe7L-ckcTJMWiNLvi500jQfUxzdJtwQ@mail.gmail.com>
 <880a1d69-dc06-b921-e0be-e3ebff75938d@ti.com> <CAKvHMgTJ6k-opU+oBP502+8HNz7As2KP7NLFQ9uRdP_YU135Lw@mail.gmail.com>
 <CAKvHMgTGNLeTte0wf3m-u0UmJB3DE4bQhSxF7Dg-Zr7J-MBLdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:33665 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752999AbdCAXQ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 18:16:59 -0500
Received: by mail-it0-f68.google.com with SMTP id 68so6694996itg.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Mar 2017 15:16:18 -0800 (PST)
In-Reply-To: <CAKvHMgTGNLeTte0wf3m-u0UmJB3DE4bQhSxF7Dg-Zr7J-MBLdg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On Mon, Feb 27, 2017 at 2:37 PM, Liam Breck <liam@networkimprov.net> wrote:
> On Mon, Feb 27, 2017 at 2:14 PM, Liam Breck <liam@networkimprov.net> wrot=
e:
>> On Mon, Feb 27, 2017 at 1:47 PM, Andrew F. Davis <afd@ti.com> wrote:
>>> On 02/27/2017 03:35 PM, Liam Breck wrote:
>>>> On Mon, Feb 27, 2017 at 1:21 PM, Andrew F. Davis <afd@ti.com> wrote:
>>>>> On 02/27/2017 02:05 PM, Liam Breck wrote:
>>>>>> On Mon, Feb 27, 2017 at 10:06 AM, Andrew F. Davis <afd@ti.com> wrote=
:
>>>>>>> On 02/27/2017 01:11 AM, Liam Breck wrote:
>>>>>>>> From: Liam Breck <kernel@networkimprov.net>
>>>>>>>>
>>>>>>>> Previously there was no way to configure chip registers in the eve=
nt that the
>>>>>>>> defaults didn't match the battery in question.
>>>>>>>>
>>>>>>>> BQ27xxx driver now calls power_supply_get_battery_info, checks the=
 inputs,
>>>>>>>> and writes battery data to chip RAM or non-volatile memory.
>>>>>>>>
>>>>>>>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>>>>>>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>>>>>>> ---
>>>>>>>>  drivers/power/supply/bq27xxx_battery.c | 458 ++++++++++++++++++++=
++++++++++++-
>>>>>>>>  1 file changed, 456 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/powe=
r/supply/bq27xxx_battery.c
>>>>>>>> index 7475a5f..41d4ce7 100644
>>>>>>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>>>>>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>>>>>>> @@ -51,7 +51,7 @@
>>>>>>>>
>>>>>>>>  #include <linux/power/bq27xxx_battery.h>
>>>>>>>>
>>>>>>>> -#define DRIVER_VERSION               "1.2.0"
>>>>>>>> +#define DRIVER_VERSION               "1.3.0"
>>>>>>>>
>>>>>>>>  #define BQ27XXX_MANUFACTURER "Texas Instruments"
>>>>>>>>
>>>>>>>> @@ -59,6 +59,7 @@
>>>>>>>>  #define BQ27XXX_FLAG_DSC     BIT(0)
>>>>>>>>  #define BQ27XXX_FLAG_SOCF    BIT(1) /* State-of-Charge threshold =
final */
>>>>>>>>  #define BQ27XXX_FLAG_SOC1    BIT(2) /* State-of-Charge threshold =
1 */
>>>>>>>> +#define BQ27XXX_FLAG_CFGUP   BIT(5)
>>>>>>>>  #define BQ27XXX_FLAG_FC              BIT(9)
>>>>>>>>  #define BQ27XXX_FLAG_OTD     BIT(14)
>>>>>>>>  #define BQ27XXX_FLAG_OTC     BIT(15)
>>>>>>>> @@ -72,6 +73,11 @@
>>>>>>>>  #define BQ27000_FLAG_FC              BIT(5)
>>>>>>>>  #define BQ27000_FLAG_CHGS    BIT(7) /* Charge state flag */
>>>>>>>>
>>>>>>>> +/* control register params */
>>>>>>>> +#define BQ27XXX_SEALED                       0x20
>>>>>>>> +#define BQ27XXX_SET_CFGUPDATE                0x13
>>>>>>>> +#define BQ27XXX_SOFT_RESET           0x42
>>>>>>>> +
>>>>>>>>  #define BQ27XXX_RS                   (20) /* Resistor sense mOhm =
*/
>>>>>>>>  #define BQ27XXX_POWER_CONSTANT               (29200) /* 29.2 =C2=
=B5V^2 * 1000 */
>>>>>>>>  #define BQ27XXX_CURRENT_CONSTANT     (3570) /* 3.57 =C2=B5V * 100=
0 */
>>>>>>>> @@ -102,6 +108,11 @@ enum bq27xxx_reg_index {
>>>>>>>>       BQ27XXX_REG_SOC,        /* State-of-Charge */
>>>>>>>>       BQ27XXX_REG_DCAP,       /* Design Capacity */
>>>>>>>>       BQ27XXX_REG_AP,         /* Average Power */
>>>>>>>> +     BQ27XXX_DM_CTRL,        /* BlockDataControl() */
>>>>>>>
>>>>>>> /* Block Data Control */
>>>>>>>
>>>>>>>> +     BQ27XXX_DM_CLASS,       /* DataClass() */
>>>>>>>
>>>>>>> /* Data Class */
>>>>>>
>>>>>> I used the terms from the docs, so a search will find meaningful res=
ults.
>>>>>>
>>>>>>>> +     BQ27XXX_DM_BLOCK,       /* DataBlock() */
>>>>>>>> +     BQ27XXX_DM_DATA,        /* BlockData() */
>>>>>>>> +     BQ27XXX_DM_CKSUM,       /* BlockDataChecksum() */
>>>>>>>>       BQ27XXX_REG_MAX,        /* sentinel */
>>>>>>>>  };
>>>>>>>>
>>>>>>>> @@ -125,6 +136,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D=
 {
>>>>>>>>               [BQ27XXX_REG_SOC] =3D 0x0b,
>>>>>>>>               [BQ27XXX_REG_DCAP] =3D 0x76,
>>>>>>>>               [BQ27XXX_REG_AP] =3D 0x24,
>>>>>>>> +             [BQ27XXX_DM_CTRL] =3D INVALID_REG_ADDR,
>>>>>>>> +             [BQ27XXX_DM_CLASS] =3D INVALID_REG_ADDR,
>>>>>>>> +             [BQ27XXX_DM_BLOCK] =3D INVALID_REG_ADDR,
>>>>>>>> +             [BQ27XXX_DM_DATA] =3D INVALID_REG_ADDR,
>>>>>>>> +             [BQ27XXX_DM_CKSUM] =3D INVALID_REG_ADDR,
>>>>>>>>       },
>>>>>>>>       [BQ27010] =3D {
>>>>>>>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>>>>>>>> @@ -144,6 +160,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D=
 {
>>>>>>>>               [BQ27XXX_REG_SOC] =3D 0x0b,
>>>>>>>>               [BQ27XXX_REG_DCAP] =3D 0x76,
>>>>>>>>               [BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>>>>>>>> +             [BQ27XXX_DM_CTRL] =3D INVALID_REG_ADDR,
>>>>>>>> +             [BQ27XXX_DM_CLASS] =3D INVALID_REG_ADDR,
>>>>>>>> +             [BQ27XXX_DM_BLOCK] =3D INVALID_REG_ADDR,
>>>>>>>> +             [BQ27XXX_DM_DATA] =3D INVALID_REG_ADDR,
>>>>>>>> +             [BQ27XXX_DM_CKSUM] =3D INVALID_REG_ADDR,
>>>>>>>>       },
>>>>>>>>       [BQ27500] =3D {
>>>>>>>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>>>>>>>> @@ -163,6 +184,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D=
 {
>>>>>>>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>>>>>>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>>>>>>>               [BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>>>>>>>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>>>>>>>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>>>>>>>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>>>>>>>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>>>>>>>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>>>>>>>       },
>>>>>>>>       [BQ27510] =3D {
>>>>>>>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>>>>>>>> @@ -182,6 +208,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D=
 {
>>>>>>>>               [BQ27XXX_REG_SOC] =3D 0x20,
>>>>>>>>               [BQ27XXX_REG_DCAP] =3D 0x2e,
>>>>>>>>               [BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>>>>>>>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>>>>>>>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>>>>>>>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>>>>>>>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>>>>>>>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>>>>>>>       },
>>>>>>>>       [BQ27530] =3D {
>>>>>>>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>>>>>>>> @@ -201,6 +232,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D=
 {
>>>>>>>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>>>>>>>               [BQ27XXX_REG_DCAP] =3D INVALID_REG_ADDR,
>>>>>>>>               [BQ27XXX_REG_AP] =3D 0x24,
>>>>>>>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>>>>>>>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>>>>>>>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>>>>>>>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>>>>>>>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>>>>>>>       },
>>>>>>>>       [BQ27541] =3D {
>>>>>>>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>>>>>>>> @@ -220,6 +256,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D=
 {
>>>>>>>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>>>>>>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>>>>>>>               [BQ27XXX_REG_AP] =3D 0x24,
>>>>>>>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>>>>>>>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>>>>>>>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>>>>>>>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>>>>>>>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>>>>>>>       },
>>>>>>>>       [BQ27545] =3D {
>>>>>>>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>>>>>>>> @@ -239,6 +280,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D=
 {
>>>>>>>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>>>>>>>               [BQ27XXX_REG_DCAP] =3D INVALID_REG_ADDR,
>>>>>>>>               [BQ27XXX_REG_AP] =3D 0x24,
>>>>>>>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>>>>>>>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>>>>>>>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>>>>>>>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>>>>>>>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>>>>>>>       },
>>>>>>>>       [BQ27421] =3D {
>>>>>>>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>>>>>>>> @@ -258,6 +304,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D=
 {
>>>>>>>>               [BQ27XXX_REG_SOC] =3D 0x1c,
>>>>>>>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>>>>>>>               [BQ27XXX_REG_AP] =3D 0x18,
>>>>>>>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>>>>>>>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>>>>>>>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>>>>>>>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>>>>>>>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>>>>>>>       },
>>>>>>>>       [BQ27425] =3D {
>>>>>>>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>>>>>>>> @@ -277,6 +328,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D=
 {
>>>>>>>>               [BQ27XXX_REG_SOC] =3D 0x1c,
>>>>>>>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>>>>>>>               [BQ27XXX_REG_AP] =3D 0x18,
>>>>>>>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>>>>>>>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>>>>>>>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>>>>>>>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>>>>>>>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>>>>>>
>>>>>>> That wasn't so painful was it :)
>>>>>>
>>>>>> It added 11% to the patch :-/
>>>>>>
>>>>>>>>       },
>>>>>>>>  };
>>>>>>>>
>>>>>>>> @@ -452,6 +508,81 @@ static struct {
>>>>>>>>  static DEFINE_MUTEX(bq27xxx_list_lock);
>>>>>>>>  static LIST_HEAD(bq27xxx_battery_devices);
>>>>>>>>
>>>>>>>> +#define BQ27XXX_DM_SZ                        32
>>>>>>>> +
>>>>>>>> +#define BQ27XXX_MSLEEP(i) usleep_range((i)*1000, (i)*1000+500)
>>>>>>>> +
>>>>>>>> +struct bq27xxx_dm_reg {
>>>>>>>> +     u8 subclass_id;
>>>>>>>> +     u8 offset;
>>>>>>>> +     u8 bytes;
>>>>>>>> +     u16 min, max;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +struct bq27xxx_dm_buf {
>>>>>>>> +     u8 class;
>>>>>>>> +     u8 block;
>>>>>>>> +     u8 a[BQ27XXX_DM_SZ];
>>>>>>>> +     bool full, updt;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +#define BQ27XXX_DM_BUF(di, i) { \
>>>>>>>> +     .class =3D bq27xxx_dm_regs[(di)->chip][i].subclass_id, \
>>>>>>>> +     .block =3D bq27xxx_dm_regs[(di)->chip][i].offset / BQ27XXX_D=
M_SZ, \
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static inline u16* bq27xxx_dm_buf_ptr(struct bq27xxx_dm_buf *buf,
>>>>>>>> +                                   struct bq27xxx_dm_reg *reg) {
>>>>>>>> +     if (buf->class =3D=3D reg->subclass_id
>>>>>>>> +      && buf->block =3D=3D reg->offset / BQ27XXX_DM_SZ)
>>>>>>>> +             return (u16*) (buf->a + reg->offset % BQ27XXX_DM_SZ)=
;
>>>>>>>> +
>>>>>>>> +     return NULL;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +enum bq27xxx_dm_reg_id {
>>>>>>>> +     BQ27XXX_DM_DESIGN_CAPACITY =3D 0,
>>>>>>>> +     BQ27XXX_DM_DESIGN_ENERGY,
>>>>>>>> +     BQ27XXX_DM_TERMINATE_VOLTAGE,
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +static const char* bq27xxx_dm_reg_name[] =3D {
>>>>>>>> +     [BQ27XXX_DM_DESIGN_CAPACITY] =3D "design-capacity",
>>>>>>>> +     [BQ27XXX_DM_DESIGN_ENERGY] =3D "design-energy",
>>>>>>>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] =3D "terminate-voltage",
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +static struct bq27xxx_dm_reg bq27425_dm_regs[] =3D {
>>>>>>>> +     [BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 82, 12, 2,    0, 32767 =
},
>>>>>>>> +     [BQ27XXX_DM_DESIGN_ENERGY]     =3D { 82, 14, 2,    0, 32767 =
},
>>>>>>>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 82, 18, 2, 2800,  3700 =
},
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +static struct bq27xxx_dm_reg bq27421_dm_regs[] =3D { /* not teste=
d */
>>>>>>>> +     [BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 82, 10, 2,    0,  8000 =
},
>>>>>>>> +     [BQ27XXX_DM_DESIGN_ENERGY]     =3D { 82, 12, 2,    0, 32767 =
},
>>>>>>>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 82, 16, 2, 2500,  3700 =
},
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +//static struct bq27xxx_dm_reg bq27621_dm_regs[] =3D { /* not tes=
ted */
>>>>>>>> +//   [BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 82, 3, 2,    0,  8000 }=
,
>>>>>>>> +//   [BQ27XXX_DM_DESIGN_ENERGY]     =3D { 82, 5, 2,    0, 32767 }=
,
>>>>>>>> +//   [BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 82, 9, 2, 2500,  3700 }=
,
>>>>>>>> +//};
>>>>>>>
>>>>>>> I don't think this comment style is allowed.
>>>>>>
>>>>>> This is a to-do item.
>>>>>>
>>>>>>>> +
>>>>>>>> +static struct bq27xxx_dm_reg *bq27xxx_dm_regs[] =3D {
>>>>>>>> +     [BQ27421] =3D bq27421_dm_regs, /* and BQ27441 */
>>>>>>>> +     [BQ27425] =3D bq27425_dm_regs,
>>>>>>>> +//   [BQ27621] =3D bq27621_dm_regs,
>>>>>>>> +};
>>>>>>>
>>>>>>> I know it is not tested, but lets not comment it out, I'll do a rou=
nd of
>>>>>>> testing for this part when this series is ready.
>>>>>>
>>>>>> ID for 621 is not yet defined. We need an efficient way to add IDs.
>>>>>> Perhaps via chip-id and group-id. Most current ID refs would be to
>>>>>> group-id. I'd like to defer that, so we should only add inputs for t=
he
>>>>>> single-chip groups in this patchset: 500, 545, 425.
>>>>>>
>>>>>> We must NOT set one-time program (OTP) memory, mentioned in 421 & 44=
1
>>>>>> docs. It's not clear whether documented data-memory ops change OTP.
>>>>>> Can you ask? The 425 has rewritable NVM. The 621 docs don't say. All
>>>>>> the above have cfgupdate mode, which the rest of the family lacks.
>>>>>>
>>>>>
>>>>> This would be a good question for e2e[0].
>>>>>
>>>>> [0] http://e2e.ti.com/support/power_management/battery_management/f/1=
80
>>>>
>>>> Can I ask you to handle discussions with TI folks?
>>>>
>>>
>>> You can ask, doesn't mean I will :) but really I don't have any special
>>> means of getting a hold of the gauge team that you don't have (except
>>> maybe walking over to their cubes and bugging them).
>>>
>>> We try to ask even internal inter-team questions on e2e, you can see
>>> questions asked by TI employees to other employees on that site, the
>>> idea is that if we have a problem, someday customers may have the same
>>> problem, so it's best not no keep these answers buried in some internal
>>> email chain. So the most I would do is post the same question to them o=
n
>>> e2e, you can avoid me being a middle-man by asking them directly.
>>
>> I understand; I'm just trying to minimize my todo list for this
>> patchset. We can put off the OTP issue, as this patchset won't support
>> those parts, since that needs the chip-id/group-id fix I mentioned.
>
> Here for use now or later is the Q I would ask:
>
> The following parts provide set_cfgupdate & soft_reset commands:
> BQ27... 421, 425, 441, 621
>
> Docs for 421 & 441 mention OTP memory
> Docs for 621 do not mention OTP
> Docs for 425 mention rewritable NVM
>
> What is in OTP on 421 & 441?
> Is anything in OTP on 621?
> Is anything in OTP on 425?
>
> Will documented data-memory ops, e.g. BlockData(), change OTP?
> Is OTP only changed in config-update mode?
>
> Context: we are adding DM update to the BQ27xxx linux driver, and must
> avoid setting OTP memory.

The above Q was asked and answered here:
https://e2e.ti.com/support/power_management/battery_management/f/180/t/5777=
98

On that basis, I'll use set_cfgupdate for all the mentioned parts.
