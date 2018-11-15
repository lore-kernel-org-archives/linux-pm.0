From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 3/6] kexec: export PG_offline to VMCOREINFO
Date: Thu, 15 Nov 2018 10:23:13 +0100
Message-ID: <685892a9-3a56-8e8c-dbe7-8b1159067a6b@redhat.com>
References: <20181114211704.6381-1-david@redhat.com>
 <20181114211704.6381-4-david@redhat.com>
 <20181115061923.GA3971@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20181115061923.GA3971@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>, linux-pm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, Borislav Petkov <bp@alien8.de>, xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, devel@linuxdriverproject.org, Andrew Morton <akpm@linux-foundation.org>, Omar Sandoval <osandov@fb.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lianbo Jiang <lijiang@redhat.com>
List-Id: linux-pm@vger.kernel.org

On 15.11.18 07:19, Dave Young wrote:
> Hi David,
> 
> On 11/14/18 at 10:17pm, David Hildenbrand wrote:
>> Let's export PG_offline via PAGE_OFFLINE_MAPCOUNT_VALUE, so
>> makedumpfile can directly skip pages that are logically offline and the
>> content therefore stale.
> 
> It would be good to copy some background info from cover letter to the
> patch description so that we can get better understanding why this is
> needed now.

Yes, will add more detail!

> 
> BTW, Lianbo is working on a documentation of the vmcoreinfo exported
> fields. Ccing him so that he is aware of this.
> 
> Also cc Boris,  although I do not want the doc changes blocks this
> he might have different opinion :)

I'll be happy to help updating documentation (or updating it myself if
the doc updates go in first).

-- 

Thanks,

David / dhildenb
