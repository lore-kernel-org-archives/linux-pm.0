From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v3 1/7] ACPI/PPTT: Add Processor Properties Topology Table
 parsing
Date: Mon, 23 Oct 2017 16:14:22 -0500
Message-ID: <e114e061-cd4b-1f15-d1a6-943e6f1f56d8@arm.com>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
 <20171012194856.13844-2-jeremy.linton@arm.com>
 <3e898236-0e7d-a8b0-e4c2-443012472296@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbdJWVO2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Oct 2017 17:14:28 -0400
In-Reply-To: <3e898236-0e7d-a8b0-e4c2-443012472296@codeaurora.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Christ, Austin" <austinwc@codeaurora.org>, linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com

Hi,

On 10/20/2017 02:53 PM, Christ, Austin wrote:
> Hey Jeremy,
> 
> Quick comment below.
> 
> On 10/12/2017 1:48 PM, Jeremy Linton wrote:
>> +static int topology_setup_acpi_cpu(struct acpi_table_header *table,
>> +                    unsigned int cpu, int level)
>> +{
>> +    struct acpi_pptt_processor *cpu_node;
>> +    u32 acpi_cpu_id = acpi_cpu_get_madt_gicc(cpu)->uid;
> 
> This lookup for the acpi id is architecture dependent. Can you use a 
> function that would work for any user of PPTT and MADT? It may require 
> writing and exporting the inverse lookup of the function 
> acpi_get_cpuid() which is exported from processor_core.c

Sure, I was actually thinking about just passing it into the function, 
so it becomes the responsibility of the caller to do the platform 
specific reverse lookup.

> 
>> +
>> +    cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>> +    if (cpu_node) {
>> +        cpu_node = acpi_find_processor_package_id(table, cpu_node, 
>> level);
>> +        /* Only the first level has a guaranteed id */
>> +        if (level == 0)
>> +            return cpu_node->acpi_processor_id;
>> +        return (int)((u8 *)cpu_node - (u8 *)table);
>> +    }
>> +    pr_err_once("PPTT table found, but unable to locate core for %d\n",
>> +            cpu);
>> +    return -ENOENT;
>> +}
> 
