From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 10/10] arm64: kernel: Add support for
 hibernate/suspend-to-disk.
Date: Tue, 1 Dec 2015 10:31:43 +0100
Message-ID: <20151201093143.GD21222@amd>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
 <1448559168-8363-11-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33089 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755934AbbLAJbq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2015 04:31:46 -0500
Content-Disposition: inline
In-Reply-To: <1448559168-8363-11-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

Hi!

> Suspend borrows code from cpu_suspend() to write cpu state onto the stack,
> before calling swsusp_save() to save the memory image.
> 
> Restore creates a set of temporary page tables, covering the kernel and the
> linear map, copies the restore code to a 'safe' page, then uses the copy to
> restore the memory image. It calls into cpu_resume(),
> and then follows the normal cpu_suspend() path back into the suspend code.
> 
> The implementation assumes that exactly the same kernel is booted on the
> same hardware, and that the kernel is loaded at the same physical address.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>

> diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
> index 5faa3ce1fa3a..e75ad7aa268c 100644
> --- a/arch/arm64/include/asm/suspend.h
> +++ b/arch/arm64/include/asm/suspend.h
> @@ -1,3 +1,5 @@
> +#include <linux/suspend.h>
> +
>  #ifndef __ASM_SUSPEND_H
>  #define __ASM_SUSPEND_H
>

Actually... even additional includes should go after the #ifdef
guards.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
