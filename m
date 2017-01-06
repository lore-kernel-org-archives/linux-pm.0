From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH 17/22] power: supply: add battery driver for AXP20X and
 AXP22X PMICs
Date: Fri, 6 Jan 2017 09:29:07 +0100
Message-ID: <b26272cc-d8c9-f213-ab66-a24d7bc30dc4@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-18-quentin.schulz@free-electrons.com>
 <CAGb2v66XnWOGcaLeRo+cb6NGqfm_cyJVoK+GURUo5iV4pdZzew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGb2v66XnWOGcaLeRo+cb6NGqfm_cyJVoK+GURUo5iV4pdZzew@mail.gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-iio@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Russell King <linux@armlinux.org.uk>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de, Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jonathan Cameron <jic23@kernel.org>, Icenowy Zheng <icenowy@aosc.xyz>
List-Id: linux-pm@vger.kernel.org

Hi,

On 06/01/2017 04:39, Chen-Yu Tsai wrote:
>  Hi,
> 
> On Tue, Jan 3, 2017 at 12:37 AM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
[...]
>> +       case POWER_SUPPLY_PROP_CURRENT_MAX:
>> +               ret = regmap_read(axp20x_batt->regmap, AXP20X_CHRG_CTRL1, &reg);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               reg &= AXP20X_CHRG_CTRL1_TGT_CURR;
>> +               val->intval = reg * 100000 + 300000;
>> +               break;
> 
> 
> This controls the charge current. I believe the correct property to use
> is CONSTANT_CHARGE_CURRENT. And you should add CONSTANT_CHARGE_CURRENT_MAX
> which returns the highest possible setting.
> 

ACK.

> Also letting the user control this might not always be a good idea.
> IIUC, LiPo batteries can only be charged at 1C, where C is the
> rated capacity (X mAh).
> 

OK. Should I get the charge current from a DT property then?

Like "x-powers,charge-current = <300000>;"
It's close to what has been done in bq24257_charger for example.

[...]
>> +static enum power_supply_property axp20x_battery_props[] = {
>> +       POWER_SUPPLY_PROP_PRESENT,
>> +       POWER_SUPPLY_PROP_ONLINE,
>> +       POWER_SUPPLY_PROP_STATUS,
>> +       POWER_SUPPLY_PROP_VOLTAGE_NOW,
>> +       POWER_SUPPLY_PROP_CURRENT_NOW,
>> +       POWER_SUPPLY_PROP_CURRENT_MAX,
>> +       POWER_SUPPLY_PROP_HEALTH,
>> +       POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
>> +       POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
>> +       POWER_SUPPLY_PROP_CAPACITY,
> 
> You can also add POWER_SUPPLY_PROP_TECHNOLOGY, which would return
> POWER_SUPPLY_TECHNOLOGY_LIPO.
> 

Hum.. There are also POWER_SUPPLY_TECHNOLOGY_LION,
POWER_SUPPLY_TECHNOLOGY_LiFe and POWER_SUPPLY_TECHNOLOGY_LiMn which are
all Lithium-based batteries. From the datasheet, it can take a "single
cell Li-battery (Li-Ion/Polymer)". So I guess it's either
POWER_SUPPLY_TECHNOLOGY_LION or POWER_SUPPLY_TECHNOLOGY_LIPO.

> It is also possible to do POWER_SUPPLY_PROP_CHARGE_TYPE. According
> to the manual, if the battery is charging, it is in constant current
> mode (POWER_SUPPLY_CHARGE_TYPE_FAST) when V_battery < V_target.
> When V_battery == V_target, it is in constant voltage mode, though
> I don't think this is the same as POWER_SUPPLY_CHARGE_TYPE_TRICKLE.
> When it is not charging, you can return POWER_SUPPLY_CHARGE_TYPE_NONE.
> 

ACK, I'll look into that.

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
