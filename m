From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v2 4/8] tick/nohz: keep tick on for a fast idle
Date: Mon, 16 Oct 2017 13:34:57 +0800
Message-ID: <c64ed43d-8afe-7317-e31f-a7a5eef914d1@linux.intel.com>
References: <1506756034-6340-1-git-send-email-aubrey.li@intel.com>
 <1506756034-6340-5-git-send-email-aubrey.li@intel.com>
 <4523111.uMcC96MW3N@aspire.rjw.lan>
 <5beefd1a-2792-c371-3bb8-8ee2a6574020@linux.intel.com>
 <1508129104.8087.2.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1508129104.8087.2.camel@gmx.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Galbraith <efault@gmx.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aubrey Li <aubrey.li@intel.com>
Cc: tglx@linutronix.de, peterz@infradead.org, len.brown@intel.com, ak@linux.intel.com, tim.c.chen@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2017/10/16 12:45, Mike Galbraith wrote:
> On Mon, 2017-10-16 at 11:26 +0800, Li, Aubrey wrote:
>>
>> I'll try to move quiet_vmstat() into the normal idle branch if this patch series
>> are reasonable. Is fast_idle a good indication for it?
> 
> see x86_tip 62cb1188ed86 sched/idle: Move quiet_vmstate() into the NOHZ code

It looks like this commit makes tick stop critical as it can be invoked in interrupt
exit path?

->smp_apic_timer_interrupt
-->irq_exit
--->tick_nohz_irq_exit
---->__tick_nohz_idle_enter
----->tick_nohz_stop_sched_tick
------>quiet_vmstat

Thanks,
-Aubrey
