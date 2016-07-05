From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/3] PM / Hibernate: Allow arch code to influence CPUs disabled during hibernate
Date: Tue, 05 Jul 2016 14:28:50 +0200
Message-ID: <2602641.slsnqsKrbn@vostro.rjw.lan>
References: <1467643950-11034-1-git-send-email-james.morse@arm.com> <1467643950-11034-2-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56220 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754833AbcGEMYQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2016 08:24:16 -0400
In-Reply-To: <1467643950-11034-2-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Pavel Machek <pavel@ucw.cz>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Chen Yu C <yu.c.chen@intel.com>

On Monday, July 04, 2016 03:52:28 PM James Morse wrote:
> Architecture code may need to do extra work when secondary CPUs are
> disabled during hibernate and resume. This may include pushing sleeping
> CPUs into a deeper power-saving state, or influencing which CPU resume
> occurs on.
> 
> Define a macro arch_hibernation_disable_cpus(), which defaults to
> calling disable_nonboot_cpus() if undefined. Architectures that
> need to do extra work around these calls can use this to influence
> the CPU down calls.
> The macros should be defined in asm/suspend.h, and
> ARCH_HIBERNATION_CPU_HOOKS should be added to Kconfig.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>

I'm going to apply this one later today.

If you want me to apply the other two as well, they need to be ACKed by the
ARM64 maintainers.

Thanks,
Rafael

