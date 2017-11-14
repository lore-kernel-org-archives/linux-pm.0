From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86: use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz"
 again
Date: Wed, 15 Nov 2017 00:53:24 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1711150038120.2221@nanos>
References: <20171109103814.70688-1-chao.wang@ucloud.cn> <CA+55aFycTaZjKg1SGujkMrOX5WmUyWHvy2ujzaV8jefOfDPy_Q@mail.gmail.com> <CAJZ5v0iPt8VKoM8BuRA7O+U+fk7dg37sqVJ0pi2=S8muqfznPQ@mail.gmail.com> <2101739.Je3pS2vcJU@aspire.rjw.lan>
 <CA+55aFxkfh1U1kawntYUtz4u610Hcgx-HWgyL+pROzQFA+MOaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:39656 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932073AbdKNXxw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Nov 2017 18:53:52 -0500
In-Reply-To: <CA+55aFxkfh1U1kawntYUtz4u610Hcgx-HWgyL+pROzQFA+MOaw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, WANG Chao <chao.wang@ucloud.cn>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Mathias Krause <minipli@googlemail.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Tue, 14 Nov 2017, Linus Torvalds wrote:

> On Tue, Nov 14, 2017 at 2:47 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > So what about the one below?  It works for me as expected.
> 
> Can somebody with 100+ cores test this? Ingo? You had a 160 core
> machine that took forever, didn't you..

On a 144 CPUs machine:

time cat /proc/cpuinfo >/dev/null

Current head:

real	0m0.003s
user	0m0.000s
sys	0m0.002s

Current head + Raphaels patch:

real	0m0.029s
user	0m0.000s
sys	0m0.010s

So that patch is actually slower.

Thanks,

	tglx
