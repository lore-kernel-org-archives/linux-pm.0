From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH v3 13/18] power: supply: add battery driver for AXP20X and
 AXP22X PMICs
Date: Tue, 21 Feb 2017 19:19:39 +0100
Message-ID: <c3b21cd4-6d1d-db6a-b1ef-ed119f683035@free-electrons.com>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
 <20170214094112.27426-14-quentin.schulz@free-electrons.com>
 <CAGb2v64MjfYSnXET1BWsv=VaZE+v7GwNj7nrWDRafjRCM5tcQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGb2v64MjfYSnXET1BWsv=VaZE+v7GwNj7nrWDRafjRCM5tcQg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-iio@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Russell King <linux@armlinux.org.uk>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, Rob Herring <robh+dt@kernel.org>, Icenowy Zheng <icenowy@aosc.xyz>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de, Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Chen-Yu,

On 21/02/2017 05:44, Chen-Yu Tsai wrote:
> On Tue, Feb 14, 2017 at 5:41 PM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
>> The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.
>>
>> This patch adds the battery power supply driver to get various data from
>> the PMIC, such as the battery status (charging, discharging, full,
>> dead), current max limit, current current, battery capacity (in
>> percentage), voltage max and min limits, current voltage and battery
>> capacity (in Ah).
>>
>> This battery driver uses the AXP20X/AXP22X ADC driver as PMIC data
>> provider.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
[...]
>> +static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp_batt,
>> +                                             int charge_current)
>> +{
>> +       if (axp_batt->axp_id == AXP209_ID)
>> +               charge_current = (charge_current - 300000) / 100000;
>> +       else
>> +               charge_current = (charge_current - 300000) / 150000;
>> +
>> +       if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
>> +               return -EINVAL;
> 
> I would add a check or warn if the value to be programmed exceeds that returned
> by power_supply_get_battery_info.

Completely agree on a warning.

> A charge current exceeding the limits of the
> battery is potentially disastrous. The battery may be destroyed or even burst
> into flames and explode, taking the board and anything nearby with it. Otherwise
> 

Yes, I understand. Maybe I'm seeing this ability to set the (max)
constant current charge the wrong way. Here is what I think:
If we limit the max constant charge current with a DT property, it would
require a DT rebuild when changing the battery (i.e. if an end-user
decides to change the battery with a bigger constant charge current, he
has to recompile the DT to change the DT value).

What I can suggest is the following:
 - set the max constant charge current and the default constant charge
current from the DT property,
 - allow the user to change the constant charge current via sysfs within
minimal-DT value range,
 - allow the user to set max constant charge current via sysfs (and
print a warning as well when setting it), then the user can set a higher
constant charge current,

That would require a two steps modification with a printed warning.
"Safer" but does not remove the ability to change the constant charge
current in the case of battery swapping/changing.

> Acked-by: Chen-Yu Tsai <wens@csie.org>
> 
> Speaking of power_supply_get_battery_info, is it merged or ready to be merged?
> 

v7 under way IIRC.

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
