From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] PM / sleep: add configurable delay for pm_test
Date: Sat, 21 Feb 2015 12:25:08 -0800
Message-ID: <CAGVrzcZgwQqfBkupWkChYg8NmpKsFzWNa0jB18wN6YUuOzgvsw@mail.gmail.com>
References: <1409788535-28264-1-git-send-email-computersforpeace@gmail.com>
 <20141213025530.GO21347@ld-irv-0074> <20141213083123.GA26129@amd>
 <20141216235813.GI9759@ld-irv-0074> <20141217080947.GB2027@amd>
 <20141217091057.GH7112@brian-ubuntu> <20141217092255.GA4588@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:44638 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbbBUUZt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 Feb 2015 15:25:49 -0500
In-Reply-To: <20141217092255.GA4588@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Brian Norris <computersforpeace@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Chirantan Ekbote <chirantan@chromium.org>

2014-12-17 1:22 GMT-08:00 Pavel Machek <pavel@ucw.cz>:
>
>> > Make it module parameter so that the patch is two lines of code. If
>> > that does not work for you, think of something that does.
>>
>> OK, so that's actually constructive. If lines of code is really the most
>> important factor here, then I suppose I can do that. I'd argue that a
>> module parameter is a much less sensible interface here, though, given
>> that it is coupled with the existing /sys/power/pm_test interface.
>
> If module parameter works for you, we have a winner, that should be
> two lines of code and two lines of documentation.

I do not think that a module parameter is good, some of the uses cases
I can think about (from real people using that facility) involve
setting up a Linux system in a lab with multiple measurement
equipments, having to reboot Linux to change this delay is going to be
a no-go for them because that will break the
uptime/endurance/stability/automated testing they might be doing.
Having them be able to change the PM delay at runtime is completely
satisfactory though.

Both module parameters and sysfs entries need to remain stable, and
potentially there forever, once introduced, yet the sysfs entries are
a lot more flexible.

Considering that Brian's change are enclosed within a CONFIG_PM_DEBUG
ifdef, can we really use the code bloat as a technical argument here?

Thanks!
-- 
Florian
