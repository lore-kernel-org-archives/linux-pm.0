From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: cpufreq-cpu0: use the max voltage instead
 of voltage-tolerance
Date: Thu, 7 Nov 2013 12:55:42 +0800
Message-ID: <20131107045540.GE5994@S2101-09.ap.freescale.net>
References: <1383621014-11202-1-git-send-email-rongjun.ying@csr.com>
 <CAKohpo=qR5WD=5VjGmeRraQ+_m5NUn8xiP5Z_ZuZWLv1hNx5KA@mail.gmail.com>
 <20131105115307.GN19770@S2101-09.ap.freescale.net>
 <86130EF012BDF348AA0D464A4F44947801295423DF@SHAASIEXM01.ASIA.ROOT.PRI>
 <20131106032742.GP19770@S2101-09.ap.freescale.net>
 <86130EF012BDF348AA0D464A4F44947801295427BD@SHAASIEXM01.ASIA.ROOT.PRI>
 <20131107022639.GB5994@S2101-09.ap.freescale.net>
 <86130EF012BDF348AA0D464A4F4494780129542816@SHAASIEXM01.ASIA.ROOT.PRI>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:16116
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750869Ab3KGEzE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2013 23:55:04 -0500
Content-Disposition: inline
In-Reply-To: <86130EF012BDF348AA0D464A4F4494780129542816@SHAASIEXM01.ASIA.ROOT.PRI>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rongjun Ying <Rongjun.Ying@csr.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, rjying <rjying@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Barry Song <Barry.Song@csr.com>

On Thu, Nov 07, 2013 at 03:32:09AM +0000, Rongjun Ying wrote:
> I think my patch is better.

Well, unfortunately your patch is plainly wrong, because there are
in-tree users of voltage-tolerance right now.  How can you simply remove
it from driver with ignoring these users?

$ git grep voltage-tolerance arch/arm/boot/dts
arch/arm/boot/dts/am33xx.dtsi:                  voltage-tolerance = <2>; /* 2 percentage */
arch/arm/boot/dts/imx27.dtsi:                   voltage-tolerance = <5>;
arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts:        voltage-tolerance = <1>; /* 1% */
arch/arm/boot/dts/r8a73a4-ape6evm.dts:  voltage-tolerance = <1>; /* 1% */
arch/arm/boot/dts/sh73a0-kzm9g-reference.dts:                   voltage-tolerance = <1>; /* 1% */

Shawn

> All soc have a max work voltage. If regulator IC can't supply min voltage, 
> It can supply max voltage to soc.
> As my patch, not need overwrite OPP in <board>.dts.
> As your comment above, almost all board need overwrite OPP, unless the regulator 
> IC can supply all voltage ranges of SoC need.

