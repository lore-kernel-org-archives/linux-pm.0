From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH V8 8/8] MIPS: Loongson: Make CPUFreq usable for Loongson-3
Date: Thu, 26 Mar 2015 14:05:18 +0100
Message-ID: <20150326130517.GD9705@linux-mips.org>
References: <1426213836-28600-1-git-send-email-chenhc@lemote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:58338 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbbCZNFZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2015 09:05:25 -0400
Received: from localhost.localdomain ([127.0.0.1]:57481 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014639AbbCZNFXEQPcx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2015 14:05:23 +0100
Content-Disposition: inline
In-Reply-To: <1426213836-28600-1-git-send-email-chenhc@lemote.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Huacai Chen <chenhc@lemote.com>
Cc: "Steven J. Hill" <Steven.Hill@imgtec.com>, linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>, Zhangjin Wu <wuzhangjin@gmail.com>, linux-pm@vger.kernel.org, Hongliang Tao <taohl@lemote.com>

On Fri, Mar 13, 2015 at 10:30:36AM +0800, Huacai Chen wrote:

> Loongson-3A/3B support frequency scaling. But due to hardware
> limitation, Loongson-3A's frequency scaling is not independent for
> each core, we suggest enable Loongson-3A's CPUFreq only when there is
> one core online. Loongson-3B can adjust frequency independently for
> each core, so it can be always enabled.
> 
> Each package has only one register (ChipConfig or FreqCtrl) to control
> frequency, so we need spinlocks to protect register access for multi-
> cores. However, we cannot use spinlock when a core becomes into "wait"
> status (frequency = 0), so we only enable "wait" when there is one core
> in a package online.
> 
> arch/mips/kernel/smp.c is modified to guarantee udelay_val has the
> correct value while both CPU hotplug and CPUFreq are enabled.

With clockscaling you have a fundamental problem with udelay.  If the clock
is increased for a CPU that already has computed the number of iterations
of the delay loop for the old, lower clock rate, it is possible that
udelay won't wait for long enough.

The opposite case would result in waiting too long but that's not a big
problem as udelay only guarantees a minimum waiting time.

So you probably need a different delay mechanism than the classic delay
loop on SMP with clockscaling.

  Ralf
