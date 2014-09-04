From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: ppc-corenet: remove per-cpu variable 'cpu_mask'
Date: Thu, 4 Sep 2014 10:07:23 +0530
Message-ID: <CAKohpok5fBvi3UFEszL8in=-TWJ8CG6p9gcUXeEG0322afS-QA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:41619 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755587AbaIDEhY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 00:37:24 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo20so6937792obc.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2014 21:37:24 -0700 (PDT)
In-Reply-To: <2248223d9db143108dc32ad5f43a145e@BY2PR03MB570.namprd03.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yuantian Tang <Yuantian.Tang@freescale.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "LeoLi@freescale.com" <LeoLi@freescale.com>, Hongtao Jia <hongtao.jia@freescale.com>

On 4 September 2014 10:03, Yuantian Tang <Yuantian.Tang@freescale.com> wrote:
> What about the other arch? Can they deal with this situation?

Yes for most of them (speacially ARM), because they fulfill the
requirement of CPUFreq
core. i.e. set policy->cpus to all online+offline CPUs.
