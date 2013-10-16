From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RESEND] cpuidle for ARM pull request
Date: Wed, 16 Oct 2013 18:35:24 +0200
Message-ID: <525EC04C.8020507@linaro.org>
References: <51E536C5.1020609@linaro.org> <1598661.FpX5cmjM1U@vostro.rjw.lan> <51F3650B.8080708@linaro.org> <2224191.VjCA0rsPcU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:39383 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760719Ab3JPQf1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2013 12:35:27 -0400
Received: by mail-we0-f173.google.com with SMTP id u57so1001303wes.32
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2013 09:35:26 -0700 (PDT)
In-Reply-To: <2224191.VjCA0rsPcU@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, keun-o.park@windriver.com, "nsekhar@ti.com >> Sekhar Nori" <nsekhar@ti.com>

On 07/27/2013 02:37 PM, Rafael J. Wysocki wrote:
> On Saturday, July 27, 2013 08:13:31 AM Daniel Lezcano wrote:
>> On 07/26/2013 02:07 AM, Rafael J. Wysocki wrote:
>>> On Friday, July 26, 2013 12:41:09 AM Rafael J. Wysocki wrote:
>>>> On Friday, July 26, 2013 12:29:08 AM Rafael J. Wysocki wrote:
>>>>> On Friday, July 26, 2013 12:07:03 AM Daniel Lezcano wrote:
>>>>>> On 07/16/2013 02:04 PM, Daniel Lezcano wrote:
>>>>>>>

[ ... ]

> Next time, can you please add a general description of what the patch=
es do and
> why they do that to the pull request?
>
>> I thought it would have been easier for us if I could based my PRs o=
n
>> top of your linux-next branch, so acting as a proxy for ARM patches.=
 I
>> am maintaining the clocksource drivers and I am basing my tree on to=
p of
>> tip/core.
>>
>> I guess you are rebasing your tree often and this is an issue for yo=
u,
>> right ?
>
> Yes, my linux-next branch may contain commits that will be modified l=
ater
> (e.g. ACKs added, fixes folded in etc.).
>
> Anyway, as I said, as long as the material you have for me doesn't de=
pend on
> anything new in my tree, it's better to base it on top of an -rc kern=
el.
>
> In case it does depend on that, I've put the entire outstanding cpuid=
le
> material into my pm-cpuidle branch (including your ARM commits just p=
ulled).

Hi Rafael,

is it possible to update the pm-cpuidle branch ? so I can base my pull=20
request on it. There will be a (trivial) conflict in the Makefile and=20
Kconfig.arm if I base my PR on v3.12-rc5.

Thanks
   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

