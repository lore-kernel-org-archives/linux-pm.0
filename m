From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 4/8] xen/balloon: mark inflated pages PG_offline
Date: Mon, 19 Nov 2018 14:07:18 +0100
Message-ID: <554d4e68-8fa9-6849-8480-fc9446bea79d@redhat.com>
References: <20181119101616.8901-1-david@redhat.com>
 <20181119101616.8901-5-david@redhat.com>
 <fc69e0cf-c005-472a-b3f6-09d0c963cf52@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <fc69e0cf-c005-472a-b3f6-09d0c963cf52@suse.com>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Juergen Gross <jgross@suse.com>, linux-mm@kvack.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, linux-pm@vger.kernel.org, pv-drivers@vmware.com, linux-doc@vger.kernel.org, kexec-ml <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>, xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, devel@linuxdriverproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 19.11.18 13:22, Juergen Gross wrote:
> On 19/11/2018 11:16, David Hildenbrand wrote:
>> Mark inflated and never onlined pages PG_offline, to tell the world that
>> the content is stale and should not be dumped.
>>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  drivers/xen/balloon.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
>> index 12148289debd..14dd6b814db3 100644
>> --- a/drivers/xen/balloon.c
>> +++ b/drivers/xen/balloon.c
>> @@ -425,6 +425,7 @@ static int xen_bring_pgs_online(struct page *pg, unsigned int order)
>>  	for (i = 0; i < size; i++) {
>>  		p = pfn_to_page(start_pfn + i);
>>  		__online_page_set_limits(p);
>> +		__SetPageOffline(p);
>>  		__balloon_append(p);
>>  	}
> 
> This seems not to be based on current master. Could you please tell
> against which tree this should be reviewed?
> 
Hi Juergen,

this is based on linux-next/master.

Thanks!

> 
> Juergen
> 


-- 

Thanks,

David / dhildenb
