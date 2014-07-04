From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 2/8] cpufreq: add driver for Armada XP
Date: Fri, 04 Jul 2014 15:52:14 +0200
Message-ID: <1404481934.4634.2.camel@weser.hi.pengutronix.de>
References: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
	 <1404467103-29644-3-git-send-email-thomas.petazzoni@free-electrons.com>
	 <CAKohponuvPd1kWDdB66kxd8TxxYqQ219jCq2D2RGhMHAuZTSWA@mail.gmail.com>
	 <20140704131247.2c8ecde2@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40825 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbaGDNyG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jul 2014 09:54:06 -0400
In-Reply-To: <20140704131247.2c8ecde2@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Am Freitag, den 04.07.2014, 13:12 +0200 schrieb Thomas Petazzoni:
[...]
> This doesn't work very well with the idea of having the OPP table
> statically encoded in to the Device Tree. Options are:
> 
>  - Improve the cpufreq-cpu0 driver so that the OPP table can be passed
>    through platform_data, and therefore built dynamically by the
>    platform code and passed when registering the cpufreq
>    platform_device.
> 
>  - Dynamically build/update the OPP table in the Device Tree.

This sounds like the right thing to do. Ideally your bootloader would do
this for you, so you don't have to encode those properties statically at
all.

Barebox already has facilities to fixup any loaded device tree. Have a
look at of_register_fixup() there.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

