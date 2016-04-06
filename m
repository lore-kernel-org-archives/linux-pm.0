From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Prefer kASLR over Hibernation
Date: Wed, 6 Apr 2016 13:56:37 -0700
Message-ID: <CA+55aFw+JFfy+dfMbAdB3ueA1O-w--EBwMF4WKrGp754trHBDA@mail.gmail.com>
References: <20160406194404.GA11150@www.outflux.net>
	<20160406201716.GA14241@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f193.google.com ([209.85.213.193]:32788 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333AbcDFU4i (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 16:56:38 -0400
In-Reply-To: <20160406201716.GA14241@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@denx.de>
Cc: Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Matt Redfearn <matt.redfearn@imgtec.com>, Yves-Alexis Perez <corsac@debian.org>, Emrah Demir <ed@abdsec.com>, Jonathan Corbet <corbet@lwn.net>, the arch/x86 maintainers <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>

On Wed, Apr 6, 2016 at 1:17 PM, Pavel Machek <pavel@denx.de> wrote:
>
> Why is kASLR incompatible with hibernation? We can hibernate have
> 4.3 kernel resume hibernation image of 4.2 kernel (on x86-64, and I
> have patches for x86). Resuming kernel with different randomization
> does not look that much different...

Oh, I'd absolutely prefer to just allow kaslr together with
hibernation if it actually works.

Could the people who piped up to say that they actually use
hibernation just try passing in the "kaslr" command line option on
their machine, and see if it works for them? We could just remove the
"no kaslr with hibername" code - or at least limit it to 32-bit for
now..

Because that would be lovely.

            Linus
