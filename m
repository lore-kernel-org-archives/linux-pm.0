From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH][RFC] x86, hotplug: Use zero page for monitor when
 resuming from hibernation
Date: Mon, 6 Jun 2016 16:25:06 +0200
Message-ID: <20160606142506.GE30909@twins.programming.kicks-ass.net>
References: <1465222749-8388-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40853 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbcFFOZV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jun 2016 10:25:21 -0400
Content-Disposition: inline
In-Reply-To: <1465222749-8388-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>, Zhu Guihua <zhugh.fnst@cn.fujitsu.com>, Juergen Gross <jgross@suse.com>

On Mon, Jun 06, 2016 at 10:19:09PM +0800, Chen Yu wrote:
> @@ -1595,8 +1596,21 @@ static inline void mwait_play_dead(void)
>  	 * This should be a memory location in a cache line which is
>  	 * unlikely to be touched by other processors.  The actual
>  	 * content is immaterial as it is not actually modified in any way.
> +	 *
> +	 * However in hibernation resume process, this address could be
> +	 * touched by BSP when restoring page frames, if the page table
> +	 * for this address is not coherent across hibernation(due to
> +	 * inconsistence of e820 memory map), access from APs might
> +	 * cause exception. So change the mwait address to zero page,
> +	 * which is located in .bss, in this way we can avoid illegal
> +	 * access from APs because page table for kernel mapping
> +	 * of text/data/bss should keeps unchanged according to
> +	 * hibernation semantic.
>  	 */
> -	mwait_ptr = &current_thread_info()->flags;
> +	if (hibernation_in_resume())
> +		mwait_ptr = empty_zero_page;
> +	else
> +		mwait_ptr = &current_thread_info()->flags;

Why is this conditional? Is there any case in which the zero page is not
also correct?
