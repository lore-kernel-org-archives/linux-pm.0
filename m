From: Cody P Schafer <cody@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 14/15] mm: Add alloc-free handshake to trigger
 memory region compaction
Date: Wed, 10 Apr 2013 16:26:00 -0700
Message-ID: <5165F508.4020207@linux.vnet.ibm.com>
References: <20130409214443.4500.44168.stgit@srivatsabhat.in.ibm.com> <20130409214853.4500.63619.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20130409214853.4500.63619.stgit@srivatsabhat.in.ibm.com>
Sender: owner-linux-mm@kvack.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: akpm@linux-foundation.org, mgorman@suse.de, matthew.garrett@nebula.com, dave@sr71.net, rientjes@google.com, riel@redhat.com, arjan@linux.intel.com, srinivas.pandruvada@linux.intel.com, maxime.coquelin@stericsson.com, loic.pallardy@stericsson.com, kamezawa.hiroyu@jp.fujitsu.com, lenb@kernel.org, rjw@sisk.pl, gargankita@gmail.com, paulmck@linux.vnet.ibm.com, amit.kachhap@linaro.org, svaidy@linux.vnet.ibm.com, andi@firstfloor.org, wujianguo@huawei.com, kmpark@infradead.org, thomas.abraham@linaro.org, santosh.shilimkar@ti.com, linux-pm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/09/2013 02:48 PM, Srivatsa S. Bhat wrote:
> We need a way to decide when to trigger the worker threads to perform
> region evacuation/compaction. So the strategy used is as follows:
>
> Alloc path of page allocator:
> ----------------------------
>
> This accurately tracks the allocations and detects the first allocation
> in a new region and notes down that region number. Performing compaction
> rightaway is not going to be helpful because we need free pages in the
> lower regions to be able to do that. And the page allocator allocated in
> this region precisely because there was no memory available in lower regions.
> So the alloc path just notes down the freshly used region's id.
>
> Free path of page allocator:
> ---------------------------
>
> When we enter this path, we know that some memory is being freed. Here we
> check if the alloc path had noted down any region for compaction. If so,
> we trigger the worker function that tries to compact that memory.
>
> Also, we avoid any locking/synchronization overhead over this worker
> function in the alloc/free path, by attaching appropriate semantics to the
> available status flags etc, such that we won't need any special locking
> around them.
>

Can you explain why avoiding locking works in this case?

It appears the lack of locking is only on the worker side, and the 
mem_power_ctrl is implicitly protected by zone->lock on the alloc & free 
side.

In the previous patch I see smp_mb(), but no explanation is provided for 
why they are needed. Are they related to/necessary for this lack of locking?

What happens when a region is passed over for compaction because the 
worker is already compacting another region? Can this occur? Will the 
compaction re-trigger appropriately?

I recommend combining this patch and the previous patch to make the 
interface more clear, or make functions that explicitly handle the 
interface for accessing mem_power_ctrl.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
