From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 1/6] cpufreq: suspend governors on system suspend/hibernate
Date: Wed, 27 Nov 2013 08:43:10 +0530
Message-ID: <CAKohpomm_2iWVOt8MyWFr6=zrEfuBo1z-fPvkaFk-H873-74cw@mail.gmail.com>
References: <cover.1385374819.git.viresh.kumar@linaro.org>
	<40779593.MBXsTetiKz@vostro.rjw.lan>
	<CAKohpok0E=m=63KXM22usiW7Rsu59cD7Q=+k3tRcW=8269tZnQ@mail.gmail.com>
	<4253729.doK7ubnxKx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:59384 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235Ab3K0DNL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2013 22:13:11 -0500
Received: by mail-oa0-f48.google.com with SMTP id l6so6968438oag.21
        for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2013 19:13:10 -0800 (PST)
In-Reply-To: <4253729.doK7ubnxKx@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Kgene Kim <kgene.kim@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-tegra@vger.kernel.org, jinchoi@broadcom.com, Lan Tianyu <tianyu.lan@intel.com>, Sebastian Capella <sebastian.capella@linaro.org>, Jonghwan Choi <jhbird.choi@samsung.com>

On 27 November 2013 01:53, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, November 26, 2013 07:56:19 AM Viresh Kumar wrote:
>> On 26 November 2013 04:59, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

>> > This appears to be racy.  Is it really racy, or just seemingly?
>>
>> Why does it look racy to you? Userspace should be frozen by now,
>> policy_list should be stable as well as nobody would touch it.
>
> You're stopping governors while they may be in use in principle.  Do we have
> suitable synchronization in place for that?

At what point exactly in suspend cycle do we suspend timers and workqueues.
I thought userspace would be frozen by now and so would be the governors..
