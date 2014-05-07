From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 0/8] Introduce new cpufreq helper macros
Date: Wed, 07 May 2014 15:13:18 +0200
Message-ID: <4469396.zveA7sC36d@vostro.rjw.lan>
References: <535AC247.3070907@semaphore.gr> <5369220A.3030207@semaphore.gr> <CAKohpo=3_7G+3bMF2CpWgZXvktdXBkCi4-tCxogwGcvvEEh18w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=3_7G+3bMF2CpWgZXvktdXBkCi4-tCxogwGcvvEEh18w@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, Geert Uytterhoeven <geert@linux-m68k.org>, Jesper Nilsson <jesper.nilsson@axis.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "David S. Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Sekhar Nori <nsekhar@ti.com>, Samuel Ortiz <samuel@sortiz.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, May 07, 2014 10:53:16 AM Viresh Kumar wrote:
> On 6 May 2014 23:25, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> > My bad. I'm sorry for this. :(
> >
> > Rafael,
> > A solution could be to make cpufreq_next_valid an inline function in cpufreq.h,
> > but as Viresh mentioned this would be very inefficient because of multiple copies.
> 
> That statement was true when we didn't had this problem..
> 
> > So, maybe it's better to revert the 2 patches that don't depend on CONFIG_CPU_FREQ:
> >
> > 4229e1c61a4a ("sh: clk: Use cpufreq_for_each_valid_entry macro for iteration") and
> > 04ae58645afa ("irda: sh_sir: Use cpufreq_for_each_valid_entry macro for iteration").
> 
> This doesn't look right. It can happen to some other drivers as well in future.
> So, there are two solutions I can think of:
> 1. move cpufreq_next_valid and rename it to __cpufreq_next_valid(). Also make it
> inline. Then create two versions of cpufreq_next_valid(), one inlined (only when
> CONFIG_CPU_FREQ=n) and other one in cpufreq.c (non- inlined)..
> 
> But probably that would be called ugly by some people :)
> 
> 2. Make cpufreq_next_valid() inline and forget about extra space it takes :)
> 
> @Rafel: Let me know which one you like :)

2.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
