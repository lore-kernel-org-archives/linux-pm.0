From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][RFC] x86, hotplug: Use zero page for monitor when
 resuming from hibernation
Date: Tue, 7 Jun 2016 16:44:24 +0800
Message-ID: <57568968.2090100@intel.com>
References: <1465222749-8388-1-git-send-email-yu.c.chen@intel.com>
 <20160607080307.GB13858@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160607080307.GB13858@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Zhu Guihua <zhugh.fnst@cn.fujitsu.com>, Juergen Gross <jgross@suse.com>, "Zheng, Lv" <lv.zheng@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Pavel,

On 2016=E5=B9=B406=E6=9C=8807=E6=97=A5 16:03, Pavel Machek wrote:
> On Mon 2016-06-06 22:19:09, Chen Yu wrote:
>> Stress test from Varun Koyyalagunta reports that, the
>> nonboot CPU would hang occasionally, when resuming from
>> hibernation. Further investigation shows that, the precise
>> phase when nonboot CPU hangs, is the time when the nonboot
>> CPU been woken up incorrectly, and tries to monitor the
>> mwait_ptr for the second time, then an exception is
>> triggered due to illegal vaddr access, say, something like,
>> 'Unable to handler kernel address of 0xffff8800ba800010...'
>>
>> One of the possible scenarios for this issue is illustrated below,
>> when the boot CPU tries to resume from hibernation:
>> 1. puts the nonboot CPUs offline, so the nonboot CPUs are monitoring
>>     at the address of the task_struct.flags.
>> 2. boot CPU copies pages to their original address, which includes
>>     task_struct.flags, thus wakes up one of the nonboot CPUs.
>> 3. nonboot CPU tries to monitor the task_struct.flags again, but sin=
ce
>>     the page table for task_struct.flags has been overwritten by
>>     boot CPU, and there is probably a changed across hibernation
>>     (because of inconsistence of e820 memory map), an exception is
>>     triggered.
> If memory map changes between suspend and resume, there'll be fun. If
> that's suspected, should we attach md5 sum of e820 to the hibernation
> image?
Actually what I described  in the  scenario might be not so accurate,
it might not be related to inconsistence of e820 map,
because there is no guarantee that boot kernel and resume kernel
have the same memory layout(page table).

I've re-checked the logs from reporter, it seems that, the fault
access is caused by accessing a page without PRESENT flag,
and the pte entry for this vaddr is zero:

    // DATA ADDRESS TRANSLATION, virtual address =3D 0xFFFF8800BA803E88
    //   DATA TABLE WALK, virtual address =3D 0xFFFF8800BA803E88
    pml4read   0x0001C12880    0x01FD2067; // pgd
    pdptread   0x0001FD2010    0x9BEBF063; // pud
    pderead    0x009BEBFEA0    0x2D9D9063; // pmd
    pteread    0x002D9D9018    0x00000000; // pte

The last line above is a pte entry located at physical address 0x2d9d90=
18,
with value zero, thus access to this vaddr results in a page-not-presen=
t exception.


Since some of the pud/pde/pte are allocated dynamically during bootup
(kernel_physical_mapping_init),
it is possible that, when the boot cpu writes to this vaddr,
the page table(especially for pud/pmd/pte) for this vaddr
are not the same as it is before hibernation,  thus an exception would =
be
triggered due to incorrect page table, even e820 is consistent.

I'm doing more test to verify this.

thanks,
Yu
