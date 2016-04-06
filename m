From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] Prefer kASLR over Hibernation
Date: Wed, 6 Apr 2016 23:49:36 +0200
Message-ID: <CAJZ5v0ieAd3WSiytzcdtD=eueLPk_SM1KgrqZXHBa6+bwK=KnQ@mail.gmail.com>
References: <20160406194404.GA11150@www.outflux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33730 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbcDFVti (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 17:49:38 -0400
In-Reply-To: <20160406194404.GA11150@www.outflux.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Matt Redfearn <matt.redfearn@imgtec.com>, Yves-Alexis Perez <corsac@debian.org>, Emrah Demir <ed@abdsec.com>, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-hardening@lists.openwall.com

On Wed, Apr 6, 2016 at 9:44 PM, Kees Cook <keescook@chromium.org> wrote:
> When building with both CONFIG_HIBERNATION and CONFIG_RANDOMIZE_BASE,
> one or the other must be chosen at boot-time. Until now, hibernation
> was selected when no choice was made on the command line.
>
> To make the security benefits of kASLR more widely available to end
> users (since the use of hibernation is becoming more rare and kASLR,
> already available on x86, will be available on arm64 and MIPS soon),
> this changes the default to preferring kASLR over hibernation. Users
> wanting hibernation can turn off kASLR by adding "nokaslr" to the kernel
> command line.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Or do you want me to apply it?
