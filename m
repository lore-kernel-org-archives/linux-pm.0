From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v9 1/5] ACPI: Introduce CPU performance controls using CPPC
Date: Sun, 27 Sep 2015 13:15:20 -0400
Message-ID: <CAJ5Y-eb0vYaf6krUMT-XKESkD56nkFwbB+gc_Rzwii8ctp65Gw@mail.gmail.com>
References: <cover.1441830300.git.ashwin.chaugule@linaro.org>
	<de2aab7944aea82d7f846e96c193bf577507cdcd.1441830300.git.ashwin.chaugule@linaro.org>
	<10036388.hkOY1zLhN4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <10036388.hkOY1zLhN4@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "rwells@codeaurora.org" <rwells@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,


On 25 September 2015 at 20:05, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, September 09, 2015 04:27:04 PM Ashwin Chaugule wrote:
>> CPPC stands for Collaborative Processor Performance Controls
>> and is defined in the ACPI v5.0+ spec. It describes CPU
>> performance controls on an abstract and continuous scale
>> allowing the platform (e.g. remote power processor) to flexibly
>> optimize CPU performance with its knowledge of power budgets
>> and other architecture specific knowledge.
>>
>> This patch adds a shim which exports commonly used functions
>> to get and set CPPC specific controls for each CPU. This enables
>> CPUFreq drivers to gather per CPU performance data and use
>> with exisiting governors or even allows for customized governors
>> which are implemented inside CPUFreq drivers.
>>
>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> Reviewed-by: Al Stone <al.stone@linaro.org>
>> ---
>
> [cut]
>
>> +
>> +/**
>> + * acpi_get_psd_map - Map the CPUs in a common freq domain as indicated
>> + *   in the respective _PSD entries.
>
> One minor nit: this needs to be one-line in a proper kerneldoc.
>
>> + * @all_cpu_data: This array of pointers contains all the CPU specific
>> + *   details to access CPPC registers and freq domain information for each
>> + *   CPU.
>
> Ditto.
>
> You can add more description below.

Ok. Will do.

>
> [cut]
>
>> +int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>> +{
>> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>> +     struct cpc_register_resource *delivered_reg, *reference_reg;
>> +     u64 delivered, reference;
>> +     int ret = 0;
>> +
>> +     if (!cpc_desc) {
>> +             pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
>> +             return -ENODEV;
>> +     }
>> +
>> +     delivered_reg = &cpc_desc->cpc_regs[DELIVERED_CTR];
>> +     reference_reg = &cpc_desc->cpc_regs[REFERENCE_CTR];
>> +
>> +     spin_lock(&pcc_lock);
>
> I still have the question about this lock.
>
> Why does it have to be a spinlock?

The idea is to let CPUs send in their requests as quickly as possible.
The PCC transaction only relays the request. So the CPUs don't really
wait for all the clk + voltage toggling etc. I think any other
primitive, might cause unnecessary delays in sending requests. Also
FWIW, this is another thing I was influenced by from the pcc-cpufreq.c
driver. :)

Regards,
Ashwin.
