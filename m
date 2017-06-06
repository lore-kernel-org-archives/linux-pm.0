From: Markus Mayer <code@mmayer.net>
Subject: Re: [PATCH 1/2] Documentation: devicetree: add binding for Broadcom
 STB AVS TMON
Date: Tue, 6 Jun 2017 10:07:08 -0700
Message-ID: <CANEuBv6y+FD86oH7hHctjrt=5Oh_4_iitgNHLppMOPt=D5yXig@mail.gmail.com>
References: <20170605210930.65432-1-code@mmayer.net> <20170605210930.65432-2-code@mmayer.net>
 <e5da2edfae3bd593fd7819db1d7e2337@milecki.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:32919 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdFFRHK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jun 2017 13:07:10 -0400
Received: by mail-ua0-f196.google.com with SMTP id x47so11757553uab.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Jun 2017 10:07:09 -0700 (PDT)
In-Reply-To: <e5da2edfae3bd593fd7819db1d7e2337@milecki.pl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc: Markus Mayer <code@mmayer.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Doug Berger <opendmb@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>

On 6 June 2017 at 05:21, Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl> wrote:
> On 2017-06-05 23:09, Markus Mayer wrote:
>>
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
>> @@ -0,0 +1,20 @@
>> +* Broadcom STB thermal management
>> +
>> +Thermal management core, provided by the AVS TMON hardware block.
>> +
>> +Required properties:
>> +- compatible: must be one of "brcm,avs-tmon" or "brcm,avs-tmon-bcm7445"
>
>
> Is the "one of" correct here? I'm not native English but it sounds like
> setting both is a wrong thing.

You are right. It should not say "one of". I'll fix the wording.

>> +- reg: address range for the AVS TMON registers
>> +- interrupts: temperature monitor interrupt, for high/low threshold
>> triggers
>> +- interrupt-names: should be "tmon"
>> +- interrupt-parent: the parent interrupt controller
>> +
>> +Example:
>> +
>> +       thermal@f04d1500 {
>> +               compatible =3D "brcm,avs-tmon-bcm7445", "brcm,avs-tmon";
>
>
> Yet here you use both bindings.
