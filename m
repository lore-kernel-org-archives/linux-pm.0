From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Subject: Re: [PATCH v4 1/2] Documentation: Add sbs-manager device tree node
 documentation
Date: Thu, 01 Sep 2016 00:34:59 +0200
Message-ID: <4d255da80e88b400bc6f481b7fa48403@schneider-inet.de>
References: <1bIiDr-0004G1-0P>
 <1472156461-25180-1-git-send-email-karl-heinz@schneider-inet.de>
 <1472156461-25180-2-git-send-email-karl-heinz@schneider-inet.de>
 <20160831144349.GA18510@rob-hp-laptop>
Reply-To: <karl-heinz@schneider-inet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160831144349.GA18510@rob-hp-laptop>
Sender: linux-acpi-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Peter Rosin <peda@axentia.se>, Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org

Hi Rob,

Sorry for resending this mail, evolution mixed it up...

On Wed, 31 Aug 2016 09:43:49 -0500, Rob Herring wrote:
> On Thu, Aug 25, 2016 at 10:21:00PM +0200, Karl-Heinz Schneider wrote:
>> This patch adds device tree documentation for the sbs-manager
>>
>> Reviewed-by: Phil Reid <preid@electromag.com.au>
>> Signed-off-by: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
>> ---
>>  .../devicetree/bindings/power/sbs,sbs-manager.txt  | 53 
>> ++++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt 
>> b/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
>> new file mode 100644
>> index 0000000..6b1a87ce
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
>> @@ -0,0 +1,53 @@
>> +Binding for sbs-manager
>> +
>> +Required properties:
>> +- compatible: should be "lltc,ltc1760" or use "sbs,sbs-manager" as 
>> fallback.
>> +- reg: integer, i2c address of the device. Should be <0xa>.
>
> What happened to adding Phil's interrupt support into this? You don't
> have to add the whole patch, just the binding part. The driver 
> support
> can come later.

Phil revoked his patch. Right now it's not clear how the interrupt/gpio
solution will look like and if they will need an device tree binding at
all...

>
>> +
>> +From OS view the device is basically an i2c-mux used to communicate 
>> with up to
>> +four smart battery devices at address 0xb. The driver actually 
>> implements this
>> +behaviour. So standard i2c-mux nodes can be used to register up to 
>> four slave
>> +batteries. See Documentation/devicetree/bindings/i2c/i2c-mux.txt 
>> for more
>> +information on i2c-mux nodes. Channels will be numerated starting 
>> from 1 to 4.
>> +
>> +Example:
>> +
>> +batman@0a {
>
> drop leading 0.

OK.

>> +    compatible = "lltc,ltc1760";
>> +    reg = <0x0a>;


Will remove leading 0 at this places too.

>> +    #address-cells = <1>;
>> +    #size-cells = <0>;
>> +
>> +    i2c@1 {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        reg = <1>;
>> +
>> +        battery@0b {
>
> and here...

OK.

>
>> +            compatible = "ti,bq2060", "sbs,sbs-battery";
>> +            reg = <0x0b>;
>> +        };
>> +    };
>> +
>> +    i2c@2 {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        reg = <2>;
>> +
>> +        battery@0b {
>> +            compatible = "ti,bq2060", "sbs,sbs-battery";
>> +            reg = <0x0b>;
>> +        };
>> +    };
>> +
>> +    i2c@3 {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        reg = <3>;
>> +
>> +        battery@0b {
>> +            compatible = "ti,bq2060", "sbs,sbs-battery";
>> +            reg = <0x0b>;
>> +        };
>> +    };
>> +};
>> --
>> 2.7.4
>>

Thanks for review Rob.
-- 
Karl-Heinz
