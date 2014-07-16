From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 2/8] cpufreq: add driver for Armada XP
Date: Wed, 16 Jul 2014 17:28:11 +0200
Message-ID: <20140716172811.2289a64c@free-electrons.com>
References: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1404467103-29644-3-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAKohponuvPd1kWDdB66kxd8TxxYqQ219jCq2D2RGhMHAuZTSWA@mail.gmail.com>
	<20140716160256.7e8dbccf@free-electrons.com>
	<CAKohpomaYfuq0CR5xsf73obTbXsxdBtHToLsNWcW2NQcCd5LUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:36121 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933938AbaGPP2P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 11:28:15 -0400
In-Reply-To: <CAKohpomaYfuq0CR5xsf73obTbXsxdBtHToLsNWcW2NQcCd5LUw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Dear Viresh Kumar,

On Wed, 16 Jul 2014 20:55:21 +0530, Viresh Kumar wrote:
> On 16 July 2014 19:32, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > Could you get your tree in linux-next, or get your patches merged by
> > Rafael in his linux-next branch so that they will appear in linux-next ?
> 
> They aren't in yet and Rafael haven't started pushing stuff for 3.16 yet.

I guess you meant 3.17, right?

> But it might be pushed sometime soon, no deadlines decided yet.

Would be good to have this soon, since the 3.17 merge window is
approaching. You asked me to use this cpufreq-generic driver instead of
a custom cpufreq driver, and I did the work to do that. So now I clearly
hope that cpufreq-generic will be merged in 3.17.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
