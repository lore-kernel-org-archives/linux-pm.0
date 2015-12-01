From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 01/10] arm64: Fold proc-macros.S into assembler.h
Date: Tue, 1 Dec 2015 10:18:48 +0100
Message-ID: <20151201091848.GA21222@amd>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
 <1448559168-8363-2-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:32821 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755568AbbLAJSv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2015 04:18:51 -0500
Content-Disposition: inline
In-Reply-To: <1448559168-8363-2-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On Thu 2015-11-26 17:32:39, James Morse wrote:
> From: Geoff Levand <geoff@infradead.org>
> 
> To allow the assembler macros defined in arch/arm64/mm/proc-macros.S to be used
> outside the mm code move the contents of proc-macros.S to asm/assembler.h.  Also,
> delete proc-macros.S, and fix up all references to proc-macros.S.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
