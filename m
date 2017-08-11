From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v2 2/5] devicetree: power: Add docs for TI BQ24190 battery charger
Date: Fri, 11 Aug 2017 14:57:10 -0700
Message-ID: <CAKvHMgSuwm5UFivbsq9dQn_wfd7kbs63UuuQSHVdGxDf_WReUA@mail.gmail.com>
References: <20170807195420.20767-1-liam@networkimprov.net>
 <20170807195420.20767-3-liam@networkimprov.net> <20170811025038.5qnhbabyybx7rgu5@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35000 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753742AbdHKV5L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2017 17:57:11 -0400
In-Reply-To: <20170811025038.5qnhbabyybx7rgu5@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

Hi Rob,

On Thu, Aug 10, 2017 at 7:50 PM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Aug 07, 2017 at 12:54:17PM -0700, Liam Breck wrote:
>> From: Liam Breck <kernel@networkimprov.net>
>>
>> Document monitored-battery and ti,system-minimum-microvolt properties.
>>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> ---
>>  .../devicetree/bindings/power/supply/bq24190.txt   | 49 ++++++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq24190.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.txt b/Documentation/devicetree/bindings/power/supply/bq24190.txt
>> new file mode 100644
>> index 00000000..82a1c842
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/bq24190.txt
>> @@ -0,0 +1,49 @@
>> +TI BQ24190 Li-Ion Battery Charger
>> +
>> +Required properties:
>> +- compatible: contains one of the following:
>> +    * "ti,bq24190"
>> +    * "ti,bq24192i"
>> +- reg: integer, I2C address of the charger.
>> +- interrupts[-extended]: configuration for charger INT pin.
>> +
>> +Optional properties:
>> +- monitored-battery: phandle of battery characteristics devicetree node
>> +    The charger uses the following battery properties:
>> +    + precharge-current-microamp: maximum charge current during precharge
>> +      phase (typically 20% of battery capacity).
>> +    + charge-term-current-microamp: a charge cycle terminates when the
>> +      battery voltage is above recharge threshold, and the current is below
>> +      this setting (typically 10% of battery capacity).
>> +    See Documentation/devicetree/bindings/power/supply/battery.txt
>> +- ti,system-minimum-microvolt: when power is connected and the battery is below
>> +    minimum system voltage, the system will be regulated above this setting.
>> +
>> +Other features:
>> +- Use gpio-hog to set the OTG pin high to enable 500mA charge current on USB SDP port.
>
> Why doesn't the charger driver control this?

This pin/gpio has to be high when USB is plugged in to make the
charger chip negotiate 500mA from a SDP port. It should generally be
configured that way even if the driver is not loaded, as the chip does
not require a driver to function. Some boards may do that with a
pull-up. Also the user may want to change this via sysfs and not have
the driver "fix" it.

>> +
>> +Example:
>> +
>> +     bat: battery {
>> +             compatible = "simple-battery";
>> +             precharge-current-microamp = <256000>;
>> +             charge-term-current-microamp = <128000>;
>> +             // etc.
>> +     };
>> +
>> +     bq24190: charger@6a {
>> +             compatible = "ti,bq24190";
>> +             reg = <0x6a>;
>> +             interrupts-extended = <&gpiochip 10 IRQ_TYPE_EDGE_FALLING>;
>> +             monitored-battery = <&bat>;
>> +             ti,system-minimum-microvolt = <3200000>;
>> +     };
>> +
>> +     &twl_gpio {
>> +             otg {
>> +                     gpio-hog;
>> +                     gpios = <6 0>;
>> +                     output-high;
>> +                     line-name = "otg-gpio";
>> +             };
>> +     };
>> --
>> 2.13.2
>>
