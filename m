From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 2/6] mm: convert PG_balloon to PG_offline
Date: Wed, 14 Nov 2018 23:49:15 +0100
Message-ID: <b4668081-5aa3-d7f5-6880-d01c75cfc6ae@redhat.com>
References: <20181114211704.6381-1-david@redhat.com>
 <20181114211704.6381-3-david@redhat.com>
 <20181114222321.GB1784@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114222321.GB1784@bombadil.infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org, Jonathan Corbet <corbet@lwn.net>, Alexey Dobriyan <adobriyan@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Christian Hansen <chansen3@cisco.com>, Vlastimil Babka <vbabka@suse.cz>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Miles Chen <miles.chen@mediatek.>
List-Id: linux-pm@vger.kernel.org

On 14.11.18 23:23, Matthew Wilcox wrote:
> On Wed, Nov 14, 2018 at 10:17:00PM +0100, David Hildenbrand wrote:
>> Rename PG_balloon to PG_offline. This is an indicator that the page is
>> logically offline, the content stale and that it should not be touched
>> (e.g. a hypervisor would have to allocate backing storage in order for the
>> guest to dump an unused page).  We can then e.g. exclude such pages from
>> dumps.
>>
>> In following patches, we will make use of this bit also in other balloon
>> drivers.  While at it, document PGTABLE.
> 
> Thank you for documenting PGTABLE.  I didn't realise I also had this
> document to update when I added PGTABLE.

Thank you for looking into this :)

> 
>> +++ b/Documentation/admin-guide/mm/pagemap.rst
>> @@ -78,6 +78,8 @@ number of times a page is mapped.
>>      23. BALLOON
>>      24. ZERO_PAGE
>>      25. IDLE
>> +    26. PGTABLE
>> +    27. OFFLINE
> 
> So the offline *user* bit is new ... even though the *kernel* bit
> just renames the balloon bit.  I'm not sure how I feel about this.
> I'm going to think about it some more.  Could you share your decision
> process with us?

BALLOON was/is documented as

"23 - BALLOON
    balloon compaction page
"

and only includes all virtio-ballon pages after the non-lru migration
feature has been implemented for ballooned pages. Since then, this flag
does basically no longer stands for what it actually was supposed to do.

To not break uapi I decided to not rename it but instead to add a new flag.

> 
> I have no objection to renaming the balloon bit inside the kernel; I
> think that's a wise idea.  I'm just not sure whether we should rename
> the user balloon bit rather than adding a new bit.
> 

Can we rename without breaking uapi?

-- 

Thanks,

David / dhildenb
