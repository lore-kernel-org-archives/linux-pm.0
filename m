From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: Re: [PATCH v3 1/7] ACPI/PPTT: Add Processor Properties Topology Table
 parsing
Date: Wed, 18 Oct 2017 09:10:22 +0800
Message-ID: <c6132eec-3c32-8471-76ab-6ec432b7b3f1@huawei.com>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
 <20171012194856.13844-2-jeremy.linton@arm.com>
 <38c63cfd-4c13-9461-0d4a-74b0943be0fd@semihalf.com>
 <2ce92b90-fc2c-3fff-a3e3-b9517057ab2c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2ce92b90-fc2c-3fff-a3e3-b9517057ab2c@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, Tomasz Nowicki <tn@semihalf.com>, linux-acpi@vger.kernel.org
Cc: mark.rutland@arm.com, Jonathan.Zhang@cavium.com, Jayachandran.Nair@cavium.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, jhugo@codeaurora.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ahs3@redhat.com, viresh.kumar@linaro.org, hanjun.guo@linaro.org, sudeep.holla@arm.com, austinwc@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Jeremy,


On 2017/10/17 23:22, Jeremy Linton wrote:
> Hi,
>
> On 10/17/2017 08:25 AM, Tomasz Nowicki wrote:
>> Hi Jeremy,
>>
>> I did second round of review and have some more comments, please see below:
>>
>> On 12.10.2017 21:48, Jeremy Linton wrote:
> I disagree, that routine is shared by the two code paths because its functionality is 99% duplicated between the two. The difference being whether it terminates the search at a given level, or continues searching until it runs out of nodes. The latter case is simply a degenerate version of the first.
>
>
>>
>> Also, seems like we can merge acpi_parse_pptt() & acpi_process_node().
>
> That is true, but I fail to see how any of this is actually fixes anything. There are a million ways to do this, including as pointed out by building another data-structure to simplify the parsing what is a table that is less than ideal for runtime parsing (starting with the direction of the relative pointers, and ending with having to "infer" information that isn't directly flagged). I actually built a couple other versions of this, including a nice cute version which is about 1/8 this size of this and really easy to understand but of course is recursive...
>
>
Maybe you can see my version below. It is similar to what you said above. It may give some help.
https://github.com/fenghusthu/acpi_pptt

Thanks
Xiongfeng Wang
>>
>> Here are my suggestions:
>>
>>
>> static struct acpi_pptt_cache *acpi_pptt_cache_type_level(
>>      struct acpi_table_header *table_hdr,
>>      struct acpi_subtable_header *res,
>>      int *local_level,
>>      int level, int type)
>> {
>>      struct acpi_pptt_cache *cache = (struct acpi_pptt_cache *) res;
>>
>>      if (res->type != ACPI_PPTT_TYPE_CACHE)
>>          return NULL;
>>
>>      while (cache) {
>>          if ((*local_level == level) &&
>>              (cache->flags & ACPI_PPTT_CACHE_TYPE_VALID) &&
>>              ((cache->attributes & ACPI_PPTT_MASK_CACHE_TYPE) >> 2 == type)) {
>>
>>              pr_debug("Found cache @ level %d\n", level);
>>              return cache;
>>          }
>>          cache = fetch_pptt_cache(table_hdr, cache->next_level_of_cache);
>>          (*local_level)++;
>>      }
>>      return NULL;
>> }
>>
>> static struct acpi_pptt_cache *_acpi_find_cache_node(
>>      struct acpi_table_header *table_hdr,
>>      struct acpi_pptt_processor *cpu_node,
>>      int *local_level, int level, int type)
>> {
>>      struct acpi_subtable_header *res;
>>      struct acpi_pptt_cache *cache_tmp, *cache = NULL;
>>      int resource = 0;
>>
>>      /* walk down from the processor node */
>>      while ((res = acpi_get_pptt_resource(table_hdr, cpu_node, resource))) {
>>
>>          cache_tmp = acpi_pptt_cache_type_level(table_hdr, res,
>>                                 local_level, level, type);
>>          if (cache_tmp) {
>>              if (cache)
>>                  pr_err("Found duplicate cache level/type unable to determine uniqueness\n");
>>
>>              cache = cache_tmp;
>>          }
>>          resource++;
>>      }
>>      return cache;
>> }
>>
>> /* find the ACPI node describing the cache type/level for the given CPU */
>> static struct acpi_pptt_cache *acpi_find_cache_node(
>>      struct acpi_table_header *table_hdr, u32 acpi_cpu_id,
>>      enum cache_type type, unsigned int level,
>>      struct acpi_pptt_processor **node)
>> {
>>      int total_levels = 0;
>>      struct acpi_pptt_cache *found = NULL;
>>      struct acpi_pptt_processor *cpu_node;
>>      u8 acpi_type = acpi_cache_type(type);
>>
>>      pr_debug("Looking for CPU %d's level %d cache type %d\n",
>>           acpi_cpu_id, level, acpi_type);
>>
>>      cpu_node = acpi_find_processor_node(table_hdr, acpi_cpu_id);
>>      if (!cpu_node)
>>          return NULL;
>>
>>      do {
>>          found = _acpi_find_cache_node(table_hdr, cpu_node,
>>                            &total_levels, level, acpi_type);
>>          *node = cpu_node;
>>          cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
>>      } while ((cpu_node) && (!found));
>>
>>      return found;
>> }
>>
>> static int acpi_pptt_cache_level(struct acpi_table_header *table_hdr,
>>                  struct acpi_subtable_header *res)
>> {
>>      struct acpi_pptt_cache *cache = (struct acpi_pptt_cache *) res;
>>      int local_level = 1;
>>
>>      if (res->type != ACPI_PPTT_TYPE_CACHE)
>>          return 0;
>>
>>      while ((cache = fetch_pptt_cache(table_hdr, cache->next_level_of_cache)))
>>          local_level++;
>>      return local_level;
>> }
>>
>> static int _acpi_count_cache_level(
>>      struct acpi_table_header *table_hdr,
>>      struct acpi_pptt_processor *cpu_node)
>> {
>>      struct acpi_subtable_header *res;
>>      int levels = 0, resource = 0, number_of_levels = 0;
>>
>>      /* walk down from the processor node */
>>      while ((res = acpi_get_pptt_resource(table_hdr, cpu_node, resource))) {
>>          levels = acpi_pptt_cache_level(table_hdr, res);
>>
>>          /*
>>           * we are looking for the max depth. Since its potentially
>>           * possible for a given node to have resources with differing
>>           * depths verify that the depth we have found is the largest.
>>           */
>>          if (levels > number_of_levels)
>>              number_of_levels = levels;
>>
>>          resource++;
>>      }
>>      return number_of_levels;
>> }
>>
>> static int acpi_count_cache_level(struct acpi_table_header *table_hdr,
>>                    u32 acpi_cpu_id)
>> {
>>      int total_levels = 0;
>>      struct acpi_pptt_processor *cpu_node;
>>
>>      cpu_node = acpi_find_processor_node(table_hdr, acpi_cpu_id);
>>      while (cpu_node) {
>>          total_levels += _acpi_count_cache_level(table_hdr, cpu_node);
>>          cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
>>      }
>>
>>      return total_levels;
>> }
>>
>>
>> Did not compile the code so I may have missed somthing.
>>
>> Thanks,
>> Tomasz
>
>
> .
>
