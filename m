From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/8] cpufreq: add driver for Armada XP
Date: Fri, 4 Jul 2014 21:42:54 +0530
Message-ID: <CAKohpon-ncOGR7KCJeUJEru7bZfoNbKTqUpkZUkMxPwH2WWFJg@mail.gmail.com>
References: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1404467103-29644-3-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAKohponuvPd1kWDdB66kxd8TxxYqQ219jCq2D2RGhMHAuZTSWA@mail.gmail.com>
	<20140704131247.2c8ecde2@free-electrons.com>
	<1404481934.4634.2.camel@weser.hi.pengutronix.de>
	<20140704141541.GE7773@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:60285 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbaGDQMy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jul 2014 12:12:54 -0400
Received: by mail-oa0-f49.google.com with SMTP id i7so1958428oag.8
        for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2014 09:12:54 -0700 (PDT)
In-Reply-To: <20140704141541.GE7773@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

On 4 July 2014 19:45, Andrew Lunn <andrew@lunn.ch> wrote:
> We are talking about legacy devices here, which have been in the field
> for years. There is very little chance of a boot loader
> upgrade. Appended DT is the norm for these devices, and modifying the
> DT would have to happen in kernel.

FWIW, I should mention that we don't need to fix DT's at all in your case.
Just add OPPs at runtime using dev_pm_opp_add() API from within
kernel, maybe from your arch/arm/mach-* folder and cpufreq-cpu0
would be able to parse them.

--
viresh
