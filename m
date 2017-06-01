From: Jongman Heo <jongman.heo@samsung.com>
Subject: RE: Re: FW: [4.12 regression]
 "cpufreq: intel_pstate: Active mode P-state limits rework"
Date: Thu, 01 Jun 2017 01:08:16 +0000
Message-ID: <20170601010816epcms1p16cded9ef0657a694c5a7a73ab723ecd7@epcms1p1>
References: <3772609.tskOqDLWI3@aspire.rjw.lan>
        <20170516042511epcms1p33c79e84f62d4b1d37cf227d2379bbecf@epcms1p3>
        <20170529021852epcms1p66b2e89d2aec7988e00fb64c41a48a839@epcms1p6>
        <CGME20170516042313epcms1p5523f4e3e1ae608eaf0327be0242ee46e@epcms1p1>
Reply-To: jongman.heo@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:62234 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdFABIT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2017 21:08:19 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20170601010817epoutp048c588e46285d348500ccc6008edbc037~D2hfora711301513015epoutp044
        for <linux-pm@vger.kernel.org>; Thu,  1 Jun 2017 01:08:17 +0000 (GMT)
In-Reply-To: <3772609.tskOqDLWI3@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> 
>--------- Original Message ---------
>Sender : Rafael J. Wysocki <rjw@rjwysocki.net>
>Date   : 2017-06-01 08:58 (GMT+9)
>Title  : Re: FW: [4.12 regression] "cpufreq: intel_pstate: Active mode P-state limits rework"
> 
>On Monday, May 29, 2017 02:18:52 AM Jongman Heo wrote:
>> 
>> Hi,
>> 
>> FYI, 4.12-rc3 still has this issue.
>> 
>>  
>> --------- Original Message ---------
>> Sender : 허종만 <jongman.heo@samsung.com>

>> Date   : 2017-05-16 13:25 (GMT+9)

>> Title  : [4.12 regression] "cpufreq: intel_pstate: Active mode P-state limits rework"

>>  

>>  

>> Hi,

>>  

>> With 4.12-rc1 (Linus git), booting fails due to kernel panic, at intel_pstate_register_driver+0x56/0x110.

>> I can't copy the whole trace from the graphic console, it looks like below.

>>  

>> Call Trace:

>>   intel_pstate_init

>>   intel_pstate_setup

>>   do_one_initcall

>>   set_debug_rodata

>>   kernel_init_freeable

>>   rest_init

>>   kernel_init

>>   ret_from_fork

>>     Code: ...

>>   RIP: intel_pstate_register_driver+0x56/0x110 RSP: ffffa3a98000bd80

>>   ...

> 

>I guess this is a division by 0 due to the unmet assumption that the denominator

>in min_perf_pct_min() will always be nonzero.

> 

>If this guess is correct, the patch below should help, so can you please test it?

> 

>Thanks,

>Rafael

> 

> 

>---

> drivers/cpufreq/intel_pstate.c |    5 +++--

> 1 file changed, 3 insertions(+), 2 deletions(-)

> 

>Index: linux-pm/drivers/cpufreq/intel_pstate.c

>===================================================================

>--- linux-pm.orig/drivers/cpufreq/intel_pstate.c

>+++ linux-pm/drivers/cpufreq/intel_pstate.c

>@@ -571,9 +571,10 @@ static inline void update_turbo_state(vo

> static int min_perf_pct_min(void)

> {

>         struct cpudata *cpu = all_cpu_data[0];

>+        int turbo_pstate = cpu->pstate.turbo_pstate;

> 

>-        return DIV_ROUND_UP(cpu->pstate.min_pstate * 100,

>-                            cpu->pstate.turbo_pstate);

>+        return turbo_pstate ?

>+                DIV_ROUND_UP(cpu->pstate.min_pstate * 100, turbo_pstate) : 0;

> }

> 

> static s16 intel_pstate_get_epb(struct cpudata *cpu_data)

> 

> 

> 



Hi,



Your patch fixes the issue.

Thanks~.



Jongman.
