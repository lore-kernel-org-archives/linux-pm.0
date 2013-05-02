From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] x86, x86-64, gdt, hibernate: Store/load GDT for
 hibernate path.
Date: Thu, 2 May 2013 14:34:38 +0200
Message-ID: <20130502123438.GD22618@amd.pavel.ucw.cz>
References: <1367459610-9656-1-git-send-email-konrad.wilk@oracle.com>
 <1367459610-9656-2-git-send-email-konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35388 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757512Ab3EBMek (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2013 08:34:40 -0400
Content-Disposition: inline
In-Reply-To: <1367459610-9656-2-git-send-email-konrad.wilk@oracle.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rjw@sisk.pl, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org

Hi!

> The git commite7a5cd063c7b4c58417f674821d63f5eb6747e37
> ("x86-64, gdt: Store/load GDT for ACPI S3 or hibernate/resume path
> is not needed.") assumes that for the hibernate path the booting
> kernel and the resuming kernel MUST be the same. That is certainly
> the case for a 32-bit kernel (see check_image_kernel and
> CONFIG_ARCH_HIBERNATION_HEADER config option).
> 
> However for 64-bit kernels it is OK to have a different kernel
> version (and size of the image) of the booting and resuming kernels.
> Hence the above mentioned git commit introduces an regression.

Ok.

> This patch fixes it by introducing a 'struct desc_ptr gdt_desc'
> back in the 'struct saved_context'. However instead of having in the
> 'save_processor_state' and 'restore_processor_state' the
> store/load_gdt calls, we are only saving the GDT in the
> save_processor_state.
> 
> For the restore path the lgdt operation is done in
> hibernate_asm_[32|64].S in the 'restore_registers' path.

So the on-disk format changed and we need to bump the version number
somewhere?

I guess we should add big fat warning to the affected structures.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
