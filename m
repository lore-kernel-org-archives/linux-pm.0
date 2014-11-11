From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] cpufreq: qoriq: Make the driver usable on all QorIQ
 platforms
Date: Tue, 11 Nov 2014 13:09:40 -0600
Message-ID: <1415732980.15957.33.camel@freescale.com>
References: <1413515616-15874-1-git-send-email-B29983@freescale.com>
	 <CAKohpokotKSvQ13uU4MnCer+qzBUUbGVTd19y7xswCAEKk3nGQ@mail.gmail.com>
	 <6aaa50ef5f234fe2896f1c66eb646dfb@DM2PR03MB574.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6aaa50ef5f234fe2896f1c66eb646dfb@DM2PR03MB574.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuantian Tang <Yuantian.Tang@freescale.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2014-10-21 at 08:59 +0000, Yuantian Tang wrote:
> > > -config PPC_CORENET_CPUFREQ
> > > -       tristate "CPU frequency scaling driver for Freescale E500MC SoCs"
> > > -       depends on PPC_E500MC && OF && COMMON_CLK
> > > +config QORIQ_CPUFREQ
> > > +       tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
> > > +       depends on OF && COMMON_CLK
> > >         select CLK_PPC_CORENET
> > >         help
> > > -         This adds the CPUFreq driver support for Freescale e500mc,
> > > -         e5500 and e6500 series SoCs which are capable of changing
> > > -         the CPU's frequency dynamically.
> > > +         This adds the CPUFreq driver support for Freescale QorIQ SoCs
> > > +         which are capable of changing the CPU's frequency dynamically.
> > >
> > >  config CPU_FREQ_PMAC
> > >         bool "Support for Apple PowerBooks"
> > 
> > Don't need this duplication at all. Just move this to Kconfig instead of .arm and
> > ppc.
> > 
> If I do so, menuconfig will display like this(on PPC):
> 	PowerPC CPU frequency scaling drivers  ----  
>     QorIQ CPU Frequency scaling  --->    
>   		<*> CPU frequency scaling driver for Freescale QorIQ SoCs
> On ARM, there should be a similar problem.
> Isn't weird?

What purpose do those "<arch> CPU frequency scaling drivers" submenus
serve, versus just including the options in the main cpufreq menu?  It's
not as if more than one arch would be visible at once (and when a
situation with multiple visible menus popped up, it was considered a
bug).

-Scott
