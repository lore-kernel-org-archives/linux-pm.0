From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] makedumpfile: exclude pages that are logically offline
Date: Wed, 21 Nov 2018 16:35:31 +0100
Message-ID: <e5ac1f79-cd69-2b8e-41ee-873fea48afdd@redhat.com>
References: <20181119101616.8901-1-david@redhat.com>
 <20181119101835.9140-1-david@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03561222@BPXM09GP.gisp.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03561222@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, kexec-ml <kexec@lists.infradead.org>, "pv-drivers@vmware.com" <pv-drivers@vmware.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
List-Id: linux-pm@vger.kernel.org

On 21.11.18 15:58, Kazuhito Hagio wrote:
> Hi David,
> 
>> Linux marks pages that are logically offline via a page flag (map count).
>> Such pages e.g. include pages infated as part of a balloon driver or
>> pages that were not actually onlined when onlining the whole section.
>>
>> While the hypervisor usually allows to read such inflated memory, we
>> basically read and dump data that is completely irrelevant. Also, this
>> might result in quite some overhead in the hypervisor. In addition,
>> we saw some problems under Hyper-V, whereby we can crash the kernel by
>> dumping, when reading memory of a partially onlined memory segment
>> (for memory added by the Hyper-V balloon driver).
>>
>> Therefore, don't read and dump pages that are marked as being logically
>> offline.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  makedumpfile.c | 34 ++++++++++++++++++++++++++++++----
>>  makedumpfile.h |  1 +
>>  2 files changed, 31 insertions(+), 4 deletions(-)
>>
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index 8923538..b8bfd4c 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -88,6 +88,7 @@ mdf_pfn_t pfn_cache_private;
>>  mdf_pfn_t pfn_user;
>>  mdf_pfn_t pfn_free;
>>  mdf_pfn_t pfn_hwpoison;
>> +mdf_pfn_t pfn_offline;
>>
>>  mdf_pfn_t num_dumped;
>>
>> @@ -249,6 +250,21 @@ isHugetlb(unsigned long dtor)
>>                      && (SYMBOL(free_huge_page) == dtor));
>>  }
>>
>> +static int
>> +isOffline(unsigned long flags, unsigned int _mapcount)
>> +{
>> +	if (NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) == NOT_FOUND_NUMBER)
>> +		return FALSE;
> 
> This is NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE), isn't it?
> If so, I will correct it when merging.
> 
> Otherwise, looks good to me.
> 
> Thanks!
> Kazu

Indeed,

I will most probably resend either way along with a new mm series!

Thanks a lot!


-- 

Thanks,

David / dhildenb
