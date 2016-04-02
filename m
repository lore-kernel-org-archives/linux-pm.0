From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] x86: Calculate MHz using APERF/MPERF for cpuinfo and scaling_cur_freq
Date: Sat, 2 Apr 2016 01:22:56 -0400
Message-ID: <CAJvTdKnONi=Mkv8ReQbKifmeL09ddbhbK4Cn8qFCS2h1Aaqdog@mail.gmail.com>
References: <6e0c25e64e0fb65a42dfc63ad5f660302e07cd87.1459485198.git.len.brown@intel.com>
	<52f711be59539723358bea1aa3c368910a68b46d.1459485198.git.len.brown@intel.com>
	<20160401080328.GC3448@twins.programming.kicks-ass.net>
	<9222CD56-C603-449C-A049-E518DAFA6883@linux.intel.com>
	<20160401082323.GE3448@twins.programming.kicks-ass.net>
	<20160401082923.GH11035@twins.programming.kicks-ass.net>
	<7239BF36-2C27-4325-A5B8-01BC4CA58B4C@linux.intel.com>
	<20160401095005.GA25313@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:33926 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbcDBFW6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 2 Apr 2016 01:22:58 -0400
In-Reply-To: <20160401095005.GA25313@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Stephane Gasparini <stephane.gasparini@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

Thanks for the comments.

Re: is this a useful semantic?

Yes, average MHz over an interval is significantly more useful than
a snapshot of the recent instantaneous frequency.
It is possible to convert the former into the later,
but it is not possible to reliably and efficiently convert the later
into the former.

Indeed, we stopped using MSR_PERF_STATUS for this very reason --
a snapshot of instantaneous frequency can be very misleading.

Further, the mechanism in this patch will still work even when Linux
has no concept of frequency control,
including firmware control and CONFIG_CPU_FREQ=n

Of course, when there is 1 reader, this mechanism works the best --
as they get to select whatever interval they like.
For multi-user, the interval would shorten -- possibly
degrading to the 100ms limit set here.  My reasoning on the
100ms limit is that anything more frequent is abuse,
and the users should be using user-space tools like turbostat in that case.

Re: 64-bit math.

Stephane is correct, APERF and  MPERF will not overflow in the uptime
of the machine.
They are both 64-bit registers, and they tick at TSC rate or slower.
(Indeed, they tick at 0 when idle)

Boris is right, this works as long as somebody doesn't scribble on these MSRs.
Linux used to do that in 2.6.23, but we learned our lesson and we leave them
free running since then.  I'm not going to worry about a yahoo
scribbling on MSRs
behind the kernel's back.  More than this will break if that happens.

Peter is right, in the expression "numerator = cpu_khz * aperf_delta",
the capacity of the 64-bit numerator is reduced as cpu_khz
and aperf_delta grow.

For example, if this patch runs on a busy system having a 4GHz CPU,
then APERF ticks at 2^32 Hz.
cpu_khz = 2^22
so max aperf_delta without overflow is 2^64/2^22 = 2^42 cycles

2^42 cycles / 2^32 cycles/sec = 2^10 sec = 1024 seconds = 17 minutes.

Though we could improve this range by 1024x by simply operating on
cpu_mhz instead of cpu_khz, yielding 12 days.

Or we could simply detect potential overflow:

2^64 < cpu_khz * delta_aperf
so
if (2^64/cpu_khz < delta_aperf) then overflow

and since delta_aperf and delta_mperf are much larger than cpu_khz
in this case, we can calculate this way:

khz = cpu_khz (delta_aperf)/(delta_mperf)
khz = cpu_khz (delta_aperf/cpu_khz)/(delta_mperf/cpu_khz)
khz = delta_aperf / (delta_mperf/cpu_khz)

no calculation here can overflow 64-bits in the uptime of the machine.

I'll send an updated patch.

thanks,
-Len
