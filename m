From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86: use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz"
 again
Date: Wed, 15 Nov 2017 08:43:58 +0100
Message-ID: <20171115074358.4jf4sjpq4ffmhmpi@gmail.com>
References: <20171109103814.70688-1-chao.wang@ucloud.cn>
 <CA+55aFw=JkvmxohBtVy-3QPtFibq_rv_uqp3ss+gpo8vSqYGQw@mail.gmail.com>
 <CA+55aFyRYWUn790wumcGNky98gJsDzz8W3Qna1xLC9fwcKOE=Q@mail.gmail.com>
 <2067351.8xeh6jAbVr@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:46074 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754635AbdKOHoC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 02:44:02 -0500
Content-Disposition: inline
In-Reply-To: <2067351.8xeh6jAbVr@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, WANG Chao <chao.wang@ucloud.cn>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Mathias Krause <minipli@googlemail.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>


* Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> On Wednesday, November 15, 2017 1:06:12 AM CET Linus Torvalds wrote:
> > On Tue, Nov 14, 2017 at 4:04 PM, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > > On Tue, Nov 14, 2017 at 3:53 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > >> Current head + Raphaels patch:
> > >>
> > >> real    0m0.029s
> > >> user    0m0.000s
> > >> sys     0m0.010s
> > >>
> > >> So that patch is actually slower.
> > >
> > > Oh it definitely is expected to be slower, because it does the IPI to
> > > all the cores and actually gets their frequency right.
> > >
> > > It was the old one that we had to revert (because it did so
> > > sequentially) that was really bad, and took something like 2+ seconds
> > > on Ingo's 160-core thing, iirc.
> > 
> > Looked it up. Ingo's machine "only" had 120 cores, and he said
> > 
> >     fomalhaut:~> time cat /proc/cpuinfo  >/dev/null
> >     real    0m2.689s
> > 
> > for the bad serial case, so yeah, it looks "a bit" better than it was ;)
> 
> OK, so may I queue it up?
> 
> I don't think I can get that to work substantially faster anyway ...

The new version is OK I suppose:

  Acked-by: Ingo Molnar <mingo@kernel.org>

I also think that /proc/cpuinfo is a pretty bad interface for many uses - I 
personally only very rarely need the cpuinfo of _all_ CPUs.

We we should eventually have /proc/cpu/N/info or so, so that 99% of the times 
cpuinfo is needed to report bugs we can do:

	cat /proc/cpu/0/info

With maybe also the following variants:

	/proc/cpu/first/
	/proc/cpu/last/
	/proc/cpu/current/

... to the first/last/current CPUs.

Thanks,

	Ingo
