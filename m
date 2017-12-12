From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v5 4/9] drivers: base cacheinfo: Add support for ACPI
 based firmware tables
Date: Tue, 12 Dec 2017 16:55:01 -0600
Message-ID: <9bb1c58a-8d48-9952-e292-60b2bcb87a51@arm.com>
References: <20171201222330.18863-1-jeremy.linton@arm.com>
 <20171201222330.18863-5-jeremy.linton@arm.com>
 <2078459.JrYtfXc8fv@aspire.rjw.lan>
 <5024a041-2ef4-3912-994f-b5fcc945e916@arm.com>
 <CAJZ5v0hHdfE3khVvuqQm5JFMgY5R054c8UB9Nixii9ucq0Ecnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hHdfE3khVvuqQm5JFMgY5R054c8UB9Nixii9ucq0Ecnw@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, Al Stone <ahs3@redhat.com>, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, Len Brown <lenb@>
List-Id: linux-pm@vger.kernel.org

Hi,

On 12/12/2017 11:25 AM, Rafael J. Wysocki wrote:
> On Tue, Dec 12, 2017 at 6:03 PM, Jeremy Linton <jeremy.linton@arm.com> wrote:
>> Hi,
>>
>>
>> On 12/11/2017 07:11 PM, Rafael J. Wysocki wrote:
>>>
>>> On Friday, December 1, 2017 11:23:25 PM CET Jeremy Linton wrote:
>>>>
>>>> Add a entry to to struct cacheinfo to maintain a reference to the PPTT
>>>> node which can be used to match identical caches across cores. Also
>>>> stub out cache_setup_acpi() so that individual architectures can
>>>> enable ACPI topology parsing.
>>>>
>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>> ---
>>>>    drivers/acpi/pptt.c       |  1 +
>>>>    drivers/base/cacheinfo.c  | 20 ++++++++++++++------
>>>>    include/linux/cacheinfo.h | 13 ++++++++++++-
>>>>    3 files changed, 27 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>>>> index 0f8a1631af33..a35e457cefb7 100644
>>>> --- a/drivers/acpi/pptt.c
>>>> +++ b/drivers/acpi/pptt.c
>>>> @@ -329,6 +329,7 @@ static void update_cache_properties(struct cacheinfo
>>>> *this_leaf,
>>>>    {
>>>>          int valid_flags = 0;
>>>>    +     this_leaf->firmware_node = cpu_node;
>>>>          if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID) {
>>>>                  this_leaf->size = found_cache->size;
>>>>                  valid_flags++;
>>>> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
>>>> index eb3af2739537..ba89f9310e6f 100644
>>>> --- a/drivers/base/cacheinfo.c
>>>> +++ b/drivers/base/cacheinfo.c
>>>> @@ -86,7 +86,10 @@ static int cache_setup_of_node(unsigned int cpu)
>>>>    static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
>>>>                                             struct cacheinfo *sib_leaf)
>>>>    {
>>>> -       return sib_leaf->of_node == this_leaf->of_node;
>>>> +       if (acpi_disabled)
>>>> +               return sib_leaf->of_node == this_leaf->of_node;
>>>> +       else
>>>> +               return sib_leaf->firmware_node ==
>>>> this_leaf->firmware_node;
>>>>    }
>>>>      /* OF properties to query for a given cache type */
>>>> @@ -215,6 +218,11 @@ static inline bool cache_leaves_are_shared(struct
>>>> cacheinfo *this_leaf,
>>>>    }
>>>>    #endif
>>>>    +int __weak cache_setup_acpi(unsigned int cpu)
>>>> +{
>>>> +       return -ENOTSUPP;
>>>> +}
>>>> +
>>>>    static int cache_shared_cpu_map_setup(unsigned int cpu)
>>>>    {
>>>>          struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>>>> @@ -225,11 +233,11 @@ static int cache_shared_cpu_map_setup(unsigned int
>>>> cpu)
>>>>          if (this_cpu_ci->cpu_map_populated)
>>>>                  return 0;
>>>>    -     if (of_have_populated_dt())
>>>> +       if (!acpi_disabled)
>>>> +               ret = cache_setup_acpi(cpu);
>>>> +       else if (of_have_populated_dt())
>>>>                  ret = cache_setup_of_node(cpu);
>>>> -       else if (!acpi_disabled)
>>>> -               /* No cache property/hierarchy support yet in ACPI */
>>>> -               ret = -ENOTSUPP;
>>>> +
>>>>          if (ret)
>>>>                  return ret;
>>>>    @@ -286,7 +294,7 @@ static void cache_shared_cpu_map_remove(unsigned
>>>> int cpu)
>>>>      static void cache_override_properties(unsigned int cpu)
>>>>    {
>>>> -       if (of_have_populated_dt())
>>>> +       if (acpi_disabled && of_have_populated_dt())
>>>>                  return cache_of_override_properties(cpu);
>>>>    }
>>>>    diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
>>>> index 3d9805297cda..7ebff157ae6c 100644
>>>> --- a/include/linux/cacheinfo.h
>>>> +++ b/include/linux/cacheinfo.h
>>>> @@ -37,6 +37,8 @@ enum cache_type {
>>>>     * @of_node: if devicetree is used, this represents either the cpu node
>>>> in
>>>>     *    case there's no explicit cache node or the cache node itself in
>>>> the
>>>>     *    device tree
>>>> + * @firmware_node: When not using DT, this may contain pointers to other
>>>> + *     firmware based values. Particularly ACPI/PPTT unique values.
>>>>     * @disable_sysfs: indicates whether this node is visible to the user
>>>> via
>>>>     *    sysfs or not
>>>>     * @priv: pointer to any private data structure specific to particular
>>>> @@ -65,8 +67,8 @@ struct cacheinfo {
>>>>    #define CACHE_ALLOCATE_POLICY_MASK    \
>>>>          (CACHE_READ_ALLOCATE | CACHE_WRITE_ALLOCATE)
>>>>    #define CACHE_ID              BIT(4)
>>>> -
>>>>          struct device_node *of_node;
>>>> +       void *firmware_node;
>>>
>>>
>>> What about converting this to using struct fwnode instead of adding
>>> fields to it?
>>
>>
>> I didn't really want to add another field here, but I've also pointed out
>> how I thought converting it to a fwnode wasn't a good choice.
>>
>> https://lkml.org/lkml/2017/11/20/502
>>
>> Mostly because IMHO its even more misleading (lacking any fwnode_operations)
>> than misusing the of_node as a void *.
> 
> I'm not sure what you mean.

Converting the DT drivers/cacheinfo.c code to use a fwnode_handle is 
straightforward. But IMHO it doesn't solve the readability problem of 
either casting the ACPI/PPTT token directly to the resulting 
fwnode_handle *, or alternatively an actual fwnode_handle with bogus 
fwnode_operations to wrap that token.


> 
> Anyway, the idea is to have one pointer in there instead of two that
> cannot be used at the same time and there's no reason why of_node
> should be special.

	Avoid two pointers for size, or readability? Because the last version 
had a union with of_node, which isn't strictly necessary as I can just 
cast the pptt token to of_node. There is exactly one line of code after 
that which uses the token and it doesn't care about type.

(in cache_leaves_are_shared())

> 
> of_node should just be one of multiple choices.
> 
>> Given that I'm in the minority thinking this, how far down the fwnode path
>> on the ACPI side do we want to go?
> 
> I have no idea. :-)
> 
>> Is simply treating it as a void pointer
>> sufficient for the ACPI side, considering all the PPTT code needs is a
>> unique token?
> 
> I guess you can think about it as of_node under a different name, but
> whether or not this is sufficient depends on what you need it for.

> 
> Thanks,
> Rafael
> 

