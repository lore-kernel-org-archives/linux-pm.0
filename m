From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv2 12/17] cpuidle: mvebu: make the cpuidle driver capable of handling multiple SoCs
Date: Mon, 21 Jul 2014 13:30:47 +0200
Message-ID: <52019695.n2AjkGEsJ7@wuerfel>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com> <8387001.GKG5goCh1a@wuerfel> <20140721131939.20e81354@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:54828 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575AbaGULb3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jul 2014 07:31:29 -0400
In-Reply-To: <20140721131939.20e81354@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>

On Monday 21 July 2014 13:19:39 Thomas Petazzoni wrote:
> On Mon, 21 Jul 2014 13:16:22 +0200, Arnd Bergmann wrote:
> 
> > > It isn't possible to do:
> > > 
> > > if (of_machine_is_compatible("marvell,armada-370-xp-pmsu"))
> > >         cpuidle_register(&armadaxp_cpuidle_driver, NULL);
> > > 
> > > ?
> > > 
> > > That will prevent the creation of the new single-declaration header file.
> > 
> > It would be best to have a way to read a property (or multiple
> > properties) from DT instead, to identify the requirements of the
> > device individually. However, I guess that would also require
> > changing the DT representation in an incompatible way, which we
> > normally don't.
> 
> cpuidle is not represented in DT, so besides checking the global
> compatible string with of_machine_is_compatible(), or passing data
> through platform_data (as proposed in the patch series), I don't really
> see how the cpuidle driver could find out which SoC variant is being
> used.

One way I think it can be done is by looking up the pmsu node
and then looking at some of the properties in there.

	Arnd
