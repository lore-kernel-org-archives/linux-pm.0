From: Chris Lapa <chris@lapa.com.au>
Subject: Re: [PATCH v3 1/7] max8903: adds documentation for device tree
 bindings.
Date: Tue, 21 Jun 2016 09:43:47 +1000
Message-ID: <c4d85f15-e0ed-7a6c-4c2f-fcf79eb96856@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466139626-51434-2-git-send-email-chris@lapa.com.au>
 <20160620132247.GA30380@rob-hp-laptop>
Reply-To: chris@lapa.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36761 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbcFTXpM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2016 19:45:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id i123so9488429pfg.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2016 16:43:53 -0700 (PDT)
In-Reply-To: <20160620132247.GA30380@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: k.kozlowski@samsung.com, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 20/06/2016 11:22 PM, Rob Herring wrote:
> On Fri, Jun 17, 2016 at 03:00:20PM +1000, Chris Lapa wrote:
>> From: Chris Lapa <chris@lapa.com.au>
>>
>> Signed-off-by: Chris Lapa <chris@lapa.com.au>
>> ---
>>  .../devicetree/bindings/power/max8903-charger.txt  | 25 ++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/max8903-charger.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/max8903-charger.txt b/Documentation/devicetree/bindings/power/max8903-charger.txt
>> new file mode 100644
>> index 0000000..aea1dd2a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/max8903-charger.txt
>> @@ -0,0 +1,25 @@
>> +Maxim Semiconductor MAX8903 Battery Charger bindings
>> +
>> +Required properties:
>> +- compatible: "maxim,max8903-charger" for MAX8903 Battery Charger
>
> Drop "charger" as that is implied by the chip.
Just for clarification, you mean:
	compatible: "maxim,max8903" for MAX8903 Battery Charger

Thanks,
Chris

>
>> +- dok-gpios: Valid DC power has been detected, optional if uok-gpios is provided
>> +- uok-gpios: Valid USB power has been detected, optional if dok-gpios is provided
>> +
>> +Optional properties:
>> +- cen-gpios: Charge enable pin
>> +- chg-gpios: Charger status pin
>> +- flt-gpios: Fault pin
>> +- dcm-gpios: Current limit mode setting (DC or USB)
>> +- usus-gpios: USB suspend pin
>
> Need to state direction and active state for all of these.
>

