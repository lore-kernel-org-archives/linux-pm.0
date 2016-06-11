From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: PROBLEM: Resume form hibernate broken by setting NX on gap
Date: Sat, 11 Jun 2016 10:35:32 -0600
Message-ID: <575C3DD4.40806@deltatee.com>
References: <573DF82D.50006@deltatee.com> <19310985.zBnH00loSf@vostro.rjw.lan>
 <2597967.kdkjeIcHno@vostro.rjw.lan> <2614999.LIbMBxYypT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:57852 "EHLO ale.deltatee.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752598AbcFKQfr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 11 Jun 2016 12:35:47 -0400
In-Reply-To: <2614999.LIbMBxYypT@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kees Cook <keescook@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>

Hey Rafael,

Thank for looking into this. I tried the patch below applied to v4.6 and 
I still got a lockup on resume. Additionally there was a kernel warning 
at arch/x86/mm/pageattr.c:1414 change_page_attr_set_clr+0x2bb/0x440 and 
another one right afterwards at kernel/smp.c:416 
smp_call_function_many+0xb5/0x250.

Regardless, Ill try the other patch you sent shortly.

Logan

On 11/06/16 05:48 AM, Rafael J. Wysocki wrote:
> On Saturday, June 11, 2016 03:47:59 AM Rafael J. Wysocki wrote:
>> On Saturday, June 11, 2016 02:13:45 AM Rafael J. Wysocki wrote:
>>> On Saturday, June 11, 2016 12:33:31 AM Rafael J. Wysocki wrote:
>>>> On Friday, June 10, 2016 04:28:01 PM Logan Gunthorpe wrote:
>>>>>
>>>>> On 10/06/16 04:29 PM, Rafael J. Wysocki wrote:
>>>>>> OK, I have a theory, but I need a bit of help.
>>>>>>
>>>>>> This may be a dumb question, but I don't quite remember the answer readily.
>>>>>>
>>>>>> Given a physical address, how do I get the corresponding virtual one under
>>>>>> the kernel identity mapping?
>>>>>
>>>>> Is that not just 'phys_to_virt(x)'??
>>>>
>>>> Ah that.  Thanks!
>>>
>>> So first, appended is a cleanup of the 64-bit hibernate/restore code that hopefully
>>> will make it a bit clearer what happens there.
>>>
>>> In particular, it follows from it quite clearly that the restore will only work
>>> if the virtual address of the trampoline (&restore_registers) in the image
>>> kernel happens to match the virtual address of the same chunk of memory in the
>>> boot kernel (and after it has switched to the temporary page tables).
>>>
>>> That appears to be the case most of the time, or hibernation would randomly
>>> break for people all over, but I'm not actually sure if that's guaranteed to
>>> happen.  If not, that very well may explain unexpected failures in there.
>>>
>>> If it is not guaranteed to happen, the solution would be to pass the physical
>>> address of that memory from the image kernel to the boot kernel instead of its
>>> virtual address,
>>
>> OK, the appended patch does the trick for me.
>>
>> Logan, can you please try it?  It shouldn't break things, but I'm wondering if
>> the problem you're having after commit ab76f7b4ab is still reproducible with it.
>
> No, it won't help, and I think I know what's going on.
>
> The temporary page tables set up by set_up_temporary_mappings() re-use the
> original boot kernel's text mapping, so if the trampoline code address
> falls into a non-executable page in that mapping, the boot kernel can't
> pass control to the image kernel.
>
> If that theory is correct, the patch below should help, but IMO it should
> be applied regardless to eliminate this particular failure mode.
>
> I'll prepare another patch to pass the physical address on top of this one.
>
> Thanks,
> Rafael
>
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] x86 / hibernate: Ensure that 64-bit trampoline code is executable
>
> During resume from hibernation, the boot kernel has to jump to
> the image kernel's trampoline code to pass control to it.  On
> x86_64 the address of that code is passed from the image kernel
> to the boot kernel in the image header.
>
> That address is interpreted with respect to the original boot
> kernel's kernel text memory mapping, so if the page containing it
> is not executable in that mapping, the jump to it will crash the
> kernel, so prevent that from happening.
>
> While at it, clean up the way in which the trampoline code address
> is saved by the image kernel (assembly code is involved in that
> unnecessarily etc).
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   arch/x86/power/hibernate_64.c     |   15 ++++++++++++---
>   arch/x86/power/hibernate_asm_64.S |    3 ---
>   2 files changed, 12 insertions(+), 6 deletions(-)
>
> Index: linux-pm/arch/x86/power/hibernate_64.c
> ===================================================================
> --- linux-pm.orig/arch/x86/power/hibernate_64.c
> +++ linux-pm/arch/x86/power/hibernate_64.c
> @@ -12,6 +12,7 @@
>   #include <linux/smp.h>
>   #include <linux/suspend.h>
>
> +#include <asm/cacheflush.h>
>   #include <asm/init.h>
>   #include <asm/proto.h>
>   #include <asm/page.h>
> @@ -27,7 +28,7 @@ extern asmlinkage __visible int restore_
>    * Address to jump to in the last phase of restore in order to get to the image
>    * kernel's text (this value is passed in the image header).
>    */
> -unsigned long restore_jump_address __visible;
> +void *restore_jump_address __visible;
>
>   /*
>    * Value of the cr3 register from before the hibernation (this value is passed
> @@ -91,6 +92,14 @@ int swsusp_arch_resume(void)
>   		return -ENOMEM;
>   	memcpy(relocated_restore_code, &core_restore_code,
>   	       &restore_registers - &core_restore_code);
> +	/*
> +	 * The temporary memory mapping set up by set_up_temporary_mappings()
> +	 * above re-uses the original kernel text mapping.  If the page with
> +	 * restore_jump_address is not executable in that mapping, it won't be
> +	 * possible to pass control to the image kernel, so prevent that from
> +	 * happening.
> +	 */
> +	set_memory_x((unsigned long)restore_jump_address, 1);
>
>   	restore_image();
>   	return 0;
> @@ -108,7 +117,7 @@ int pfn_is_nosave(unsigned long pfn)
>   }
>
>   struct restore_data_record {
> -	unsigned long jump_address;
> +	void *jump_address;
>   	unsigned long cr3;
>   	unsigned long magic;
>   };
> @@ -126,7 +135,7 @@ int arch_hibernation_header_save(void *a
>
>   	if (max_size < sizeof(struct restore_data_record))
>   		return -EOVERFLOW;
> -	rdr->jump_address = restore_jump_address;
> +	rdr->jump_address = &restore_registers;
>   	rdr->cr3 = restore_cr3;
>   	rdr->magic = RESTORE_MAGIC;
>   	return 0;
> Index: linux-pm/arch/x86/power/hibernate_asm_64.S
> ===================================================================
> --- linux-pm.orig/arch/x86/power/hibernate_asm_64.S
> +++ linux-pm/arch/x86/power/hibernate_asm_64.S
> @@ -44,9 +44,6 @@ ENTRY(swsusp_arch_suspend)
>   	pushfq
>   	popq	pt_regs_flags(%rax)
>
> -	/* save the address of restore_registers */
> -	movq	$restore_registers, %rax
> -	movq	%rax, restore_jump_address(%rip)
>   	/* save cr3 */
>   	movq	%cr3, %rax
>   	movq	%rax, restore_cr3(%rip)
>
