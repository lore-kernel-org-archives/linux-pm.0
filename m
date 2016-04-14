From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH v2] kaslr: allow kASLR to be default over Hibernation
Date: Thu, 14 Apr 2016 22:01:02 +0200
Message-ID: <20160414200102.GB3856@amd>
References: <20160412221659.GA18102@www.outflux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60425 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbcDNUBH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Apr 2016 16:01:07 -0400
Content-Disposition: inline
In-Reply-To: <20160412221659.GA18102@www.outflux.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@kernel.org>, James Morse <james.morse@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Matt Redfearn <matt.redfearn@imgtec.com>, Yves-Alexis Perez <corsac@debian.org>, Emrah Demir <ed@abdsec.com>, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com

Hi!

> Since kASLR and Hibernation can not currently coexist at runtime
> on x86, the default behavior was to disable kASLR by default when
> CONFIG_HIBERNATION was present (to retain original behavior).
> 
> The behavior of kASLR on arm64 (and soon MIPS) is to be enabled by
> default when selected at build time. Since arm64 Hibernation does not
> conflict with kASLR, this fixes the hibernation argument parsing to be
> x86-specific. Additionally, since end users want to be able to select
> kASLR on x86 by default at build time, create CONFIG_RANDOMIZE_BASE_ON
> that is present only on x86.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

I believe this is bad idea. arm64 shows that kaslr and hibernation can
coexist, and hibernation is still useful when your battery runs out.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
