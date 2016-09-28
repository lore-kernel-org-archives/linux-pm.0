From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/3] regulator: max77693: Also manipulate the fast charge
 current
Date: Wed, 28 Sep 2016 10:04:41 +0200
Message-ID: <e9c76587-1a50-167c-0f4b-2442cbc0fa39@kernel.org>
References: <CGME20160927175220eucas1p2885508f3fe274837693845ffc6745671@eucas1p2.samsung.com>
 <874m51w7r7.fsf@machinist.wiedmeyer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:35864 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751006AbcI1IEu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Sep 2016 04:04:50 -0400
In-reply-to: <874m51w7r7.fsf@machinist.wiedmeyer.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, Mark Brown <broonie@kernel.org>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, cw00.choi@samsung.com, b.zolnierkie@samsung.com, lgirdwood@gmail.com, lee.jones@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/27/2016 07:51 PM, Wolfgang Wiedmeyer wrote:
> 
> Mark Brown writes:
> 
>> On Tue, Sep 27, 2016 at 03:50:42PM +0200, Wolfgang Wiedmeyer wrote:
>>
>>> When charging is disabled (e.g. by removing the USB cable) the charge
>>> current is not reset to zero. So if I expose the current by the
>>> CURRENT_NOW property, it incorrectly reports the current that was set
>>> when charging was enabled, although there is no charging going on
>>> anymore. So I felt the need to update the charge current every time the
>>> charger gets enabled or disabled.
>>> Initially, the charge current is set to zero, so I think it needs to be
>>> set at least at the beginning to enable charging.
>>
>> Are you sure that the register value you're looking at is the actual
>> charge current right now and not just the maximum that the charger will
>> try to use depending on the conditions (supply available, battery
>> state...)?  It seems like you're acting as though it's the latter but
>> that's not what the chip is doing.
> 
> I was looking at the vendor code that was released for the Galaxy S3 and
> there the same register gets accessed for getting the current for
> the CURRENT_NOW property [1] and for setting the current [2]. So is this
> probably the wrong use of the CURRENT_NOW property because not the
> actual charge current is read but the maximum value that was
> set?

Yes, reading from this register will give only information about
currently set charge current. Not the real current.

Best regards,
Krzysztof

