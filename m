From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCHv2 12/17] cpuidle: mvebu: make the cpuidle driver capable
 of handling multiple SoCs
Date: Mon, 21 Jul 2014 13:35:34 +0200
Message-ID: <20140721133534.3415e425@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<8387001.GKG5goCh1a@wuerfel>
	<20140721131939.20e81354@free-electrons.com>
	<52019695.n2AjkGEsJ7@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52599 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754157AbaGULfi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jul 2014 07:35:38 -0400
In-Reply-To: <52019695.n2AjkGEsJ7@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>

Dear Arnd Bergmann,

On Mon, 21 Jul 2014 13:30:47 +0200, Arnd Bergmann wrote:

> > > It would be best to have a way to read a property (or multiple
> > > properties) from DT instead, to identify the requirements of the
> > > device individually. However, I guess that would also require
> > > changing the DT representation in an incompatible way, which we
> > > normally don't.
> > 
> > cpuidle is not represented in DT, so besides checking the global
> > compatible string with of_machine_is_compatible(), or passing data
> > through platform_data (as proposed in the patch series), I don't really
> > see how the cpuidle driver could find out which SoC variant is being
> > used.
> 
> One way I think it can be done is by looking up the pmsu node
> and then looking at some of the properties in there.

Which properties do you have in mind? Should we simply use different
compatible strings for the PMSU node, per SoC ? Some other suggestions ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
