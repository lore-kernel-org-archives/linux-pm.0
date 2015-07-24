From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: Re: [PATCH] power_supply: Adjust devm usage
Date: Fri, 24 Jul 2015 18:44:41 +0530
Message-ID: <CAK-LDbJQ07fi3YOEOJ+8Qwm3jbqA7L8tFNF9U9=_QO0B0gg_UA@mail.gmail.com>
References: <20150724115813.GA3004@vaishali-Ideapad-Z570>
	<20150724122622.GA22105@earth>
	<CAK-LDbKk5wYAKVJ9eE5Kr6iOW1ah6VxAxBWcZjbufHp8WZXW=g@mail.gmail.com>
	<20150724125951.GA25447@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35057 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbbGXNOm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2015 09:14:42 -0400
In-Reply-To: <20150724125951.GA25447@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Frans Klaver <fransklaver@gmail.com>

On Fri, Jul 24, 2015 at 6:29 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Fri, Jul 24, 2015 at 06:03:38PM +0530, Vaishali Thakkar wrote:
>> On Fri, Jul 24, 2015 at 5:56 PM, Sebastian Reichel <sre@kernel.org> wrote:
>> > On Fri, Jul 24, 2015 at 05:28:13PM +0530, Vaishali Thakkar wrote:
>> >> @@ -267,8 +267,9 @@ static int bq24735_charger_probe() {}
>> >> [...]
>> >
>> > Your patch is missing removal of the
>> > kfree(charger->charger_desc.name) in bq24735_charger_remove().
>>
>> Yes. Because it seems that this kfree is freeing some other data which
>> is not related to devm_kzalloc. I was not sure about removing it.
>> So, I was about to discuss it in a separate thread.s
>
> it's assigned in the probe function:
>
>     name = kasprintf(...);
>     ...
>     supply_desc->name = name;
>     ...
>     power_supply_register(..., supply_desc, ...);
>

Oh. Yes. I missed that.

>> Also, in the remove function we have devm_free_irq. I am unsure it
>> too. Because normally remove functions do not use devm
>> counterparts.
>
> It's required to free the irq before removing the power supply
> device.
>
> If the power supply is registered with devm, that should happen
> automatically, since it is requested before the irq.  Thus the
> remove function can be removed completely at that point :)

This makes sense. Thanks for explanation and review :)
So, can I send all changes along with getting rid of remove
function here in a single patch?

> -- Sebastian



-- 
Vaishali
