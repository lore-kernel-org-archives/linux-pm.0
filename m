From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] x86/centaur: Mark TSC invariant
Date: Thu, 28 Dec 2017 12:12:12 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1712281206140.1688@nanos>
References: <1511765383-2755-1-git-send-email-timguo_via@aliyun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:60850 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753274AbdL1LMV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Dec 2017 06:12:21 -0500
In-Reply-To: <1511765383-2755-1-git-send-email-timguo_via@aliyun.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: TimGuo <timguo_via@aliyun.com>
Cc: mingo@redhat.com, hpa@zytor.com, mingo@kernel.org, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brucechang@via-alliance.com, benjaminpan@viatech.com, cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com

On Mon, 27 Nov 2017, TimGuo wrote:

> During the FIO benchmark for block device, we found there are lots of clocksource
> access. TSC access latency is much lower than HPET. Use TSC as clocksource can improve 
> the FIO benchmark result.
>  
> 
> changes from v1 to v2:
> ---------------------
> Adjust the subject and description of this patch according to tglx's suggestion.

Well, the subject makes sense. The changelog not so much.

It's completely irrelevant whether you run a FIO benchmark or something
different.

What's relevant is that the CPU has a constant frequency TSC and that TSC
does not stop in C-States. But because the flags are not set for that CPU
the TSC is treated as non constant frequency and assumed to stop in
C-States, which makes it an unreliable and unusable clock source.

Setting those flags tells the kernel that the TSC is usable, so it will
select it over HPET. The effect of this is that reading time stamps (from
kernel or user space) will be faster and more efficient.

Thanks,

	tglx
