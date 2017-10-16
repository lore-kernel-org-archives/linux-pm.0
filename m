From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v2 3/8] cpuidle: add a new predict interface
Date: Mon, 16 Oct 2017 17:52:24 +0800
Message-ID: <b17aa4ae-cd72-fa95-48a6-b7f43aaa338f@linux.intel.com>
References: <1506756034-6340-1-git-send-email-aubrey.li@intel.com>
 <1506756034-6340-4-git-send-email-aubrey.li@intel.com>
 <3044561.Ej2KzLJlAU@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:11011 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750914AbdJPJw0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Oct 2017 05:52:26 -0400
In-Reply-To: <3044561.Ej2KzLJlAU@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aubrey Li <aubrey.li@intel.com>
Cc: tglx@linutronix.de, peterz@infradead.org, len.brown@intel.com, ak@linux.intel.com, tim.c.chen@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 2017/10/14 9:27, Rafael J. Wysocki wrote:
>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
>> index 0951dac..8704f3c 100644
>> --- a/kernel/sched/idle.c
>> +++ b/kernel/sched/idle.c
>> @@ -225,6 +225,7 @@ static void do_idle(void)
>>  	 */
>>  	__current_set_polling();
>>  	quiet_vmstat();
>> +	cpuidle_predict();
> 
> One more question here.
> 
> This changes the cpuidle code ordering such that if the ->predict callback
> is present, the governor prediction will run before tick_nohz_idle_enter(),
> whereas without that callback it runs in cpuidle_idle_call().
> 
> Is that actually going to work correctly for the menu governor, in particular?
>

This depends on how prediction works, patch 1/8 has the details.

The first factor we get is the next clock event from tick device, this is not
related to cpuidle call.

The other two factors are derived from idle interval history, the data is already
maintained in menu_device data structure.

I'm not sure if this can address your concern, or anything else I can provide to
help this.

Thanks,
-Aubrey
