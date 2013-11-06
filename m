From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: cpufreq-cpu0: use the max voltage instead
 of voltage-tolerance
Date: Wed, 6 Nov 2013 11:27:44 +0800
Message-ID: <20131106032742.GP19770@S2101-09.ap.freescale.net>
References: <1383621014-11202-1-git-send-email-rongjun.ying@csr.com>
 <CAKohpo=qR5WD=5VjGmeRraQ+_m5NUn8xiP5Z_ZuZWLv1hNx5KA@mail.gmail.com>
 <20131105115307.GN19770@S2101-09.ap.freescale.net>
 <86130EF012BDF348AA0D464A4F44947801295423DF@SHAASIEXM01.ASIA.ROOT.PRI>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-db9lp0251.outbound.messaging.microsoft.com ([213.199.154.251]:48997
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751050Ab3KFD1I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2013 22:27:08 -0500
Content-Disposition: inline
In-Reply-To: <86130EF012BDF348AA0D464A4F44947801295423DF@SHAASIEXM01.ASIA.ROOT.PRI>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rongjun Ying <Rongjun.Ying@csr.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, rjying <rjying@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "rongjun.ying@gcsr.com" <rongjun.ying@gcsr.com>

On Wed, Nov 06, 2013 at 02:15:07AM +0000, Rongjun Ying wrote:
> If omit voltage-tolerance, sometimes also can't get appropriate voltages.
> For example:
> If the regulator IC only can supply min voltage is 1.000V and max voltage is 1.200V, and cpu work max voltage is 1.200V.
> But the cpu just need 1.100V when cpu run under a freq.
> So regulator_set_voltage_tol will return failed. 
> Because the regulator_set_voltage will invoke with min-uV is 1100000 and max-uV is 1100000 parameters.
> Regulator can't supply it.
> As this case, the regulator just need supply 1.200V.

For given board, what voltages could be provided is known.  So you can
just define OPP table in <board>.dts and specify the voltage as the
value that the regulator IC can supply, e.g. 1.200V in above example.

This is not nice, as OPP table is CPU/SoC specific and should be ideally
defined in <soc>.dtsi.  But still it's a way out for you to use
cpufreq-cpu0 driver as it is.

In any case, you can not just change voltage-tolerance to voltage-max
with no care about the existing users.

Shawn

