From: Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH V2 12/12] MIPS: Loongson: Make CPUFreq usable for Loongson-3
Date: Tue, 11 Nov 2014 19:25:59 +0800
Message-ID: <CAAhV-H6T71WzgAcDPYePO2onT9h1PBDjyX8BuCwZGi9V+wLh6g@mail.gmail.com>
References: <1415081928-25899-1-git-send-email-chenhc@lemote.com>
	<20141111105748.GK27259@linux-mips.org>
	<CAAhV-H7H+7TYyvbecaS6C1NEq7DEnjez2Z_eHnpix0+m_5FDoA@mail.gmail.com>
	<20141111110702.GA28822@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:56095 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbaKKL0A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Nov 2014 06:26:00 -0500
Received: by mail-ie0-f176.google.com with SMTP id rd18so11308421iec.35
        for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2014 03:25:59 -0800 (PST)
In-Reply-To: <20141111110702.GA28822@linux-mips.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <john@phrozen.org>, "Steven J. Hill" <Steven.Hill@imgtec.com>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-pm@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>, Zhangjin Wu <wuzhangjin@gmail.com>, Hongliang Tao <taohl@lemote.com>

Hi, Ralf,

I hope I didn't misunderstand your meaning...
If all cores share the same clockrate (like Loongson-3A), then CPUFreq
driver should update all core's udelay_val (include the offline core's
udelay_val) at frequency changing. If each core has its own clockrate
(like Loongson-3B), the new online core can use its old udelay_val
when online. In any case, we don't use loops_per_jiffy for CPU
hotplug. Maybe you need to see set_shared_udelay_val() in my patch.

Huacai

On Tue, Nov 11, 2014 at 7:07 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Nov 11, 2014 at 07:02:48PM +0800, Huacai Chen wrote:
>
>> Loops_per_jiffy is set on startup and doesn't change later. It reflect
>> the maximum value frequency, but for CPU hotplug, a new online CPU may
>> not run at the maximum frequency (remain the old value before it is
>> offline).
>
> As suspected.  But what if a CPU is hotunplugged, then the clockrate
> for all the CPUs changes and then the gets re-hotplugged into the system.
> Wouldn't in that case the udelay_val be used?
>
>   Ralf
>
