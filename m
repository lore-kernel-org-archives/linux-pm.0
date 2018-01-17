From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
Date: Wed, 17 Jan 2018 18:08:27 +0000
Message-ID: <a7d2910e-ae73-61de-9349-c5d804269695@arm.com>
References: <mhng-72d1934a-43df-4a5b-851d-0dd6d8a1b30b@palmer-si-x1c4>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mhng-72d1934a-43df-4a5b-851d-0dd6d8a1b30b@palmer-si-x1c4>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, jeremy.linton@arm.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, Will Deacon <will.deacon@arm.com>, catalin.marinas@arm.com, Greg KH <gregkh@linuxfoundation.org>, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, vkilari@codeaurora.org, morten.rasmussen@arm.com, albert@sifive.com
List-Id: linux-pm@vger.kernel.org

(Sorry, somehow I missed this email until I saw Jeremy's reply today)

On 15/01/18 16:07, Palmer Dabbelt wrote:
> On Mon, 15 Jan 2018 04:33:38 PST (-0800), sudeep.holla@arm.com wrote:
>> On Fri, Jan 12, 2018 at 06:59:10PM -0600, Jeremy Linton wrote:
>>> The original intent in cacheinfo was that an architecture
>>> specific populate_cache_leaves() would probe the hardware
>>> and then cache_shared_cpu_map_setup() and
>>> cache_override_properties() would provide firmware help to
>>> extend/expand upon what was probed. Arm64 was really
>>> the only architecture that was working this way, and
>>> with the removal of most of the hardware probing logic it
>>> became clear that it was possible to simplify the logic a bit.
>>>
>>> This patch combines the walk of the DT nodes with the
>>> code updating the cache size/line_size and nr_sets.
>>> cache_override_properties() (which was DT specific) is
>>> then removed. The result is that cacheinfo.of_node is
>>> no longer used as a temporary place to hold DT references
>>> for future calls that update cache properties. That change
>>> helps to clarify its one remaining use (matching
>>> cacheinfo nodes that represent shared caches) which
>>> will be used by the ACPI/PPTT code in the following patches.
>>>
>>> Cc: Palmer Dabbelt <palmer@sifive.com>
>>> Cc: Albert Ou <albert@sifive.com>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> ---
>>>  arch/riscv/kernel/cacheinfo.c |  1 +
>>>  drivers/base/cacheinfo.c      | 65
>>> +++++++++++++++++++------------------------
>>>  include/linux/cacheinfo.h     |  1 +
>>>  3 files changed, 31 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/arch/riscv/kernel/cacheinfo.c
>>> b/arch/riscv/kernel/cacheinfo.c
>>> index 10ed2749e246..6f4500233cf8 100644
>>> --- a/arch/riscv/kernel/cacheinfo.c
>>> +++ b/arch/riscv/kernel/cacheinfo.c
>>> @@ -30,6 +30,7 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>>>          CACHE_WRITE_BACK
>>>          | CACHE_READ_ALLOCATE
>>>          | CACHE_WRITE_ALLOCATE;
>>> +    cache_of_set_props(this_leaf, node);
>>
>> This may be necessary but can it be done as later patch ? So far nothing
>> is added that may break riscv IIUC.
>>
>> Palmer, Albert,
>>
>> Can you confirm ? Also, as I see we can thin down arch specific
>> implementation on riscv if it's just using DT like ARM64. Sorry if
>> I am missing to see something, so thought of checking.
>>
>> [...]
> 
> Sorry, I guess I'm a bit confused as to what's going on here.  RISC-V
> uses device tree on all Linux systems.
> 

Good. By thin down, I was thinking of moving the init_cache_level and
populate_cache_leaves implementation of riscv to generic weak function
under CONFIG_OF. You may even endup deleting riscv cacheinfo.c

Just a thought, sorry for not being clear earlier.

-- 
Regards,
Sudeep
