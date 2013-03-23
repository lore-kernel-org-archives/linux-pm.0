From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 13/14] ARM: mvebu: Add thermal support to Armada 370
 device tree
Date: Sat, 23 Mar 2013 18:25:58 +0400
Message-ID: <514DBB76.4080006@cogentembedded.com>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com> <1363991114-4225-14-git-send-email-ezequiel.garcia@free-electrons.com> <514DB9B9.8090601@cogentembedded.com> <514DBA1F.6050701@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:58407 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab3CWO05 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 Mar 2013 10:26:57 -0400
Received: by mail-la0-f45.google.com with SMTP id er20so8868857lab.4
        for <linux-pm@vger.kernel.org>; Sat, 23 Mar 2013 07:26:54 -0700 (PDT)
In-Reply-To: <514DBA1F.6050701@cogentembedded.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On 23-03-2013 18:20, Sergei Shtylyov wrote:

>>> This patch adds support for the thermal controller available in
>>> all Armada 370 boards. This controller has two 4-byte registers:
>>> one to read the thermal sensor, the other for sensor initialization.

>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>>> ---
>>> This patch depends on the patch to add Armada 370 support
>>> in the mvebu_thermal driver:
>>> 'thermal: mvebu: Add support for Armada 370 thermal sensor'

>>>   arch/arm/boot/dts/armada-370.dtsi |    6 ++++++
>>>   1 files changed, 6 insertions(+), 0 deletions(-)

>>> diff --git a/arch/arm/boot/dts/armada-370.dtsi
>>> b/arch/arm/boot/dts/armada-370.dtsi
>>> index 8188d13..5831994 100644
>>> --- a/arch/arm/boot/dts/armada-370.dtsi
>>> +++ b/arch/arm/boot/dts/armada-370.dtsi
>>> @@ -153,5 +153,11 @@
>>>               clocks = <&coreclk 0>;
>>>           };
>>>
>>> +        thermal@d0018300 {
>>> +            compatible = "marvell,armada370-thermal";
>>> +            reg = <0xd0018300 0x4
>>> +                   0xd0018304 0x4>;

>>     As the two registers are adjacent to each other, why have two register
>> regions ISO one?

>     Ah, I just saw the previous patch where the registers are not adjacent and
> it became clear why.

    However, the "compatible" properties are different...

WBR, Sergei

