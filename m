From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: 4.7-rc6: NMI in intel_idle on HP Proliant G6
Date: Tue, 12 Jul 2016 14:40:23 +0200
Message-ID: <5630546.0MIYeGNSYG@vostro.rjw.lan>
References: <alpine.LRH.2.20.1607121445020.2088@math.ut.ee> <alpine.LRH.2.20.1607121525060.2088@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.20.1607121525060.2088@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 12, 2016 03:27:19 PM Meelis Roos wrote:
> > On HP Proliant DL360 G6, Debian unstable 4.6 kernel runs fine but 
> > selfcompiled 4.7-rc6 and 4.7-rc7 sometimes crash with NMI from 
> > intel_idle. Sometimes it boots fine. With intel_idle disabled, it has 
> > booted successful so far in 2 tries, one with rc6 and one with rc7.
> 
> More testing shows it can NMI on acpi_idle too, not just intel_idle.
> 
> > Screenshot with some backtrace: 
> > http://kodu.ut.ee/~mroos/intel-idle-NMI.png
> 
> http://kodu.ut.ee/~mroos/acpi-idle-NMI.png

There were almost no changes in the ACPI idle driver between 4.6 and
4.7-rc, so the reason is somewhere else.

Have you tried any earlier 4.7-rc?

The only change between 4.6 and now in the ACPI processor stuff at all is
this one

86314751c794 ACPI / processor: Avoid reserving IO regions too early

so does it help if that's reverted?

Otherwise, any chances to bisect?

Thanks,
Rafael
