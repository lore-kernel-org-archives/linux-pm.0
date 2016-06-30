From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] x86/power/64: Fix kernel text mapping corruption during image restoration
Date: Thu, 30 Jun 2016 04:20:43 +0200
Message-ID: <2398306.qXx6AZtdS5@vostro.rjw.lan>
References: <20160617105435.GB15997@pd.tnic> <CAGXu5jK4w+2WOEeNqv2CU5wqTY3oDY3pWPgJkM7Lp2AmEZuj2g@mail.gmail.com> <65d98ad4-124b-64e4-84e5-877af71a1d44@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55965 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751450AbcF3CQQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2016 22:16:16 -0400
In-Reply-To: <65d98ad4-124b-64e4-84e5-877af71a1d44@deltatee.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>

On Wednesday, June 29, 2016 07:52:18 PM Logan Gunthorpe wrote:
> Hey Raf,
> 
> Sorry to report that although the patch works the majority of the time, 
> I just got a suspicious kernel panic during resume.
> 
> It said:
> 
> "kernel tried to execute NX protected page - exploit attempt? (uid: 0)"
> 
> You can find a photo of the panic here:
> 
> http://staff.deltatee.com/~logang/panic.jpg

Thanks for the report!

That's not what Boris was seeing at least.

It looks like clearing the NX bit for relocated_restore_code in
relocate_restore_code() didn't work for some reason.

I don't see why it may not work ATM, I need to have a fresh look at that
tomorrow.

I had hoped to be able to fix this bug for 4.7, but it looks like it will
miss the mark after all.  Oh well.

Thanks,
Rafael

