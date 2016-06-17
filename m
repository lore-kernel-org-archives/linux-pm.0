From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ktime_get_ts64() splat during resume
Date: Fri, 17 Jun 2016 23:03:46 +0200
Message-ID: <CAJZ5v0jZypC17Qbvn3TXe5Z6M5JrGaktAwXQwAW=UEhccRv=nw@mail.gmail.com>
References: <20160617105435.GB15997@pd.tnic> <alpine.DEB.2.11.1606171351390.5839@nanos>
 <20160617132943.GA3336@nazgul.tnic> <20160617143346.GA3912@pd.tnic>
 <CAJZ5v0gsrAGcQqTO-+E3yGsNaO+45TmX5Wn=AoYu9JxWsR1HQA@mail.gmail.com> <20160617161247.GB3912@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36499 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbcFQVDs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2016 17:03:48 -0400
In-Reply-To: <20160617161247.GB3912@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Logan Gunthorpe <logang@deltatee.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kees Cook <keescook@chromium.org>, Stable <stable@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>

On Fri, Jun 17, 2016 at 6:12 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Fri, Jun 17, 2016 at 05:28:10PM +0200, Rafael J. Wysocki wrote:
>> A couple of questions:
>> - I guess this is reproducible 100% of the time?
>
> Yap.
>
> I took latest Linus + tip/master which has your commit.
>
>> - If you do "echo disk > /sys/power/state" instead of using s2disk,
>> does it still crash in the same way?
>
> My suspend to disk script does:
>
> echo 3 > /proc/sys/vm/drop_caches
> echo "shutdown" > /sys/power/disk
> echo "disk" > /sys/power/state
>
> I don't use anything else for years now.
>
>> - Are both the image and boot kernels the same binary?
>
> Yep.

OK, we need to find out what's wrong, then.

First, please revert the changes in hibernate_asm_64.S alone and see
if that makes any difference.

Hibernation should still work then most of the time, but the bug fixed
by this commit will be back.
