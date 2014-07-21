From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCHv2 12/17] cpuidle: mvebu: make the cpuidle driver capable
 of handling multiple SoCs
Date: Mon, 21 Jul 2014 13:12:03 +0200
Message-ID: <20140721131203.2746bbaa@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1404913221-17343-13-git-send-email-thomas.petazzoni@free-electrons.com>
	<53CCF295.6030907@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52427 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755036AbaGULMH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jul 2014 07:12:07 -0400
In-Reply-To: <53CCF295.6030907@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Dear Daniel Lezcano,

On Mon, 21 Jul 2014 12:59:33 +0200, Daniel Lezcano wrote:

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
> 
> It isn't possible to do:
> 
> if (of_machine_is_compatible("marvell,armada-370-xp-pmsu"))
> 	cpuidle_register(&armadaxp_cpuidle_driver, NULL);

So you suggest to have a different cpuidle driver, with a different
name, one for each SoC ?

Or do you suggest to have the cpuidle probe() function call
of_machine_is_compatible() to find out the SoC type?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
