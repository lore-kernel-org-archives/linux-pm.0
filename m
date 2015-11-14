From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 02/11] arm64: Fold proc-macros.S into assembler.h
Date: Sat, 14 Nov 2015 22:25:15 +0100
Message-ID: <20151114212515.GF20429@amd>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
 <1445966960-31724-3-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36116 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbbKNVZR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 14 Nov 2015 16:25:17 -0500
Content-Disposition: inline
In-Reply-To: <1445966960-31724-3-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On Tue 2015-10-27 17:29:11, James Morse wrote:
> From: Geoff Levand <geoff@infradead.org>
> 
> To allow the assembler macros defined in arch/arm64/mm/proc-macros.S to
> be used outside the mm code move the contents of proc-macros.S to
> asm/assembler.h.  Also, delete proc-macros.S, and fix up all references
> to proc-macros.S.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/include/asm/assembler.h | 48 +++++++++++++++++++++++++++-
>  arch/arm64/kernel/head.S           |  1 -
>  arch/arm64/kvm/hyp-init.S          |  1 -
>  arch/arm64/mm/cache.S              |  2 --
>  arch/arm64/mm/proc-macros.S        | 64 --------------------------------------
>  arch/arm64/mm/proc.S               |  3 --
>  6 files changed, 47 insertions(+), 72 deletions(-)
>  delete mode 100644 arch/arm64/mm/proc-macros.S
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index b51f2cc22ca9..91cb311d33de 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -1,5 +1,5 @@
>  /*
> - * Based on arch/arm/include/asm/assembler.h
> + * * Based on arch/arm/include/asm/assembler.h, arch/arm/mm/proc-macros.S

Why the two stars?

Otherwise looks ok.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
