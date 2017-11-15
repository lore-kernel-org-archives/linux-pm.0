From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] x86: use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz" again
Date: Wed, 15 Nov 2017 01:06:37 +0100
Message-ID: <1640278.1Q7Qv8A4h4@aspire.rjw.lan>
References: <20171109103814.70688-1-chao.wang@ucloud.cn> <CA+55aFxkfh1U1kawntYUtz4u610Hcgx-HWgyL+pROzQFA+MOaw@mail.gmail.com> <alpine.DEB.2.20.1711150038120.2221@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46163 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751105AbdKOAGt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Nov 2017 19:06:49 -0500
In-Reply-To: <alpine.DEB.2.20.1711150038120.2221@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, WANG Chao <chao.wang@ucloud.cn>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Mathias Krause <minipli@googlemail.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Wednesday, November 15, 2017 12:53:24 AM CET Thomas Gleixner wrote:
> On Tue, 14 Nov 2017, Linus Torvalds wrote:
> 
> > On Tue, Nov 14, 2017 at 2:47 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > So what about the one below?  It works for me as expected.
> > 
> > Can somebody with 100+ cores test this? Ingo? You had a 160 core
> > machine that took forever, didn't you..
> 
> On a 144 CPUs machine:
> 
> time cat /proc/cpuinfo >/dev/null
> 
> Current head:
> 
> real	0m0.003s
> user	0m0.000s
> sys	0m0.002s
> 
> Current head + Raphaels patch:
> 
> real	0m0.029s
> user	0m0.000s
> sys	0m0.010s
> 
> So that patch is actually slower.

Thanks for testing!

It is adding a delay (mostly because it has to allow APERF and MPERF to grow
somewhat for the frequency computation to produce a useful result), so it will
be slower even in theory, but really the question is whether or not the slow
down is acceptable.

It doesn't look horrible to me, but that's my patch after all. :-)
