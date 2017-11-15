From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86 / CPU: Always show current CPU frequency in
 /proc/cpuinfo
Date: Wed, 15 Nov 2017 09:47:57 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1711150947170.1805@nanos>
References: <20171109103814.70688-1-chao.wang@ucloud.cn> <2067351.8xeh6jAbVr@aspire.rjw.lan> <CA+55aFxYQKzGbZ3GUWcuta5kz=2jp52xbEhV96R5RfCaMbLaNg@mail.gmail.com> <50366815.86mgx8Isne@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:40614 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754203AbdKOIs0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 03:48:26 -0500
In-Reply-To: <50366815.86mgx8Isne@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, WANG Chao <chao.wang@ucloud.cn>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Mathias Krause <minipli@googlemail.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Wed, 15 Nov 2017, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit 890da9cf0983 (Revert "x86: do not use cpufreq_quick_get()
> for /proc/cpuinfo "cpu MHz"") the "cpu MHz" number in /proc/cpuinfo
> on x86 can be either the nominal CPU frequency (which is constant)
> or the frequency most recently requested by a scaling governor in
> cpufreq, depending on the cpufreq configuration.  That is somewhat
> inconsistent and is different from what it was before 4.13, so in
> order to restore the previous behavior, make it report the current
> CPU frequency like the scaling_cur_freq sysfs file in cpufreq.
> 
> To that end, modify the /proc/cpuinfo implementation on x86 to use
> aperfmperf_snapshot_khz() to snapshot the APERF and MPERF feedback
> registers, if available, and use their values to compute the CPU
> frequency to be reported as "cpu MHz".
> 
> However, do that carefully enough to avoid accumulating delays that
> lead to unacceptable access times for /proc/cpuinfo on systems with
> many CPUs.  Run aperfmperf_snapshot_khz() once on all CPUs
> asynchronously at the /proc/cpuinfo open time, add a single delay
> upfront (if necessary) at that point and simply compute the current
> frequency while running show_cpuinfo() for each individual CPU.
> 
> Also, to avoid slowing down /proc/cpuinfo accesses too much, reduce
> the default delay between consecutive APERF and MPERF reads to 10 ms,
> which should be sufficient to get large enough numbers for the
> frequency computation in all cases.
> 
> Fixes: 890da9cf0983 (Revert "x86: do not use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz"")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Thomas Gleixner <tglx@linutronix.de>
