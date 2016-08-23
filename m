From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [RFC][PATCH 7/7] cpufreq: intel_pstate: Change P-state selection
 algorithm for Core
Date: Tue, 23 Aug 2016 12:50:14 +0800
Message-ID: <CANRm+Cw1bVObw44akr0ofTyN=LDy-aoXYxNuSNmDQcg4byo3Ww@mail.gmail.com>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan> <1572483.RZjvRFdxPx@vostro.rjw.lan>
 <CANRm+Cxzm9xoLpddNdkXYahQMHUwsvkn4d-CObvApRhxU-GjWg@mail.gmail.com> <1471925285.5747.5.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33243 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753379AbcHWEui (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2016 00:50:38 -0400
In-Reply-To: <1471925285.5747.5.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

2016-08-23 12:08 GMT+08:00 Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com>:
> On Tue, 2016-08-23 at 11:48 +0800, Wanpeng Li wrote:
>> Hi Rafael,
>> 2016-08-01 7:38 GMT+08:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
>> >
>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > The PID-base P-state selection algorithm used by intel_pstate for
>> > Core processors is based on very weak foundations.  Namely, its
>> > decisions are mostly based on the values of the APERF and MPERF
>> > feedback registers and it only estimates the actual utilization to
>> > check if it is not extremely low (in order to avoid getting stuck
>> > in the highest P-state in that case).
>> >
>> > Since it generally causes the CPU P-state to ramp up quickly, it
>> > leads to satisfactory performance, but the metric used by it is
>> > only
>> > really valid when the CPU changes P-states by itself (ie. in the
>> > turbo
>> > range) and if the P-state value set by the driver is treated by the
>> > CPU as the upper limit on turbo P-states selected by it.
>>
>> Do you mean CPU will ignore the request value which is submitted by
>> intel_pstate driver in the turbo range, but respect the upper limit
>> on
>> the turbo P-states which is submitted by intel_pstate driver?
> Any request to request a P-state even upper limit can be totally
> ignored in turbo range.

How to understand Rafael's description "if the P-state value set by
the driver is treated by the CPU as the upper limit on the turbo
P-states selected by it"? The upper limit will be totally ignored in
turbo range.

Regards,
Wanpeng Li
