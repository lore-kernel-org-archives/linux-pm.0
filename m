From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 5/8] sched/cpufreq: pass sched class into
 cpufreq_update_util
Date: Tue, 15 Mar 2016 20:55:35 -0700
Message-ID: <56E8D937.3020903@linaro.org>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-6-git-send-email-mturquette+renesas@baylibre.com>
 <20160315212520.GF6344@twins.programming.kicks-ass.net>
 <20160315220609.30639.67271@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35532 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbcCPDzi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 23:55:38 -0400
Received: by mail-pf0-f173.google.com with SMTP id n5so56821919pfn.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Mar 2016 20:55:38 -0700 (PDT)
In-Reply-To: <20160315220609.30639.67271@quark.deferred.io>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

Hi Mike,

On 03/15/2016 03:06 PM, Michael Turquette wrote:
>>> > >  void cpufreq_set_freq_update_hook(int cpu, struct freq_update_hook *hook,
>>> > > +                     void (*func)(struct freq_update_hook *hook,
>>> > > +                                  enum sched_class_util sched_class,
>>> > > +                                  u64 time, unsigned long util,
>>> > > +                                  unsigned long max));
>> > 
>> > Have you looked at the asm that generated? At some point you'll start
>> > spilling on the stack and it'll be a god awful mess.
>> > 
> Is your complaint about the enum that I added to the existing function
> signature, or do you not like the original function signature[0] from
> Rafael's patch, sans enum?

The ARM procedure call standard has the first four arguments in
registers so the addition of the enum above will start using the stack.
