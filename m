From: Meelis Roos <mroos@linux.ee>
Subject: Re: 4.7-rc6: NMI in intel_idle on HP Proliant G6
Date: Tue, 12 Jul 2016 15:27:19 +0300 (EEST)
Message-ID: <alpine.LRH.2.20.1607121525060.2088@math.ut.ee>
References: <alpine.LRH.2.20.1607121445020.2088@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.20.1607121445020.2088@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

> On HP Proliant DL360 G6, Debian unstable 4.6 kernel runs fine but 
> selfcompiled 4.7-rc6 and 4.7-rc7 sometimes crash with NMI from 
> intel_idle. Sometimes it boots fine. With intel_idle disabled, it has 
> booted successful so far in 2 tries, one with rc6 and one with rc7.

More testing shows it can NMI on acpi_idle too, not just intel_idle.

> Screenshot with some backtrace: 
> http://kodu.ut.ee/~mroos/intel-idle-NMI.png

http://kodu.ut.ee/~mroos/acpi-idle-NMI.png

-- 
Meelis Roos (mroos@linux.ee)
