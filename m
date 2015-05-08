From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] x86: speed cpu_up by quirking cpu_init_udelay
Date: Fri, 8 May 2015 14:15:42 -0400
Message-ID: <CAJvTdKk3TM1PMUgGeWCxThzVknfBc8xMK-dJkbxJrwkWhjGzLg@mail.gmail.com>
References: <418898b5b9a6d76e7fbbd2af7cc988de1a5a287d.1431066425.git.len.brown@intel.com>
	<170f6f6e9ac4aa4d8ec1ed5000bee95463897337.1431066425.git.len.brown@intel.com>
	<20150508083250.GB4137@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:36521 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbbEHSPn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 14:15:43 -0400
In-Reply-To: <20150508083250.GB4137@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Fri, May 8, 2015 at 4:32 AM, Borislav Petkov <bp@alien8.de> wrote:

>> +     pr_debug("cpu_init_udelay quirk to %d, was %d", new_udelay, init_udelay);
>
> Can we make this printk(KERN_DEBUG please?
>
> I'd like to be able to slap "debug" on the command line and not
> recompile the kernel. And no, dyndbg="file smpboot.c +p" or whatever the
> syntax is, simply doesn't scale if I want to see all debug messages from
> early boot.

I agree with you.  Further, you made me think about it, and while it was helpful
when I wrote the patch, I don't think any printk() is needed upstream.

see v3 just sent.

Len Brown, Intel Open Source Technology Center
