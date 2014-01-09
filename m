From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V3 Resend] cpufreq: create cpufreq_generic_get() routine
Date: Thu, 9 Jan 2014 11:33:00 +0000
Message-ID: <20140109113300.GA27432@n2100.arm.linux.org.uk>
References: <d9239e0a5df99392647ff8343673342f89d09476.1389059568.git.viresh.kumar@linaro.org> <CAOesGMgfFVoVJpOMXWtzVWj_F4pD-L9Osyv4u6=c8RUWOoLHFw@mail.gmail.com> <CAKohpo=EsaBPdF3wYsa2rEdjcpPagbhPcxWw1_PA=yVLDnjRiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60305 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750905AbaAILdT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2014 06:33:19 -0500
Content-Disposition: inline
In-Reply-To: <CAKohpo=EsaBPdF3wYsa2rEdjcpPagbhPcxWw1_PA=yVLDnjRiA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Fengguang Wu <fengguang.wu@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jan 09, 2014 at 02:56:28PM +0530, Viresh Kumar wrote:
> Naah.. After some investigation I found this:
> 
> - We already have dummy implementations of clk routines in case
> CONFIG_HAVE_CLK is not defined (I added them long back).
> 
> - There is one thing common among all above defconfigs, all
> belong to SA1100 family :)
> 
> - And the problem is: SA1100 wanted to define its own clk routines
> and selects CLKDEV_LOOKUP (which enables HAVE_CLK), but it
> doesn't implement all clk routines. Which is *wrong*.

No, it implements only what it's clk API implementation requires.

> @Russell: If above looks correct then can you please communicate
> what should we do here? I don't really know what exactly these
> routines should have, simply a copy of dummy routines from clk.h
> or some meaningful stuff. So, maybe you can write a patch, otherwise
> let me know what to write and I will give it a try.

I've no idea at the moment, and I don't have time to look at this.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
