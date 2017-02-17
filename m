From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCHv3 2/2] arch: Rename CONFIG_DEBUG_RODATA and CONFIG_DEBUG_MODULE_RONX
Date: Thu, 16 Feb 2017 17:08:20 -0800
Message-ID: <CAGXu5jJ4FD=6HLK_21T079JrO569DwWBTeiD18x3WRrYBsaAqw@mail.gmail.com>
References: <1486427518-14819-1-git-send-email-labbott@redhat.com>
 <1486427518-14819-3-git-send-email-labbott@redhat.com> <20170216222529.GA7531@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:38753 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754071AbdBQBIV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Feb 2017 20:08:21 -0500
Received: by mail-it0-f47.google.com with SMTP id g67so1523959itb.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Feb 2017 17:08:21 -0800 (PST)
In-Reply-To: <20170216222529.GA7531@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, "H. Peter Anvin" <hpa@zytor.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Rob Herring <robh@kernel.org>, Jessica Yu <jeyu@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>, "x86@kernel.org" <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Len Brown <len.brown@intel.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linut>

On Thu, Feb 16, 2017 at 2:25 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>>
>> -config DEBUG_RODATA
>> +config STRICT_KERNEL_RWX
>>       bool "Make kernel text and rodata read-only" if ARCH_OPTIONAL_KERNEL_RWX
>>       depends on ARCH_HAS_STRICT_KERNEL_RWX
>>       default !ARCH_OPTIONAL_KERNEL_RWX ||
>
> Debug features are expected to have runtime cost, so kconfig help is
> silent about those. But there are runtime costs, right? It would be
> nice to mention them in the help text...

It depends on the architecture. The prior help text for arm said:

         The tradeoff is that each region is padded to section-size (1MiB)
         boundaries (because their permissions are different and splitting
         the 1M pages into 4K ones causes TLB performance problems), which
         can waste memory.

parisc (somewhat inaccurately) said:

         This option may have a slight performance impact because a
         portion of the kernel code won't be covered by a TLB anymore.

IIUC, arm64 does what parisc is hinting at: mappings at the end are
broken down to PAGE_SIZE. On x86, IIUC, there's actually no change to
TLB performance due to how the mappings are already set up.

I'm not sure the best way to express this in the new help text. Do you
have some suggestions on wording? Personally, I don't really think
it's worth mentioning this in Kconfig help, which, in theory, is
supposed to limit how technical it gets. And I think the performance
impact is almost entirely negligible compared to the risks addressed.

-Kees

-- 
Kees Cook
Pixel Security
