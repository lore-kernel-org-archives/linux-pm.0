From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] x86/power/64: Do not refer to __PAGE_OFFSET from assembly code
Date: Sat, 06 Aug 2016 01:12:30 +0200
Message-ID: <3091490.MoJzMOfeFu@vostro.rjw.lan>
References: <1470071280-78706-1-git-send-email-thgarnie@google.com> <1601227.1rWnhT6gJp@vostro.rjw.lan> <CAJcbSZFTA8v6KEdWZ9rj8qMQUREhpexExO0BxmaWBmW2_f2TxA@mail.gmail.com>
Reply-To: kernel-hardening@lists.openwall.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <kernel-hardening-return-4270-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <CAJcbSZFTA8v6KEdWZ9rj8qMQUREhpexExO0BxmaWBmW2_f2TxA@mail.gmail.com>
To: Thomas Garnier <thgarnie@google.com>
Cc: Pavel Machek <pavel@denx.de>, the arch/x86 maintainers <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Yinghai Lu <yinghai@kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel-hardening@lists.openwall.com
List-Id: linux-pm@vger.kernel.org

On Friday, August 05, 2016 08:21:31 AM Thomas Garnier wrote:
> On Fri, Aug 5, 2016 at 7:44 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Friday, August 05, 2016 12:37:13 PM Pavel Machek wrote:
> >> On Wed 2016-08-03 01:19:26, Rafael J. Wysocki wrote:
> >> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> >
> >> > When CONFIG_RANDOMIZE_MEMORY is set on x86-64, __PAGE_OFFSET becomes
> >> > a variable and using it as a symbol in the image memory restoration
> >> > assembly code under core_restore_code is not correct any more.
> >>
> >> On a related note... we should really have page_offset variable in
> >> such case, and use that -- having __FOO_BAR not being a constant is
> >> ugly/confusing/dangerous.
> >>
> >> > To avoid that problem, modify set_up_temporary_mappings() to compute
> >> > the physical address of the temporary page tables and store it in
> >> > temp_level4_pgt, so that the value of that variable is ready to be
> >> > written into CR3.  Then, the assembly code doesn't have to worry
> >> > about converting that value into a physical address and things work
> >> > regardless of whether or not CONFIG_RANDOMIZE_MEMORY is set.
> >> >
> >> > Reported-and-tested-by: Thomas Garnier <thgarnie@google.com>
> >> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> Acked-by: Pavel Machek <pavel@ucw.cz>
> >>
> >> Is similar patch needed for i386?
> >
> > Yes, it is, in general, for i386 hibernation to work with ASLR.
> >
> > But it doesn't work with it for other reasons ATM, AFAICS.
> >
> > Unfortunately, I won't really have the time to take care of this any time
> > soon.
> >
> 
> KASLR memory randomization is only available for x64 right now. I plan
> on porting to 32bit eventually and will test/adapt hibernation as part
> of it.

Great to hear that, but you need to be aware that the i386 hibernate code has
not been touched for a long time and it makes some heavy assumptions that
are not made on x86-64.

Please keep me and Pavel in the loop, though.

Thanks,
Rafael
