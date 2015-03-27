From: Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH V8 8/8] MIPS: Loongson: Make CPUFreq usable for Loongson-3
Date: Fri, 27 Mar 2015 11:45:29 +0800
Message-ID: <CAAhV-H6GsdmiC=bGXdYmMP4EAtDNcf_GC8i19U8=hJGZf8BW-g@mail.gmail.com>
References: <1426213836-28600-1-git-send-email-chenhc@lemote.com>
	<20150326130517.GD9705@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:33184 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbbC0Dpa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2015 23:45:30 -0400
Received: by wgel2 with SMTP id l2so1515273wge.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2015 20:45:29 -0700 (PDT)
In-Reply-To: <20150326130517.GD9705@linux-mips.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Steven J. Hill" <Steven.Hill@imgtec.com>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>, Zhangjin Wu <wuzhangjin@gmail.com>, linux-pm@vger.kernel.org, Hongliang Tao <taohl@lemote.com>

Hi, Ralf,

This is a problem, but it seems not a very big problem. Because X86
also use percpu's loops_per_jiffy to implement udelay(), and percpu's
loops_per_jiffy also adjusted after cpufreq transition.

Please look at arch/x86/lib/delay.c, arch/x86/kernel/tsc.c.

Huacai

On Thu, Mar 26, 2015 at 9:05 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Mar 13, 2015 at 10:30:36AM +0800, Huacai Chen wrote:
>
>> Loongson-3A/3B support frequency scaling. But due to hardware
>> limitation, Loongson-3A's frequency scaling is not independent for
>> each core, we suggest enable Loongson-3A's CPUFreq only when there is
>> one core online. Loongson-3B can adjust frequency independently for
>> each core, so it can be always enabled.
>>
>> Each package has only one register (ChipConfig or FreqCtrl) to control
>> frequency, so we need spinlocks to protect register access for multi-
>> cores. However, we cannot use spinlock when a core becomes into "wait"
>> status (frequency = 0), so we only enable "wait" when there is one core
>> in a package online.
>>
>> arch/mips/kernel/smp.c is modified to guarantee udelay_val has the
>> correct value while both CPU hotplug and CPUFreq are enabled.
>
> With clockscaling you have a fundamental problem with udelay.  If the clock
> is increased for a CPU that already has computed the number of iterations
> of the delay loop for the old, lower clock rate, it is possible that
> udelay won't wait for long enough.
>
> The opposite case would result in waiting too long but that's not a big
> problem as udelay only guarantees a minimum waiting time.
>
> So you probably need a different delay mechanism than the classic delay
> loop on SMP with clockscaling.
>
>   Ralf
>
