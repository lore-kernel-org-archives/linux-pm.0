From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 01/47] kernel: Add support for poweroff handler call
 chain
Date: Tue, 21 Oct 2014 06:17:09 -0700
Message-ID: <54465CD5.5070002@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net> <1413864783-3271-2-git-send-email-linux@roeck-us.net> <41603148.RJg26vx0Wv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59287 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932510AbaJUNne (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Oct 2014 09:43:34 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XgZin-001Hvh-1w
	for linux-pm@vger.kernel.org; Tue, 21 Oct 2014 13:43:33 +0000
In-Reply-To: <41603148.RJg26vx0Wv@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Alexander Graf <agraf@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee.jones@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, =?UTF-8?B?UGhpbGlwcGUgUsOpdG9ybmF6?= <philippe.retornaz@gmail.com>, Romain Perier <romain.perier@gmail.com>

On 10/21/2014 05:26 AM, Rafael J. Wysocki wrote:
> On Monday, October 20, 2014 09:12:17 PM Guenter Roeck wrote:
>> Various drivers implement architecture and/or device specific means to
>> remove power from the system.  For the most part, those drivers set the
>> global variable pm_power_off to point to a function within the driver.
>>
>> This mechanism has a number of drawbacks.  Typically only one scheme
>> to remove power is supported (at least if pm_power_off is used).
>> At least in theory there can be multiple means remove power, some of
>> which may be less desirable. For example, some mechanisms may only
>> power off the CPU or the CPU card, while another may power off the
>> entire system.  Others may really just execute a restart sequence
>> or drop into the ROM monitor. Using pm_power_off can also be racy
>> if the function pointer is set from a driver built as module, as the
>> driver may be in the process of being unloaded when pm_power_off is
>> called. If there are multiple poweroff handlers in the system, removing
>> a module with such a handler may inadvertently reset the pointer to
>> pm_power_off to NULL, leaving the system with no means to remove power.
>>
>> Introduce a system poweroff handler call chain to solve the described
>> problems.  This call chain is expected to be executed from the
>> architecture specific machine_power_off() function.  Drivers providing
>> system poweroff functionality are expected to register with this call chain.
>> By using the priority field in the notifier block, callers can control
>> poweroff handler execution sequence and thus ensure that the poweroff
>> handler with the optimal capabilities to remove power for a given system
>> is called first.
>
> Well, I must admit to having second thoughts regarding this particular
> mechanism.  Namely, notifiers don't seem to be the best way of expressing
> what's needed from the design standpoint.
>
> It looks like we need a list of power off methods and a way to select one
> of them, so it seems that using a plist would be a natural choice here?
>
Isn't a notifier call chain nothing but a list of methods, with its priority
the means to select which one to use (first) ?

The only difference I can see is that you would only select one of them,
meaning the one with the highest priority, and not try the others.
Am I missing something ?

Thanks,
Guenter

