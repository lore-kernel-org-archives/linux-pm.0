From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/8] cpufreq: add driver for Armada XP
Date: Fri, 4 Jul 2014 15:25:28 +0200
Message-ID: <20140704132528.GD7773@lunn.ch>
References: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404467103-29644-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAKohponuvPd1kWDdB66kxd8TxxYqQ219jCq2D2RGhMHAuZTSWA@mail.gmail.com>
 <20140704131247.2c8ecde2@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:42228 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613AbaGDNaG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Jul 2014 09:30:06 -0400
Content-Disposition: inline
In-Reply-To: <20140704131247.2c8ecde2@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

> This doesn't work very well with the idea of having the OPP table
> statically encoded in to the Device Tree. Options are:
> 
>  - Improve the cpufreq-cpu0 driver so that the OPP table can be passed
>    through platform_data, and therefore built dynamically by the
>    platform code and passed when registering the cpufreq
>    platform_device.
> 
>  - Dynamically build/update the OPP table in the Device Tree.
> 
> Which option do you think is appropriate here?

It should also be noted that that applies to many Marvell SoCs.
Kirkwood and Dove are the same.

	 Andrew
