From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v2 5/8] timers: keep sleep length updated as needed
Date: Mon, 16 Oct 2017 14:46:41 +0800
Message-ID: <33404efd-a8e0-eb0b-4df8-9e7aa5a66dde@linux.intel.com>
References: <1506756034-6340-1-git-send-email-aubrey.li@intel.com>
 <1506756034-6340-6-git-send-email-aubrey.li@intel.com>
 <1554921.dz8jk4n8cL@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554921.dz8jk4n8cL@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aubrey Li <aubrey.li@intel.com>
Cc: tglx@linutronix.de, peterz@infradead.org, len.brown@intel.com, ak@linux.intel.com, tim.c.chen@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2017/10/14 8:56, Rafael J. Wysocki wrote:
> On Saturday, September 30, 2017 9:20:31 AM CEST Aubrey Li wrote:
>> sleep length indicates how long we'll be idle. Currently, it's updated
>> only when tick nohz enters. These patch series make a new requirement
>> with tick, so we should keep sleep length updated as needed
> 
> So what exactly would be the problem with leaving things as they are?

Previously ts->sleep_length is only updated when tick is stopped.

As follows, in

__tick_nohz_idle_enter()
{
	if (can_stop_idle_tick() /* return true */) {
		tick_nohz_stop_sched_tick()
			|
			|-----> update sleep_length
	}
}

Now ts->sleep_length is required out of tick_nohz_idle_enter(), so we want
to update sleep_length every time we read it

If we leave it unchanged, the prediction could read a sleep_length long time
ago if the system keep ticking.
> 
>> ---
>>  kernel/time/tick-sched.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
>> index d663fab..94fb9b8 100644
>> --- a/kernel/time/tick-sched.c
>> +++ b/kernel/time/tick-sched.c
>> @@ -1008,8 +1008,11 @@ void tick_nohz_irq_exit(void)
>>   */
>>  ktime_t tick_nohz_get_sleep_length(void)
>>  {
>> +	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
>>  	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
>>  
>> +	ts->sleep_length = ktime_sub(dev->next_event, ktime_get());
>> +
>>  	return ts->sleep_length;
>>  }
>>  
>>
> 
> I probably wouldn't do it this way ...
> 
> 

May I know the detailed thoughts?

Thanks,
-Aubrey
