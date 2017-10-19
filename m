From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v3 1/7] ACPI/PPTT: Add Processor Properties Topology Table
 parsing
Date: Thu, 19 Oct 2017 11:25:08 +0100
Message-ID: <49421fa9-c3ac-c81b-ed2d-a113f676edd8@huawei.com>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
 <20171012194856.13844-2-jeremy.linton@arm.com>
 <38c63cfd-4c13-9461-0d4a-74b0943be0fd@semihalf.com>
 <2ce92b90-fc2c-3fff-a3e3-b9517057ab2c@arm.com>
 <4ee4af4d-d987-33f9-4d55-67bfede3ebfa@caviumnetworks.com>
 <ed7f2e82-1e9b-9f46-89af-4e638275355d@caviumnetworks.com>
 <47d8ef93-a3ce-6d40-f8db-2bc7d527ac6f@arm.com>
 <2605aa54-95f7-4619-e632-0a95a68e5fb0@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:8992 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbdJSK0P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2017 06:26:15 -0400
In-Reply-To: <2605aa54-95f7-4619-e632-0a95a68e5fb0@caviumnetworks.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Nowicki <tnowicki@caviumnetworks.com>, Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
Cc: mark.rutland@arm.com, Jonathan.Zhang@cavium.com, Jayachandran.Nair@cavium.com, lorenzo.pieralisi@arm.com, austinwc@codeaurora.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, gregkh@linuxfoundation.org, sudeep.holla@arm.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, will.deacon@arm.com, wangxiongfeng2@huawei.com, viresh.kumar@linaro.org, hanjun.guo@linaro.org, catalin.marinas@arm.com, ahs3@redhat.com, linux-arm-kernel@lists.infradead.org

On 19/10/2017 06:18, Tomasz Nowicki wrote:
>>
>> Summary:
>>
>> I'm not at all happy with this specification's attempt to leave out
>> pieces of information which make parsing things more deterministic. In
>> this case I'm happy to demote the message level, but not remove it
>> entirely but I do think the obvious case you list shouldn't be the
>> default one.
>>
>> Lastly:
>>
>> I'm assuming the final result is that the table is actually being
>> parsed correctly despite the ugly message?
>
> Indeed, the ThunderX2 PPTT table is being parsed so that topology shown
> in lstopo and lscpu is correct.

Hi Tomasz,

Can you share the lscpu output? Does it have cluster info? I did not 
think that lscpu has a concept of clustering.

I would say that the per-cpu cluster index sysfs entry needs be added to 
drivers/base/arch_topology.c (and other appropiate code under 
GENERIC_ARCH_TOPOLOGY) to support this.

Thanks,
John


>
> Thanks,
> Tomasz
