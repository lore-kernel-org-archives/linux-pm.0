From: Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH 1/2] security: Change name of CONFIG_DEBUG_RODATA
Date: Wed, 25 Jan 2017 12:25:03 +0100
Message-ID: <4116b91a-4fb5-414d-5fd5-36be151c600c@redhat.com>
References: <1484789346-21012-1-git-send-email-labbott@redhat.com>
 <1484789346-21012-2-git-send-email-labbott@redhat.com>
 <20170119105646.GA11176@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yb0-f171.google.com ([209.85.213.171]:34543 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbdAYLZM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2017 06:25:12 -0500
Received: by mail-yb0-f171.google.com with SMTP id j82so6935930ybg.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2017 03:25:12 -0800 (PST)
In-Reply-To: <20170119105646.GA11176@leverpostej>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>, Jason Wessel <jason.wessel@windriver.com>, Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jessica Yu <jeyu@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.i

On 01/19/2017 11:56 AM, Mark Rutland wrote:
> Hi Laura,
>
> On Wed, Jan 18, 2017 at 05:29:05PM -0800, Laura Abbott wrote:
>>
>> Despite the word 'debug' in CONFIG_DEBUG_RODATA, this kernel option
>> provides key security features that are to be expected on a modern
>> system. Change the name to CONFIG_HARDENED_PAGE_MAPPINGS which more
>> accurately describes what this option is intended to do.
>
> This generally sounds good. Thanks for attacking this!
>
> On the bikeshedding front, *maybe* it would be nice to mention
> permissions in the name, something like STRICT_KERNEL_RWX. That might
> also prevent the reading of 'hardened' as 'optional overhead'.
>
> That said, the proposed name is fine by me -- I'm happy so long as
> 'DEBUG' goes.
>

(Apologies for the delay, my SMTP was set up incorrectly so my
messages didn't actually get sent out)

I like that better since it's describing specifically what the config
should be setting as opposed to something more vague. That might fit
better with what Pavel was suggesting as well.

Thanks,
Laura


