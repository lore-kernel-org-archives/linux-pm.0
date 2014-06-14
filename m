From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] make kASLR vs hibernation boot-time selectable
Date: Sat, 14 Jun 2014 02:14:15 +0200
Message-ID: <1517175.iyVMqh7r2z@vostro.rjw.lan>
References: <1402602419-27934-1-git-send-email-keescook@chromium.org> <1737131.VlQuirUC3S@vostro.rjw.lan> <CAGXu5j+BTYup-9cbwSJsKNW4R1e2QY4wVubfpC3s2LVkE4Amow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAGXu5j+BTYup-9cbwSJsKNW4R1e2QY4wVubfpC3s2LVkE4Amow@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, Len Brown <len.brown@intel.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, June 13, 2014 03:59:57 PM Kees Cook wrote:
> On Fri, Jun 13, 2014 at 3:54 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Friday, June 13, 2014 03:07:19 PM Kees Cook wrote:

[cut]

> > I'll have a closer look at that shortly (it's been quite some time since
> > I wrote that code).
> 
> Thanks; I'm trying to get a test environment instrumented too so I can
> look at this. (At the very least, it sounds like we'll still need my
> patch series for other architectures.)

How can I obtain a kernel address of the beginning of a given page
(as represented by struct page) on x86_64 today?

Rafael

