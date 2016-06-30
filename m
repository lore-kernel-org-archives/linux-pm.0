From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] x86/power/64: Fix kernel text mapping corruption
 during image restoration
Date: Thu, 30 Jun 2016 13:27:16 +0200
Message-ID: <CAJZ5v0j+w4tBiFL16Dz_T1Jokj3pYubt2z0DP-eB2sFA5W3-rg@mail.gmail.com>
References: <20160617105435.GB15997@pd.tnic> <CAGXu5jK4w+2WOEeNqv2CU5wqTY3oDY3pWPgJkM7Lp2AmEZuj2g@mail.gmail.com>
 <65d98ad4-124b-64e4-84e5-877af71a1d44@deltatee.com> <2398306.qXx6AZtdS5@vostro.rjw.lan>
 <20160630094505.GA17833@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33764 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbcF3L1T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2016 07:27:19 -0400
In-Reply-To: <20160630094505.GA17833@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Logan Gunthorpe <logang@deltatee.com>, Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>

On Thu, Jun 30, 2016 at 11:45 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Thu, Jun 30, 2016 at 04:20:43AM +0200, Rafael J. Wysocki wrote:
>> That's not what Boris was seeing at least.
>
> Well, I had it a couple of times during testing patches. This is all
> from the logs:
>
> [   65.121109] PM: Basic memory bitmaps freed
> [   65.125991] Restarting tasks ...
> [   65.129342] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> [   65.129585] done.
> [   65.141314] BUG: unable to handle kernel paging request at ffff88042b957e40

I mean the failure mode, not the particular exception type. :-)

You always saw it in a user space task after kernel resume:

> [   65.141340] Call Trace:
> [   65.141344]  [<ffffffff81181e1e>] ? getname_flags+0x5e/0x1b0
> [   65.141346]  [<ffffffff811782bf>] ? cp_new_stat+0x10f/0x120
> [   65.141348]  [<ffffffff810bb33a>] ? ktime_get_ts64+0x4a/0xf0
> [   65.141353]  [<ffffffff81185fc7>] ? poll_select_copy_remaining+0xe7/0x130
> [   65.141355]  [<ffffffff8100263a>] exit_to_usermode_loop+0x8a/0xb0
> [   65.141356]  [<ffffffff81002a6b>] syscall_return_slowpath+0x5b/0x70
> [   65.141358]  [<ffffffff81688e72>] entry_SYSCALL_64_fastpath+0xa5/0xa7

[cut]

> [  381.850792] Call Trace:
> [  381.850795]  [<ffffffff8117f8ae>] ? getname_flags+0x5e/0x1b0
> [  381.850797]  [<ffffffff81175d5f>] ? cp_new_stat+0x10f/0x120
> [  381.850799]  [<ffffffff810b9eca>] ? ktime_get_ts64+0x4a/0xf0
> [  381.850800]  [<ffffffff81183a57>] ? poll_select_copy_remaining+0xe7/0x130
> [  381.850802]  [<ffffffff8100263a>] exit_to_usermode_loop+0x8a/0xb0
> [  381.850804]  [<ffffffff81002a6b>] syscall_return_slowpath+0x5b/0x70
> [  381.850806]  [<ffffffff81688272>] entry_SYSCALL_64_fastpath+0xa5/0xa7

[cut]

> [   49.022675] Call Trace:
> [   49.022680]  [<ffffffff8117f8ae>] ? getname_flags+0x5e/0x1b0
> [   49.022683]  [<ffffffff81175d5f>] ? cp_new_stat+0x10f/0x120
> [   49.022686]  [<ffffffff810b9eca>] ? ktime_get_ts64+0x4a/0xf0
> [   49.022689]  [<ffffffff81183a57>] ? poll_select_copy_remaining+0xe7/0x130
> [   49.022692]  [<ffffffff8100263a>] exit_to_usermode_loop+0x8a/0xb0
> [   49.022695]  [<ffffffff81002a6b>] syscall_return_slowpath+0x5b/0x70
> [   49.022698]  [<ffffffff81688272>] entry_SYSCALL_64_fastpath+0xa5/0xa7

[cut]

> [   39.636905] Call Trace:
> [   39.636908]  [<ffffffff8117f8be>] ? getname_flags+0x5e/0x1b0
> [   39.636910]  [<ffffffff81175d6f>] ? cp_new_stat+0x10f/0x120
> [   39.636912]  [<ffffffff810b9eaa>] ? ktime_get_ts64+0x4a/0xf0
> [   39.636917]  [<ffffffff81183a67>] ? poll_select_copy_remaining+0xe7/0x130
> [   39.636919]  [<ffffffff8100263a>] exit_to_usermode_loop+0x8a/0xb0
> [   39.636921]  [<ffffffff81002a6b>] syscall_return_slowpath+0x5b/0x70
> [   39.636922]  [<ffffffff81688272>] entry_SYSCALL_64_fastpath+0xa5/0xa7

which is a clear indication of image corruption during restore.

In the Logan's case this happens in swsusp_arch_resume() proper and
the address in RIP is relative to the identity mapping, so the only
place it can happen is the jump to relocated_restore_code.  That's
because before that jump the addresses in RIP are relative to the
kernel text mapping and after it we immediately switch over to the
temporary page tables which are all executable.  So that is the only
place AFAICS.

Also in your case the failure was 100% reproducible, while in the
Logan's case it has happened once so far (so generally it happens once
in a blue moon).

In summary, I'm sure that this is a different issue.

Thanks,
Rafael
