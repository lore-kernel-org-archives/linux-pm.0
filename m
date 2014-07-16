From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCHv3 4/7] ARM: mvebu: update Armada XP DT for dynamic
 frequency scaling
Date: Wed, 16 Jul 2014 08:55:27 -0400
Message-ID: <20140716125527.GY13108@titan.lakedaemon.net>
References: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404920715-19834-5-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59066 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933597AbaGPMzn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 08:55:43 -0400
Content-Disposition: inline
In-Reply-To: <1404920715-19834-5-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

On Wed, Jul 09, 2014 at 05:45:12PM +0200, Thomas Petazzoni wrote:
> In order to support dynamic frequency scaling:
> 
>  * the cpuclk Device Tree node needs to be updated to describe a
>    second set of registers describing the PMU DFS registers.
> 
>  * the clock-latency property of the CPUs must be filled, otherwise
>    the ondemand and conservative cpufreq governors refuse to work. The
>    latency is high because the cost of a frequency transition is quite
>    high on those CPUs.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi | 2 ++
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi | 2 ++
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi | 4 ++++
>  arch/arm/boot/dts/armada-xp.dtsi         | 2 +-
>  4 files changed, 9 insertions(+), 1 deletion(-)

Applied to mvebu/dt

thx,

Jason.
