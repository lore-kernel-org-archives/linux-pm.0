From: Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [PATCH 3/4] ARM: bcm2835: add thermal node to device-tree of bcm283x
Date: Fri, 13 May 2016 08:29:37 +0200
Message-ID: <FA3695BE-D1A7-44E3-9714-08B6A002EB06@martin.sperl.org>
References: <1463063738-11506-1-git-send-email-kernel@martin.sperl.org> <1463063738-11506-4-git-send-email-kernel@martin.sperl.org> <87posqamh9.fsf@eliezer.anholt.net>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 212-186-180-163.dynamic.surfer.at ([212.186.180.163]:54556 "EHLO
	cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbcEMG3k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2016 02:29:40 -0400
In-Reply-To: <87posqamh9.fsf@eliezer.anholt.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eric Anholt <eric@anholt.net>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Russell King <linux@arm.linux.org.uk>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org


> On 13.05.2016, at 01:24, Eric Anholt <eric@anholt.net> wrote:
> 
> kernel@martin.sperl.org writes:
> 
>> From: Martin Sperl <kernel@martin.sperl.org>
>> 
>> Add the node for the thermal sensor of the bcm2835-soc
>> to the device tree.
>> 
>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>> ---
>> arch/arm/boot/dts/bcm283x.dtsi | 6 ++++++
>> 1 file changed, 6 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
>> index 9db9d97..525f1f2 100644
>> --- a/arch/arm/boot/dts/bcm283x.dtsi
>> +++ b/arch/arm/boot/dts/bcm283x.dtsi
>> @@ -159,6 +159,12 @@
>> 			status = "disabled";
>> 		};
>> 
>> +		thermal: thermal@0x7e212000 {
>> +			compatible = "brcm,bcm2835-thermal";
>> +			reg = <0x7e212000 0x8>;
>> +			clocks = <&clocks BCM2835_CLOCK_TSENS>;
>> +		};
>> +
> 
> You could drop the "thermal: " here since nothing refers to it.  Either
> way,
Actually you will refer to it in the device tree for the bcm2837
so that you can set a different compatible string.

