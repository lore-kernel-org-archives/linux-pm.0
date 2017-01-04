From: Matt Ranostay <matt@ranostay.consulting>
Subject: Re: [PATCH 2/3] devicetree: bq27425: add documentation for bq27425
 fuel gauge
Date: Tue, 3 Jan 2017 21:23:55 -0800
Message-ID: <CAJ_EiSTcpxQVWZALJC_u5P8YM_ku8_wPaiTLyENq5h0XHiQA2g@mail.gmail.com>
References: <20161226054442.23599-1-matt@ranostay.consulting>
 <20161226054442.23599-3-matt@ranostay.consulting> <20170103164715.pypb5zt22hg4zqlh@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:33285 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbdADFX4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Jan 2017 00:23:56 -0500
Received: by mail-qt0-f175.google.com with SMTP id v23so13600633qtb.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Jan 2017 21:23:56 -0800 (PST)
In-Reply-To: <20170103164715.pypb5zt22hg4zqlh@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>

On Tue, Jan 3, 2017 at 8:47 AM, Rob Herring <robh@kernel.org> wrote:
> On Sun, Dec 25, 2016 at 09:44:41PM -0800, Matt Ranostay wrote:
>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>> ---
>>  .../devicetree/bindings/power/bq27425.txt          | 25 ++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/bq27425.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/bq27425.txt b/Documentation/devicetree/bindings/power/bq27425.txt
>> new file mode 100644
>> index 000000000000..f09f787a9378
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/bq27425.txt
>> @@ -0,0 +1,25 @@
>> +* TI BQ27425 Fuel Gauge
>> +
>> +http://www.ti.com/lit/ds/symlink/bq27425-g2a.pdf
>> +
>> +Please note that if any of the optional properties are defined
>> +then all settings must be.
>> +
>> +Required properties:
>> +- compatible: Should be "ti,bq27425"
>> +- reg: integer, i2c of the device
>
> s/i2c/I2C address/
>
>> +
>> +Optional properties:
>> +- ti,design-capacity: integer of mAh of the battery
>> +- ti,design-energy: integer of the mWh of the battery
>> +- ti,terminate-voltage: integer of mV of the dead voltage of
>> +                     the battery
>
> These all need unit suffixes. mAh and mWh may need to be added to
> property-units.txt.

Ok makes sense.

>
>> +
>> +bq27425 {
>> +     compatible = "ti,bq27425";
>> +     reg = <0x55>;
>> +
>> +     ti,design-capacity = <1360>;
>> +     ti,design-energy = <4970>;
>> +     ti,terminate-voltage = <3200>;
>> +};
>> --
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
