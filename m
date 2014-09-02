From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: ppc-corenet: remove per-cpu variable 'cpu_mask'
Date: Tue, 2 Sep 2014 12:19:26 +0530
Message-ID: <CAKohpokQo=Jqgj2CzTH41WbD6F1GpdhksWdg0dm8WLN_CT5KkA@mail.gmail.com>
References: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
	<3d467a39ab1b96dc24ed8a71139d5e030239477f.1409629117.git.viresh.kumar@linaro.org>
	<6a145a322bd64e14a2d94e8c40151bbe@BY2PR03MB570.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:46919 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbaIBGt1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Sep 2014 02:49:27 -0400
Received: by mail-oi0-f51.google.com with SMTP id v63so4134334oia.38
        for <linux-pm@vger.kernel.org>; Mon, 01 Sep 2014 23:49:26 -0700 (PDT)
In-Reply-To: <6a145a322bd64e14a2d94e8c40151bbe@BY2PR03MB570.namprd03.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yuantian Tang <Yuantian.Tang@freescale.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Hongbo Zhang <hongbo.zhang@freescale.com>, "LeoLi@freescale.com" <LeoLi@freescale.com>

On 2 September 2014 12:16, Yuantian Tang <Yuantian.Tang@freescale.com> wrote:
> Hello Viresh:
>
> Probably it is not right considering the CPU cluster and CPU hotplug case.

So in case of hotplug the worst that can happen is policy->cpu gets updated.
But because we are all concerned about cpu_data here, which is stored in
per-cpu variables and is updated for all online CPUs, it should work.

I would like to see how that fails :)
