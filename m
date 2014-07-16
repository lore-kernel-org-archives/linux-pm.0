From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCHv3 7/7] ARM: configs: add cpufreq-generic in
 multi_v7_defconfig
Date: Wed, 16 Jul 2014 08:49:49 -0400
Message-ID: <20140716124949.GW13108@titan.lakedaemon.net>
References: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404920715-19834-8-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49332 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146AbaGPMuC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 08:50:02 -0400
Content-Disposition: inline
In-Reply-To: <1404920715-19834-8-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

On Wed, Jul 09, 2014 at 05:45:15PM +0200, Thomas Petazzoni wrote:
> The cpufreq-generic driver is going to be used by more and more
> platforms to support dynamic frequency scaling of the CPU. This commit
> enables this driver by default in multi_v7_defconfig.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Jason Cooper <jason@lakedaemon.net>

Please re-send to arm-soc maintainers for them to apply directly.

thx,

Jason.
