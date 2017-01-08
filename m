From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 14/22] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
Date: Sun, 8 Jan 2017 10:59:18 +0000
Message-ID: <b950822a-0ecc-09b6-288e-3e837459ebbb@kernel.org>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-15-quentin.schulz@free-electrons.com>
 <20170104132107.tciklylgqvhftb6f@rob-hp-laptop>
 <3155ba16-b51a-9306-6be4-0bdf4482a679@kernel.org>
 <4a8456e6-c6e9-73ac-0f5c-29e9faceb13c@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4a8456e6-c6e9-73ac-0f5c-29e9faceb13c@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>, Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, sre@kernel.org, linux@armlinux.org.uk, wens@csie.org, icenowy@aosc.xyz, pmeerw@pmeerw.net, knaack.h@gmx.de, maxime.ripard@free-electrons.com, bonbons@linux-vserver.org, lee.jones@linaro.org, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 08/01/17 10:48, Quentin Schulz wrote:
> Hi Jonathan,
> 
> On 07/01/2017 20:33, Jonathan Cameron wrote:
>> On 04/01/17 08:21, Rob Herring wrote:
>>> On Mon, Jan 02, 2017 at 05:37:14PM +0100, Quentin Schulz wrote:
>>>> The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.
>>>>
>>>> This patch adds the DT binding documentation for the battery power
>>>> supply which gets various data from the PMIC, such as the battery status
>>>> (charging, discharging, full, dead), current max limit, current current,
>>>> battery capacity (in percentage), voltage max and min limits, current
>>>> voltage and battery capacity (in Ah).
>>>>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>>> ---
>>>>  .../bindings/power/supply/axp20x_battery.txt       | 27 ++++++++++++++++++++++
>>>>  1 file changed, 27 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
>>>> new file mode 100644
>>>> index 0000000..5489d0d
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
>>>> @@ -0,0 +1,27 @@
>>>> +AXP20x and AXP22x battery power supply
>>>> +
>>>> +Required Properties:
>>>> + - compatible, one of:
>>>> +			"x-powers,axp209-battery-power-supply"
>>>> +			"x-powers,axp221-battery-power-supply"
>>>> + - io-channels: phandles to battery voltage, charge and discharge
>>>> + currents ADC channels
>>>> + - io-channel-names = "batt_v", "batt_chrg_i", "batt_dischrg_i";
>>>> +
>>>> +This node is a subnode of the axp20x/axp22x PMIC.
>>>> +
>>>> +The AXP20X and AXP22X can read the battery voltage, charge and discharge
>>>> +currents of the battery by reading ADC channels from the AXP20X/AXP22X
>>>> +ADC.
>>>> +
>>>> +Example:
>>>> +
>>>> +&axp209 {
>>>> +	battery_power_supply: battery_power_supply {
>>>
>>> Humm, I guess you power-supply is not sufficient, so 
>>> 'battery-power-supply' and similar for ac.
>>>
>>>> +		compatible = "x-powers,axp209-battery-power-supply";
>>>> +		io-channels = <&axp209_adc 7>, <&axp209_adc 8>,
>>>> +			<&axp209_adc 9>;
>>>> +		io-channel-names = "batt_v", "batt_chrg_i",
>>>> +			"batt_dischrg_i";
>> Is this stuff fixed for the device?
> 
> If we don't mix the IIO channels order, it is. This driver only requires
> batt_v, batt_chrg_i and batt_dischrg_i so we've to keep them at that
> place in the list of IIO channels. Or as suggested by Rob and Chen-Yu, I
> can move all this inside the driver with iio_map and don't care anymore
> about the order.
> 
I'd do that. Makes life easier to represented fixed things as fixed!
> Thanks,
> Quentin
> 
