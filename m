From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 6/6] PM / Hibernate: exclude all PageOffline() pages
Date: Thu, 15 Nov 2018 13:29:44 +0100
Message-ID: <2e94148a-514f-0e18-5103-0e3ae342b3c9@redhat.com>
References: <20181114211704.6381-1-david@redhat.com>
 <20181114211704.6381-7-david@redhat.com>
 <20181115122302.GR23831@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115122302.GR23831@dhcp22.suse.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: linux-pm@vger.kernel.org

On 15.11.18 13:23, Michal Hocko wrote:
> On Wed 14-11-18 22:17:04, David Hildenbrand wrote:
> [...]
>> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
>> index b0308a2c6000..01db1d13481a 100644
>> --- a/kernel/power/snapshot.c
>> +++ b/kernel/power/snapshot.c
>> @@ -1222,7 +1222,7 @@ static struct page *saveable_highmem_page(struct zone *zone, unsigned long pfn)
>>  	BUG_ON(!PageHighMem(page));
>>  
>>  	if (swsusp_page_is_forbidden(page) ||  swsusp_page_is_free(page) ||
>> -	    PageReserved(page))
>> +	    PageReserved(page) || PageOffline(page))
>>  		return NULL;
>>  
>>  	if (page_is_guard(page))
>> @@ -1286,6 +1286,9 @@ static struct page *saveable_page(struct zone *zone, unsigned long pfn)
>>  	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
>>  		return NULL;
>>  
>> +	if (PageOffline(page))
>> +		return NULL;
>> +
>>  	if (PageReserved(page)
>>  	    && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
>>  		return NULL;
> 
> Btw. now that you are touching this file could you also make
> s@pfn_to_page@pfn_to_online_page@ please? We really do not want to touch
> offline pfn ranges in general. A separate patch for that of course.
> 
> Thanks!
> 

Sure thing, will look into that!

Thanks!

-- 

Thanks,

David / dhildenb
