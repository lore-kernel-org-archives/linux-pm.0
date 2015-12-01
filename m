From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 08/10] arm64: Promote KERNEL_START/KERNEL_END
 definitions to a header file
Date: Tue, 1 Dec 2015 10:28:41 +0100
Message-ID: <20151201092841.GC21222@amd>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
 <1448559168-8363-9-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33034 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755651AbbLAJ2n (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2015 04:28:43 -0500
Content-Disposition: inline
In-Reply-To: <1448559168-8363-9-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On Thu 2015-11-26 17:32:46, James Morse wrote:
> KERNEL_START and KERNEL_END are useful outside head.S, move them to a
> header file.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Pavel	 Machek <pavel@ucw.cz>

> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 853953cd1f08..5773a6629f10 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -70,6 +70,9 @@
>  
>  #define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 4))
>  
> +#define KERNEL_START      _text
> +#define KERNEL_END        _end
> +
>  /*
>   * Physical vs virtual RAM address space conversion.  These are
>   * private definitions which should NOT be used outside memory.h
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 7cec62a76f50..c58ede3398db 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -48,9 +48,6 @@
>  #error TEXT_OFFSET must be less than 2MB
>  #endif
>  
> -#define KERNEL_START	_text
> -#define KERNEL_END	_end
> -
>  /*
>   * Kernel startup entry point.
>   * ---------------------------

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
