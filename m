From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 05/12] ACPI/PPTT: Add Processor Properties Topology
 Table parsing
Date: Wed, 17 Jan 2018 17:58:06 +0000
Message-ID: <6215c089-0b93-2ac5-34ac-8d5e726cbf58@arm.com>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-6-jeremy.linton@arm.com>
 <20180115145839.GA12531@e107155-lin>
 <65c42ed6-8ac7-3adb-43f2-de20080eaaa9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <65c42ed6-8ac7-3adb-43f2-de20080eaaa9@arm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, vkilari@codeaurora.org, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org



On 16/01/18 20:55, Jeremy Linton wrote:
> 

[...]

>>> +/*
>>> + * Determine if the *node parameter is a leaf node by iterating the
>>> + * PPTT table, looking for nodes which reference it.
>>> + * Return 0 if we find a node referencing the passed node,
>>> + * or 1 if we don't.
>>> + */
>>> +static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
>>> +                   struct acpi_pptt_processor *node)
>>> +{
>>> +    struct acpi_subtable_header *entry;
>>> +    unsigned long table_end;
>>> +    u32 node_entry;
>>> +    struct acpi_pptt_processor *cpu_node;
>>> +
>>> +    table_end = (unsigned long)table_hdr + table_hdr->length;
>>> +    node_entry = ACPI_PTR_DIFF(node, table_hdr);
>>> +    entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
>>> +                 sizeof(struct acpi_table_pptt));
>>> +
>>> +    while ((unsigned long)(entry + 1) < table_end) {
>>
>> Is entry + 1 check sufficient to access entry of length ?
>> Shouldn't that be entry + sizeof(struct acpi_pptt_processor *) so that
>> we are sure it's valid entry ?
> 
> All we need is the subtable_header size which gives us the type/len. As
> we are just scanning the whole table touching the entry->length and the
> while() terminates if that is > table_end it should be ok. In general
> sizeof(acpi_pptt_processor) isn't right either since the structure only
> covers a larger "header" portion due to attached entries extending
> beyond it.

OK, understood. In that case it should be at least
entry + sizeof(struct acpi_subtable_header), no ?

I did a quick check and acpi_parse_entries_array does exactly same.
Does it make sense to keep it consistent with that ?

Also looking at acpi_parse_entries_array, I recall now that it has some
kind of handler to deal with such table parsing. I think we should be
able to reuse, I need to stare more at the code to see how :(.
Let me know if you already looked at that and found reasons not to use it.

>>> +        cpu_node = (struct acpi_pptt_processor *)entry;
>>> +        if ((entry->type == ACPI_PPTT_TYPE_PROCESSOR) &&
>>> +            (cpu_node->parent == node_entry))
>>> +            return 0;
>>> +        entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
>>> +                     entry->length);
>>> +    }
>>> +    return 1;
>>> +}
>>> +
>>> +/*
>>> + * Find the subtable entry describing the provided processor.
>>> + * This is done by iterating the PPTT table looking for processor nodes
>>> + * which have an acpi_processor_id that matches the acpi_cpu_id
>>> parameter
>>> + * passed into the function. If we find a node that matches this
>>> criteria
>>> + * we verify that its a leaf node in the topology rather than depending
>>> + * on the valid flag, which doesn't need to be set for leaf nodes.
>>> + */
>>> +static struct acpi_pptt_processor *acpi_find_processor_node(
>>> +    struct acpi_table_header *table_hdr,
>>> +    u32 acpi_cpu_id)
>>> +{
>>> +    struct acpi_subtable_header *entry;
>>> +    unsigned long table_end;
>>> +    struct acpi_pptt_processor *cpu_node;
>>> +
>>> +    table_end = (unsigned long)table_hdr + table_hdr->length;
>>> +    entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
>>> +                 sizeof(struct acpi_table_pptt));
>>> +
>>> +    /* find the processor structure associated with this cpuid */
>>> +    while ((unsigned long)(entry + 1) < table_end) {
>>
>> Same comment as above on entry + 
> This one is probably less clear than the one above, because we do access
> a full acpi_pptt_processor sized structure, but only after making sure
> that is actually a processor node. If anything the check should probably
> dereference the len as a second check aka
> 
> while ((entry+1 < table_end) && (entry+1->length < table_end))
> 
> I think this may have been changed after previous review comments asked
> for the cpu_node assignment earlier and of course moving the leaf_node
> check into the if condition to avoid a bit of extra processing.
> 

Makes sense.


>>> +/* Convert the linux cache_type to a ACPI PPTT cache type value */
>>> +static u8 acpi_cache_type(enum cache_type type)
>>> +{
>>
>> [nit] Just wondering if we can avoid this with some static mapping:
>>
>> static u8 acpi_cache_type[] = {
>>          [CACHE_TYPE_NONE] = 0,
>>          [CACHE_TYPE_DATA] = ACPI_PPTT_CACHE_TYPE_DATA,
>>          [CACHE_TYPE_INST] = ACPI_PPTT_CACHE_TYPE_INSTR,
>>          [CACHE_TYPE_UNIFIED] = ACPI_PPTT_CACHE_TYPE_UNIFIED,
>> };
> 
> Potentially, but the default case below is important and makes it a
> little less brittle because, as the recent DT commit, in your table
> TYPE_NONE actually needs to map to ACPI TYPE_UNIFIED to find the nodes.
> 

OK

> Doesn't matter much to me, and I would convert it if the switch() got a
> lot bigger, but right now I tend to think what the code actually would
> look like is a two entry conversion (data/instruction) with a default
> initially set. So a loop for two entries is borderline IMHO.
> 

Sure, that sounds good.


>>> +    /*
>>> +     * If all the above flags are valid, and the cache type is NOCACHE
>>> +     * update the cache type as well.
>>> +     */
>>
>> I am not sure if it makes sense to mandate at least last 2 (read allocate
>> and write policy). They can be optional.
> 
> As I mentioned in the previous set, I'm of the opinion that some are
> more useful than others, but to avoid having a discussion about which
> ones, just decided to do them all. After all, its not going to hurt
> (AFAIK).
> 

Sorry I missed to notice that.

> 
> If your more _sure_ and no one else has an opinion then i will remove
> those two.
>

That was just my opinion based on the possibility that some vendors
don't what to provide those information. We can wait until we come
across tables that have these missing.

-- 
Regards,
Sudeep
