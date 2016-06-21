From: Kees Cook <keescook@chromium.org>
Subject: Re: ktime_get_ts64() splat during resume
Date: Tue, 21 Jun 2016 11:04:41 -0700
Message-ID: <CAGXu5j+1_06mKVsV2BeBZtitRk8GtjMPH8_zAxocfxtp7NeLXg@mail.gmail.com>
References: <20160617105435.GB15997@pd.tnic> <CAJZ5v0grcXRW6tukVmyZ3Xi0PqXSyf0+swfOLjxJkNawsSP-QA@mail.gmail.com>
 <3043121.Rmj8QIPsb8@vostro.rjw.lan> <1540485.MOmcxrPnr8@vostro.rjw.lan> <96a692a0-08eb-6d64-d396-82bee5d7a0a1@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <96a692a0-08eb-6d64-d396-82bee5d7a0a1@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stable <stable@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 20, 2016 at 9:35 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> Hey Rafael,
>
> This patch appears to be working on my laptop. Thanks.

Same for me: resume still works with KASLR in my tests too.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
