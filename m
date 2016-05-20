From: Hongbo Zhang <hongbo.zhang@nxp.com>
Subject: RE: [PSCI DISCUSS] How to implement standby and suspend-to-ram by PSCI
Date: Fri, 20 May 2016 08:23:36 +0000
Message-ID: <DB3PR04MB0812AAD69AEE789DB577C2D2844B0@DB3PR04MB0812.eurprd04.prod.outlook.com>
References: <DB3PR04MB0812DAA98F71C30E8A8832E3847D0@DB3PR04MB0812.eurprd04.prod.outlook.com>
 <572C9BF2.9010004@arm.com>
 <DB3PR04MB08125A628F5034749F8109D884730@DB3PR04MB0812.eurprd04.prod.outlook.com>
 <1463486036.19237.9.camel@suse.com>
 <AM3PR04MB0805D7F5375413C154DFB981844A0@AM3PR04MB0805.eurprd04.prod.outlook.com>
 <1463659261.14323.3.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1463659261.14323.3.camel@suse.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "jszhang@marvell.com" <jszhang@marvell.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Frank Li <Frank.Li@freescale.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Jan Kiszka <jan.kiszka@siemens.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Peng Fan <Peng.Fan@freescale.com>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, Tom Warren <twarren@nvidia.com>, Sudeep Holla <sudeep.holla@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Oliver Neukum [mailto:oneukum@suse.com]
> Sent: Thursday, May 19, 2016 8:01 PM
> To: Hongbo Zhang <hongbo.zhang@nxp.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>; linux-pm@vger.kernel.org;
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Marc Zyngier
> <marc.zyngier@arm.com>; Jan Kiszka <jan.kiszka@siemens.com>; Mark
> Rutland <mark.rutland@arm.com>; Daniel Lezcano
> <daniel.lezcano@linaro.org>; Chen-Yu Tsai <wens@csie.org>; Hans de Goede
> <hdegoede@redhat.com>; Frank Li <Frank.Li@freescale.com>; Peng Fan
> <Peng.Fan@freescale.com>; Tom Warren <twarren@nvidia.com>; Vincent
> Guittot <vincent.guittot@linaro.org>; jszhang@marvell.com; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PSCI DISCUSS] How to implement standby and suspend-to-ram by
> PSCI
> 
> On Thu, 2016-05-19 at 10:27 +0000, Hongbo Zhang wrote:
> > > For the pm module of the core kernel a low power state is a sleep
> > > state if even one of three conditions is met:
> > >
> > > a) a device that can be used for input is not a source of wake ups
> > > b) tasks need to be frozen to enter it
> > > c) the display goes off, while it should be on
> > >
> > > Generally runtime PM is better if you can get the same results.
> > > Going to a system sleep state is a necessary evil.
> 
> 
> > As I just explained in previous reply, many devices in our Soc cannot
> > be physically clock or power gated, all the non-wakeup devices can
> > only be gated off at same time by a PM module, so runtime PM doesn't
> > fit for us well.
> 
> You are looking for a contradiction where none is to be found. We have
> PM domains which allow you to model common clocks and gates. You simply
> use the driver core and it will use the common gate when every device is
> idle. Obviously this is also true when the system is suspended. But not
> necessarily only when the system is suspended.
> 
> 	Regards
> 		Oliver
> 

Understand.
Well, currently our situation is that we've already implemented our sleep/deep sleep mode (mapping to kernel terms standby/suspend to ram), and now while transferring to PSCI we meet such a problem.
If runtime PM is used, many device driver's developers have to be involved to offer their runtime callbacks, a lot of efforts needed in whole system level. But yes, runtime PM has its own advantages, will consider to apply it in the coming SOCs.
Thanks for advice.

Hongbo Zhang @ NXP
