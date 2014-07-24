From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCHv3 11/16] cpuidle: mvebu: rename the driver from
 armada-370-xp to mvebu-v7
Date: Thu, 24 Jul 2014 08:00:34 -0400
Message-ID: <20140724120034.GS23220@titan.lakedaemon.net>
References: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1406120453-29291-12-git-send-email-thomas.petazzoni@free-electrons.com>
 <53D0CEA3.1050204@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26467 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757901AbaGXMAu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jul 2014 08:00:50 -0400
Content-Disposition: inline
In-Reply-To: <53D0CEA3.1050204@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On Thu, Jul 24, 2014 at 11:15:15AM +0200, Daniel Lezcano wrote:
> On 07/23/2014 03:00 PM, Thomas Petazzoni wrote:
> >From: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >
> >This driver will be able to manage the cpuidle for more SoCs than just
> >Armada 370 and XP. It will also support Armada 38x and potentially
> >other SoC of the Marvell Armada EBU family. To take this into account,
> >this patch renames the driver and its symbols.
> >
> >It also changes the driver name from cpuidle-armada-370-xp to
> >cpuidle-armada-xp, because separate platform drivers will be
> >registered for the other SoC types. This change must be done
> >simultaneously in the cpuidle driver and in the PMSU code in order to
> >remain bisectable.
> >
> >Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks for getting on top of this so quickly after returning from
vacation!

thx,

Jason.
