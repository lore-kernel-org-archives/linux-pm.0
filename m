From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq
 constantly keeps frequency at maximum on 4.5-rc4)
Date: Thu, 10 Mar 2016 00:18:21 +0100
Message-ID: <CAJZ5v0i0cx_xYUwFWDX5nE+rNgbX4TY0ATYuD3rEi86Ky5cA5A@mail.gmail.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<87si087tsr.fsf@iki.fi>
	<CAJvTdKmg=H2hqFd+fwu0t8Rx4PV8E3vNGc-j8zzVKLFX4nprYg@mail.gmail.com>
	<87a8m74mcc.fsf@iki.fi>
	<002d01d17a57$ec417030$c4c45090$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33357 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964957AbcCIXSY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 18:18:24 -0500
Received: by mail-lb0-f181.google.com with SMTP id k15so89025220lbg.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Mar 2016 15:18:23 -0800 (PST)
In-Reply-To: <002d01d17a57$ec417030$c4c45090$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: Rik van Riel <riel@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>

On Thu, Mar 10, 2016 at 12:03 AM, Doug Smythies <dsmythies@telus.net> wrote:
> Does the direction that this thread has taken mean that those two
> commits that Arto identified might now not be reverted?

Yes.

> Commits:
> 9c4b2867ed7c8c8784dd417ffd16e705e81eb145
> a9ceb78bc75ca47972096372ff3d48648b16317a
>
> Recall that increased energy consumption was also isolated to those
> two commits for some types of workflow. The suggestion is that the
> commits should be reverted anyhow.
>
> What seems to be happening is that CPUs are deciding to stay in idle
> state 0 a lot more, when they actually could / should be in a deeper
> idle state.
>
> Test time is always: 33 minutes and 20 seconds test (8 CPUs), and there
> is never any noticeable difference in execution times for the work:
>
> Example 1: kernel 4.5-rc5 with the rjw 3 patch set version 10
> "Replace timers with utilization update callbacks":
> Aggregate times in each idle state:

You need to say what workload that is too.

> rjwv10 (minutes)        reverted (minutes)      Idle State
> 27.0654211              2.617325533                     0
> 12.92451315             24.53266672                     1
> 3.668558467             3.780482633                     2
> 1.2727832               1.61352195                      3
> 130.8342596             141.2234947                     4
>
> 175.7655355             173.7674915                     total
>
> Example 2: kernel 4.5-rc7 stock:
> Aggregate times in each idle state:
>
> k45rc7 (minutes)        reverted (minutes)      Idle State
> 20.1771917              2.638311483                     0
> 13.02770225             21.81474838                     1
> 3.428136783             3.951405                        2
> 1.4540243               1.552488167                     3
> 134.9057413             143.5533                        4
>
> 172.9927963             173.5102531                     total
>
> Energy (restated from a previous e-mail):
>
> Test 7: reverted: Package Joules: 47830
> Test 8: rjwv10: Package Joules: 54419 (revert saves 12.1% energy)
>
> Test 9: reverted: Package Joules: 49326
> Test 10: rjwv10: Package Joules: 55442 (revert saves 11% energy)
>
> Test 11: reverted: acpi-cpufreq ondemand: Package Joules: 49146
> Test 12: rjwv10: acpi-cpufreq ondemand: Package Joules: 56302 (revert saves 12.7% energy)
>
> Energy (not in any previous e-mail):
>
> Reverted: 56178 Joules
> Kernel 4.5-rc7: 63269 Joules (revert saves 12.6% energy)

So the claim in commit a9ceb78bc75ca47972096372ff3d48648b16317a is
that the change should not really affect systems with low C1
latencies.

I wonder what's the C1 latency on your test system?

Thanks,
Rafael
