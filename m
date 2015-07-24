From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: Re: [PATCH] power_supply: Adjust devm usage
Date: Fri, 24 Jul 2015 18:03:38 +0530
Message-ID: <CAK-LDbKk5wYAKVJ9eE5Kr6iOW1ah6VxAxBWcZjbufHp8WZXW=g@mail.gmail.com>
References: <20150724115813.GA3004@vaishali-Ideapad-Z570>
	<20150724122622.GA22105@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37640 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbbGXMdj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2015 08:33:39 -0400
In-Reply-To: <20150724122622.GA22105@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jul 24, 2015 at 5:56 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,

Hi

> Thanks for the cleanup patch.
> I have a couple of comments inlined.
>
>> Subject: Re: [PATCH] power_supply: Adjust devm usage
>
> Please make this "power_supply: bq24735: ...".

Ok. Sure.

> On Fri, Jul 24, 2015 at 05:28:13PM +0530, Vaishali Thakkar wrote:
>> Use devm_kasprintf instead of kasprintf. Also, remove various
>> gotos by direct returns and drop unneeded label err_free_name.
>
> Please also use devm_power_supply_unregister() instead
> of power_supply_unregister() to further simplify the driver.

Ok.

>> @@ -267,8 +267,9 @@ static int bq24735_charger_probe() {}
>> [...]
>
> Your patch is missing removal of the
> kfree(charger->charger_desc.name) in bq24735_charger_remove().

Yes. Because it seems that this kfree is freeing some other data which
is not related to devm_kzalloc. I was not sure about removing it.
So, I was about to discuss it in a separate thread. Also, in the remove function
we have devm_free_irq. I am unsure it too. Because normally remove functions
do not use devm counterparts.

> -- Sebastian



-- 
Vaishali
