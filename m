From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv2 12/17] cpuidle: mvebu: make the cpuidle driver capable of handling multiple SoCs
Date: Mon, 21 Jul 2014 14:51:38 +0200
Message-ID: <19699239.33i4BRP9GE@wuerfel>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com> <53CD08CF.6080900@linaro.org> <20140721143813.6028b6ed@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:52869 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318AbaGUMwC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jul 2014 08:52:02 -0400
In-Reply-To: <20140721143813.6028b6ed@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Tawfik Bayouk <tawfik@marvell.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>

On Monday 21 July 2014 14:38:13 Thomas Petazzoni wrote:
> Dear Daniel Lezcano,
> 
> On Mon, 21 Jul 2014 14:34:23 +0200, Daniel Lezcano wrote:
> 
> > So there are three solutions:
> > 
> > 1. Pass the flag through the platform data, I am not really in favor of 
> > that as mentioned above
> 
> That's what is already implemented.

It's certainly better than checking a global compatible string in
driver code, IMHO.

Instead of a global header file, I would have put the structure
definition under linux/platform-data, as we do for most other
legacy drivers.

> > 2. Use the compatible string like the cpuidle-big-little.c driver, but 
> > Arnd is not in favor of that
> > 
> > 3. Register 3 platform drivers, in cpuidle-mvebu-v7.c, and let the 
> > registering of the cpuidle's platform device to enable the right one
> 
> I'm fine with doing (3). Daniel, Arnd, let me know if that's ok for
> you, and I'll respin the patch series accordingly.

If I understood Daniel correctly, this is temporary anyway until
we have a proper binding, right?

If so, I don't really mind either approach.

	Arnd
