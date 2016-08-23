From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 5/5] firmware: ti_sci: Add support for reboot core service
Date: Tue, 23 Aug 2016 13:46:20 -0500
Message-ID: <CAGo_u6oP2Z-82fj06Kk6Pz1p7e6wyrvvqhWUj8wff_VjeOHdhw@mail.gmail.com>
References: <20160819225159.10758-1-nm@ti.com> <20160819225159.10758-6-nm@ti.com>
 <20160823174841.GA23677@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:33098 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752786AbcHWSqW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2016 14:46:22 -0400
In-Reply-To: <20160823174841.GA23677@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, lkml <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Russ Dill <Russ.Dill@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Santosh Shilimkar <ssantosh@kernel.org>, dt list <devicetree@vger.kernel.org>

On Tue, Aug 23, 2016 at 12:48 PM, Rob Herring <robh@kernel.org> wrote:
>> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>> index 965d45e313b1..ed5b8fc185f1 100644
>> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>> @@ -38,6 +38,7 @@ Optional Properties:
>>  - reg-names:
>>       debug_messages - Map the Debug message region
>>  - reg:  register space corresponding to the debug_messages
>> +- ti,system-reboot-controller: If system reboot can be triggered by SoC reboot
>
> Don't define bindings incrementally. But all the binding in one patch.

Thanks for catching.  Fixed and will post a v2 next week if there is
no further comments.

---
Regards,
Nishanth Menon
