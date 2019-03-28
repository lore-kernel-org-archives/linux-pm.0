From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/3] arm64: defconfig: Enable CONFIG_ENERGY_MODEL
Date: Thu, 28 Mar 2019 18:27:49 +0100
Message-ID: <f5c699d6-f8f8-ab53-2835-329ae2bd8202@linaro.org>
References: <20190328101352.25657-1-quentin.perret@arm.com>
 <20190328101352.25657-2-quentin.perret@arm.com>
 <20190328102206.doqj5fykqlld7jkd@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328102206.doqj5fykqlld7jkd@queper01-lin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>, edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org, viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com
Cc: dietmar.eggemann@arm.com, ionela.voinescu@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 28/03/2019 11:22, Quentin Perret wrote:
> On Thursday 28 Mar 2019 at 10:13:50 (+0000), Quentin Perret wrote:
>> The recently introduced Energy Model (EM) framework manages power cost
>> tables for the CPUs of the system. Its only user right now is the
>> scheduler, in the context of Energy Aware Scheduling (EAS).
>>
>> However, the EM framework also offers a generic infrastructure that
>> could replace subsystem-specific implementations of the same concepts,
>> as this is the case in the thermal framework.
>>
>> So, in order to prepare the migration of the thermal subsystem to use
>> the EM framework, enable it in the default arm64 defconfig, which is the
>> most commonly used architecture for IPA. This will also compile-in all
>> of the EAS code, although it won't be enabled by default -- EAS requires
>> to use the 'schedutil' CPUFreq governor while arm64 defaults to
>> 'performance'.
>>
>> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
>> ---
>>  arch/arm64/configs/defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 2d9c39033c1a..3c09bdaaefd3 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -97,6 +97,7 @@ CONFIG_XEN=y
>>  CONFIG_COMPAT=y
>>  CONFIG_HIBERNATION=y
>>  CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
>> +CONFIG_ENERGY_MODEL=n
> 
> Hmm, sorry I turned this to '=n' for testing and forgot to update the
> patch. This obviously should be '=y' ...

I did a test without the ENERGY_MODEL config option set, dhrystone and
the power_allocator policy on the hikey. The board did not mitigate well
and ended up rebooting. May be the cpu cooling Kconfig option should add
a SELECT or a DEPENDS on ENERGY_MODEL ?


>>  CONFIG_ARM_CPUIDLE=y
>>  CONFIG_CPU_FREQ=y
>>  CONFIG_CPU_FREQ_STAT=y
>> -- 
>> 2.21.0
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
