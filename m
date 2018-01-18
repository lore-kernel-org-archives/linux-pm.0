From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH v6 02/12] drivers: base: cacheinfo: setup DT cache properties early
Date: Thu, 18 Jan 2018 09:36:42 -0800 (PST)
Message-ID: <mhng-758d7724-dc4c-4d08-adf2-967862df2925@palmer-si-x1c4>
References: <a7d2910e-ae73-61de-9349-c5d804269695@arm.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33407 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755353AbeARRgo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jan 2018 12:36:44 -0500
Received: by mail-pg0-f68.google.com with SMTP id u1so1416306pgr.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2018 09:36:43 -0800 (PST)
In-Reply-To: <a7d2910e-ae73-61de-9349-c5d804269695@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: sudeep.holla@arm.com, jeremy.linton@arm.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, Will Deacon <will.deacon@arm.com>, catalin.marinas@arm.com, Greg KH <gregkh@linuxfoundation.org>, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, vkilari@codeaurora.org, morten.rasmussen@arm.com, albert@sifive.com

On Wed, 17 Jan 2018 10:08:27 PST (-0800), sudeep.holla@arm.com wrote:
> (Sorry, somehow I missed this email until I saw Jeremy's reply today)
>
> On 15/01/18 16:07, Palmer Dabbelt wrote:
>> On Mon, 15 Jan 2018 04:33:38 PST (-0800), sudeep.holla@arm.com wrote:
>>> On Fri, Jan 12, 2018 at 06:59:10PM -0600, Jeremy Linton wrote:
>>>> The original intent in cacheinfo was that an architecture
>>>> specific populate_cache_leaves() would probe the hardware
>>>> and then cache_shared_cpu_map_setup() and
>>>> cache_override_properties() would provide firmware help to
>>>> extend/expand upon what was probed. Arm64 was really
>>>> the only architecture that was working this way, and
>>>> with the removal of most of the hardware probing logic it
>>>> became clear that it was possible to simplify the logic a bit.
>>>>
>>>> This patch combines the walk of the DT nodes with the
>>>> code updating the cache size/line_size and nr_sets.
>>>> cache_override_properties() (which was DT specific) is
>>>> then removed. The result is that cacheinfo.of_node is
>>>> no longer used as a temporary place to hold DT references
>>>> for future calls that update cache properties. That change
>>>> helps to clarify its one remaining use (matching
>>>> cacheinfo nodes that represent shared caches) which
>>>> will be used by the ACPI/PPTT code in the following patches.
>>>>
>>>> Cc: Palmer Dabbelt <palmer@sifive.com>
>>>> Cc: Albert Ou <albert@sifive.com>
>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>> ---
>>>>  arch/riscv/kernel/cacheinfo.c |  1 +
>>>>  drivers/base/cacheinfo.c      | 65
>>>> +++++++++++++++++++------------------------
>>>>  include/linux/cacheinfo.h     |  1 +
>>>>  3 files changed, 31 insertions(+), 36 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/kernel/cacheinfo.c
>>>> b/arch/riscv/kernel/cacheinfo.c
>>>> index 10ed2749e246..6f4500233cf8 100644
>>>> --- a/arch/riscv/kernel/cacheinfo.c
>>>> +++ b/arch/riscv/kernel/cacheinfo.c
>>>> @@ -30,6 +30,7 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>>>>          CACHE_WRITE_BACK
>>>>          | CACHE_READ_ALLOCATE
>>>>          | CACHE_WRITE_ALLOCATE;
>>>> +    cache_of_set_props(this_leaf, node);
>>>
>>> This may be necessary but can it be done as later patch ? So far nothing
>>> is added that may break riscv IIUC.
>>>
>>> Palmer, Albert,
>>>
>>> Can you confirm ? Also, as I see we can thin down arch specific
>>> implementation on riscv if it's just using DT like ARM64. Sorry if
>>> I am missing to see something, so thought of checking.
>>>
>>> [...]
>>
>> Sorry, I guess I'm a bit confused as to what's going on here.  RISC-V
>> uses device tree on all Linux systems.
>>
>
> Good. By thin down, I was thinking of moving the init_cache_level and
> populate_cache_leaves implementation of riscv to generic weak function
> under CONFIG_OF. You may even endup deleting riscv cacheinfo.c
>
> Just a thought, sorry for not being clear earlier.

OK, well, I'm always happy to convert things to generic implementations.
