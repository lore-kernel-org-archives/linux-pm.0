From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: CPUIdle for Exynos5422 Odroid-XU3/XU4 boards.
Date: Tue, 25 Aug 2015 16:35:29 +0200
Message-ID: <4468206.R1amSm9GHX@amdc1976>
References: <CANAwSgTWZ1a+j8RTiamsKaALKf+ekLVqtO6RFTLXkG=bJN4BPQ@mail.gmail.com>
 <CAJKOXPeFVwmRzP3YPSaJ_PtNf3L3pzXSXVqHwyYfWDYwhTmsBQ@mail.gmail.com>
 <55DC38CA.9090202@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:54587 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbbHYOhV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2015 10:37:21 -0400
In-reply-to: <55DC38CA.9090202@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Anand Moon <linux.amoon@gmail.com>, Daniel Lezcano <daniel.lezcano@free.fr>, Kukjin Kim <kgene@kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Przemyslaw Marczak <p.marczak@samsung.com>, Kevin Hilman <khilman@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org


[ added Lorenzo and linux-pm to Cc: ]

Hi,

On Tuesday, August 25, 2015 11:43:38 AM Javier Martinez Canillas wrote:
> [adding Kevin Hilman as cc who was also interested in CPUidle for Exynos]
> 
> Hello Krzysztof,
> 
> On 08/23/2015 03:26 AM, Krzysztof Kozlowski wrote:
> 
> [snip]
> 
> > 2015-08-21 16:21 GMT+09:00 Javier Martinez Canillas <javier@osg.samsung.com>:
> > 
> > The big.LITTLE cpuidle driver is not a typical Exynos cpuidle driver.
> > It only executes CPU suspend on a cluster which essentially is a power
> > down operation.
> >
> 
> You are correct, looking at the the big.LITTLE CPUidle driver I see that
> it only has two C-states: C0 (normal WFI) and C1 (single CPU power-down)
> which as you said, places the CPU into power-down mode by using the MCPM
> infrastructure so it's basically a CPU suspend AFAIU.
> 
> So what you are saying is that there are deeper C-states supported by the
> Exynos 542x SoC family but these are not handled by the b.L CPUidle driver.
>  
> > When we talk about cpuidle on Exynos, we have in mind one of sleep
> > modes: AFTR or LPA (sometimes instead of LPA there is LPD or W-AFTR).
> > Actually this is more like a system idle mode, not CPU idle. The power
> > savings are much bigger than disabling only one cluster.
> >
> 
> Interesting, I was not aware of AFTR and LPA but I looked in the manual now.
> Thanks a lot for the information.
> 
> I see that the Exynos CPUidle driver (drivers/cpuidle/cpuidle-exynos.c) also
> has only two C-states (WFI and C1) but C1 makes the system to enter in AFTR
> (system-level power gating).
> 
> This is similar to what the downstream ChromiumOS 3.8 kernel CPUidle driver
> does IIUC [0].

Yes but upstream does it in a clean way, has support for platforms
requiring secure firmware operations and also implements coupled
AFTR mode on a few platforms.

> > So the question is still valid - whether someone wants or plans to
> > implement cpuidle for Exynos 542x family. Odroid XU3 is not a priority
> > here because energy consumption is not an issue there. This is not a
> > mobile device.
> >
> 
> That's true but it will be interesting for the 5420 and 5800 based
> Chromebooks since optimizing power consumption would be useful there.

I would be happy to help with reviewing patches etc. but personally
I don't have any plans for doing this work.  I may look into adding
support for newer ARM64 SoCs (Exynos5433) if I find some extra time
(quite unlikely currently).

> I thought that big.LITTLE platforms were encouraged to use the generic b.L
> CPUidle driver just like DT platforms should use the generic CPUFreq DT
> driver but I guess I misunderstood.
> 
> So the b.L CPUidle driver is only to have minimum CPUidle support but a SoC
> specific driver is needed to fine tune and get most out of the platform?
> 
> Or should the b.L CPUidle driver be extended to add per platform C-states?

This is a good question. Daniel/Lorenzo?

> > Best regards,
> > Krzysztof
> >
> 
> [0]: https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.8/arch/arm/mach-exynos/cpuidle.c

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

