From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ktime_get_ts64() splat during resume
Date: Wed, 22 Jun 2016 01:29:43 +0200
Message-ID: <7413367.x7aK2JsW8t@vostro.rjw.lan>
References: <20160617105435.GB15997@pd.tnic> <96a692a0-08eb-6d64-d396-82bee5d7a0a1@deltatee.com> <CAGXu5j+1_06mKVsV2BeBZtitRk8GtjMPH8_zAxocfxtp7NeLXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAGXu5j+1_06mKVsV2BeBZtitRk8GtjMPH8_zAxocfxtp7NeLXg@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Logan Gunthorpe <logang@deltatee.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stable <stable@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 21, 2016 11:04:41 AM Kees Cook wrote:
> On Mon, Jun 20, 2016 at 9:35 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> > Hey Rafael,
> >
> > This patch appears to be working on my laptop. Thanks.
> 
> Same for me: resume still works with KASLR in my tests too.

Thanks for the confirmation!

Rafael
