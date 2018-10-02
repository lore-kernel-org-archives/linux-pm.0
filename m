From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 00/12][v4] Backport several fixes from 64bits to 32bits
 hibernation
Date: Tue, 2 Oct 2018 11:20:23 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1810021119540.32062@nanos.tec.linutronix.de>
References: <cover.1537448058.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537448058.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 21 Sep 2018, Chen Yu wrote:

> Currently there are mainly three bugs in 32bits system when doing
> hibernation:
> 1. The page copy code is not running in safe page, which might
>    cause hang during resume.
> 2. There's no text mapping for the final jump address
>    of the original kernel, which might cause the system jumping
>    into illegal address and causes system hang during resume.
> 3. The restore kernel switches to its own kernel page table(swapper_pg_dir)
>    rather than the original kernel page table after all the pages
>    been copied back, which might cause invalid virtual-physical
>    mapping issue during resume.
> 
> To solve these problems:
> 
> 1. Copy the code core_restore_code to a safe page, to avoid the instruction
>    code been overwritten when image kernel pages are being copied.
> 2. Set up temporary text mapping for the image kernel's jump address,
>    so that after all the pages have been copied back, the system could
>    jump to this address.
> 3. Switch to the original kernel page table during resume.
> 
> Furthermore, MD5 hash check for e820 map is also backported from 64bits
> system.
> 
> In order to make this patch set more readable, these fixes are splitted
> into several sub patches.
> 
> And use CONFIG_X86_64 to control the common code to be 'activated' for
> 32 bit system during each sub-patch for better maintaining.

Acked-by: Thomas Gleixner <tglx@linutronix.de>

Rafael, it's all yours :)

Thanks,

	tglx
