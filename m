From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [RFC PATCH 6/7] sched/fair: update cpu_capcity to reflect thermal
 pressure
Date: Wed, 10 Oct 2018 10:22:20 -0400
Message-ID: <5BBE0B1C.4060508@linaro.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <1539102302-9057-7-git-send-email-thara.gopinath@linaro.org>
 <20181010055722.GA5038@tesla>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010055722.GA5038@tesla>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com, gregkh@linuxfoundation.org, rafael@kernel.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, quentin.perret@arm.com, ionela.voinescu@arm.com, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

On 10/10/2018 01:57 AM, Javi Merino wrote:
> On Tue, Oct 09, 2018 at 12:25:01PM -0400, Thara Gopinath wrote:
>> cpu_capacity relflects the maximum available capacity of a cpu. Thermal
>> pressure on a cpu means this maximum available capacity is reduced. This
>> patch reduces the average thermal pressure for a cpu from its maximum
>> available capacity so that cpu_capacity reflects the actual
>> available capacity.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>  kernel/sched/fair.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 7deb1d0..8651e55 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7497,6 +7497,7 @@ static unsigned long scale_rt_capacity(int cpu)
>>  
>>  	used = READ_ONCE(rq->avg_rt.util_avg);
>>  	used += READ_ONCE(rq->avg_dl.util_avg);
>> +	used += READ_ONCE(rq->avg_thermal.load_avg);
> 
> IIUIC, you are treating thermal pressure as an artificial load on the
> cpu.  If so, this sounds like a hard to maintain hack.  Thermal
> pressure have different characteristics to utilization.  What happens
> if thermal sets the cpu cooling state back to 0 because there is
> thermal headroom again?  Do we keep adding this artificial load to the
> cpu just because there was thermal pressure in the past and let it
> decay as if it was cpu load?

Setting cpu cooling state back to 0 will decay the thermal pressure back
to 0 ? Yes, cpu will not register an instantaneous drop in the cap, it
will be decayed down following the PELT signals.

> 
> Cheers,
> Javi
> 


-- 
Regards
Thara
