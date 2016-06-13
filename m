From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/5] PM / Hibernate: Allow architectures to specify the hibernate/resume CPU
Date: Tue, 14 Jun 2016 00:05:28 +0200
Message-ID: <1982845.x73eTHIS7X@vostro.rjw.lan>
References: <1464876657-6692-1-git-send-email-james.morse@arm.com> <1464876657-6692-4-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64102 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1422700AbcFMWBV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2016 18:01:21 -0400
In-Reply-To: <1464876657-6692-4-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

On Thursday, June 02, 2016 03:10:55 PM James Morse wrote:
> On arm64 the cpu with logical id 0 is assumed to be the boot CPU. If a
> user hotplugs this CPU out, then uses kexec to boot a new kernel, the new
> kernel will assign logical id 0 to a different physical CPU.
> This breaks hibernate as hibernate and resume will be attempted on different
> CPUs.
> 
> Define a weak symbol arch_hibernation_disable_cpus(), which defaults to
> calling disable_nonboot_cpus). Architectures that allow CPU 0 to be
> hotplugged can use this to control which CPU is used for hibernate/resume.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> ---
> I would have preferred a macro, but there is no hibernate-relevant header
> file that all arch's have. arm, arm64 and x86 have a suspend.h, but powerpc
> doesn't.

What about include/linux/suspend.h?

There are arch_ things declared in there.

Thanks,
Rafael

