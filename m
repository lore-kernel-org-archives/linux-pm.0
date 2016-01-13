From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 0/2] power: act8945a: add charger driver for the
 sub-device of ACT8945A MFD
Date: Wed, 13 Jan 2016 11:13:49 +0900
Message-ID: <5695B2DD.3000504@samsung.com>
References: <1452586185-818-1-git-send-email-wenyou.yang@atmel.com>
 <5695ACE7.3050505@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:19708 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbcAMCNx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 21:13:53 -0500
In-reply-to: <5695ACE7.3050505@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 13.01.2016 10:48, Krzysztof Kozlowski wrote:
> On 12.01.2016 17:09, Wenyou Yang wrote:
>> The ACT8945A is a Multi Function Device with the following subdevices:
>>  - Regulator
>>  - Charger
>>
>> This patch set is to add regulator driver for ACT8945A.
>> It is based on the patch set:
>> 	[PATCH v2] mfd: act8945a: add Active-semi ACT8945A PMIC MFD driver
>>
> 
> The useful information would be can be applied independently to other
> tree than MFD.

Oh damn, that was far from English. I meant:

The useful information would be whether it can be applied independently
from that patchset.

>From the sentence above I would guess not (in that
case don't send it as separate patchset)... but from the code I think it
could (because it depends on MFD_ACT8945A so no build errors).

Anyway please mark it explicitly - it helps the maintainer to make the
decision.

Best regards,
Krzysztof

