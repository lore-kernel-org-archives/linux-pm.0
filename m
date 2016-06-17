From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ktime_get_ts64() splat during resume
Date: Fri, 17 Jun 2016 17:28:10 +0200
Message-ID: <CAJZ5v0gsrAGcQqTO-+E3yGsNaO+45TmX5Wn=AoYu9JxWsR1HQA@mail.gmail.com>
References: <20160617105435.GB15997@pd.tnic> <alpine.DEB.2.11.1606171351390.5839@nanos>
 <20160617132943.GA3336@nazgul.tnic> <20160617143346.GA3912@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160617143346.GA3912@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Logan Gunthorpe <logang@deltatee.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kees Cook <keescook@chromium.org>, Stable <stable@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 17, 2016 at 4:33 PM, Borislav Petkov <bp@alien8.de> wrote:
> Ok,
>
> bisect is done, full log below.
>
> Rafael, that fix
>
>   70595b479ce1 ("x86/power/64: Fix crash whan the hibernation code passes control to the image kernel")
>
> breaks s2disk here. It explodes during resume and a statically allocated
> struct's member is NULL. See
>
> https://lkml.kernel.org/r/20160617105435.GB15997@pd.tnic
>
> for the splat and some debugging attempts.
>
> Reverting 70595b479ce1 fixes the issue here.

Quite evidently, memory is corrupted in the image kernel, but this
particular commit only affects the boot kernel, so it can't really
corrupt anything in the image one.

A couple of questions:
- I guess this is reproducible 100% of the time?
- If you do "echo disk > /sys/power/state" instead of using s2disk,
does it still crash in the same way?
- Are both the image and boot kernels the same binary?

> @stable folk: You might want to hold off on picking up that one yet...
>
>
> Now, I have serial connected to that box so if you want me to dump stuff
> and try patches, let me know.
>
> Btw, while I have your ear, can you pick up my einj fixes please?
>
> :-)
>
> -> https://lkml.kernel.org/r/1463992084-10012-1-git-send-email-bp@alien8.de

Sure.  I thought Tony would pick them up.
