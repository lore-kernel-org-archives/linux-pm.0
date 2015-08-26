From: Abylay Ospan <aospan@netup.ru>
Subject: Re: [PATCH v2] x86 kernel crash fix when thermal interrupt called
Date: Wed, 26 Aug 2015 18:18:02 +0300
Message-ID: <CAK3bHNWvyPBgi=_dNuejdTx6Z2njXSbuq36T62gU6dWhVFpp_A@mail.gmail.com>
References: <1440491511-2751-1-git-send-email-aospan@netup.ru>
	<36DF59CE26D8EE47B0655C516E9CE6401CB01F7B@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.netup.ru ([77.72.80.15]:49905 "EHLO imap.netup.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752336AbbHZPSG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 26 Aug 2015 11:18:06 -0400
Received: from mail-la0-f45.google.com (mail-la0-f45.google.com [209.85.215.45])
	by imap.netup.ru (Postfix) with ESMTPA id 9125C71948B
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2015 18:18:03 +0300 (MSK)
Received: by labgv11 with SMTP id gv11so53927238lab.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2015 08:18:03 -0700 (PDT)
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6401CB01F7B@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Yu,

Thanks for review. comments below inline.

>>       if (platform_thermal_package_rate_control &&
>>               platform_thermal_package_rate_control()) {
>>               /* Rate control is implemented in callback */
>>               platform_thermal_package_notify(msr_val);
> Hum, I have one question, is there a risk here ?

yes, this is main 'goal' of this patch. We need to protect
'platform_thermal_package_notify' because it can be NULL when
'x86_pkg_temp_thermal' module unloading. To achieve this protection
'platform_thermal_lock' introduced.


> After graping platform_thermal_lock, we try to get another lock of
> worker_pool->lock by :
> pkg_temp_thermal_platform_thermal_notify->
> schedule_delayed_work_on(cpu,
>                                 &per_cpu(pkg_temp_thermal_threshold_work, cpu),
>                                 msecs_to_jiffies(notify_delay_ms));
> since schedule_work can be called in many context, and it only use a
> spinlock rather than spinlock_irq,  a AB-BA deadlock may happen.

Do you mean spin_lock's in __queue_work ( schedule_delayed_work_on
finally calling this) ?
For my understanding: we should try to re-acquire
platform_thermal_lock to get ABBA deadlock. But according to code we
do not try to do this. Is this correct ?

> I think CONFIG_LOCK_DEP might help.

I have built kernel with CONFIG_LOCKDEP enabled. Will stress-test on
my system. FYI, here is grep for platform_thermal_lock:

# egrep platform_thermal_lock /proc/lock_stat
        &(&platform_thermal_lock)->rlock:          9285           9287
          0.16         470.44       35221.94           3.79
21956          23026           0.11         426.52       35563.35
     1.54
        &(&platform_thermal_lock)->rlock           9287
[<ffffffff810439c8>] intel_thermal_interrupt+0xb8/0x230
        &(&platform_thermal_lock)->rlock           9285
[<ffffffff810439c8>] intel_thermal_interrupt+0xb8/0x230
        &(&platform_thermal_lock)->rlock              1
[<ffffffffa0308c77>] enable_thermal_callback+0x19/0x5e
[x86_pkg_temp_thermal]
        &(&platform_thermal_lock)->rlock              1
[<ffffffffa026bc77>] 0xffffffffa026bc77

-- 
Abylay Ospan,
NetUP Inc.
http://www.netup.tv
