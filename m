From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency selection
Date: Tue, 1 Mar 2016 20:44:59 +0100
Message-ID: <CAJZ5v0ioxysoFjVxdPKZ7OYW0Xoz3kiqCYM3ywfWSqiMGCLscw@mail.gmail.com>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
	<1792311.cuUNhUde5n@vostro.rjw.lan>
	<20160226091843.GX6356@twins.programming.kicks-ass.net>
	<1743951.Hhdov0yvNG@vostro.rjw.lan>
	<20160301125727.GT6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34431 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbcCATpB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 14:45:01 -0500
In-Reply-To: <20160301125727.GT6357@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>

On Tue, Mar 1, 2016 at 1:57 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Sat, Feb 27, 2016 at 01:08:02AM +0100, Rafael J. Wysocki wrote:
>> @@ -95,18 +98,20 @@ EXPORT_SYMBOL_GPL(cpufreq_set_update_uti
>>   *
>>   * This function is called by the scheduler on every invocation of
>>   * update_load_avg() on the CPU whose utilization is being updated.
>> + *
>> + * It can only be called from RCU-sched read-side critical sections.
>>   */
>>  void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
>>  {
>>       struct update_util_data *data;
>>
>> -     rcu_read_lock();
>> -
>
> Maybe, just because I'm paranoid, add something like:
>
> #ifdef CONFIG_LOCKDEP
>         WARN_ON(debug_locks && !rcu_read_lock_sched_held());
> #endif

OK
