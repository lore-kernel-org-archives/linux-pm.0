From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] dt-bindings: power: New bindings for ltc3651-charger
Date: Tue, 9 May 2017 07:26:51 +0200
Message-ID: <1d046814-8a0b-099b-0a5b-b704623e1b92@topic.nl>
References: <1493966315-15893-1-git-send-email-mike.looijmans@topic.nl>
 <20170508171206.ajxjbw5mybvrpwss@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx6-14.smtp.antispamcloud.com ([95.211.2.226]:54731 "EHLO
        mx6-14.smtp.antispamcloud.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751270AbdEIFpu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2017 01:45:50 -0400
In-Reply-To: <20170508171206.ajxjbw5mybvrpwss@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com

﻿On 08-05-17 19:12, Rob Herring wrote:
> On Fri, May 05, 2017 at 08:38:35AM +0200, Mike Looijmans wrote:
>> This adds the devicetree bindings documentation for the LTC3651 battery charger.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>>  .../bindings/power/supply/ltc3651-charger.txt      | 26 ++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
>> new file mode 100644
>> index 0000000..a7dd80f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
>> @@ -0,0 +1,26 @@
>> +ltc3651-charger
>> +
>> +Required properties:
>> + - compatible: "lltc,ltc3651-charger"
>> + - acpr-gpios: Connect to ACPR output. See remark below.
>> +
>> +Optional properties:
>> + - fault-gpios: Connect to FAULT output. See remark below.
>> + - chrg-gpios: Connect to CHRG output. See remark below.
>
> All the gpios need vendor prefix.

Will prefix "lltc," adjust the driver and submit new patches.

>
>> +
>> +The ltc3651 outputs are open-drain type and active low. The driver assumes the
>> +GPIO reports "active" when the output is asserted, so if the pins have been
>> +connected directly, the GPIO flags should be set to active low also.
>> +
>> +The driver will attempt to aquire interrupts for all GPIOs. If the system is
>> +not capabale of providing that, the driver cannot report changes and userspace
>> +will need to periodically read the sysfs attributes to detect changes.
>
> If these are interrupts, then you should use the interrupt binding
> instead (most GPIO controllers are also interrupt controllers).

They're GPIO (the driver needs the current state), the use of interrupts is 
just to detect changes. Similar to gpio-charger for example. Interrupt 
bindings cannot provide the current state of the line.


>
>> +
>> +Example:
>> +
>> +	charger: battery-charger {
>> +		compatible = "lltc,ltc3651-charger";
>> +		acpr-gpios = <&gpio0 68 GPIO_ACTIVE_LOW>;
>> +		fault-gpios = <&gpio0 64 GPIO_ACTIVE_LOW>;
>> +		chrg-gpios = <&gpio0 63 GPIO_ACTIVE_LOW>;
>> +	};
>> --
>> 1.9.1
>>



Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
