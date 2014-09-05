From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: ppc-corenet: remove per-cpu variable 'cpu_mask'
Date: Fri, 5 Sep 2014 15:10:09 +0530
Message-ID: <CAKohpombskHhows7skLYBPfBA0yHTAigmTHk9U4xMjvd8L7QLw@mail.gmail.com>
References: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
	<3d467a39ab1b96dc24ed8a71139d5e030239477f.1409629117.git.viresh.kumar@linaro.org>
	<6a145a322bd64e14a2d94e8c40151bbe@BY2PR03MB570.namprd03.prod.outlook.com>
	<CAKohpokQo=Jqgj2CzTH41WbD6F1GpdhksWdg0dm8WLN_CT5KkA@mail.gmail.com>
	<9fde1bf81522480484897416019b0ee9@BY2PR03MB570.namprd03.prod.outlook.com>
	<CAKohpo=skCssnm0AZi2rMDUTKg0Xo0p9Sz0KwO1iuapLks=nyg@mail.gmail.com>
	<d9f1dbc51c9d408ea593d11a95a36ee4@BY2PR03MB570.namprd03.prod.outlook.com>
	<CAKohpo=Pb88SBg0HwrAtzfRkG5Z9HgsapSmA1PbmqqvP-wQ1qw@mail.gmail.com>
	<21e79b8a95ca443a9844fc2b79ec5379@BY2PR03MB570.namprd03.prod.outlook.com>
	<CAKohpokZ9vGJzD0G8n=rg8qQJEuZZpuz=X7XNn_UarKbyOmQxw@mail.gmail.com>
	<2248223d9db143108dc32ad5f43a145e@BY2PR03MB570.namprd03.prod.outlook.com>
	<CAKohpok5fBvi3UFEszL8in=-TWJ8CG6p9gcUXeEG0322afS-QA@mail.gmail.com>
	<618265ad45564bd68100c4a72140f645@BY2PR03MB570.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:53069 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756485AbaIEJkK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Sep 2014 05:40:10 -0400
Received: by mail-oi0-f45.google.com with SMTP id a3so7614616oib.4
        for <linux-pm@vger.kernel.org>; Fri, 05 Sep 2014 02:40:09 -0700 (PDT)
In-Reply-To: <618265ad45564bd68100c4a72140f645@BY2PR03MB570.namprd03.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yuantian Tang <Yuantian.Tang@freescale.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "LeoLi@freescale.com" <LeoLi@freescale.com>, Hongtao Jia <hongtao.jia@freescale.com>

On 5 September 2014 15:05, Yuantian Tang <Yuantian.Tang@freescale.com> wrote:
> What's the name of function on ARM arch which get the mask of all online and offline cpus?

You can have a look at arm_big_little.c for this, its topology_core_cpumask().

Also, this might not work for everybody and so we are trying to get this
information from DT, but it is taking some time to get the bindings correctly.

> We want this driver to be used on ARM as well. So how to write the Kconfig,
> as you know we already have a CONFIG_* item in Kconfig.powerpc.

Just duplicate them.
