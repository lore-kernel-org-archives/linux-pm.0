From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/10] cpufreq: mvebu: Use generic platdev driver
Date: Mon, 25 Apr 2016 17:46:53 +0200
Message-ID: <5536968.ADFL5hRmGD@wuerfel>
References: <cover.1461228504.git.viresh.kumar@linaro.org> <17150729.NF4MViUffk@wuerfel> <20160425152914.GI6104@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:59446 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783AbcDYPsA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 11:48:00 -0400
In-Reply-To: <20160425152914.GI6104@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, nm@ti.com, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Monday 25 April 2016 20:59:14 Viresh Kumar wrote:
> On 25-04-16, 17:26, Arnd Bergmann wrote:
> > On Monday 25 April 2016 18:26:05 Viresh Kumar wrote:
> > > On 25-04-16, 14:53, Arnd Bergmann wrote:
> > > > What are the downsides of moving armada_xp_pmsu_cpufreq_init()
> > > > into drivers/cpufreq?
> > > 
> > > More special code :)
> > 
> > Of course the special code still exists, it seems more like neither of
> > us wants to have it in the portion of the kernel that he maintains ;-)
> 
> Hehe.. But after $subject patch, we don't have any special code for
> creating the device, isn't it?
> 
> > Maybe the mvebu maintainers have a preference where they'd like the
> > code to be, they are the ones that are most impacted if anything
> > goes wrong.
> 
> What code are you talking about? Initializing the OPPs or adding the
> cpufreq-dt device? The first one (or whatever is left now in that
> function) can stay anywhere, even as a cpufreq driver. I was talking
> about the fact that we don't have a sequence problem to solve here.

My line of thinking was that the armada_xp_pmsu_cpufreq_init()
function makes sense by itself and feels like it should be
one file in drivers/cpufreq, including the creation of the device.

Even without the argument of the sequencing, they two parts sort
of belong together because the cpufreq-dt driver depends on both
of them being run before it can function. It's also the same amount
of code, as you are replacing one line in armada_xp_pmsu_cpufreq_init
with one line in "struct of_device_id machines".

It's not really that important, just a feeling I had that it could
be done better. Unless the mvebu maintainers feel strongly about
it, just do as you prefer.

	Arnd
