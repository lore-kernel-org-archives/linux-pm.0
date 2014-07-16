From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCHv3 1/7] ARM: mvebu: ensure CPU clocks are enabled
Date: Wed, 16 Jul 2014 09:02:51 -0400
Message-ID: <20140716130251.GZ13108@titan.lakedaemon.net>
References: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404920715-19834-2-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26518 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932770AbaGPNDG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 09:03:06 -0400
Content-Disposition: inline
In-Reply-To: <1404920715-19834-2-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

On Wed, Jul 09, 2014 at 05:45:09PM +0200, Thomas Petazzoni wrote:
> In the Armada XP SMP support code, we are reading the clock frequency
> of the booting CPU, and use that to assign the same frequency to the
> other CPUs, and we do this while the clocks are disabled.
> 
> However, the CPU clocks are in fact never prepared/enabled, and to
> support cpufreq, we now have two code paths to change the frequency of
> the CPU clocks in the CPU clock driver: one when the clock is enabled
> (dynamic frequency scaling), one when the clock is disabled (adjusting
> the CPU frequency before starting the CPU). In order for this to work,
> the CPU clocks now have to be prepared and enabled after the initial
> synchronization of the clock frequencies is done, so that all future
> rate changes of the CPU clocks will trigger a dynamic frequency
> scaling transition.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/platsmp.c | 1 +
>  1 file changed, 1 insertion(+)

Tentatively applied patches 1-3, and 5 to mvebu/soc-cpufreq to get some
coverage in -next.

thx,

Jason.
