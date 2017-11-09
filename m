From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] x86: use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz" again
Date: Thu, 9 Nov 2017 23:30:54 +0100
Message-ID: <CAJZ5v0hdJhuoX2j=X4C5Rq+GT9_qKtMwgc-P6OJMfQ_36uLaKg@mail.gmail.com>
References: <20171109103814.70688-1-chao.wang@ucloud.cn> <6583ed1f-3ea3-c7fd-7e69-1430c8387e54@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45633 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbdKIWaz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Nov 2017 17:30:55 -0500
In-Reply-To: <6583ed1f-3ea3-c7fd-7e69-1430c8387e54@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: WANG Chao <chao.wang@ucloud.cn>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Mathias Krause <minipli@googlemail.com>, the arch/x86 maintainers <x86@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Thu, Nov 9, 2017 at 5:06 PM, Rafael J. Wysocki
<rafael.j.wysocki@intel.com> wrote:
> Hi Linus,
>
> On 11/9/2017 11:38 AM, WANG Chao wrote:
>>
>> Commit 941f5f0f6ef5 (x86: CPU: Fix up "cpu MHz" in /proc/cpuinfo) caused
>> a serious performance issue when reading from /proc/cpuinfo on system
>> with aperfmperf.
>>
>> For each cpu, arch_freq_get_on_cpu() sleeps 20ms to get its frequency.
>> On a system with 64 cpus, it takes 1.5s to finish running `cat
>> /proc/cpuinfo`, while it previously was done in 15ms.
>
> Honestly, I'm not sure what to do to address this ATM.
>
> The last requested frequency is only available in the non-HWP case, so it
> cannot be used universally.

OK, here's an idea.

c_start() can run aperfmperf_snapshot_khz() on all CPUs upfront (say
in parallel), then wait for a while (say 5 ms; the current 20 ms wait
is overkill) and then aperfmperf_snapshot_khz() can be run once on
each CPU in show_cpuinfo() without taking the "stale cache" threshold
into account.

I'm going to try that and see how far I can get with it.

Thanks,
Rafael
