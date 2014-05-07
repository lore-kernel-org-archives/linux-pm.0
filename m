From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 0/8] Introduce new cpufreq helper macros
Date: Thu, 08 May 2014 00:37:27 +0200
Message-ID: <1628906.bvqGfBpWxn@vostro.rjw.lan>
References: <535AC247.3070907@semaphore.gr> <4469396.zveA7sC36d@vostro.rjw.lan> <536A3654.20201@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53329 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751862AbaEGWUs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 May 2014 18:20:48 -0400
In-Reply-To: <536A3654.20201@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Jesper Nilsson <jesper.nilsson@axis.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "David S. Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Sekhar Nori <nsekhar@ti.com>, Samuel Ortiz <samuel@sortiz.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Wednesday, May 07, 2014 04:34:12 PM Stratos Karafotis wrote:
> Hi Rafael,
>=20
> On 07/05/2014 04:13 =CE=BC=CE=BC, Rafael J. Wysocki wrote:
> > On Wednesday, May 07, 2014 10:53:16 AM Viresh Kumar wrote:
> >> On 6 May 2014 23:25, Stratos Karafotis <stratosk@semaphore.gr> wro=
te:
> >>> My bad. I'm sorry for this. :(
> >>>
> >>> Rafael,
> >>> A solution could be to make cpufreq_next_valid an inline function=
 in cpufreq.h,
> >>> but as Viresh mentioned this would be very inefficient because of=
 multiple copies.
> >>
> >> That statement was true when we didn't had this problem..
> >>
> >>> So, maybe it's better to revert the 2 patches that don't depend o=
n CONFIG_CPU_FREQ:
> >>>
> >>> 4229e1c61a4a ("sh: clk: Use cpufreq_for_each_valid_entry macro fo=
r iteration") and
> >>> 04ae58645afa ("irda: sh_sir: Use cpufreq_for_each_valid_entry mac=
ro for iteration").
> >>
> >> This doesn't look right. It can happen to some other drivers as we=
ll in future.
> >> So, there are two solutions I can think of:
> >> 1. move cpufreq_next_valid and rename it to __cpufreq_next_valid()=
=2E Also make it
> >> inline. Then create two versions of cpufreq_next_valid(), one inli=
ned (only when
> >> CONFIG_CPU_FREQ=3Dn) and other one in cpufreq.c (non- inlined)..
> >>
> >> But probably that would be called ugly by some people :)
> >>
> >> 2. Make cpufreq_next_valid() inline and forget about extra space i=
t takes :)
> >>
> >> @Rafel: Let me know which one you like :)
> >=20
> > 2.
> >=20
> >=20
>=20
> Do you want me to resend the entire patch set or only patch 1/8?

It's already on a branch that cannot be rebased.  Please send me a fix =
on top of it.


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
