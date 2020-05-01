Return-Path: <SRS0=hlrK=6P=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56BCC47257
	for <linux-pm@archiver.kernel.org>; Fri,  1 May 2020 17:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C727424954
	for <linux-pm@archiver.kernel.org>; Fri,  1 May 2020 17:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t+M1Kbn4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbgEARJD (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 1 May 2020 13:09:03 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44486 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728970AbgEARJC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 13:09:02 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 041H8xO0023136;
        Fri, 1 May 2020 12:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588352939;
        bh=lXV4W/J4p3Alq0xOCow6eOHuCKTPPX9evdAxwBeNS0g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=t+M1Kbn4iCS4hxHlV/OQF9IyyuYrvyp+O7kcW1QT2l143zVmxLQ4lyc95PC0D0zGc
         Wvo/B1SvOm1+p8cdOeV/w0G8CcbuIk6Sn5O9wEolVXLU1LHCV2fNFr9chrzHcPO85w
         tQ3Lb/grDUAZH0HH8aN0O6Xd7UbhxWjYLTaSp8XI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 041H8xYj000612
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 May 2020 12:08:59 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 1 May
 2020 12:08:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 1 May 2020 12:08:59 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 041H8wr0030634;
        Fri, 1 May 2020 12:08:58 -0500
Subject: Re: [PATCH] dt-bindings: power: Convert power_supply text to yaml
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>
References: <20200430151841.17453-1-dmurphy@ti.com>
 <20200501165829.2y2soxprt6naemki@earth.universe>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <0caf4ac4-386f-b554-9702-76c7023bb72f@ti.com>
Date:   Fri, 1 May 2020 12:00:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501165829.2y2soxprt6naemki@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian

On 5/1/20 11:58 AM, Sebastian Reichel wrote:
> Hi,
>
> On Thu, Apr 30, 2020 at 10:18:41AM -0500, Dan Murphy wrote:
>> Convert the power_supply.txt to power-supply.yaml.
>> This conversion entailed fixing up the binding to being yaml and dt
>> checker compliant.
> Looks mostly good to me, thanks for taking care of it.
>
>> Added a note in the power_supply.txt to reference the power-supply.yaml
> Yes, we should keep the file until all bindings referencing the file
> have been converted to YAML.
Ack
>> CC: Rob Herring <robh@kernel.org>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   .../bindings/power/supply/power-supply.yaml   | 40 +++++++++++++++++++
>>   .../bindings/power/supply/power_supply.txt    | 25 +-----------
>>   2 files changed, 42 insertions(+), 23 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/power/supply/power-supply.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/power-supply.yaml b/Documentation/devicetree/bindings/power/supply/power-supply.yaml
>> new file mode 100644
>> index 000000000000..cfbc79833ed8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/power-supply.yaml
>> @@ -0,0 +1,40 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/power/supply/power_supply.yaml#"
> This should be power-supply instead of power_supply, which is also
> reported by dtb_binding_check on my system :)

Yeah I had an untracked file called power_supply.yaml and removed it 
after checking it in.

I will change this

>
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Power Supply Core Support
>> +
>> +maintainers:
>> +  - Sebastian Reichel <sre@kernel.org>
>> +
>> +properties:
>> +  power-supplies:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      This property is added to a supply in order to list the devices which
>> +      supply it power, referenced by their phandles.
>> +
>> +examples:
>> +  - |
>> +    power {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      usb_charger:power@e {
>> +        compatible = "some,usb-charger";
>> +        reg = <0xe>;
>> +      };
>> +
>> +      ac_charger:power@c {
> ^^^ while at it, let's also fix this up and use
> charger instead of power (for both entries).

Ack

Dan
