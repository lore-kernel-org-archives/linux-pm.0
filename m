From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [PATCH] x86: General protection fault after STR (32 bit systems only)
Date: Sat, 13 Jun 2015 00:45:29 +0200
Message-ID: <CAK1hOcPvst1+vT_3_m0t7HZF_fz9zjDd_azyWj6n0Ma-qY3ZQQ@mail.gmail.com>
References: <1434066338-6619-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20150612060747.GA25024@gmail.com> <CALCETrUfrbLeJoOeNQU2vK+jAmNBazB5rmfD5M11tv6NVeppmg@mail.gmail.com>
 <20150612075013.GA8759@gmail.com> <A58C5D0E-A557-4406-9317-442D78E4700B@zytor.com>
 <20150612083625.GA22760@gmail.com> <CAMzpN2gHpsW9ZMBdOR8+VuMNkYyi_THVeX5W4JLukmFK95GjZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34707 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755171AbbFLWpu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jun 2015 18:45:50 -0400
In-Reply-To: <CAMzpN2gHpsW9ZMBdOR8+VuMNkYyi_THVeX5W4JLukmFK95GjZQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Gerst <brgerst@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, X86 ML <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Denys Vlasenko <dvlasenk@redhat.com>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Jun 12, 2015 at 5:48 PM, Brian Gerst <brgerst@gmail.com> wrote:
> If you follow the convoluted flow of the calls in this file,
> ...

Speaking of which. It is indeed quite bad.

For one, saved_eip is only ever set to point to ret_point:

ENTRY(saved_eip)        .long   0
...

        movl    $ret_point, saved_eip

and it has just a single user, where an indirect jump
through it is performed:

        # jump to place where we left off
        movl    saved_eip, %eax
        jmp     *%eax

No comments why it is so.

All this seems to be equivalent to trivial

        # jump to place where we left off
        jmp     ret_point

Am I missing something?
