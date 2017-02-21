From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH v3 11/18] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
Date: Tue, 21 Feb 2017 19:05:28 +0100
Message-ID: <13eb32a3-8a84-2ad1-a3b1-39e688db31c0@free-electrons.com>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
 <20170214094112.27426-12-quentin.schulz@free-electrons.com>
 <CAGb2v658e8R+qw1zbqp6rY-dXXSsax7ZZGoL0WTZR=Gya7BbnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGb2v658e8R+qw1zbqp6rY-dXXSsax7ZZGoL0WTZR=Gya7BbnA@mail.gmail.com>
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

On 21/02/2017 05:45, Chen-Yu Tsai wrote:
> On Tue, Feb 14, 2017 at 5:41 PM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
>> The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.
>>
>> This patch adds the DT binding documentation for the battery power
>> supply which gets various data from the PMIC, such as the battery status
>> (charging, discharging, full, dead), current max limit, current current,
>> battery capacity (in percentage), voltage max and min limits, current
>> voltage and battery capacity (in Ah).
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>
>> v3:
>>  - removed constant charge current property, now should use the WIP
>>  battery framework,
> 
> IIRC this should also include a property for referencing the battery?
> 

Indeed.

Quentin

> Otherwise,
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> 
>>
>> v2:
>>  - changed DT node name from ac_power_supply to ac-power-supply,
>>  - removed io-channels and io-channel-names from DT (the IIO mapping is
>>  done in the IIO ADC driver now),
>>  - added x-powers,constant-charge-current property to set the maximal
>>  default constant current charge of the battery,
>>
>>  .../bindings/power/supply/axp20x_battery.txt         | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
>> new file mode 100644
>> index 0000000..c248866
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
>> @@ -0,0 +1,20 @@
>> +AXP20x and AXP22x battery power supply
>> +
>> +Required Properties:
>> + - compatible, one of:
>> +                       "x-powers,axp209-battery-power-supply"
>> +                       "x-powers,axp221-battery-power-supply"
>> +
>> +This node is a subnode of the axp20x/axp22x PMIC.
>> +
>> +The AXP20X and AXP22X can read the battery voltage, charge and discharge
>> +currents of the battery by reading ADC channels from the AXP20X/AXP22X
>> +ADC.
>> +
>> +Example:
>> +
>> +&axp209 {
>> +       battery_power_supply: battery-power-supply {
>> +               compatible = "x-powers,axp209-battery-power-supply";
>> +       }
>> +};
>> --
>> 2.9.3
>>

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
