From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Wed, 14 May 2008 15:30:50 -0700
Message-ID: <m13aok1pt1.fsf__10119.4234252491$1210804985$gmane$org@frodo.ebiederm.org>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1204773188.4707.109.camel@caritas-dev.intel.com> (Ying Huang's
	message of "Thu, 06 Mar 2008 11:13:08 +0800")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:

> This is a minimal patch with only the essential features. All
> additional features are split out and can be discussed later. I think
> it may be easier to get consensus on this minimal patch.

A minimal patch route sounds good.


>   * Do not allocate memory (or fail in any way) in machine_kexec().
>   * We are past the point of no return, committed to rebooting now.
>   */
> -NORET_TYPE void machine_kexec(struct kimage *image)
> +void machine_kexec(struct kimage *image)
>  {
>  	unsigned long page_list[PAGES_NR];
>  	void *control_page;
> +	asmlinkage NORET_TYPE void
> +		(*relocate_kernel_ptr)(unsigned long indirection_page,
> +				       unsigned long control_page,
> +				       unsigned long start_address,
> +				       unsigned int has_pae) ATTRIB_NORET;
>  
>  	/* Interrupts aren't acceptable while we reboot */
>  	local_irq_disable();
>  
>  	control_page = page_address(image->control_code_page);
> -	memcpy(control_page, relocate_kernel, PAGE_SIZE);
> +	memcpy(control_page, kexec_relocate_page, PAGE_SIZE/2);
> +	KJUMP_MAGIC(control_page) = 0;
>  
> +	if (image->preserve_context) {
> +		KJUMP_MAGIC(control_page) = KJUMP_MAGIC_NUMBER;
> +		if (kexec_jump_save_cpu(control_page)) {
> +			image->start = KJUMP_ENTRY(control_page);
> +			return;

Tricky, and I expect unnecessary.
We should be able to just have relocate_new_kernel return?

> +		}
> +	}
> +
> +	relocate_kernel_ptr = control_page +
> +		((void *)relocate_kernel - (void *)kexec_relocate_page);
>  	page_list[PA_CONTROL_PAGE] = __pa(control_page);
> -	page_list[VA_CONTROL_PAGE] = (unsigned long)relocate_kernel;
> +	page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;
>  	page_list[PA_PGD] = __pa(kexec_pgd);
>  	page_list[VA_PGD] = (unsigned long)kexec_pgd;
>  #ifdef CONFIG_X86_PAE
> @@ -127,6 +148,7 @@ NORET_TYPE void machine_kexec(struct kim
>  	page_list[VA_PTE_0] = (unsigned long)kexec_pte0;
>  	page_list[PA_PTE_1] = __pa(kexec_pte1);
>  	page_list[VA_PTE_1] = (unsigned long)kexec_pte1;
> + page_list[PA_SWAP_PAGE] = (page_to_pfn(image->swap_page) << PAGE_SHIFT);
>  
>  	/* The segment registers are funny things, they have both a
>  	 * visible and an invisible part.  Whenever the visible part is
> @@ -145,8 +167,9 @@ NORET_TYPE void machine_kexec(struct kim
>  	set_idt(phys_to_virt(0),0);
>  
>  	/* now call it */
> -	relocate_kernel((unsigned long)image->head, (unsigned long)page_list,
> -			image->start, cpu_has_pae);
> +	relocate_kernel_ptr((unsigned long)image->head,
> +			    (unsigned long)page_list,
> +			    image->start, cpu_has_pae);
>  }


> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -301,18 +301,26 @@ EXPORT_SYMBOL_GPL(kernel_restart);
>   *	Move into place and start executing a preloaded standalone
>   *	executable.  If nothing was preloaded return an error.
>   */
> -static void kernel_kexec(void)
> +static int kernel_kexec(void)
>  {
> +	int ret = -ENOSYS;
>  #ifdef CONFIG_KEXEC
> -	struct kimage *image;
> -	image = xchg(&kexec_image, NULL);
> -	if (!image)
> -		return;
> -	kernel_restart_prepare(NULL);
> -	printk(KERN_EMERG "Starting new kernel\n");
> -	machine_shutdown();
> -	machine_kexec(image);
> +	if (xchg(&kexec_lock, 1))
> +		return -EBUSY;
> +	if (!kexec_image) {
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +	if (!kexec_image->preserve_context) {
> +		kernel_restart_prepare(NULL);
> +		printk(KERN_EMERG "Starting new kernel\n");
> +		machine_shutdown();
> +	}
> +	ret = kexec_jump(kexec_image);
> +unlock:
> +	xchg(&kexec_lock, 0);
>  #endif

Ugh.  No.  Not sharing the shutdown methods with reboot and
the normal kexec path looks like a recipe for failure to me.

This looks like where we really need to have the conversation.
What methods do we use to shutdown the system.

My take on the situation is this.  For proper handling we
need driver device_detach and device_reattach methods.

With the following semantics.  The device_detach methods
will disable DMA and place the hardware in a sane state
from which the device driver can reclaim and reinitialize it,
but the hardware will not be touched.

device_reattach reattaches the driver to the hardware.

So looking at this patch I see two very productive directions
we can go.
1) A patch that just fixes up the kexec infrastructure code
   so it implements the swap page and provides the kernel
   reentry point.  And doesn't handle the upper layer
   user interface portion.

2) A patch that renames device_shutdown to device_detach.
   And starts implementing the driver hooks needed from
   a resumable kexec.

Then we have the question what do we do with devices in the
kernel that don't have a device_reattach method, when we
expect to come back from a kexec.  The two choices are:
(a) fail the operations before we commit to anything.
(b) hotunplug/hotreplug the device.

With respect to device methods.  I don't think any of
the current power saving methods make sense.  Certainly
nothing that prepares the way for using weird ACPI states.

I don't think there is not enough difference between
device_detach and device_shutdown for us to maintain two
separate methods, and that seems to place an unreasonable
maintenance burden on device driver developers.

Eric
