From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
Date: Thu, 18 Jan 2018 10:14:06 +0000
Message-ID: <05a8b375-70c4-34d4-6cde-8dd4cd62c10b@arm.com>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-3-jeremy.linton@arm.com>
 <20180115123338.GB5473@e107155-lin>
 <65f78c99-8b86-0098-7ced-899840a4bf16@arm.com>
 <ca64334c-9345-705c-80d8-f2deb924a679@arm.com>
 <15884ccc-2cfb-da91-5844-369d8237175d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52782 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753505AbeARKOO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Jan 2018 05:14:14 -0500
In-Reply-To: <15884ccc-2cfb-da91-5844-369d8237175d@arm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, vkilari@codeaurora.org, morten.rasmussen@arm.com, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>



On 17/01/18 18:51, Jeremy Linton wrote:
> Hi,
> 
> On 01/17/2018 12:20 PM, Sudeep Holla wrote:
>>
>>
>> On 16/01/18 21:07, Jeremy Linton wrote:
>>> Hi,
>>>
>>> On 01/15/2018 06:33 AM, Sudeep Holla wrote:
>>>> On Fri, Jan 12, 2018 at 06:59:10PM -0600, Jeremy Linton wrote:
>>>>> The original intent in cacheinfo was that an architecture
>>>>> specific populate_cache_leaves() would probe the hardware
>>>>> and then cache_shared_cpu_map_setup() and
>>>>> cache_override_properties() would provide firmware help to
>>>>> extend/expand upon what was probed. Arm64 was really
>>>>> the only architecture that was working this way, and
>>>>> with the removal of most of the hardware probing logic it
>>>>> became clear that it was possible to simplify the logic a bit.
>>>>>
>>>>> This patch combines the walk of the DT nodes with the
>>>>> code updating the cache size/line_size and nr_sets.
>>>>> cache_override_properties() (which was DT specific) is
>>>>> then removed. The result is that cacheinfo.of_node is
>>>>> no longer used as a temporary place to hold DT references
>>>>> for future calls that update cache properties. That change
>>>>> helps to clarify its one remaining use (matching
>>>>> cacheinfo nodes that represent shared caches) which
>>>>> will be used by the ACPI/PPTT code in the following patches.
>>>>>
>>>>> Cc: Palmer Dabbelt <palmer@sifive.com>
>>>>> Cc: Albert Ou <albert@sifive.com>
>>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>>> ---
>>>>>    arch/riscv/kernel/cacheinfo.c |  1 +
>>>>>    drivers/base/cacheinfo.c      | 65
>>>>> +++++++++++++++++++------------------------
>>>>>    include/linux/cacheinfo.h     |  1 +
>>>>>    3 files changed, 31 insertions(+), 36 deletions(-)
>>>>>
>>>>> diff --git a/arch/riscv/kernel/cacheinfo.c
>>>>> b/arch/riscv/kernel/cacheinfo.c
>>>>> index 10ed2749e246..6f4500233cf8 100644
>>>>> --- a/arch/riscv/kernel/cacheinfo.c
>>>>> +++ b/arch/riscv/kernel/cacheinfo.c
>>>>> @@ -30,6 +30,7 @@ static void ci_leaf_init(struct cacheinfo
>>>>> *this_leaf,
>>>>>            CACHE_WRITE_BACK
>>>>>            | CACHE_READ_ALLOCATE
>>>>>            | CACHE_WRITE_ALLOCATE;
>>>>> +    cache_of_set_props(this_leaf, node);
>>>>
>>>> This may be necessary but can it be done as later patch ? So far
>>>> nothing
>>>> is added that may break riscv IIUC.
>>>
>>> Well I think you have a bisection issue where the additional information
>>> will disappear between this patch and wherever we put this code back in.
>>>
>>
>> Hmm, I am sorry but I fail to see the issue. Before this change,
>> populate_cache_leaves just populated the info as per ci_leaf_init in
>> arch/riscv/kernel/cacheinfo.c and cache_override_properties used to fill
>> the remaining.
>>
>> After this patch, the same is achieved in cache_shared_cpu_map_setup.
>>
>> In both case, it was by the end of detect_cache_attributes, so I see no
>> issue.
>>
> 
> 
> Hi,
> 
> I must be misunderstanding something.
> 

Looks like I was missing to understand something :)

> AFAIK, The code in cache_setup_of_node() won't call cache_of_set_props()
> because it returns when there is an existing of_node (fw_unique) created
> by the riscv populate_cache_leaves(). That's why I'm making the direct
> call here. If we fail to get that change in place before
> cache_override_properties() is removed then the fields not set by the
> riscv code (size/etc) will be missing.

Indeed. I am trying to avoid use of cache_of_set_props outside.
How about skipping setting up of fw_unique in ci_leaf_init instead ?

-- 
Regards,
Sudeep
