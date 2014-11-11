From: Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH V2 12/12] MIPS: Loongson: Make CPUFreq usable for Loongson-3
Date: Tue, 11 Nov 2014 19:02:48 +0800
Message-ID: <CAAhV-H7H+7TYyvbecaS6C1NEq7DEnjez2Z_eHnpix0+m_5FDoA@mail.gmail.com>
References: <1415081928-25899-1-git-send-email-chenhc@lemote.com>
	<20141111105748.GK27259@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:48423 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbaKKLCs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Nov 2014 06:02:48 -0500
Received: by mail-ie0-f173.google.com with SMTP id tr6so11070247ieb.4
        for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2014 03:02:48 -0800 (PST)
In-Reply-To: <20141111105748.GK27259@linux-mips.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <john@phrozen.org>, "Steven J. Hill" <Steven.Hill@imgtec.com>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-pm@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>, Zhangjin Wu <wuzhangjin@gmail.com>, Hongliang Tao <taohl@lemote.com>

Hi, Ralf,

Loops_per_jiffy is set on startup and doesn't change later. It reflect
the maximum value frequency, but for CPU hotplug, a new online CPU may
not run at the maximum frequency (remain the old value before it is
offline).

Huacai

On Tue, Nov 11, 2014 at 6:57 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Nov 04, 2014 at 02:18:48PM +0800, Huacai Chen wrote:
>
>> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
>> index c94c4e9..01d676a 100644
>> --- a/arch/mips/kernel/smp.c
>> +++ b/arch/mips/kernel/smp.c
>> @@ -136,7 +136,8 @@ asmlinkage void start_secondary(void)
>>       calibrate_delay();
>>       preempt_disable();
>>       cpu = smp_processor_id();
>> -     cpu_data[cpu].udelay_val = loops_per_jiffy;
>> +     if (!cpu_data[cpu].udelay_val)
>> +             cpu_data[cpu].udelay_val = loops_per_jiffy;
>
> Why this?  Is the idea that the value of loops_per_jiffy which was set
> on bootup may no longer match the actual clock frequency?
>
>   Ralf
>
