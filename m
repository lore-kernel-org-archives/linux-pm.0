From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 1/7] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
Date: Wed, 5 Apr 2017 10:48:53 +0200
Message-ID: <c1fd3ae7-4e4a-bb5b-f8ce-123d85d9b937@free-electrons.com>
References: <20170405081059.1684-1-quentin.schulz@free-electrons.com>
 <20170405081059.1684-2-quentin.schulz@free-electrons.com>
 <CAKvHMgRD8N4zuW1E4NO8Dzux6V8cHTwiYL+cvoEuz49am2duKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKvHMgRD8N4zuW1E4NO8Dzux6V8cHTwiYL+cvoEuz49am2duKQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Liam,

On 05/04/2017 10:38, Liam Breck wrote:
> [reduced CC list]
> 
> Hi Quentin,
> 
> On Wed, Apr 5, 2017 at 1:10 AM, Quentin Schulz
> <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>> The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.
>>
>> This patch adds the DT binding documentation for the battery power
>> supply which gets various data from the PMIC, such as the battery status
>> (charging, discharging, full, dead), current max limit, current current,
>> battery capacity (in percentage), voltage max and min limits, current
>> voltage and battery capacity (in Ah).
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> Acked-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> ---
>>
>> v5:
>>   - removed DT property example from monitored-battery,
>>
>> v4:
>>  - added monitored-battery optional property,
>>  - added example with battery,
>>
>> v3:
>>  - removed constant charge current property, now should use the WIP
>>  battery framework,
>>
>> v2:
>>  - changed DT node name from ac_power_supply to ac-power-supply,
>>  - removed io-channels and io-channel-names from DT (the IIO mapping is
>>  done in the IIO ADC driver now),
>>  - added x-powers,constant-charge-current property to set the maximal
>>  default constant current charge of the battery,
>>
>>  .../bindings/power/supply/axp20x_battery.txt       | 28 ++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
>> new file mode 100644
>> index 0000000..63826fd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
>> @@ -0,0 +1,28 @@
>> +AXP20x and AXP22x battery power supply
>> +
>> +Required Properties:
>> + - compatible, one of:
>> +                       "x-powers,axp209-battery-power-supply"
>> +                       "x-powers,axp221-battery-power-supply"
>> +
>> +Optional properties:
>> + - monitored-battery, phandle to a fixed battery
> 
> Say here what properties of the battery your driver considers, e.g.
> https://patchwork.kernel.org/patch/9660987/
> 

Sorry but I'm completely lost in your patch series, this isn't your
patch series for the battery framework. How do I know from which I
should take the name of the DT property then?

>> +
>> +This node is a subnode of the axp20x/axp22x PMIC.
>> +
>> +The AXP20X and AXP22X can read the battery voltage, charge and discharge
>> +currents of the battery by reading ADC channels from the AXP20X/AXP22X
>> +ADC.
>> +
>> +Example:
>> +
>> +battery: battery {
>> +       compatible = "fixed-battery";
> 
> This is now "simple-battery". Also needs properties.
> 

I've removed all the code in the driver to take care of the monitored
battery info until your framework is merged. Since there are still
discussion around the name to give to the different DT properties and
since it's not required in this driver, I'll add them later to the DT
binding.

Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
