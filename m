From: Meelis Roos <mroos@linux.ee>
Subject: Re: 4.7-rc6: NMI in intel_idle on HP Proliant G6
Date: Wed, 13 Jul 2016 10:21:27 +0300 (EEST)
Message-ID: <alpine.LRH.2.20.1607131018150.20366@math.ut.ee>
References: <alpine.LRH.2.20.1607121445020.2088@math.ut.ee> <alpine.LRH.2.20.1607121525060.2088@math.ut.ee> <5630546.0MIYeGNSYG@vostro.rjw.lan> <alpine.LRH.2.20.1607121654490.2088@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.20.1607121654490.2088@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> > > > On HP Proliant DL360 G6, Debian unstable 4.6 kernel runs fine but 
> > > > selfcompiled 4.7-rc6 and 4.7-rc7 sometimes crash with NMI from 
> > > > intel_idle. Sometimes it boots fine. With intel_idle disabled, it has 
> > > > booted successful so far in 2 tries, one with rc6 and one with rc7.
> > > 
> > > More testing shows it can NMI on acpi_idle too, not just intel_idle.
> > > 
> > > > Screenshot with some backtrace: 
> > > > http://kodu.ut.ee/~mroos/intel-idle-NMI.png
> > > 
> > > http://kodu.ut.ee/~mroos/acpi-idle-NMI.png
> > 
> > There were almost no changes in the ACPI idle driver between 4.6 and
> > 4.7-rc, so the reason is somewhere else.
> > 
> > Have you tried any earlier 4.7-rc?
> 
> I tried selfcompiled 4.6.0 now with the same conf that 4.7-rc's have and 
> after multiple tries I got the same NMI out of 4.6 too, from kernfs 
> lookup (that seems to just a random victim).
> 
> So this is not a 4.7 regression and probably not idle-releated.

Confirmed this is about IOMMU+DMAR, I'm continuing in another reply 
thread with other CC-s to not bother linux-pm people with it.

-- 
Meelis Roos (mroos@linux.ee)
