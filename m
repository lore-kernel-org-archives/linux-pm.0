From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Update][PATCH v7 6/7] cpufreq: Support for fast frequency switching
Date: Wed, 30 Mar 2016 13:28:58 +0200
Message-ID: <CAJZ5v0ghnm3JcsJf4TmV12sTHtGcrxgAG8SuWTyx8-hcZe6WEw@mail.gmail.com>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
	<25154681.B5BGJ94JlQ@vostro.rjw.lan>
	<16969991.55r1UouI6A@vostro.rjw.lan>
	<20160330050732.GE8773@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34885 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbcC3L3A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 07:29:00 -0400
In-Reply-To: <20160330050732.GE8773@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Wed, Mar 30, 2016 at 7:07 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 30-03-16, 03:47, Rafael J. Wysocki wrote:
>> Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
>> @@ -843,6 +883,7 @@ static int acpi_cpufreq_cpu_exit(struct
>>       pr_debug("acpi_cpufreq_cpu_exit\n");
>>
>>       if (data) {
>> +             policy->fast_switch_possible = false;
>
> Is this done just for keeping code symmetric or is there a logical advantage
> of this? Just for my understanding, not saying that it is wrong.

It is not necessary for correctness today, as schedutil will be the
only governor using fast switch, but generally that prevents leaking
configuration information from one governor to another.

Thanks,
Rafael
