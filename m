From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] x86: make sure wakeup code is below 1M -v2
Date: Thu, 12 Nov 2009 11:25:49 -0800
Message-ID: <4AFC613D.2060808__16716.2325968549$1258054110$gmane$org@kernel.org>
References: <4AF7D820.5040503@kernel.org> <200911091315.13151.rjw@sisk.pl>
	<4AFA210B.3020207@kernel.org> <20091112073616.GA11365@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091112073616.GA11365@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> On Tue 2009-11-10 18:27:23, Yinghai Lu wrote:
>> try to find_e820_area/reserve_early, and call acpi_reserve_memory early
>>
>> to get area is below 1M
> 
>> -	acpi_realmode = (unsigned long)alloc_bootmem_low(WAKEUP_SIZE);
>> +	mem = find_e820_area(0, 1<<20, WAKEUP_SIZE, PAGE_SIZE);
>>  
>> -	if (!acpi_realmode) {
>> +	if (mem == -1L) {
>>  		printk(KERN_ERR "ACPI: Cannot allocate lowmem, S3 disabled.\n");
>>  		return;
>>  	}
> 
> How is it better then old code?

could get range below 1M.

alloc_bootmem_low can not make sure get that below 1M.

init_memory_mapping could use below 1M as page table...

so need to get some buffer for acpi wakeup realmode code.

YH
