From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/3 v5] cpufreq: governor: Replace timers with utilization
 update callbacks
Date: Tue, 9 Feb 2016 19:49:33 +0100
Message-ID: <CAJZ5v0hSeqkTv-FN5yeuA+D=0QM3W17LULMwVF+=rHwAopEoaQ@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
	<1486401.1RcnnVKZNP@vostro.rjw.lan>
	<2848076.UWJmIl2O1K@vostro.rjw.lan>
	<2448026.UXsVxjJmrX@vostro.rjw.lan>
	<20160209100103.GB5726@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:34986 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbcBIStf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 13:49:35 -0500
In-Reply-To: <20160209100103.GB5726@in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ego@linux.vnet.ibm.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Feb 9, 2016 at 11:01 AM, Gautham R Shenoy
<ego@linux.vnet.ibm.com> wrote:
> Hello Rafael,
>
> On Sun, Feb 07, 2016 at 03:50:31PM +0100, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Instead of using a per-CPU deferrable timer for queuing up governor
>> work items, register a utilization update callback that will be
>> invoked from the scheduler on utilization changes.
>>
>> The sampling rate is still the same as what was used for the
>> deferrable timers and the added irq_work overhead should be offset by
>> the eliminated timers overhead, so in theory the functional impact of
>> this patch should not be significant.
>
> I tested this patch series (including v5 of PATCH 3) on POWER with
> Viresh's CPUFreq test suite. I didn't see any issues with the
> patchset except for a lockdep splat involving "s_active" and
> "od_dbs_cdata.mutex", which was also observed on 4.5-rc3 and which
> was fixed by Viresh's recent patches.
>
> With a kernbench run, there were no regression when compared to 4.5-rc3.
>
> FWIW, Tested-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Thank you!
