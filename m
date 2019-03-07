From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] makedumpfile: exclude pages that are logically offline
Date: Thu, 7 Mar 2019 09:41:15 +0100
Message-ID: <7c9d6d5c-d6cf-00a7-7f23-bf28cbb382af@redhat.com>
References: <20181122100627.5189-1-david@redhat.com>
 <20181122100938.5567-1-david@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03561800@BPXM09GP.gisp.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03561800@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, kexec-ml <kexec@lists.infradead.org>, "pv-drivers@vmware.com" <pv-drivers@vmware.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
List-Id: linux-pm@vger.kernel.org

On 27.11.18 17:32, Kazuhito Hagio wrote:
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
> 
> Thanks for the v2 update.
> I'm going to merge this patch after the kernel patches are merged
> and it tests fine with the kernel.
> 
> Kazu

Hi Kazu,

the patches are now upstream. Thanks!

-- 

Thanks,

David / dhildenb
