From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v8 6/8] drivers: cpuidle: CPU idle ARM64 driver
Date: Mon, 29 Sep 2014 12:08:04 +0100
Message-ID: <20140929110804.GC2165@e102568-lin.cambridge.arm.com>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1409585324-3678-7-git-send-email-lorenzo.pieralisi@arm.com>
 <20140903173740.GJ1824@e102568-lin.cambridge.arm.com>
 <20140904160320.GB22354@arm.com>
 <20140904172909.GA14822@e102568-lin.cambridge.arm.com>
 <20140905092120.GG13515@arm.com>
 <20140905153457.GA26306@e102568-lin.cambridge.arm.com>
 <54115D16.30206@linaro.org>
 <20140911085727.GA25773@e102568-lin.cambridge.arm.com>
 <5415C968.90303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:45940 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbaI2LIN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Sep 2014 07:08:13 -0400
In-Reply-To: <5415C968.90303@gmail.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter

On Sun, Sep 14, 2014 at 05:59:20PM +0100, Tomasz Figa wrote:

[...]

> About the patch 8 alone, somebody would have to test it. Maybe Bart or
> Krzysztof could find some time to look at this? Other than that, I'm not
> quite sure about entry latency you specified. It would look like
> entering the state takes longer time than leaving, which I believe is
> not the case. However I can't find any place in the code which would use
> entry latency, so it might not be that important for now.

I added that entry latency value because I thought that when entering that
idle state the CPU had to flush the outercache, which I do not think that's
what's really happening on Exynos.

Since Bart's patch to define cpu nodes in DT is making it to the
mainline, this leaves us time to find out what that entry-latency-us value
should be and patch the dts accordingly (Exynos CPUidle DT changes are
not making it for this cycle, so we have time to update the patch
accordingly).

entry-latency-us is used to compute CPUidle exit_latency so it has to be
correct, and I rely on Samsung guys to provide me with that value, or
I will ask them to set it properly for me.

Thanks,
Lorenzo

