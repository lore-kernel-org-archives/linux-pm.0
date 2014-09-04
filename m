From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: ppc-corenet: remove per-cpu variable 'cpu_mask'
Date: Thu, 4 Sep 2014 09:08:18 +0530
Message-ID: <CAKohpokZ9vGJzD0G8n=rg8qQJEuZZpuz=X7XNn_UarKbyOmQxw@mail.gmail.com>
References: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
	<3d467a39ab1b96dc24ed8a71139d5e030239477f.1409629117.git.viresh.kumar@linaro.org>
	<6a145a322bd64e14a2d94e8c40151bbe@BY2PR03MB570.namprd03.prod.outlook.com>
	<CAKohpokQo=Jqgj2CzTH41WbD6F1GpdhksWdg0dm8WLN_CT5KkA@mail.gmail.com>
	<9fde1bf81522480484897416019b0ee9@BY2PR03MB570.namprd03.prod.outlook.com>
	<CAKohpo=skCssnm0AZi2rMDUTKg0Xo0p9Sz0KwO1iuapLks=nyg@mail.gmail.com>
	<d9f1dbc51c9d408ea593d11a95a36ee4@BY2PR03MB570.namprd03.prod.outlook.com>
	<CAKohpo=Pb88SBg0HwrAtzfRkG5Z9HgsapSmA1PbmqqvP-wQ1qw@mail.gmail.com>
	<21e79b8a95ca443a9844fc2b79ec5379@BY2PR03MB570.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:53068 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163AbaIDDiT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Sep 2014 23:38:19 -0400
Received: by mail-oi0-f49.google.com with SMTP id g201so6243016oib.22
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2014 20:38:19 -0700 (PDT)
In-Reply-To: <21e79b8a95ca443a9844fc2b79ec5379@BY2PR03MB570.namprd03.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yuantian Tang <Yuantian.Tang@freescale.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "LeoLi@freescale.com" <LeoLi@freescale.com>, Hongtao Jia <hongtao.jia@freescale.com>

On 4 September 2014 08:21, Yuantian Tang <Yuantian.Tang@freescale.com> wrote:
> Can't agree you more.

Its not about upstreaming my patch but doing the right thing.

> As I know, there is no such function to get mask of online and offline cpus in a cluster.

This is a primary requirement of cpufreq-subsystem. The ->init()
callback must initialize
policy->cpus to the mask of all online+offline CPUs that are sharing clock.

Okay, then what I can say is your driver is already broken (without my
patch) when we
use it as a module.

>> - build driver as module and don't load it by default
>> - boot your system
>> - offline CPUs 8 to 15 as you did above.
>> - insert module
>> - try to online cores as you did above.

Above sequence of events would reproduce similar crash for you. So, either
fix this problem or mark your module as 'bool' instead of 'tristate' so that it
can't be compiled as module anymore.

--
viresh
