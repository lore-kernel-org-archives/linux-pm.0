From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 3/3] power_supply: max77693: Listen for cable events and
 enable charging
Date: Wed, 28 Sep 2016 09:56:28 +0200
Message-ID: <298d81d5-fe41-e2d1-32a7-d3dc35b0fe25@kernel.org>
References: <CGME20160927133519eucas1p147b1e49693cde0e7e2d683901bdeb7ed@eucas1p1.samsung.com>
 <87a8etwjnr.fsf@machinist.wiedmeyer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:35305 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbcI1H4g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Sep 2016 03:56:36 -0400
In-reply-to: <87a8etwjnr.fsf@machinist.wiedmeyer.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, cw00.choi@samsung.com, b.zolnierkie@samsung.com, broonie@kernel.org, lgirdwood@gmail.com, lee.jones@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/27/2016 03:34 PM, Wolfgang Wiedmeyer wrote:
> 
> Krzysztof Kozlowski writes:
> 
>> On Tue, Sep 27, 2016 at 01:31:10AM +0200, Wolfgang Wiedmeyer wrote:
>>> This patch adds a listener for extcon cable events and enables
>>> charging if an USB cable is connected. It recognizes SDP and DCP cable
>>> types and treats them the same (same input current and fast charge
>>> current). The maximum input current is set before the charger is
>>> enabled and before the charger gets disabled, the maximum input
>>> current is set to zero. The listener is inspired by the listener
>>> implementation that was used for the AXP288 Charger driver.
>>>
>>> The patch also adds support for the CURRENT_NOW property. It reads the
>>> fast charge current that gets set before the charger is enabled or
>>> disabled.
>>>
>>> Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
>>
>> No. This power supply driver should not manage regulators. It is not a
>> regulator consumer. For that specific need, there is a charger-manager driver.
> 
> When I was in the middle of implementing this, I noticed that the
> charger manager does everything that is needed. But it took me quite
> some time to configure the DTS correctly until I realized that the
> charger manager used a deprecated function
> (extcon_register_interest()) and thus couldn't work. And as I didn't see
> the charger-manager in any other device's DTS, I thought that this might
> not be right way.
> But Chanwoo Choi has a fix: https://patchwork.kernel.org/patch/8898541/
> So I will try to get it working with this patch.
> 
>> I agree that you might configure here the charger. You might even expose
>> some writeable properties through power supply class. However the
>> purpose of this driver is to expose the battery charger to user-space,
>> not to replace the user-space with its work.
>>
>> So... NACK.
> 
> Ok, then I will try to reduce the patch to the CURRENT_NOW property
> support.
> 
>> If you would like to play with charger-manager, here is my old DTS for
>> Trats2 (might need updates):
> 
> Is there a reason that this patch is not in the kernel? It would have
> been very helpful for me :)

In general, DeviceTree should describe the hardware. Charger manager is
an abstract device, not a real one. This DT node does not describe real
hardware but it is a driver-specific glue needed to get things done.

I am not convinced that we should add to DTS such abstract devices. What
about people who want to control charging from user-space? They would
have to disable charger-manager from config.

Best regards,
Krzysztof

