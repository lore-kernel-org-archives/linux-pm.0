From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: mvebu: Fix the CPU PM notifier usage
Date: Fri, 27 Feb 2015 17:50:23 +0100
Message-ID: <54F0A04F.20706@linaro.org>
References: <1424971248-29076-1-git-send-email-gregory.clement@free-electrons.com> <4892716.Bf612zPN6E@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:46366 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbbB0Qu2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Feb 2015 11:50:28 -0500
Received: by wggy19 with SMTP id y19so21490496wgg.13
        for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2015 08:50:27 -0800 (PST)
In-Reply-To: <4892716.Bf612zPN6E@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

On 02/26/2015 10:55 PM, Rafael J. Wysocki wrote:
> On Thursday, February 26, 2015 06:20:48 PM Gregory CLEMENT wrote:
>> As stated in kernel/cpu_pm.c, "Platform is responsible for ensuring
>> that cpu_pm_enter is not called twice on the same CPU before
>> cpu_pm_exit is called.". In the current code in case of failure when
>> calling mvebu_v7_cpu_suspend, the function cpu_pm_exit() is never
>> called whereas cpu_pm_enter() was called just before.
>>
>> This patch moves the cpu_pm_exit() in order to balance the
>> cpu_pm_enter() calls.
>>
>> Reported-by: Fulvio Benini <fbf@libero.it>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>
> Should that go to "stable" too?  Which "stable" series it should go t=
o if so?

Hi Rafael,

do you mind if I take this fix in my tree ? There is the same issue for=
=20
cpuidle-arm64.c I fixed.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

