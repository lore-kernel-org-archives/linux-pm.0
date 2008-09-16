From: Arun Bharadwaj <arun@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/1]: timers: Timer Migration
Date: Tue, 16 Sep 2008 22:17:30 +0530
Message-ID: <48CFE322.8050506__4538.70997666872$1221583914$gmane$org@linux.vnet.ibm.com>
References: <20080916091219.GA1068@linux.vnet.ibm.com>
	<1221566730.6943.16.camel@lappy.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1221566730.6943.16.camel@lappy.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, tglx@linutronix.de, linux-pm@lists.linux-foundation.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

Peter Zijlstra wrote:
> On Tue, 2008-09-16 at 14:42 +0530, Arun R Bharadwaj wrote:
>   
>> Hi,
>>     
>
> 80 char lines please.
>
>   
>> An idle cpu on which device drivers have initialized timers, has to be
>> frequently woken up to service the timers. So, consolidation of timers
>> onto a fewer number of cpus is important. Migration of
>> timers from idle cpus onto lesser idle cpus is necessary. Currently,
>> timers are migrated during the cpu offline operation. However
>> cpu-hotplug for the sake of idle system power management is too
>> heavy. So, this patch implements a lightweight timer migration
>> framework.
>>
>> Also, in a multi-core, multi-package system, it is always desirable to
>> have all the timers firing on the cpus present in the same package.
>> This would enable us to place the idle package in deep sleep
>> state. So, migration of timers is required for this.
>>
>> A per_cpu sysfs hook is created
>> at /sys/devices/system/cpu/cpuX/timer_migration. By echo-ing 1 to
>> cpuX/timer_migration, all regular and hrtimers from cpuX are migrated
>> to cpu0. The fact that all
>> timers are migrated from cpuX to cpu0 is demonstrated by making a note
>> of /proc/interrupts.
>>     
>
> This seems like an exceedingly dumb idea - cpu 0 might be a long long
> way from x and by pushing all timers to cpu0 you might actually overload
> cpu 0.
>
> Initially you talked about packages an moving timers to busy cpus -
> which is something else altogether.
>
>   

Here, I've chosen cpu0 just to demonstrate migration of timers. I'm
working on the algorithm to choose the best cpu or the best set of cpus
to migrate the timers to. This is just the first iteration on which i
intend to build upon. What could be a possible way is that, a package
can be chosen as the destination for the migrated timers and any one or
many cpus in that package can be the target(s). So, this  will prevent
the possible overloading of any particular cpu.

>> $:echo 1 > /sys/devices/system/cpu/cpu3/timer_migration
>> $:cat /proc/interrupts > file1; sleep 30 ; cat /proc/interrupts >
>> file2
>> $:diff file1 file2 | grep LOC
>> < LOC:       5276       2100       2676       1647       2415
>> 1803       2275       2977   Local timer interrupts
>>     
>>> LOC:       6991       2195       2774       1647       2562
>>>       
>> 1900       2497       3075   Local timer interrupts
>>
>> As we can observe, first we are enabling timer migration in cpu3. As a
>> result, the number of local timer interrupts on cpu3 over the next 30
>> seconds are zero. cpu3  has been totally rid of all regular
>> and hrtimers.
>>
>> Please refer to the following paper for details:
>>
>> http://ols.fedoraproject.org/OLS/Reprints-2008/srinivasan1-reprint.pdf
>>     
>
> If there's anything worth reading in there it should have been mentioned
> in this email and preferably in some comment in the code and Kconfig
> help as well.
>
>   
Thanks for the hint. I'll do that next time.
