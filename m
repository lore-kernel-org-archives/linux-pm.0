From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 0/6] mm/kdump: allow to exclude pages that are
 logically offline
Date: Thu, 15 Nov 2018 00:05:38 +0100
Message-ID: <63c5f4b6-828a-764e-f64d-e603dc4b104e@redhat.com>
References: <20181114211704.6381-1-david@redhat.com>
 <8932E1F4-A5A9-4462-9800-CAC1EF85AC5D@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8932E1F4-A5A9-4462-9800-CAC1EF85AC5D@vmware.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nadav Amit <namit@vmware.com>, linux-mm <linux-mm@kvack.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Christian Hansen <chansen3@cisco.com>, Dave Young <dyoung@redhat.com>, David Rientjes <rientjes@google.com>, Haiyang Zhang <haiyangz@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>, Ka
List-Id: linux-pm@vger.kernel.org

On 14.11.18 23:57, Nadav Amit wrote:
> From: David Hildenbrand
> Sent: November 14, 2018 at 9:16:58 PM GMT
>> Subject: [PATCH RFC 0/6] mm/kdump: allow to exclude pages that are logically offline
>>
>>
>> Right now, pages inflated as part of a balloon driver will be dumped
>> by dump tools like makedumpfile. While XEN is able to check in the
>> crash kernel whether a certain pfn is actuall backed by memory in the
>> hypervisor (see xen_oldmem_pfn_is_ram) and optimize this case, dumps of
>> virtio-balloon and hv-balloon inflated memory will essentially result in
>> zero pages getting allocated by the hypervisor and the dump getting
>> filled with this data.
> 
> Is there any reason that VMware balloon driver is not mentioned?

Definitely ...

... not ;) . I haven't looked at vmware's balloon driver yet (I only saw
that there was quite some activity recently). I guess it should have
similar problems. (I mean reading and dumping data nobody cares about is
certainly not desired)

Can you share if something like this is also desired for vmware's
implementation? (I tagged this as RFC to get some more feedback)

It should in theory be as simple as adding a handful of
_SetPageOffline()/_ClearPageOffline() at the right spots.

-- 

Thanks,

David / dhildenb
