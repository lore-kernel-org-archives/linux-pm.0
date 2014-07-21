From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv2 12/17] cpuidle: mvebu: make the cpuidle driver capable of handling multiple SoCs
Date: Mon, 21 Jul 2014 13:16:22 +0200
Message-ID: <8387001.GKG5goCh1a@wuerfel>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com> <1404913221-17343-13-git-send-email-thomas.petazzoni@free-electrons.com> <53CCF295.6030907@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:50808 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157AbaGULQy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jul 2014 07:16:54 -0400
In-Reply-To: <53CCF295.6030907@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>

On Monday 21 July 2014 12:59:33 Daniel Lezcano wrote:
> On 07/09/2014 03:40 PM, Thomas Petazzoni wrote:
> > From: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >
> > In order to prepare the add of new SoCs supports for this cpuidle
> > driver, this patch extends the platform_data understood by the
> > cpuidle-mvebu-v7 driver to contain a "type" identifying which specific
> > SoC the cpuidle driver is being probed for. It will be used by the
> > cpuidle driver to know the list of states for the current SoC.
> 
> It makes more sense to use/implement a 'soc_is_xxx' macro or 
> 'of_machine_is_compatible', like the other cpuidle drivers, no ?
>
> Is there a good reason to implement a new way to check the board ?

In all other subsystems, we try to do this per-device: We have almost
killed off all soc_is_* macros, and we strongly discourage anybody
from using of_machine_is_compatible() in driver code, as this goes
against the goals of multiplatform kernels on which we treat every
device as a separate thing that may get reused on any number of
machines or SoCs.

> It isn't possible to do:
> 
> if (of_machine_is_compatible("marvell,armada-370-xp-pmsu"))
>         cpuidle_register(&armadaxp_cpuidle_driver, NULL);
> 
> ?
> 
> That will prevent the creation of the new single-declaration header file.

It would be best to have a way to read a property (or multiple
properties) from DT instead, to identify the requirements of the
device individually. However, I guess that would also require
changing the DT representation in an incompatible way, which we
normally don't.

	Arnd
