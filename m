From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 01/47] kernel: Add support for poweroff handler call
 chain
Date: Tue, 21 Oct 2014 06:32:25 -0700
Message-ID: <54466069.5070702@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net> <1413864783-3271-2-git-send-email-linux@roeck-us.net> <20141021093405.GA2113@localhost> <20141021103007.GI26842@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37519 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbaJUSS0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Oct 2014 14:18:26 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Xge0o-0030bk-65
	for linux-pm@vger.kernel.org; Tue, 21 Oct 2014 18:18:26 +0000
In-Reply-To: <20141021103007.GI26842@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Johan Hovold <johan@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Alexander Graf <agraf@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Stuebner <heiko@sntech.de>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, =?UTF-8?B?UGhpbGlwcGUgUsOpdG9ybmF6?= <philippe.retornaz@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Romain Perier <romain.perier@gmail.com>

On 10/21/2014 03:30 AM, Lee Jones wrote:
> On Tue, 21 Oct 2014, Johan Hovold wrote:
>
>> On Mon, Oct 20, 2014 at 09:12:17PM -0700, Guenter Roeck wrote:
>>
>>> v2:
>>> - poweroff -> power_off
>>
>> Do you want to stick to power[-_ ]off consistently throughout?
>
> I guess you'll want to fix all of these before I review the MFD
> patches?
>
>>> - Add defines for default priorities
>>> - Use raw notifiers protected by spinlocks instead of atomic notifiers
>>> - Add register_poweroff_handler_simple
>>> - Add devm_register_power_off_handler
>>>
>>>   include/linux/pm.h              |  22 ++++
>>>   kernel/power/Makefile           |   1 +
>>>   kernel/power/poweroff_handler.c | 252 ++++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 275 insertions(+)
>>>   create mode 100644 kernel/power/poweroff_handler.c
>>>
>>> diff --git a/include/linux/pm.h b/include/linux/pm.h
>>> index 383fd68..7e0cb36 100644
>>> --- a/include/linux/pm.h
>>> +++ b/include/linux/pm.h
>>> @@ -34,7 +34,29 @@
>>>   extern void (*pm_power_off)(void);
>>>   extern void (*pm_power_off_prepare)(void);
>>>
>>> +/*
>>> + * Callbacks to manage poweroff handlers
>>
>> power-off
>
> power_off, no?
>
That is describing text, so hopefully I can use real words here and
don't have to use a term derived from variable and function names.

Sure, I can change poweroff in all describing text to power-off
if that is preferred, no big deal.

Thanks,
Guenter

