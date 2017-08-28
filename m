From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 04/14] staging: typec: fusb302: Get max snk mv/ma/mw
 from device-properties
Date: Mon, 28 Aug 2017 18:11:38 +0200
Message-ID: <c6966f66-98bd-5271-a681-ed72c52805f6@redhat.com>
References: <20170815200502.17339-1-hdegoede@redhat.com>
 <20170815200502.17339-5-hdegoede@redhat.com>
 <20170817214131.63vetzuove7dz5pi@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170817214131.63vetzuove7dz5pi@rob-hp-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, "Yueyao (Nathan) Zhu" <yueyao@google.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 17-08-17 23:41, Rob Herring wrote:
> On Tue, Aug 15, 2017 at 10:04:52PM +0200, Hans de Goede wrote:
>> This is board specific info so it should come from board config, such
>> as devicetree.
>>
>> I've chosen to prefix these with "fcs," treating them as fusb302 driver
>> specific for now. We may want to revisit this and replace these with
>> properties which are part of a (to be written) generic type-c controller
>> devicetree binding.
>>
>> Since this commit adds new dt-properties it also adds devicetree-bindings
>> documentation (which so far was absent for the fusb302 driver).
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Frank Rowand <frowand.list@gmail.com>
>> Cc: devicetree@vger.kernel.org
>> Cc: "Yueyao (Nathan) Zhu" <yueyao@google.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Use micro... instead of mili...
>> -Add devicetree bindings documentation
>> ---
>>   .../devicetree/bindings/usb/fcs,fusb302.txt        | 29 ++++++++++++++++++++++
>>   drivers/staging/typec/fusb302/TODO                 |  4 +++
>>   drivers/staging/typec/fusb302/fusb302.c            | 18 +++++++++++++-
>>   3 files changed, 50 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/devicetree/bindings/usb/fcs,fusb302.txt
>>
>> diff --git a/Documentation/devicetree/bindings/usb/fcs,fusb302.txt b/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
>> new file mode 100644
>> index 0000000..ffc6c87
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
>> @@ -0,0 +1,29 @@
>> +Fairchild FUSB302 Type-C Port controllers
>> +
>> +Required properties :
>> +- compatible            : "fcs,fusb302"
>> +- reg                   : I2C slave address
>> +- interrupts            : Interrupt specifier
>> +
>> +Optional properties :
>> +- fcs,max-snk-microvolt : Maximum voltage to negotiate when configured as sink
>> +- fcs,max-snk-microamp  : Maximum current to negotiate when configured as sink
>> +- fcs,max-snk-microwatt : Maximum power to negotiate when configured as sink
>> +			  If this is less then max-snk-microvolt *
>> +			  max-snk-microamp then the configured current will
>> +			  be clamped.
>> +- fcs,operating-snk-microwatt :
> 
> Might as well spell out sink.

Fixed for v3.

> Otherwise,
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thank you, added to v3 of this patch-set.

Regards,

Hans

> 
>> +                          Minimum amount of power accepted from a sink
>> +			  when negotiating
>> +
>> +Example:
>> +
>> +fusb302: typec-portc@54 {
>> +	compatible = "fcs,fusb302";
>> +	reg = <0x54>;
>> +	interrupt-parent = <&nmi_intc>;
>> +	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +	fcs,max-snk-microvolt = <12000000>;
>> +	fcs,max-snk-microamp = <3000000>;
>> +	fcs,max-snk-microwatt = <36000000>;
>> +};
