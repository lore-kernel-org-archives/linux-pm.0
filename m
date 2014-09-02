From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: ppc-corenet: remove per-cpu variable 'cpu_mask'
Date: Tue, 2 Sep 2014 12:39:43 +0530
Message-ID: <CAKohpo=skCssnm0AZi2rMDUTKg0Xo0p9Sz0KwO1iuapLks=nyg@mail.gmail.com>
References: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
	<3d467a39ab1b96dc24ed8a71139d5e030239477f.1409629117.git.viresh.kumar@linaro.org>
	<6a145a322bd64e14a2d94e8c40151bbe@BY2PR03MB570.namprd03.prod.outlook.com>
	<CAKohpokQo=Jqgj2CzTH41WbD6F1GpdhksWdg0dm8WLN_CT5KkA@mail.gmail.com>
	<9fde1bf81522480484897416019b0ee9@BY2PR03MB570.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:42905 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbaIBHJn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Sep 2014 03:09:43 -0400
Received: by mail-oi0-f46.google.com with SMTP id h136so4121208oig.5
        for <linux-pm@vger.kernel.org>; Tue, 02 Sep 2014 00:09:43 -0700 (PDT)
In-Reply-To: <9fde1bf81522480484897416019b0ee9@BY2PR03MB570.namprd03.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yuantian Tang <Yuantian.Tang@freescale.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Hongbo Zhang <hongbo.zhang@freescale.com>, "LeoLi@freescale.com" <LeoLi@freescale.com>

On 2 September 2014 12:32, Yuantian Tang <Yuantian.Tang@freescale.com> wrote:
> I am saying your patch 2 probably is wrong, not patch 1.

Okay, it looked initially that both are screwed up :)

> Consider following case:
> On T4240 platform, we have 3 cluster with 8 cpu in each cluster.
> We offline 4 5 6 7 cpu and then online them back.

i.e. last four CPUs of first cluster..

> Cpu 4's policy->cpus is 0, 1, 2, 3, 4
> Cpu 5's policy->cpus is 0, 1, 2, 3, 4, 5.

How? And how is this patch going to touch policy->cpus?
CPU 0-7 should be sharing a single 'struct cpufreq_policy'
and so policy->cpus should be same for all..
