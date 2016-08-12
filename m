From: Thomas Garnier <thgarnie@google.com>
Subject: Re: [PATCH v1] x86/power/64: Restore processor state before using
 per-cpu variables
Date: Fri, 12 Aug 2016 09:03:05 -0700
Message-ID: <CAJcbSZHG3ULCATigD0hhzOEXWi+GiDhtiBQdgaTiYnkP3k2fHw@mail.gmail.com>
References: <1470952169-39061-1-git-send-email-thgarnie@google.com>
 <alpine.LNX.2.00.1608120800100.22028@cbobk.fhfr.pm> <alpine.LNX.2.00.1608121044120.22028@cbobk.fhfr.pm>
Reply-To: kernel-hardening@lists.openwall.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-hardening-return-4364-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <alpine.LNX.2.00.1608121044120.22028@cbobk.fhfr.pm>
To: Jiri Kosina <jikos@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Borislav Petkov <bpetkov@suse.de>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 12, 2016 at 2:23 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Fri, 12 Aug 2016, Jiri Kosina wrote:
>
> That's pretty nasty, as turning LOCKDEP on has sideffects on the code
> that'd normally not be expected to be run at all (tracepoint off).
>
> Oh well.

Thanks for the analysis, I didn't got that far so I had no idea how
everything was connected.

> Thanks again,

Thanks you and Borislav for finding it.
