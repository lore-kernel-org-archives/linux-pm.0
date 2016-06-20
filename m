From: chenyu <yu.chen.surf@gmail.com>
Subject: Re: ktime_get_ts64() splat during resume
Date: Mon, 20 Jun 2016 16:17:13 +0800
Message-ID: <CADjb_WRhcNEN0q7zPBdr79bGsbXL66EpvvgwEdCq_C_a3i8iSQ@mail.gmail.com>
References: <20160617105435.GB15997@pd.tnic> <alpine.DEB.2.11.1606171351390.5839@nanos>
 <20160617132943.GA3336@nazgul.tnic> <20160617143346.GA3912@pd.tnic> <CAJZ5v0gsrAGcQqTO-+E3yGsNaO+45TmX5Wn=AoYu9JxWsR1HQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gsrAGcQqTO-+E3yGsNaO+45TmX5Wn=AoYu9JxWsR1HQA@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Logan Gunthorpe <logang@deltatee.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kees Cook <keescook@chromium.org>, Stable <stable@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 17, 2016 at 11:28 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Jun 17, 2016 at 4:33 PM, Borislav Petkov <bp@alien8.de> wrote:
>> Ok,
>>
>> bisect is done, full log below.
>>
>> Rafael, that fix
>>
>>   70595b479ce1 ("x86/power/64: Fix crash whan the hibernation code passes control to the image kernel")
>>
>> breaks s2disk here. It explodes during resume and a statically allocated
>> struct's member is NULL. See
>>
>> https://lkml.kernel.org/r/20160617105435.GB15997@pd.tnic
>>
>> for the splat and some debugging attempts.
>>
>> Reverting 70595b479ce1 fixes the issue here.
>
> Quite evidently, memory is corrupted in the image kernel, but this
> particular commit only affects the boot kernel, so it can't really
> corrupt anything in the image one.
>
In previous patch,
before we jump to the new kernel entry, we add the
text mapping to temp_level4_pgt,

         /* switch over to the temporary kernel text mapping */
        movq    %r8, (%r9)
If I understand correctly,  r9 contains the virtual address
of restore_pgd_addr, since the page table for restore_pgd_addr might be
incoherent across hibernation(as NX patch changes the kernel text mapping
to dynamically mapping), so we might write pmd entry to an incorrect place in
temp_level4_pgt?

Yu
