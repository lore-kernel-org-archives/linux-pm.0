From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 3/6] kexec: export PG_offline to VMCOREINFO
Date: Thu, 15 Nov 2018 12:20:40 +0100
Message-ID: <4aa5d39d-a923-87de-d646-70b9cbfe62f0@redhat.com>
References: <20181114211704.6381-1-david@redhat.com>
 <20181114211704.6381-4-david@redhat.com>
 <20181115061923.GA3971@dhcp-128-65.nay.redhat.com>
 <20181115111023.GC26448@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20181115111023.GC26448@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, "Michael S. Tsirkin" <mst@redhat.com>, xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, devel@linuxdriverproject.org, Andrew Morton <akpm@linux-foundation.org>, Omar Sandoval <osandov@fb.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lianbo Jiang <lijiang@redhat.com>
List-Id: linux-pm@vger.kernel.org

On 15.11.18 12:10, Borislav Petkov wrote:
> On Thu, Nov 15, 2018 at 02:19:23PM +0800, Dave Young wrote:
>> It would be good to copy some background info from cover letter to the
>> patch description so that we can get better understanding why this is
>> needed now.
>>
>> BTW, Lianbo is working on a documentation of the vmcoreinfo exported
>> fields. Ccing him so that he is aware of this.
>>
>> Also cc Boris,  although I do not want the doc changes blocks this
>> he might have different opinion :)
> 
> Yeah, my initial reaction is that exporting an mm-internal flag to
> userspace is a no-no.

Sorry to say, but that is the current practice without which
makedumpfile would not be able to work at all. (exclude user pages,
exclude page cache, exclude buddy pages). Let's not reinvent the wheel
here. This is how dumping works forever.

Also see how hwpoisoned pages are handled.

(please note that most distributions only support dumping via
makedumpfile, for said reasons)

> 
> What would be better, IMHO, is having a general method of telling the
> kdump kernel - maybe ranges of physical addresses - which to skip.

And that has to be updated whenever we change a page flag. But then the
dump kernel would have to be aware about "struct page" location and
format of some old kernel to be dump. Let's just not even discuss going
down that path.

> 
> Because the moment there's a set of pages which do not have PG_offline
> set but kdump would still like to skip, this breaks.

I don't understand your concern. PG_offline is only an optimization for
sections that are online. Offline sections can already be completely
ignored when dumping.

I don't see how there should be "set of pages which do not have
PG_offline". I mean if they don't have PG_offline they will simply be
dumped like before. Which worked forever. Sorry, I don't get your point.

-- 

Thanks,

David / dhildenb
