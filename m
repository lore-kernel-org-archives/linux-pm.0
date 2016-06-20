From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: ktime_get_ts64() splat during resume
Date: Mon, 20 Jun 2016 11:29:47 -0700
Message-ID: <CA+55aFwGshPVCeBeMbY_RYrA+UR7-jLjy4SCbcHTxQ=f2KwESA@mail.gmail.com>
References: <20160617105435.GB15997@pd.tnic> <20160617161247.GB3912@pd.tnic>
 <CAJZ5v0jZypC17Qbvn3TXe5Z6M5JrGaktAwXQwAW=UEhccRv=nw@mail.gmail.com> <2816580.laIl5zA8fL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <2816580.laIl5zA8fL@vostro.rjw.lan>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Borislav Petkov <bp@alien8.de>, Logan Gunthorpe <logang@deltatee.com>, Kees Cook <keescook@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stable <stable@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 20, 2016 at 7:38 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Overall, we seem to be heading towards the "really weird" territory here.

So the whole commit that Boris bisected down to is weird to me.

Why isn't the temporary text mapping just set up unconditionally in
the temp_level4_pgt?

Why does it have that insane "let's leave the temp_level4_pgt alone
until we actually switch to it, and save away restore_pgd_addr and the
restore_pgd, to then be set up at restore time"?

All the other temporary mappings are set up statically in the
temp_level4_pgt, why not that one?

I suspect whatever corruption happens boils down to the same issue
that made people do that odd decision in the first place.

And regardless, those games are too ugly to live. So I would suggest
that that original commit should just be considered broken, and
reverted (or just removed - I'm not sure if it's in a stable branch or
not) and the fix be rethought so that the code mapping can be done
once and for all and *without* the extra games.

                 Linus
