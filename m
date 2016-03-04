From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v2 6/10] cpufreq: Support for fast frequency switching
Date: Fri, 4 Mar 2016 15:59:14 -0800
Message-ID: <56DA2152.2080207@linaro.org>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <2409306.qzzMXcm4dm@vostro.rjw.lan> <15684081.T4iOMUSHCY@vostro.rjw.lan>
 <56DA09B1.4010005@linaro.org>
 <CAJZ5v0jENyu8j0fq1-BhU64QwRHAjvcjQktYc2sa9QmhktoEnQ@mail.gmail.com>
 <CAJZ5v0hnnANO6-CCgaika+FZtoXGf5V1Z8Wmmv+niZx=h7obWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33246 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760455AbcCDX7j (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2016 18:59:39 -0500
Received: by mail-qg0-f41.google.com with SMTP id t4so56686113qge.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Mar 2016 15:59:38 -0800 (PST)
In-Reply-To: <CAJZ5v0hnnANO6-CCgaika+FZtoXGf5V1Z8Wmmv+niZx=h7obWQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On 03/04/2016 02:58 PM, Rafael J. Wysocki wrote:
>>> How about modifying cpufreq_register_notifier to return an error if the
>>> >> driver has a fast_switch callback installed and an attempt to register a
>>> >> transition notifier is made?
>> >
>> > That sounds like a good idea.
>
> Transition notifiers may be registered before the driver is
> registered, so that won't help in all cases.

Could that hole be closed by a similar check in
cpufreq_register_driver()? I.e. if the transition_notifier list is not
empty, fail to register the driver (if the driver has a fast_switch
routine)?

Or alternatively, the fast_switch routine is not installed.

thanks,
Steve
