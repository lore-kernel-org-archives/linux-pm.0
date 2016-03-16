From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 4/8] cpufreq/schedutil: sysfs capacity margin tunable
Date: Wed, 16 Mar 2016 13:45:12 +0100
Message-ID: <CAJZ5v0hNuP5aRyrmOTKdNRNzYxKAm7kXcU-mQc3D82UemnJRUQ@mail.gmail.com>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
	<1457932932-28444-5-git-send-email-mturquette+renesas@baylibre.com>
	<20160315212047.GE6344@twins.programming.kicks-ass.net>
	<20160315214043.30639.75507@quark.deferred.io>
	<20160315214821.GM6344@twins.programming.kicks-ass.net>
	<20160315223701.30639.43127@quark.deferred.io>
	<56E8D4D9.1060202@linaro.org>
	<20160316080503.GS6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:36160 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755109AbcCPMpP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 08:45:15 -0400
In-Reply-To: <20160316080503.GS6344@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Michael Turquette <mturquette@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Juri Lelli <Juri.Lelli@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette+renesas@baylibre.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On Wed, Mar 16, 2016 at 9:05 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Mar 15, 2016 at 08:36:57PM -0700, Steve Muckle wrote:
>> > Then again, maybe this knob will be part of the mythical
>> > power-vs-performance slider?
>>
>> Patrick Bellasi's schedtune series [0] (which I think is the referenced
>> mythical slider) aims to provide a more sophisticated interface for
>> tuning scheduler-driven frequency selection. In addition to a global
>> boost value it includes a cgroup controller as well for per-task tuning.
>>
>> I would definitely expect the margin/boost value to be modified at
>> runtime, for example if the battery is running low, or the user wants
>> 100% performance for a while, or the userspace framework wants to
>> temporarily tailor the performance level for a particular set of tasks, etc.
>
> OK, so how about we start with it as a debug knob, and once we have
> experience and feel like it is indeed a useful runtime knob, we upgrade
> it to ABI.
>
> The problem with starting out as ABI is that its hard to take away
> again.

Agreed, plus it is quite hard to get ABI right from the outset.  Even
if we decide on a sysfs knob, it still is unclear what exactly should
be represented by it in what units etc.
