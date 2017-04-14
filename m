From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v5 1/2] power: supply: bq24190_charger: Use new
 extcon_register_notifier_all()
Date: Fri, 14 Apr 2017 10:15:06 +0900
Message-ID: <58F0229A.1090200@samsung.com>
References: <20170413120412.12773-1-hdegoede@redhat.com>
        <20170413120412.12773-2-hdegoede@redhat.com>
        <20170413233526.ebtytz54d3ux2oze@earth>
        <CGME20170413234503epcas1p1c91946cb5246310ae53016399f21ac1c@epcas1p1.samsung.com>
        <20170413234448.stxmxvnemldzjyq3@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:49201 "EHLO
        epoutp01.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751083AbdDNBPK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2017 21:15:10 -0400
In-reply-to: <20170413234448.stxmxvnemldzjyq3@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org

Hi Sebastian,

On 2017년 04월 14일 08:44, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Apr 14, 2017 at 01:35:26AM +0200, Sebastian Reichel wrote:
>> Hi,
>>
>> On Thu, Apr 13, 2017 at 02:04:11PM +0200, Hans de Goede wrote:
>>> When I submitted the extcon handling I had a patch pending for the
>>> extcon sub-system for extcon_register_notifier to take -1 as cable id
>>> for listening for all type cable events on an extcon with a single
>>> notifier.
>>>
>>> In the end it was decided to instead add a new
>>> extcon_register_notifier_all function for this, switch to using this.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> Acked-by: Liam Breck <kernel@networkimprov.net>
>>
>> With extcon_register_notifier_all() being new and not available
>> in my tree I can't simply queue this patch. Also it can't simply
>> go through the extcon subsystem, since it depends on changes in
>> the power-supply subsystem and results in non-trivial merge conflict.
>> I see three merge solutions:
>>
>>  1. Defer to 4.13 (since we are already quite near the merge window)
>>  2. I need a immutable branch with extcon_register_notifier_all()
>>     from the extcon subsystem
>>  3. It may count as Fix and could be queued during the 4.12-rc
>>     phase based von 4.12-rc1
> 
> Sorry for the noise, I just saw the immutable branch in the cover
> mail. I will queue this now. Unfortunately it means rebasing the
> power-supply tree to 4.11-rc4 (or ugly merge, which is annoying
> in the pull-request). Chanwoo, please try to use -rc1 as base for
> immutable branches in the future.

I'm really sorry about this. It is my fault. In the future,
I'll use the -rc1 for the immutable branch. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
