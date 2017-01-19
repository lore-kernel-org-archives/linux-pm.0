From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] security: Change name of CONFIG_DEBUG_RODATA
Date: Thu, 19 Jan 2017 14:00:57 -0800
Message-ID: <CAGXu5jJRrsvRAvD99O=0teqMFn9Z2rwbm=K794cD5yXKg0OL8g@mail.gmail.com>
References: <1484789346-21012-1-git-send-email-labbott@redhat.com>
 <1484789346-21012-2-git-send-email-labbott@redhat.com> <20170119105646.GA11176@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:36284 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbdASWBY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jan 2017 17:01:24 -0500
Received: by mail-io0-f177.google.com with SMTP id j13so48903396iod.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Jan 2017 14:00:58 -0800 (PST)
In-Reply-To: <20170119105646.GA11176@leverpostej>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Laura Abbott <labbott@redhat.com>, Jason Wessel <jason.wessel@windriver.com>, Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jessica Yu <jeyu@redhat.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On Thu, Jan 19, 2017 at 2:56 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Laura,
>
> On Wed, Jan 18, 2017 at 05:29:05PM -0800, Laura Abbott wrote:
>> diff --git a/security/Kconfig b/security/Kconfig
>> index 118f454..ad6ce82 100644
>> --- a/security/Kconfig
>> +++ b/security/Kconfig
>> @@ -158,6 +158,22 @@ config HARDENED_USERCOPY_PAGESPAN
>>         been removed. This config is intended to be used only while
>>         trying to find such users.
>>
>> +config ARCH_HAS_HARDENED_MAPPINGS
>> +     def_bool n
>> +
>> +config HARDENED_PAGE_MAPPINGS
>> +     bool "Mark kernel mappings with stricter permissions (RO/W^X)"
>> +     default y
>> +     depends on ARCH_HAS_HARDENED_MAPPINGS
>> +     help
>> +          If this is set, kernel text and rodata memory will be made read-only,
>> +       and non-text memory will be made non-executable. This provides
>> +       protection against certain security attacks (e.g. executing the heap
>> +       or modifying text).
>> +
>> +       Unless your system has known restrictions or performance issues, it
>> +       is recommended to say Y here.
>
> It's somewhat unfortunate that this means the feature is no longer
> mandatory on arm64 (and s390+x86). We have a boot-time switch to turn
> the protections off, so I was hoping we could make this mandatory on all
> architectures with support.

Oh, I totally missed this. Yes, we need it to stay mandatory. It
should be possible by just adding "select HARDENED_PAGE_MAPPINGS" to
the arch Kconfig, yes?

> It would be good to see if we could make this mandatory for arm and
> parisc, or if it really needs to be optional for either of those.

(Adding mpe to CC...) Michael, what's needed to get this working on powerpc too?

-Kees

-- 
Kees Cook
Nexus Security
