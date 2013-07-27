From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RESEND] cpuidle for ARM pull request
Date: Sat, 27 Jul 2013 08:13:31 +0200
Message-ID: <51F3650B.8080708@linaro.org>
References: <51E536C5.1020609@linaro.org> <1766778.ZYeDKBOsjV@vostro.rjw.lan> <2075555.RCmWLFAfjq@vostro.rjw.lan> <1598661.FpX5cmjM1U@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:38535 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832Ab3G0GNd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Jul 2013 02:13:33 -0400
Received: by mail-we0-f181.google.com with SMTP id p58so2484077wes.40
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2013 23:13:32 -0700 (PDT)
In-Reply-To: <1598661.FpX5cmjM1U@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, keun-o.park@windriver.com, "nsekhar@ti.com >> Sekhar Nori" <nsekhar@ti.com>

On 07/26/2013 02:07 AM, Rafael J. Wysocki wrote:
> On Friday, July 26, 2013 12:41:09 AM Rafael J. Wysocki wrote:
>> On Friday, July 26, 2013 12:29:08 AM Rafael J. Wysocki wrote:
>>> On Friday, July 26, 2013 12:07:03 AM Daniel Lezcano wrote:
>>>> On 07/16/2013 02:04 PM, Daniel Lezcano wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> The first PR was against the linux-pm-next tree including the pat=
ch:
>>>>>
>>>>> "cpuidle: Add Kconfig.arm and move calxeda, kirkwood and zynq"
>>>>>
>>>>> This patch has been dropped in the meantime.
>>>>>
>>>>> Here is a new PR where my tree has been rebased against linux-pm-=
next
>>>>> and adding the patch mentioned above.
>>>>>
>>>>> As stated by Rafael, I will handle the ARM specific patches from =
now.
>>>>>
>>>>> The following changes since commit 48f99d5a97d32d70c0738d6e314d9f=
4dbefd89bf:
>>>>>
>>>>>   Merge branch 'pm-cpuidle-next' into linux-next (2013-07-16 02:4=
1:06 +0200)
>>>>>
>>>>> are available in the git repository at:
>>>>>
>>>>>
>>>>>   git://git.linaro.org/people/dlezcano/linux.git cpuidle/arm-next
>>>>>
>>>>> for you to fetch changes up to 2b7e79f4a75e803184f483985a25cc751a=
990f06:
>>>>>
>>>>>   ARM: ux500: cpuidle: Move ux500 cpuidle driver to drivers/cpuid=
le
>>>>> (2013-07-16 13:57:24 +0200)
>>>>
>>>> ping ?
>>>
>>> Sorry, something distracted me.  I'll pull it later today unless th=
ere are any
>>> problems (in which case I'll let you know).
>>
>> Well, there are some.
>>
>> It is based on my linux-next branch, but please rebase it on top of =
3.11-rc2.
>>
>> Generally, please send me pull requests based on -rc kernels only (o=
r major
>> releases).
>=20
> Unless your material depends on new things in my linux-next branch, i=
n which
> case please let me know and I'll set up a stable branch for you to ba=
se things
> on.

Hi Rafael,

I rebased my branch on top of 3.11-rc2, you can try to pull it again.

I thought it would have been easier for us if I could based my PRs on
top of your linux-next branch, so acting as a proxy for ARM patches. I
am maintaining the clocksource drivers and I am basing my tree on top o=
f
tip/core.

I guess you are rebasing your tree often and this is an issue for you,
right ?

Thanks
  -- Daniel


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

