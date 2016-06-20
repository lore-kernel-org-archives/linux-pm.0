From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ktime_get_ts64() splat during resume
Date: Mon, 20 Jun 2016 23:15:18 +0200
Message-ID: <CAJZ5v0grcXRW6tukVmyZ3Xi0PqXSyf0+swfOLjxJkNawsSP-QA@mail.gmail.com>
References: <20160617105435.GB15997@pd.tnic> <20160617161247.GB3912@pd.tnic>
 <CAJZ5v0jZypC17Qbvn3TXe5Z6M5JrGaktAwXQwAW=UEhccRv=nw@mail.gmail.com>
 <2816580.laIl5zA8fL@vostro.rjw.lan> <CA+55aFwGshPVCeBeMbY_RYrA+UR7-jLjy4SCbcHTxQ=f2KwESA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFwGshPVCeBeMbY_RYrA+UR7-jLjy4SCbcHTxQ=f2KwESA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@alien8.de>, Logan Gunthorpe <logang@deltatee.com>, Kees Cook <keescook@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stable <stable@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 20, 2016 at 8:29 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Jun 20, 2016 at 7:38 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> Overall, we seem to be heading towards the "really weird" territory here.
>
> So the whole commit that Boris bisected down to is weird to me.
>
> Why isn't the temporary text mapping just set up unconditionally in
> the temp_level4_pgt?
>
> Why does it have that insane "let's leave the temp_level4_pgt alone
> until we actually switch to it, and save away restore_pgd_addr and the
> restore_pgd, to then be set up at restore time"?
>
> All the other temporary mappings are set up statically in the
> temp_level4_pgt, why not that one?

The text mapping in temp_level4_pgt has to map the image kernel's
physical entry address to the same virtual address that the image
kernel had for it, because the image kernel will switch over to its
own page tables first and it will use its own kernel text mapping from
that point on.  That may not be the same as the text mapping of the
(currently running) restore (or "boot") kernel.

So if we set up the text mapping in temp_level4_pgt upfront, we
basically can't reference the original kernel text (or do any
addressing relative to it) any more after switching over to
temp_level4_pgt.

For some reason I thought that was not doable, but now that I look at
the code it looks like it can be done.  I'll try doing that.

> I suspect whatever corruption happens boils down to the same issue
> that made people do that odd decision in the first place.

The breakage appears to happen regardless of these changes, though.

> And regardless, those games are too ugly to live. So I would suggest
> that that original commit should just be considered broken, and
> reverted (or just removed - I'm not sure if it's in a stable branch or
> not) and the fix be rethought so that the code mapping can be done
> once and for all and *without* the extra games.

OK

Thanks,
Rafael
