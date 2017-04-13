From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [patch 09/13] cpufreq/ia64: Replace racy task affinity logic
Date: Thu, 13 Apr 2017 08:12:49 +0530
Message-ID: <20170413024249.GI5910@vireshk-i7>
References: <20170412200726.941336635@linutronix.de>
 <20170412201042.865458445@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33486 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbdDMCmx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Apr 2017 22:42:53 -0400
Received: by mail-pg0-f41.google.com with SMTP id x125so23544528pgb.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Apr 2017 19:42:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170412201042.865458445@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Lai Jiangshan <jiangshanlai@gmail.com>, Len Brown <lenb@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tejun Heo <tj@kernel.org>, Tony Luck <tony.luck@intel.com>, linux-pm@vger.kernel.org

On 12-04-17, 22:07, Thomas Gleixner wrote:
> The get() and target() callbacks must run on the affected cpu. This is
> achieved by temporarily setting the affinity of the calling thread to the
> requested CPU and reset it to the original affinity afterwards.
> 
> That's racy vs. concurrent affinity settings for that thread resulting in
> code executing on the wrong CPU and overwriting the new affinity setting.
> 
> Replace it by work_on_cpu(). All call pathes which invoke the callbacks are
> already protected against CPU hotplug.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/cpufreq/ia64-acpi-cpufreq.c |   91 +++++++++++++++---------------------
>  1 file changed, 38 insertions(+), 53 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
