From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Fix build error on some platforms that use cpufreq_for_each_*
Date: Thu, 08 May 2014 13:33:59 +0200
Message-ID: <3521459.jky0yxFEoL@vostro.rjw.lan>
References: <536A605D.6030009@semaphore.gr> <CAMuHMdWSMG0ShnkZR4E=HvqNQzk6DEdHQdr0qYqxw1THmOLanA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64859 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753294AbaEHLRT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 May 2014 07:17:19 -0400
In-Reply-To: <CAMuHMdWSMG0ShnkZR4E=HvqNQzk6DEdHQdr0qYqxw1THmOLanA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thursday, May 08, 2014 10:27:15 AM Geert Uytterhoeven wrote:
> Hi Stratos,
> 
> On Wed, May 7, 2014 at 6:33 PM, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> > On platforms that use cpufreq_for_each_* macros, build fails if
> > CONFIG_CPU_FREQ=n, e.g. ARM/shmobile/koelsch/non-multiplatform:
> >
> > drivers/built-in.o: In function `clk_round_parent':
> > clkdev.c:(.text+0xcf168): undefined reference to `cpufreq_next_valid'
> > drivers/built-in.o: In function `clk_rate_table_find':
> > clkdev.c:(.text+0xcf820): undefined reference to `cpufreq_next_valid'
> > make[3]: *** [vmlinux] Error 1
> >
> > Fix this making cpufreq_next_valid function inline and move it to
> > cpufreq.h.
> 
> Thanks!
> 
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> 
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 

Applied, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
