From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] x86: make sure wakeup code is below 1M -v2
Date: Wed, 11 Nov 2009 21:21:36 -0800
Message-ID: <4AFB9B60.7010009__17309.4809674241$1258003433$gmane$org@kernel.org>
References: <4AF7D820.5040503@kernel.org> <200911091315.13151.rjw@sisk.pl>	
	<4AFA210B.3020207@kernel.org>	
	<1257930767.31183.113.camel@localhost.localdomain>	
	<4AFB0B02.4050306@kernel.org>	
	<1257988632.31183.134.camel@localhost.localdomain>	
	<4AFB7D21.6050004@kernel.org>
	<1257997072.3888.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1257997072.3888.4.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

ykzhao wrote:
> On Thu, 2009-11-12 at 11:12 +0800, Yinghai Lu wrote:
>> ykzhao wrote:
>>> On Thu, 2009-11-12 at 03:05 +0800, Yinghai Lu wrote:
>>>> ykzhao wrote:
>>>>> On Wed, 2009-11-11 at 10:27 +0800, Yinghai Lu wrote:
>>>>>> try to find_e820_area/reserve_early, and call acpi_reserve_memory early
>>>>>>
>>>>>> to get area is below 1M
>>>>>>
>>>>>> -v2: change function name to acpi_reserve_wakeup_memory according to Rafael
>>>>> It seems that the function of find_e820_area is called in several
>>>>> places.
>>>>>    >Initmem_init: bootmap = find_e820_area(0, end_pfn<<PAGE_SHIFT,
>>>>> bootmap_size, PAGE_SIZE);
>>>>>    
>>>>> If we also call it in the acpi_reserve_wakeup_memory, do we get the same
>>>>> base address as that obtained in initmem_init?
>>>> no. find_e820_area will check the reserve res array that could be updated by reserve_early.
>>> It will check the reserved region array when calling the function of
>>> find_e820_area. 
>>> But it seems that the array is not updated when the find_e820_area is
>>> called in the function of initmem_init.
>> right after that will use reserve_bootmem for those range in initmem_init.
> Yes. The reserve_bootmem is called for the range in initmem_init.
> But the reserved_early array is not updated.

it is not needed anymore because bootmem for that node is ready at that point, could use 
reserve_bootmem_node directly. and before that early_res_to_bootmem will convert that early resource that 
fall into that node range to bootmem reserved too.

please check code setup_node_bootmem/early_node_mem/early_res_to_bootmem ...and reserve_bootmem_node...

YH
