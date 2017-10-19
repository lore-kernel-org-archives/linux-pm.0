From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v3 1/7] ACPI/PPTT: Add Processor Properties Topology Table
 parsing
Date: Thu, 19 Oct 2017 09:24:12 -0500
Message-ID: <b5dc310d-ca95-fd08-5b2e-8bbaeba19533@arm.com>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
 <20171012194856.13844-2-jeremy.linton@arm.com>
 <38c63cfd-4c13-9461-0d4a-74b0943be0fd@semihalf.com>
 <2ce92b90-fc2c-3fff-a3e3-b9517057ab2c@arm.com>
 <4ee4af4d-d987-33f9-4d55-67bfede3ebfa@caviumnetworks.com>
 <ed7f2e82-1e9b-9f46-89af-4e638275355d@caviumnetworks.com>
 <47d8ef93-a3ce-6d40-f8db-2bc7d527ac6f@arm.com>
 <2605aa54-95f7-4619-e632-0a95a68e5fb0@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2605aa54-95f7-4619-e632-0a95a68e5fb0@caviumnetworks.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Nowicki <tnowicki@caviumnetworks.com>, linux-acpi@vger.kernel.org
Cc: mark.rutland@arm.com, Jonathan.Zhang@cavium.com, Jayachandran.Nair@cavium.com, lorenzo.pieralisi@arm.com, austinwc@codeaurora.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, gregkh@linuxfoundation.org, sudeep.holla@arm.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, will.deacon@arm.com, wangxiongfeng2@huawei.com, viresh.kumar@linaro.org, hanjun.guo@linaro.org, catalin.marinas@arm.com, ahs3@redhat.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi,


On 10/19/2017 12:18 AM, Tomasz Nowicki wrote:
> On 18.10.2017 19:30, Jeremy Linton wrote:
>> On 10/18/2017 05:24 AM, Tomasz Nowicki wrote:
>>> On 18.10.2017 07:39, Tomasz Nowicki wrote:
>>>> On 17.10.2017 17:22, Jeremy Linton wrote:
>>>>> On 10/17/2017 08:25 AM, Tomasz Nowicki wrote:
>>>>>> On 12.10.2017 21:48, Jeremy Linton wrote:
(trimming)
>>>>>>> +            if (*found != NULL)
>>>>>>> +                pr_err("Found duplicate cache level/type unable 
>>>>>>> to determine uniqueness\n");
>>>
>>> Actually I still see this error messages in my dmesg. It is because 
>>> the following ThunderX2 per-core L1 and L2 cache hierarchy:
>>>
>>> Core
>>>   ------------------
>>> |                  |
>>> | L1i -----        |
>>> |         |        |
>>> |          ----L2  |
>>> |         |        |
>>> | L1d -----        |
>>> |                  |
>>>   ------------------
>>>
>>> In this case we have two paths which lead to L2 cache and hit above 
>>> case. Is it really error case?
>>
>> No, but its not deterministic unless we mark the node, which doesn't 
>> solve the problem of a table constructed like
>>
>> L1i->L2 (unified)
>> L1d->L2 (unified)
>>
>> or various other structures which aren't disallowed by the spec and 
>> have non-deterministic real world meanings, anymore than constructing 
>> the table like:
>>
>> L1i
>> Lid->L2(unified)
>>
>> which I tend to prefer because with a structuring like that it can be 
>> deterministic (and in a way actually represents the non-coherent 
>> behavior of (most?) ARM64 core's i-caches, as could be argued the 
>> first example if the allocation policies are varied between the L2 
>> nodes).
>>
>> The really ugly bits here happen if you add another layer:
>>
>> L1i->L2i-L3
>> L1d------^
>>
>> which is why I made that an error message, not including the fact that 
>> since the levels aren't tagged the numbering and meaning isn't clear.
>>
>> (the L1i in the above example might be better called an L0i to avoid 
>> throwing off the reset of the hierarchy numbering, also so it could be 
>> ignored).
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

Great.

Also, I think this is a better change:

      if ((*found != NULL) && (*found != cache))
          pr_err("Found duplicate cache level/type unable to determine 
uniqueness\n");

Which if its a duplicate node/type at the given level the message is 
just suppressed. It will of course still trigger in cases like:

L1d->L2
l1i->L2

or other odd cases.
