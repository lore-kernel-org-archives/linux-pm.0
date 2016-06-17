From: Borislav Petkov <bp@alien8.de>
Subject: Re: ktime_get_ts64() splat during resume
Date: Fri, 17 Jun 2016 18:12:47 +0200
Message-ID: <20160617161247.GB3912@pd.tnic>
References: <20160617105435.GB15997@pd.tnic>
 <alpine.DEB.2.11.1606171351390.5839@nanos>
 <20160617132943.GA3336@nazgul.tnic>
 <20160617143346.GA3912@pd.tnic>
 <CAJZ5v0gsrAGcQqTO-+E3yGsNaO+45TmX5Wn=AoYu9JxWsR1HQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gsrAGcQqTO-+E3yGsNaO+45TmX5Wn=AoYu9JxWsR1HQA@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Logan Gunthorpe <logang@deltatee.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kees Cook <keescook@chromium.org>, Stable <stable@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 17, 2016 at 05:28:10PM +0200, Rafael J. Wysocki wrote:
> A couple of questions:
> - I guess this is reproducible 100% of the time?

Yap.

I took latest Linus + tip/master which has your commit.

> - If you do "echo disk > /sys/power/state" instead of using s2disk,
> does it still crash in the same way?

My suspend to disk script does:

echo 3 > /proc/sys/vm/drop_caches
echo "shutdown" > /sys/power/disk
echo "disk" > /sys/power/state

I don't use anything else for years now.

> - Are both the image and boot kernels the same binary?

Yep.

> Sure.  I thought Tony would pick them up.

Oh ok, next time I'll pester him.

:-)

But seriously, should we route the RAS-relevant stuff touching
drivers/acpi/apei/ through our tree instead? Provided you're fine with
them?

This way we'll unload some of the burden off you...

Thanks!

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
