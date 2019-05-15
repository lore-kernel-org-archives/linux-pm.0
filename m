From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 2/3] PM / EM: Expose perf domain struct
Date: Wed, 15 May 2019 12:51:57 +0200
Message-ID: <5b55e432-f8b0-91ae-a7de-fe02e0cad322@linaro.org>
References: <20190515082318.7993-1-quentin.perret@arm.com>
 <20190515082318.7993-3-quentin.perret@arm.com>
 <0ced18eb-e424-fe6b-b11e-165a3c108170@linaro.org>
 <20190515091658.sbpg6qiovhtblqyr@queper01-lin>
 <698400c0-e0a4-4a86-b9df-cdb9bd683c0f@linaro.org>
 <20190515100748.q3t4kt72h2akdpcs@queper01-lin>
 <cf1474cb-7e31-7070-b988-a0c4d3f6f081@linaro.org>
 <20190515102200.s6uq63qnwea6xtpl@vireshk-i7>
 <20190515104043.vogspxgkapp6qsny@queper01-lin>
 <20190515104651.tv5odug7ce4zlupc@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515104651.tv5odug7ce4zlupc@queper01-lin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org, amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, dietmar.eggemann@arm.com, ionela.voinescu@arm.com, mka@chromium.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 15/05/2019 12:46, Quentin Perret wrote:
> On Wednesday 15 May 2019 at 11:40:44 (+0100), Quentin Perret wrote:

[ ... ]

>> +#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
>>         if (capacitance) {
>>                 ret = update_freq_table(cpufreq_cdev, capacitance);
>>                 if (ret) {
>>                         cdev = ERR_PTR(ret);
>>                         goto remove_ida;
>>                 }
>> -
>> -               cooling_ops = &cpufreq_power_cooling_ops;
>> -       } else {
>> -               cooling_ops = &cpufreq_cooling_ops;
>>         }
>> +#endif
>> +       cooling_ops = &cpufreq_cooling_ops;
> 
> Argh, that is actually broken with !capacitance and
> THERMAL_GOV_POWER_ALLOCATOR=y ... Perhaps it's best to keep the two
> thermal_cooling_device_ops struct separated in the end.

Or alternatively you can keep one structure but instead of filling the
state2power,power2state and getrequestedpower fields in the declaration,
you fill them in the if (capacitance) block, no?




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
