From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86: use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz" again
Date: Fri, 10 Nov 2017 11:11:16 -0800
Message-ID: <CA+55aFycTaZjKg1SGujkMrOX5WmUyWHvy2ujzaV8jefOfDPy_Q@mail.gmail.com>
References: <20171109103814.70688-1-chao.wang@ucloud.cn> <6583ed1f-3ea3-c7fd-7e69-1430c8387e54@intel.com>
 <CAJZ5v0hdJhuoX2j=X4C5Rq+GT9_qKtMwgc-P6OJMfQ_36uLaKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:51835 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753562AbdKJTLR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Nov 2017 14:11:17 -0500
In-Reply-To: <CAJZ5v0hdJhuoX2j=X4C5Rq+GT9_qKtMwgc-P6OJMfQ_36uLaKg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: WANG Chao <chao.wang@ucloud.cn>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Mathias Krause <minipli@googlemail.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Thu, Nov 9, 2017 at 2:30 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> c_start() can run aperfmperf_snapshot_khz() on all CPUs upfront (say
> in parallel), then wait for a while (say 5 ms; the current 20 ms wait
> is overkill) and then aperfmperf_snapshot_khz() can be run once on
> each CPU in show_cpuinfo() without taking the "stale cache" threshold
> into account.

Yeah, that won't work.

What could work is to do that "smp_call_function_many()" at open time,
and *not* set the "wait" flag, but do it entirely asynchronously.

But I don't think that's an option for 4.14 ;(

So I guess I'll have to revert.

            Linus
