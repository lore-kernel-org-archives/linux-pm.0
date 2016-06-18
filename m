From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ktime_get_ts64() splat during resume
Date: Sat, 18 Jun 2016 03:11:15 +0200
Message-ID: <CAJZ5v0g9Ynifa+=Z4FA1ZjcVR1qhn04UZtcgJSYiGHzJo5TW=w@mail.gmail.com>
References: <20160617105435.GB15997@pd.tnic> <alpine.DEB.2.11.1606171351390.5839@nanos>
 <20160617132943.GA3336@nazgul.tnic> <20160617143346.GA3912@pd.tnic>
 <CAJZ5v0gsrAGcQqTO-+E3yGsNaO+45TmX5Wn=AoYu9JxWsR1HQA@mail.gmail.com>
 <20160617161247.GB3912@pd.tnic> <CAJZ5v0jZypC17Qbvn3TXe5Z6M5JrGaktAwXQwAW=UEhccRv=nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jZypC17Qbvn3TXe5Z6M5JrGaktAwXQwAW=UEhccRv=nw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Logan Gunthorpe <logang@deltatee.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kees Cook <keescook@chromium.org>, Stable <stable@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 17, 2016 at 11:03 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Jun 17, 2016 at 6:12 PM, Borislav Petkov <bp@alien8.de> wrote:
>> On Fri, Jun 17, 2016 at 05:28:10PM +0200, Rafael J. Wysocki wrote:
>>> A couple of questions:
>>> - I guess this is reproducible 100% of the time?
>>
>> Yap.
>>
>> I took latest Linus + tip/master which has your commit.
>>
>>> - If you do "echo disk > /sys/power/state" instead of using s2disk,
>>> does it still crash in the same way?
>>
>> My suspend to disk script does:
>>
>> echo 3 > /proc/sys/vm/drop_caches
>> echo "shutdown" > /sys/power/disk
>> echo "disk" > /sys/power/state
>>
>> I don't use anything else for years now.
>>
>>> - Are both the image and boot kernels the same binary?
>>
>> Yep.
>
> OK, we need to find out what's wrong, then.
>
> First, please revert the changes in hibernate_asm_64.S alone and see
> if that makes any difference.
>
> Hibernation should still work then most of the time, but the bug fixed
> by this commit will be back.

Due to the nature of the memory corruption you are seeing (the same
address appears to be corrupted every time in the same way) with 100%
reproducibility and due to the fact that new code added by the commit
in question only writes to dynamically allocated memory (and you've
already verified that https://patchwork.kernel.org/patch/9185165/
doesn't help), it is quite unlikely that the memory corruption comes
from that commit itself.

However, I see a couple of ways in which that commit might uncover a latent bug.

First, it changed the layout of the kernel text by adding the
PAGE_SIZE alignment of restore_registers().  That likely pushed stuff
behind it to new offsets, possibly including the static struct field
that is now corrupted.  Now, say that the memory corruption has always
happened at the same memory location, but previously there was nothing
in there or whatever was in there, wasn't vital.  In that case the
memory corruption might have gone unnoticed until the commit in
question caused things to move to new locations and the corrupted
location contains a vital piece of data now.  This is my current
theory.

Second, it added two invocations of get_safe_page() that in theory
might push things a bit too far towards the limit and they started to
break there.  I don't see how that can happen ATM, but I'm not
excluding this possibility yet.  It seems, though, that in that case
the corruption would be more random and I certainly wouldn't expect it
to happen at the same location every time.

One more indicator is that multiple people reported success with that
commit and in many hibernation runs, so the problem appears to be very
specific to your system and/or kernel configuration.  It also is
interesting that the memory corruption only becomes visible during the
thawing of tasks and given the piece of data that is corrupted, it
should become visible much earlier if the memory was corrupted during
image restoration by the boot kernel.

In any case, reverting the changes in hibernate_asm_64.S alone should
show us the direction, but if it makes things work again, I would try
to change the restore_registers() alignment to something smaller, like
64 (which should be safe) and see what happens then.
