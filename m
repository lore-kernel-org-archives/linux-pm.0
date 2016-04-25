From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 10/10] cpufreq: mvebu: Use generic platdev driver
Date: Mon, 25 Apr 2016 17:55:03 +0200
Message-ID: <20160425175503.28ef34d9@free-electrons.com>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
	<17150729.NF4MViUffk@wuerfel>
	<20160425152914.GI6104@vireshk-i7>
	<5536968.ADFL5hRmGD@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:38290 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932723AbcDYPzQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 11:55:16 -0400
In-Reply-To: <5536968.ADFL5hRmGD@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, nm@ti.com, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hello,

On Mon, 25 Apr 2016 17:46:53 +0200, Arnd Bergmann wrote:

> > What code are you talking about? Initializing the OPPs or adding the
> > cpufreq-dt device? The first one (or whatever is left now in that
> > function) can stay anywhere, even as a cpufreq driver. I was talking
> > about the fact that we don't have a sequence problem to solve here.
> 
> My line of thinking was that the armada_xp_pmsu_cpufreq_init()
> function makes sense by itself and feels like it should be
> one file in drivers/cpufreq, including the creation of the device.
> 
> Even without the argument of the sequencing, they two parts sort
> of belong together because the cpufreq-dt driver depends on both
> of them being run before it can function. It's also the same amount
> of code, as you are replacing one line in armada_xp_pmsu_cpufreq_init
> with one line in "struct of_device_id machines".
> 
> It's not really that important, just a feeling I had that it could
> be done better. Unless the mvebu maintainers feel strongly about
> it, just do as you prefer.

As a mvebu folk, I don't really have a strong opinion on this. We also
have some cpufreq device registration code in
arch/arm/mach-mvebu/kirkwood.c for the older Kirkwood platform, though
this one uses a custom cpufreq driver and not the generic cpufreq-dt
driver.

Ideally, in the grand direction of removing as much things as possible
from mach-<foo> directories, it would be great to move such
initializations somewhere else. But cpufreq is not by far not the only
reason why we still have code in mach-<foo>, at least in the mvebu land.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
