From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 3/6] kexec: export PG_offline to VMCOREINFO
Date: Thu, 15 Nov 2018 13:01:17 +0100
Message-ID: <9d19a844-9ae0-9520-c32a-0a4491f8de43@redhat.com>
References: <20181114211704.6381-1-david@redhat.com>
 <20181114211704.6381-4-david@redhat.com>
 <20181115061923.GA3971@dhcp-128-65.nay.redhat.com>
 <20181115111023.GC26448@zn.tnic>
 <4aa5d39d-a923-87de-d646-70b9cbfe62f0@redhat.com>
 <20181115115213.GE26448@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115115213.GE26448@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Young <dyoung@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Baoquan He <bhe@redhat.com>, Omar Sandoval <osandov@fb.com>, Arnd Bergmann <arnd@arndb.de>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, Lianbo Jiang <lijiang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: linux-pm@vger.kernel.org

On 15.11.18 12:52, Borislav Petkov wrote:
> On Thu, Nov 15, 2018 at 12:20:40PM +0100, David Hildenbrand wrote:
>> Sorry to say, but that is the current practice without which
>> makedumpfile would not be able to work at all. (exclude user pages,
>> exclude page cache, exclude buddy pages). Let's not reinvent the wheel
>> here. This is how dumping works forever.
> 
> Sorry, but "we've always done this in the past" doesn't make it better.

Just saying that "I'm not the first to do it, don't hit me with a stick" :)

> 
>> I don't see how there should be "set of pages which do not have
>> PG_offline".
> 
> It doesn't have to be a set of pages. Think a (mmconfig perhaps) region
> which the kdump kernel should completely skip because poking in it in
> the kdump kernel, causes all kinds of havoc like machine checks. etc.
> We've had and still have one issue like that.

Indeed. And we still have without makedumpfile. I think you are aware of
this, but I'll explain it just for consistency: PG_hwpoison

At some point we detect a HW error and mask a page as PG_hwpoison.

makedumpfile knows how to treat that flag and can exclude it from the
dump (== not access it). No crash.

kdump itself has no clue about old "struct pages". Especially:
a) Where they are located in memory (e.g. SPARSE)
b) What their format is ("where are the flags")
c) What the meaning of flags is ("what does bit X mean")

In order to know such information, we would have to do parsing of quite
some information inside the kernel in kdump. Basically what makedumpfile
does just now. Is this feasible? I don't think so.

So we would need another approach to communicate such information as you
said. I can't think of any, but if anybody reading this has an idea,
please speak up. I am interested.


The *only* way right now we would have to handle such scenarios:

1. While dumping memory and we get a machine check, fake reading a zero
page instead of crashing.
2. While dumping memory and we get a fault, fake reading a zero page
instead of crashing.

> 
> But let me clarify my note: I don't want to be discussing with you the
> design of makedumpfile and how it should or should not work - that ship
> has already sailed. Apparently there are valid reasons to do it this
> way.

Indeed, and the basic design is to export these flags. (let's say
"unfortunately", being able to handle such stuff in kdump directly would
be the dream).

> I was *simply* stating that it feels wrong to export mm flags like that.
> 
> But as I said already, that is mm guys' call and looking at how we're
> already exporting a bunch of stuff in the vmcoreinfo - including other
> mm flags - I guess one more flag doesn't matter anymore.

Fair enough, noted. If you have an idea how to handle this in kdump,
please let me know.

-- 

Thanks,

David / dhildenb
