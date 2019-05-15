From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 2/3] PM / EM: Expose perf domain struct
Date: Wed, 15 May 2019 12:54:10 +0200
Message-ID: <b7e91d70-cd16-791c-94e1-3667ff264e49@linaro.org>
References: <20190515082318.7993-1-quentin.perret@arm.com>
 <20190515082318.7993-3-quentin.perret@arm.com>
 <0ced18eb-e424-fe6b-b11e-165a3c108170@linaro.org>
 <20190515091658.sbpg6qiovhtblqyr@queper01-lin>
 <698400c0-e0a4-4a86-b9df-cdb9bd683c0f@linaro.org>
 <20190515100748.q3t4kt72h2akdpcs@queper01-lin>
 <cf1474cb-7e31-7070-b988-a0c4d3f6f081@linaro.org>
 <20190515102200.s6uq63qnwea6xtpl@vireshk-i7>
 <20190515104043.vogspxgkapp6qsny@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515104043.vogspxgkapp6qsny@queper01-lin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org, amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, dietmar.eggemann@arm.com, ionela.voinescu@arm.com, mka@chromium.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 15/05/2019 12:40, Quentin Perret wrote:
> On Wednesday 15 May 2019 at 15:52:00 (+0530), Viresh Kumar wrote:
>> On 15-05-19, 12:16, Daniel Lezcano wrote:
>>> Viresh what do you think ?
>>
>> I agree with your last suggestions. They do make sense.
> 
> Good :-)
> 
> So, FWIW, the below compiles w/ or w/o THERMAL_GOV_POWER_ALLOCATOR. I'll
> test it and clean it up some more and put it as patch 1 in the series if
> that's OK.
> 
> Thanks,
> Quentin
> 
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index f7c1f49ec87f..ee431848ef71 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -58,7 +58,9 @@
>   */
>  struct freq_table {
>         u32 frequency;

I suspect we will have a problem here as cpufreq_set_cur_state uses the
frequency and when switching to EM, we will still need a freq table.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
