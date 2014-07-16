From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 2/8] cpufreq: add driver for Armada XP
Date: Wed, 16 Jul 2014 17:47:41 +0200
Message-ID: <20140716174741.0399e9f8@free-electrons.com>
References: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1404467103-29644-3-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAKohponuvPd1kWDdB66kxd8TxxYqQ219jCq2D2RGhMHAuZTSWA@mail.gmail.com>
	<20140716160256.7e8dbccf@free-electrons.com>
	<CAKohpomaYfuq0CR5xsf73obTbXsxdBtHToLsNWcW2NQcCd5LUw@mail.gmail.com>
	<20140716172811.2289a64c@free-electrons.com>
	<CAKohpok6-_7aQ1RxSJKLo1idc777LHWLVM=tjtTLOzZjeAUpjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:36263 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964942AbaGPPro (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 11:47:44 -0400
In-Reply-To: <CAKohpok6-_7aQ1RxSJKLo1idc777LHWLVM=tjtTLOzZjeAUpjw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Dear Viresh Kumar,

On Wed, 16 Jul 2014 21:02:29 +0530, Viresh Kumar wrote:

> > Would be good to have this soon, since the 3.17 merge window is
> > approaching. You asked me to use this cpufreq-generic driver instead of
> > a custom cpufreq driver, and I did the work to do that. So now I clearly
> > hope that cpufreq-generic will be merged in 3.17.
> 
> Yeah, I have already pinged Rafael few days back on this. He came back
> from holidays last week and this is what he told me:
> 
> Jul 11 19:58:34 <vireshk> rafael, when are you going to pick stuff for 3.17?
> Jul 11 19:59:11 <rafael> vireshk: next week i suppose

Ok.

> Do you depend on this patch btw?
> 
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg675398.html
> 
> Actually there had been some objections to comparing clocks this way and
> we *might* hold this off, unless the bindings are finalized. Will get all other
> patches merged though.

I'm not sure to fully understand what this patch is doing, but I
believe I depend on it. My system has one clock for each CPU, and
therefore each CPU has a separately controllable frequency. See
http://git.infradead.org/linux-mvebu.git/blob/3843607838cc5436d02a6771e661969a54c2fee0:/arch/arm/boot/dts/armada-xp-mv78460.dtsi#l30
for the Device Tree part describing the CPUs. So the existing
cpufreq-cpu0 (as of 3.16) doesn't work because it assumes there is one
single clock controlling the frequency.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
