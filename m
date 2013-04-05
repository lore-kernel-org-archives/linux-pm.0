From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Raname index as data in cpufreq_frequency_table
Date: Fri, 5 Apr 2013 16:00:04 +0530
Message-ID: <CAKohpo=jUOciKCAWWJ_bC-uSKzdk4a49r39gaOsuroVbqSRyFg@mail.gmail.com>
References: <03ca6f17860d290cfc67e51969062612f0ab26ab.1364643234.git.viresh.kumar@linaro.org>
	<2835305.o7Hvg1cesG@vostro.rjw.lan>
	<CAKohpo=vorTDONBR2czcZpP64sCfv1Qa-u8zGkHys9miwQrURw@mail.gmail.com>
	<6766028.RBJyPM3lJj@vostro.rjw.lan>
	<CAKohpo=wNHsV0vFhcTWg0g7=Wtbdx=g2wqpNPfidQfGhhK9Cig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:44041 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932572Ab3DEKaF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Apr 2013 06:30:05 -0400
Received: by mail-oa0-f41.google.com with SMTP id f4so3814769oah.28
        for <linux-pm@vger.kernel.org>; Fri, 05 Apr 2013 03:30:04 -0700 (PDT)
In-Reply-To: <CAKohpo=wNHsV0vFhcTWg0g7=Wtbdx=g2wqpNPfidQfGhhK9Cig@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, Sekhar Nori <nsekhar@ti.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, Stephen Warren <swarren@wwwdotorg.org>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

On 31 March 2013 09:16, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 31 March 2013 07:16, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> On Sunday, March 31, 2013 07:03:04 AM Viresh Kumar wrote:
>>> On 31 March 2013 03:31, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>> > Sorry, I won't apply this.  It changes too much stuff at a time and I'm not
>>> > really sure if the change being made is necessary.
>>>
>>> Hmm.. I thought it is important  as it puts the real meaning of "index" in the
>>> code.
>>
>> And what does that change, really?  What about documenting the meaning of
>> "index" instead?
>
> Probably not the logic but perception. People don't necessarily go through
> Documentation but code for writing new stuff. And so code should reflect the
> real meaning.
>
> In case we write something like following in documentation:
> "Index: This is driver specific data for each frequency. Core doesn't use it."
>
> Then "Index" looks even more wrong. Its not the right name for any such
> variable. And so it should be fixed.

Forgot reply to all earlier :(

You have any more comments on this patch? I really thought this change
would be good. I agree it touches lot of stuff but for clean/clear code.

--
viresh
