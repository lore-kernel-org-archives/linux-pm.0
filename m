From: David Miller <davem@davemloft.net>
Subject: Re: [patch V2 12/13] cpufreq/sparc-us2e: Replace racy task
 affinity logic
Date: Thu, 13 Apr 2017 10:50:54 -0400 (EDT)
Message-ID: <20170413.105054.2051423251306433003.davem@davemloft.net>
References: <20170412200726.941336635@linutronix.de>
        <20170412201043.129216383@linutronix.de>
        <alpine.DEB.2.20.1704131017590.2408@nanos>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:59998 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754486AbdDMOu5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2017 10:50:57 -0400
In-Reply-To: <alpine.DEB.2.20.1704131017590.2408@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org, bigeasy@linutronix.de, benh@kernel.crashing.org, fenghua.yu@intel.com, herbert@gondor.apana.org.au, jiangshanlai@gmail.com, lenb@kernel.org, mpe@ellerman.id.au, rjw@rjwysocki.net, tj@kernel.org, tony.luck@intel.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 13 Apr 2017 10:19:07 +0200 (CEST)

> spu_queue_register() needs to invoke setup functions on a particular
> CPU. This is achieved by temporarily setting the affinity of the
> calling user space thread to the requested CPU and reset it to the original
> affinity afterwards.
> 
> That's racy vs. CPU hotplug and concurrent affinity settings for that
> thread resulting in code executing on the wrong CPU and overwriting the
> new affinity setting.
> 
> Replace it by using work_on_cpu_safe() which guarantees to run the code on
> the requested CPU or to fail in case the CPU is offline.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Acked-by: David S. Miller <davem@davemloft.net>
