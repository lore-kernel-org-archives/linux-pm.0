From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] x86: use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz" again
Date: Sat, 11 Nov 2017 00:09:18 +0100
Message-ID: <CAJZ5v0iPt8VKoM8BuRA7O+U+fk7dg37sqVJ0pi2=S8muqfznPQ@mail.gmail.com>
References: <20171109103814.70688-1-chao.wang@ucloud.cn> <6583ed1f-3ea3-c7fd-7e69-1430c8387e54@intel.com>
 <CAJZ5v0hdJhuoX2j=X4C5Rq+GT9_qKtMwgc-P6OJMfQ_36uLaKg@mail.gmail.com> <CA+55aFycTaZjKg1SGujkMrOX5WmUyWHvy2ujzaV8jefOfDPy_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:51248 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdKJXJT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Nov 2017 18:09:19 -0500
In-Reply-To: <CA+55aFycTaZjKg1SGujkMrOX5WmUyWHvy2ujzaV8jefOfDPy_Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, WANG Chao <chao.wang@ucloud.cn>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Mathias Krause <minipli@googlemail.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Fri, Nov 10, 2017 at 8:11 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Nov 9, 2017 at 2:30 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> c_start() can run aperfmperf_snapshot_khz() on all CPUs upfront (say
>> in parallel), then wait for a while (say 5 ms; the current 20 ms wait
>> is overkill) and then aperfmperf_snapshot_khz() can be run once on
>> each CPU in show_cpuinfo() without taking the "stale cache" threshold
>> into account.
>
> Yeah, that won't work.

Indeed.

> What could work is to do that "smp_call_function_many()" at open time,
> and *not* set the "wait" flag, but do it entirely asynchronously.

Right.

> But I don't think that's an option for 4.14 ;(

Agreed.

> So I guess I'll have to revert.

Sure thing (and I see that you've reverted it already).

The reason why I wanted to fix this up before the final 4.14 is that
the "cpu MHz" behavior is kind of inconsistent now (generally, it is
either constant or the last requested frequency depending on the
cpufreq configuration), but that's not a blocker by any measure IMO.

Anyway, I'll try to come up with something better next week.

Thanks,
Rafael
