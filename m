From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH v3 6/7] arm64: topology: Enable ACPI/PPTT based CPU
 topology.
Date: Wed, 1 Nov 2017 14:29:26 -0600
Message-ID: <270ae2f5-0af6-1be4-2914-d1ce8d0a5cd0@redhat.com>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
 <20171012194856.13844-7-jeremy.linton@arm.com>
 <20171019155622.GC18883@red-moon>
 <b6c3fae3-eb6d-e5f2-6887-de1471978897@arm.com>
 <20171020092210.GB21060@red-moon>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:45343 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754758AbdKAU3a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Nov 2017 16:29:30 -0400
Received: by mail-io0-f195.google.com with SMTP id i38so8921261iod.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Nov 2017 13:29:29 -0700 (PDT)
In-Reply-To: <20171020092210.GB21060@red-moon>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org

On 10/20/2017 03:22 AM, Lorenzo Pieralisi wrote:
> On Thu, Oct 19, 2017 at 11:54:22AM -0500, Jeremy Linton wrote:
> 
> [...]
> 
>>>> +			cpu_topology[cpu].core_id   = topology_id;
>>>> +			topology_id = setup_acpi_cpu_topology(cpu, 2);
>>>> +			cpu_topology[cpu].cluster_id = topology_id;
>>>> +			topology_id = setup_acpi_cpu_topology(cpu, max_topo);
>>>
>>> If you want a package id (that's just a package tag to group cores), you
>>> should not use a large level because you know how setup_acpi_cpu_topology()works, you should add an API that allows you to retrieve the package id
>>> (so that you can use th ACPI_PPTT_PHYSICAL_PACKAGE flag consistenly,
>>> whatever it represents).
>>
>> I don't think the spec requires the use of PHYSICAL_PACKAGE... Am I
>> misreading it? Which means we need to "pick" a node level to
>> represent the physical package if one doesn't exist...
> 
> The specs define a means to detect if a given PPTT node corresponds to a
> package (I am refraining from stating again that to me that's not clean
> cut what a package is _architecturally_, I think you know my POV by now)
> and that's what you need to use to retrieve a packageid for a given cpu,
> if I understand the aim of the physical package flag.
> 
> Either that or that flag is completely useless.
> 
> Lorenzo
> 
> ACPI 6.2 - Table 5-151 (page 248)
> Physical package
> -----------------
> Set to 1 if this node of the processor topology represents the boundary
> of a physical package, whether socketed or surface mounted.  Set to 0 if
> this instance of the processor topology does not represent the boundary
> of a physical package.
> 

I've been following the discussion and I'm not sure I understand what the
confusion is around having a physical package ID.  Since I'm the one that
insisted it be in the spec, I'd be glad to clarify anything.  My apologies
for not saying anything sooner but things IRL have been very complicated
of late.

What was intended was a simple flag that was meant to tell me if a CPU ID
(this could be a CPU, a cluster, a processor container -- I don't really
care which) is *also* an actual physical device on a motherboard.  That is
the only intent; there was no architectural meaning intended at all -- that
is what the PPTT structures are for, in conjunction with any DSDT information
uncovered later in the boot process.

However, in the broader server ecosystem, this can be incredibly useful.  There
are a significant number of software products sold or supported that base their
fees on the number of physical sockets in use.  There have been in the past (and
may be in the near future) machines where the cost of the lease on the machine
is determined by how many physical sockets (or even CPUs) are in use, even if
the machine has many more available.

Some vendors also include FRU (Field Replaceable Unit) location info in their
ACPI tables.  So, for example, one or more CPUs or caches might fail in one
physical package, which is then reported to a maintenance system of some sort
that tells some human which of the physical sockets on what motherboard needs a
replacement device, or it's simply noted and shut off until it's time to replace
the entire server, or perhaps it's logged and used in an algorithm to predict
when the server might fail completely.

So, that's why the flag exists in the spec.  It seems to make sense to me to
have a package ID as part of struct cpu_topology -- it might even be really
handy for CPU hotplug.  If you don't, it seems to me a whole separate struct
would be needed with more cpumasks to show who belongs to what physical package;
that might be okay but seems unnecessarily complicated to me.

You can also tell me that I have completely missed the point of the discussion
so far :-).  But if you do, you have to tell me what I missed.

Hope this helps clarify...

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
