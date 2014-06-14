From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/2] make kASLR vs hibernation boot-time selectable
Date: Fri, 13 Jun 2014 17:08:21 -0700
Message-ID: <CAGXu5jJSqV2MeuofJP4OEiDytQBqKMgC3cj+tguiwTmpRX1wSQ@mail.gmail.com>
References: <1402602419-27934-1-git-send-email-keescook@chromium.org>
	<1737131.VlQuirUC3S@vostro.rjw.lan>
	<CAGXu5j+BTYup-9cbwSJsKNW4R1e2QY4wVubfpC3s2LVkE4Amow@mail.gmail.com>
	<1517175.iyVMqh7r2z@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1517175.iyVMqh7r2z@vostro.rjw.lan>
Sender: linux-doc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, Len Brown <len.brown@intel.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 13, 2014 at 5:14 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, June 13, 2014 03:59:57 PM Kees Cook wrote:
>> On Fri, Jun 13, 2014 at 3:54 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Friday, June 13, 2014 03:07:19 PM Kees Cook wrote:
>
> [cut]
>
>> > I'll have a closer look at that shortly (it's been quite some time since
>> > I wrote that code).
>>
>> Thanks; I'm trying to get a test environment instrumented too so I can
>> look at this. (At the very least, it sounds like we'll still need my
>> patch series for other architectures.)
>
> How can I obtain a kernel address of the beginning of a given page
> (as represented by struct page) on x86_64 today?

I don't know off the top of my head. I've used virt_to_phys, but
things like PFN_PHYS(page_to_pfn(page)) maybe? I'm not entirely clear
which you need, but mm.h seems to have the bulk of what I've seen.

-Kees

-- 
Kees Cook
Chrome OS Security
