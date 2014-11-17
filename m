From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Possible bug: Duplicate OPPs warning after reloading cpufreq-dt
Date: Mon, 17 Nov 2014 13:41:27 +0530
Message-ID: <CAKohpo=LFXQc0=5JcWt+37WMoPwWUekkaX8gSzhtmF4zLpFRcA@mail.gmail.com>
References: <1973548224.143005.1416052490232.JavaMail.open-xchange@oxbaltgw05.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:56687 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbaKQIL2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Nov 2014 03:11:28 -0500
Received: by mail-ob0-f169.google.com with SMTP id vb8so1085393obc.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2014 00:11:27 -0800 (PST)
In-Reply-To: <1973548224.143005.1416052490232.JavaMail.open-xchange@oxbaltgw05.schlund.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 15 November 2014 17:24, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Hi,
>
> in the case cpufreq-dt is compiled as module, reloading cpufreq-dt gives a poor
> warning about duplicate OPPs:
>
> root@duckbill:~# modprobe cpufreq-dt
> root@duckbill:~# modprobe -r cpufreq-dt
> root@duckbill:~# modprobe cpufreq-dt
> [   53.824262] cpu cpu0: dev_pm_opp_add: duplicate OPPs detected. Existing:
> freq: 261819000, volt: 1350000, enabled: 1. New: freq: 261819000, volt: 1350000,
> enabled: 1
> [   53.881680] cpu cpu0: dev_pm_opp_add: duplicate OPPs detected. Existing:
> freq: 360000000, volt: 1350000, enabled: 1. New: freq: 360000000, volt: 1350000,
> enabled: 1
> [   53.921576] cpu cpu0: dev_pm_opp_add: duplicate OPPs detected. Existing:
> freq: 392728000, volt: 1450000, enabled: 1. New: freq: 392728000, volt: 1450000,
> enabled: 1
> [   53.964054] cpu cpu0: dev_pm_opp_add: duplicate OPPs detected. Existing:
> freq: 454737000, volt: 1550000, enabled: 1. New: freq: 454737000, volt: 1550000,
> enabled: 1
>
> I think these warnings are misleading and should be avoided. Unfortunately i
> don't have a idea to fix it the right way.
>
> Test platform: Freescale i.MX28 (ARM9)
> Kernel: 3.18.0-rc3

I have replied with a patch, that should fix it. Or just hide it :)
