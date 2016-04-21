From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/8] cpufreq: dt: Don't create platform-device from platform code
Date: Thu, 21 Apr 2016 11:49:49 +0200
Message-ID: <4420115.OC4oi9pMlr@wuerfel>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:62101 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbcDUJud (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 05:50:33 -0400
In-Reply-To: <cover.1461228081.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Chen-Yu Tsai <wens@csie.org>, Simon Horman <horms@verge.net.au>, Sascha Hauer <kernel@pengutronix.de>, Leo Yan <leo.yan@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Thursday 21 April 2016 14:13:46 Viresh Kumar wrote:
> Hi,
> 
> This migrates rest of the platforms to use cpufreq-dt-platdev.c. There
> are few exceptions though:
> - mvebu: it uses platform data and its problem will be solved in a
>   separate series.
> - highbank, s5pv210, sti, tegra124: these platforms already have cpufreq
>   drivers in drivers/cpufreq/, which does some other stuff and finally
>   create the device. There are sequencing issues, and so they will be
>   left as it is.

Looks good overall, one minor comment for patch 3, thanks a lot for your
work on this!

Acked-by: Arnd Bergmann <arnd@arndb.de>

