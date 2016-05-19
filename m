From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PSCI DISCUSS] How to implement standby and suspend-to-ram by
 PSCI
Date: Thu, 19 May 2016 14:01:01 +0200
Message-ID: <1463659261.14323.3.camel@suse.com>
References: <DB3PR04MB0812DAA98F71C30E8A8832E3847D0@DB3PR04MB0812.eurprd04.prod.outlook.com>
	 <572C9BF2.9010004@arm.com>
	 <DB3PR04MB08125A628F5034749F8109D884730@DB3PR04MB0812.eurprd04.prod.outlook.com>
	 <1463486036.19237.9.camel@suse.com>
	 <AM3PR04MB0805D7F5375413C154DFB981844A0@AM3PR04MB0805.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52532 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754430AbcESMEc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 19 May 2016 08:04:32 -0400
In-Reply-To: <AM3PR04MB0805D7F5375413C154DFB981844A0@AM3PR04MB0805.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hongbo Zhang <hongbo.zhang@nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Jan Kiszka <jan.kiszka@siemens.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, Frank Li <Frank.Li@freescale.com>, Peng Fan <Peng.Fan@freescale.com>, Tom Warren <twarren@nvidia.com>, Vincent Guittot <vincent.guittot@linaro.org>, "jszhang@marvell.com" <jszhang@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 2016-05-19 at 10:27 +0000, Hongbo Zhang wrote:
> > For the pm module of the core kernel a low power state is a sleep
> > state if even one of three conditions is met:
> > 
> > a) a device that can be used for input is not a source of wake ups
> > b) tasks need to be frozen to enter it
> > c) the display goes off, while it should be on
> > 
> > Generally runtime PM is better if you can get the same results.
> > Going to a system sleep state is a necessary evil.


> As I just explained in previous reply, many devices in our Soc cannot
> be physically clock or power gated, all the non-wakeup devices can
> only be gated off at same time by a PM module, so runtime PM doesn't
> fit for us well.

You are looking for a contradiction where none is to be found. We have
PM domains which allow you to model common clocks and gates. You simply
use the driver core and it will use the common gate when every device is
idle. Obviously this is also true when the system is suspended. But not
necessarily only when the system is suspended.

	Regards
		Oliver


