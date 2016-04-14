From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] kaslr: allow kASLR to be default over Hibernation
Date: Thu, 14 Apr 2016 13:14:07 -0700
Message-ID: <CAGXu5jKNKV2RaPCw+m3R-e7irmmP0eRBBq9RKY0mcH5A1Nsx6g@mail.gmail.com>
References: <20160412221659.GA18102@www.outflux.net>
	<20160414200102.GB3856@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38018 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbcDNUOJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Apr 2016 16:14:09 -0400
Received: by mail-wm0-f48.google.com with SMTP id u206so4152195wme.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2016 13:14:08 -0700 (PDT)
In-Reply-To: <20160414200102.GB3856@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@denx.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@kernel.org>, James Morse <james.morse@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Matt Redfearn <matt.redfearn@imgtec.com>, Yves-Alexis Perez <corsac@debian.org>, Emrah Demir <ed@abdsec.com>, Jonathan Corbet <corbet@lwn.net>, "x86@kernel.org" <x86@kernel.org>, Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>

On Thu, Apr 14, 2016 at 1:01 PM, Pavel Machek <pavel@denx.de> wrote:
> Hi!
>
>> Since kASLR and Hibernation can not currently coexist at runtime
>> on x86, the default behavior was to disable kASLR by default when
>> CONFIG_HIBERNATION was present (to retain original behavior).
>>
>> The behavior of kASLR on arm64 (and soon MIPS) is to be enabled by
>> default when selected at build time. Since arm64 Hibernation does not
>> conflict with kASLR, this fixes the hibernation argument parsing to be
>> x86-specific. Additionally, since end users want to be able to select
>> kASLR on x86 by default at build time, create CONFIG_RANDOMIZE_BASE_ON
>> that is present only on x86.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> I believe this is bad idea. arm64 shows that kaslr and hibernation can
> coexist, and hibernation is still useful when your battery runs out.

What? I'm confused -- this patch leaves the x86 behavior as-is by
default but allows hibernation to work with arm64. (For example, right
now, if you boot arm64 with "kaslr" kernel argument, hibernation will
get needlessly disabled.)

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
