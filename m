From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v7 5/8] CPPC: Add a CPUFreq driver for use with CPPC
Date: Tue, 21 Jul 2015 16:32:33 +0100
Message-ID: <55AE6611.9020808@arm.com>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>	<e8464849d98e4a4f64e9b23501d84b1f843aa994.1436464513.git.ashwin.chaugule@linaro.org>	<55AD0411.4000603@arm.com>	<3774934.MfIr66XDWO@vostro.rjw.lan>	<55AE083E.80303@arm.com> <CAJZ5v0j8UHFhW+ncvHbif_bdZoxNW-NivEgXhn9DaQxMPf_94Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0j8UHFhW+ncvHbif_bdZoxNW-NivEgXhn9DaQxMPf_94Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 21/07/15 15:27, Rafael J. Wysocki wrote:
> Hi Sudeep,
>
> On Tue, Jul 21, 2015 at 10:52 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 20/07/15 23:07, Rafael J. Wysocki wrote:
>>>
>>> On Monday, July 20, 2015 03:22:09 PM Sudeep Holla wrote:
>>>>
>>>>
>>>> On 09/07/15 19:04, Ashwin Chaugule wrote:
>>>>>
>>>>> This driver utilizes the methods introduced in the previous
>>>>> patch - "ACPI: Introduce CPU performance controls using CPPC"
>>>>> and enables usage with existing CPUFreq governors.
>>>>>
>>>>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>>>>> Reviewed-by: Al Stone <al.stone@linaro.org>
>>>>>
>>>>> ---
>>>>>     drivers/cpufreq/Kconfig.arm    |  16 ++++
>>>>>     drivers/cpufreq/Makefile       |   2 +
>>>>>     drivers/cpufreq/cppc_cpufreq.c | 197
>>>>> +++++++++++++++++++++++++++++++++++++++++
>>>>>     3 files changed, 215 insertions(+)
>>>>>     create mode 100644 drivers/cpufreq/cppc_cpufreq.c
>>>>>
>>>>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>>>>> index 4f3dbc8..578384d 100644
>>>>> --- a/drivers/cpufreq/Kconfig.arm
>>>>> +++ b/drivers/cpufreq/Kconfig.arm
>>>>> @@ -272,3 +272,19 @@ config ARM_PXA2xx_CPUFREQ
>>>>>            This add the CPUFreq driver support for Intel PXA2xx SOCs.
>>>>>
>>>>>            If in doubt, say N.
>>>>> +
>>>>> +config ACPI_CPPC_CPUFREQ
>>>>> +       tristate "CPUFreq driver based on the ACPI CPPC spec"
>>>>> +       depends on ACPI_CPPC_LIB
>>>>> +       default n
>>>>> +       help
>>>>> +         This adds a CPUFreq driver which uses CPPC methods
>>>>> +         as described in the ACPIv5.1 spec. CPPC stands for
>>>>> +         Collaborative Processor Performance Controls. It
>>>>> +         is based on an abstract continuous scale of CPU
>>>>> +         performance values which allows the remote power
>>>>> +         processor to flexibly optimize for power and
>>>>> +         performance. CPPC relies on power management firmware
>>>>> +         for its operation.
>>>>
>>>>
>>>> Why is this ARM specific ? It might be used only on ARM but doesn't mean
>>>> it should be visible only on ARM ACPI systems.
>>>
>>>
>>> Why bother people with considering Kconfig options that are useless to
>>> them?
>>>
>>
>> I agree to some extent, but main worry is that we are then making these
>> features architecture specific while ACPI is supposed to be architecture
>> agnostic. I was just trying to avoid doing so.
>
> Problem is, there are no plans to support CPPC on x86 in Linux I'm
> aware of and so we should not use it even if it is exposed by the
> firmware (Windows may be using it, though).
>

Ah that makes sense.

> I'm also not aware of plans to support _PSS on ARM.

Agreed, but you never know what ARM vendors can do :)

>
> So, even though on the spec level they are arch-independent, the way
> we use those interfaces in the kernel isn't.
>

Understood.

Regards,
Sudeep
