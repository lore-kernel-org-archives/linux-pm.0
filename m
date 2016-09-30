From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH v5 3/6] Documentation: Add sbs-manager device tree node
 documentation
Date: Fri, 30 Sep 2016 15:58:09 +0800
Message-ID: <1ab3ce40-cde3-b66b-6bf6-610a70e8ca75@electromag.com.au>
References: <1474447274-90821-1-git-send-email-preid@electromag.com.au>
 <1474447274-90821-4-git-send-email-preid@electromag.com.au>
 <20160923194434.GA5771@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20160923194434.GA5771@rob-hp-laptop>
Sender: linux-i2c-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: wsa@the-dreams.de, mark.rutland@arm.com, sre@kernel.org, andrea.merello@gmail.com, karl-heinz@schneider-inet.de, arnd@arndb.de, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

G'day Rob,
On 24/09/2016 03:44, Rob Herring wrote:
> On Wed, Sep 21, 2016 at 04:41:11PM +0800, Phil Reid wrote:
>> From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
>>
>> This patch adds device tree documentation for the sbs-manager
>>
>> Reviewed-by: Phil Reid <preid@electromag.com.au>
>> Signed-off-by: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>> ---
>>  .../bindings/power/supply/sbs,sbs-manager.txt      | 62 ++++++++++++++++++++++
>>  1 file changed, 62 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
>> new file mode 100644
>> index 0000000..2a04b30
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
>> @@ -0,0 +1,62 @@
>> +Binding for sbs-manager
>> +
>> +Required properties:
>> +- compatible: should be "lltc,ltc1760" or use "sbs,sbs-manager" as fallback.
>> +- reg: integer, i2c address of the device. Should be <0xa>.
>> +Optional properties:
>> +- gpio-controller: Marks the port as GPIO controller.
>> +  See "gpio-specifier" in .../devicetree/bindings/gpio/gpio.txt.
>> +- #gpio-cells: Should be <2>. The first cell is the pin number, the second cell
>> +  is used to specify optional parameters:
>> +  See "gpio-specifier" in .../devicetree/bindings/gpio/gpio.txt.
>
> Is this leftover from the last version? It doesn't look like you are
> using any GPIOs in the example.

Sorry didn't update the example. I still need the gpio exposed to the battery.
>
>> +
>> +From OS view the device is basically an i2c-mux used to communicate with up to
>> +four smart battery devices at address 0xb. The driver actually implements this
>> +behaviour. So standard i2c-mux nodes can be used to register up to four slave
>> +batteries. See Documentation/devicetree/bindings/i2c/i2c-mux.txt for more
>> +information on i2c-mux nodes. Channels will be numerated starting from 1 to 4.
>> +
>> +Example:
>> +
>> +batman@0a {
>> +    compatible = "lltc,ltc1760";
>> +    reg = <0x0a>;
>> +    #address-cells = <1>;
>> +    #size-cells = <0>;
>> +
>> +    gpio-controller;
>> +    #gpio-cells = <2>;
>> +
>> +    i2c@1 {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        reg = <1>;
>> +
>> +        battery@b {
>> +            compatible = "ti,bq2060", "sbs,sbs-battery";
>> +            reg = <0xb>;
should have something like:
                 sbs,battery-detect-gpios = <&batman 0 GPIO_ACTIVE_HIGH>;

>> +        };
>> +    };
>> +
>> +    i2c@2 {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        reg = <2>;
>> +
>> +        battery@b {
>> +            compatible = "ti,bq2060", "sbs,sbs-battery";
>> +            reg = <0xb>;
>> +        };
>> +    };
>> +
>> +    i2c@3 {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        reg = <3>;
>> +
>> +        battery@b {
>> +            compatible = "ti,bq2060", "sbs,sbs-battery";
>> +            reg = <0xb>;
>> +        };
>> +    };
>> +};
>> --

Let me know your thoughts.

-- 
Regards
Phil Reid
