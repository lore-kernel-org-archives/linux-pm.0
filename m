From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: Montreal Linux Power Management Mini-Summit, July 13, 2009 -
	Meeting Notes
Date: Wed, 2 Sep 2009 00:22:14 +0200
Message-ID: <63386a3d0909011522m7a175d3eyb3bbe8a29a5fd104@mail.gmail.com>
References: <alpine.LFD.2.00.0905211430220.4390@localhost.localdomain>
	 <alpine.LFD.2.00.0907301801240.17818@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755286AbZIAWWO@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0907301801240.17818@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Linux Power Management List <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

2009/7/31 Len Brown <lenb@kernel.org>:

> A Linux Power Management "mini-summit" was held on July 13th, 2009 -
> on the first day of the Montreal Linux Symposium.
> (...)

> SH running cpufreq on top of clock framework
> =A0 =A0 =A0 =A0cpufreq has notifiers, clock framework does not

Hm! Paul can you elaborate on what that was about.

I've felt a need for clock notifiers and we've cheated by using
CPUfreq because it so happens that the clocking in system-wide
and whenever the CPU freq change so may the other clocks.

But if I put code into a PrimeCell MMC/SPI/I2C driver or whatever and
use CPUfreq that's very unelegant, and for other platforms where
the CPU freq don't change when this particular device clk freq
change plain misleading.

A clk pre/postchange notifier pair would really help and would
make for elegant drivers that can handle clock freq transitions.

Has anyone poked at this?

Linus Walleij
