From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [BUG] oops in cpufreq driver with AMD Kaveri CPU
Date: Wed, 13 Aug 2014 10:06:02 +0530
Message-ID: <CAKohpokHAsyy+ZAZf0Ne4Eat6fkHb3vXpS8LATVS1B6STRY6oQ@mail.gmail.com>
References: <4708675.eITUXPv8Ih@spock>
	<1449757.YVvGmvgCpE@spock>
	<3606476.mQLS7miLfb@spock>
	<2067094.cJOA1APdny@spock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:38526 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbaHMEgD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Aug 2014 00:36:03 -0400
Received: by mail-oa0-f49.google.com with SMTP id eb12so7995593oac.22
        for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2014 21:36:02 -0700 (PDT)
In-Reply-To: <2067094.cJOA1APdny@spock>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On 13 August 2014 00:24, Oleksandr Natalenko <oleksandr@natalenko.name> wrote:
> Updated logs.
>
> Registered notifiers:
>
> ===
> pf@defiant:~$ cat /var/log/kern.log | grep "Registered transition notifier"
> Aug 12 21:50:13 defiant kernel: [    3.081759] cpufreq: Registered transition
> notifier: ffffffff81590378, (ffffffff81cb0ba0)
> ===
>
> Triggered notifiers:
>
> ===
> pf@defiant:~$ dmesg | grep CPUFREQ_NOTIFIER | awk '{ s = ""; for (i = 3; i <=
> NF; i++) s = s $i " "; print s }' | sort -u
> CPUFREQ_NOTIFIER: acpi_processor_ppc_notifier
> CPUFREQ_NOTIFIER: acpi_thermal_cpufreq_notifier
> CPUFREQ_NOTIFIER: cpufreq_stat_notifier_trans

I don't know why there are three lines here. The first two are registered
for policy-notifiers and not transition ones.

So, I think its just about cpufreq-stat's notifier.
