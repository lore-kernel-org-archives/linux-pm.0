From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 00/10] mm: Linux VM Infrastructure to support
 Memory Power Management
Date: Thu, 7 Jul 2011 21:00:44 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.1107072058390.5978__25586.2000085928$1310063233$gmane$org@tiger>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<20110629130038.GA7909@in.ibm.com>
	<CAOJsxLHQP=-srK_uYYBsPb7+rUBnPZG7bzwtCd-rRaQa4ikUFg@mail.gmail.com>
	<alpine.DEB.2.02.1107061318190.2535@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.02.1107061318190.2535@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linux-kernel@vger.kernel.org, Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org, thomas.abraham@linaro.org, Ankita Garg <ankita@in.ibm.com>, linux-pm@lists.linux-foundation.org, Christoph Lameter <cl@linux.com>, linux-arm-kernel@lists.infradead.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 6 Jul 2011, Pekka Enberg wrote:
>> Why does the allocator need to know about address boundaries? Why
>> isn't it enough to make the page allocator and reclaim policies favor using
>> memory from lower addresses as aggressively as possible? That'd mean
>> we'd favor the first memory banks and could keep the remaining ones
>> powered off as much as possible.
>> 
>> IOW, why do we need to support scenarios such as this:
>>
>>   bank 0     bank 1   bank 2    bank3
>> | online  | offline | online  | offline |
>
On Wed, 6 Jul 2011, david@lang.hm wrote:
> I believe that there are memory allocations that cannot be moved after they 
> are made (think about regions allocated to DMA from hardware where the 
> hardware has already been given the address space to DMA into)
>
> As a result, you may not be able to take bank 2 offline, so your option is to 
> either leave banks 0-2 all online, or support emptying bank 1 and taking it 
> offline.

But drivers allocate DMA memory for hardware during module load and stay 
pinned there until the driver is unloaded, no? So in practice DMA buffers 
are going to be in banks 0-1?

 				Pekka
