From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] x86, acpi: Handle lapic/x2apic entries in MADT
Date: Wed, 26 Aug 2015 12:03:30 +0100
Message-ID: <715b878a9ec0652ac3af2dce4b89684d@www.loen.fr>
References: <20150802134014.380415cd@arm.com>
 <1438626365-23709-1-git-send-email-lukasz.anaczkowski@intel.com>
 <1438626365-23709-2-git-send-email-lukasz.anaczkowski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from shadow-play.misterjones.org ([91.121.53.221]:50827 "EHLO
	shadow-play.misterjones.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756539AbbHZLeH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2015 07:34:07 -0400
In-Reply-To: <1438626365-23709-2-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>

On 2015-08-03 19:26, Lukasz Anaczkowski wrote:
> v2: Fixed ARM64 syntax error
>
> From the ACPI spec:
> "Logical processors with APIC ID values less than 0xFF
> (whether in XAPIC or X2APIC mode) must use the Processor LAPIC
> structure [...]. Logical processors with APIC ID values 0xFF and
> greater must use the Processor Local x2APIC structure."
>
> Because of above, BIOS is first enumerating cores with HT with
> LAPIC values (<0xFF) and then rest with X2APIC values (>=0xFF).
>
> With current kernel code, where enumeration is in order:
> BSP, X2APIC, LAPIC
> enumeration on machine with more than 255 CPUs (each core with 4 HT)
> first X2APIC IDs get low logical CPU IDs (1..x) and then LAPIC IDs
> get higher logical CPU IDs (50..y), as in example below:
>
> Core LCpu  ApicId  LCpu   ApicId   LCpu  ApicId  LCpu  ApicId
> 0    0     0000     97    0001     145   0002    193   0003
> 1   50     0004     98    0005     146   0006    194   0007
> 2   51     0010     99    0011     147   0012    195   0013
> 3   52     0014    100    0015     148   0016    196   0017
> 4   53     0018    101    0019     149   001a    197   001b
> 5   54     001c    102    001d     150   001e    198   001f
> ...
> 62  95     00f8    143    00f9     191   00fa    239   00fb
> 63  37     00ff     96    00fc     144   00fd    192   00fe
> 64   1     0100     13    0101     25    0102     38   0103
> 65   2     0104     14    0105     26    0106     39   0107
> ...
>
> (Core - physical core, LCpu - logical CPU, ApicId - ID assigned
> by BIOS).
>
> This is wrong for the following reasons:
> () it's hard to predict how cores and threads will be enumerated
> () when it's hard to predict, s/w threads cannot be properly 
> affinitized
>    causing significant performance impact due to e.g. inproper cache
>    sharing
> () enumeration is inconsistent with how threads are enumerated on
>    other Intel Xeon processors
>
> To fix this, each LAPIC/X2APIC entry from MADT table needs to be
> handled at the same time when processing it, thus adding
> acpi_subtable_proc structure which stores
> () ACPI table id
> () handler that processes table
> () counter how many items has been processed
> and passing it to acpi_table_parse_entries().
>
> Also, order in which MADT LAPIC/X2APIC handlers are passed is
> reversed to achieve correct CPU enumeration.
>
> In scenario when someone boots kernel with options 'maxcpus=72 
> nox2apic',
> in result less cores may be booted, since some of the CPUs the kernel
> will try to use will have APIC ID >= 0xFF. In such case, one
> should not pass 'nox2apic'.
>
> Disclimer: code parsing MADT LAPIC/X2APIC has not been touched since 
> 2009,
> when X2APIC support was initially added. I do not know why MADT 
> parsing
> code was added in the reversed order in the first place.
> I guess it didn't matter at that time since nobody cared about cores
> with APIC IDs >= 0xFF, right?
>
> This patch is based on work of "Yinghai Lu <yinghai@kernel.org>"
> previously published at https://lkml.org/lkml/2013/1/21/563,
> thus putting Yinghai Lu as 'Signed-off-by', as well.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Signed-off-by: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>

It looked good, but I then made the mistake to actually try it. Bad 
idea:

[...]
RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=6
NR_IRQS:64 nr_irqs:64 0
No valid GICC entries exist
ACPI: Failed to initialize GIC IRQ controller
Kernel panic - not syncing: No interrupt controller found.
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.2.0-rc8+ #4623
Hardware name: ARM Juno development board (r1) (DT)
Call trace:
[<ffffffc000089960>] dump_backtrace+0x0/0x124
[<ffffffc000089a94>] show_stack+0x10/0x1c
[<ffffffc000658968>] dump_stack+0x84/0xc8
[<ffffffc0006577d8>] panic+0xe0/0x220
[<ffffffc0008cd2f4>] init_IRQ+0x20/0x2c
[<ffffffc0008cb850>] start_kernel+0x260/0x3b8
---[ end Kernel panic - not syncing: No interrupt controller found.

Reverting the patch makes the machine boot again. As I presume you 
don't have access to such a box, I'll try to investigate it shortly.

Thanks,

         M.
-- 
Fast, cheap, reliable. Pick two.
