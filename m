From: Hongbo Zhang <hongbo.zhang@nxp.com>
Subject: RE: [PSCI DISCUSS] How to implement standby and suspend-to-ram by PSCI
Date: Thu, 19 May 2016 09:26:15 +0000
Message-ID: <AM3PR04MB0805EC05291F31CC38919722844A0@AM3PR04MB0805.eurprd04.prod.outlook.com>
References: <DB3PR04MB0812DAA98F71C30E8A8832E3847D0@DB3PR04MB0812.eurprd04.prod.outlook.com>
 <572C9BF2.9010004@arm.com>
 <DB3PR04MB08125A628F5034749F8109D884730@DB3PR04MB0812.eurprd04.prod.outlook.com>
 <5734562E.40303@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5734562E.40303@arm.com>
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
To: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "jszhang@marvell.com" <jszhang@marvell.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Frank Li <Frank.Li@freescale.com>, Marc Zyngier <marc.zyngier@arm.com>, Jan Kiszka <jan.kiszka@siemens.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, Peng Fan <Peng.Fan@freescale.com>, Tom Warren <twarren@nvidia.com>, Vincent Guittot <vincent.guittot@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla@arm.com]
> Sent: Thursday, May 12, 2016 6:09 PM
> To: Hongbo Zhang <hongbo.zhang@nxp.com>; linux-pm@vger.kernel.org
> Cc: Sudeep Holla <sudeep.holla@arm.com>; Mark Rutland
> <mark.rutland@arm.com>; jszhang@marvell.com; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>; Frank Li <Frank.Li@freescale.com>; Marc Zyngier
> <marc.zyngier@arm.com>; Jan Kiszka <jan.kiszka@siemens.com>; Daniel
> Lezcano <daniel.lezcano@linaro.org>; Peng Fan <Peng.Fan@freescale.com>;
> Hans de Goede <hdegoede@redhat.com>; Chen-Yu Tsai <wens@csie.org>;
> Tom Warren <twarren@nvidia.com>; Vincent Guittot
> <vincent.guittot@linaro.org>; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PSCI DISCUSS] How to implement standby and suspend-to-ram by
> PSCI
> 
> 
> 
> On 12/05/16 10:42, Hongbo Zhang wrote:
> > Hi Sudeep,
> >
> 
> [...]
> 
> >
> > Sleep state:
> > All cores are in WFI state,
> > Core cluster is in standby state, e.g. L2 cache is flushed then stops
> > snooping,
> > Only those modules which are required to wake up the device still have a
> > running clock, other device modules in chip are clock gated.
> >
> > Deep sleep state:
> > ARM cores and DDR controller are switched off,
> > DDR is in self-refresh mode,
> > VDD power to off domain IPs are removed, Only the blocks needed to
> > detect wake up and sequence the chip out of deep sleep are on.
> >
> > For the two states, except for the wake-up devices, all the other device
> > dirver's suspend callback needs to be called because those devices will
> > be clock or power gated off. So, the kernel suspend process (freeze
> > tasks, suspend devices etc) are needed for our sleep and deep sleep states.
> > In fact we've already implemented these two stated by legacy way, e.g.
> > mapping sleep state to STANDBY and deep sleep to MEM, both states are
> > implemented in one traditional .enter callback and can be indexed by a
> > 'state' parameter.
> >
> 
> Yes I understand that.
> 
> > While transferring to PSCI, we met the problem I mentioned.
> >
> > As to the freeze(suspend-to-idle), it is described as "a generic, pure
> > software, light-weight, system sleep state" in the Document, and the
> > fact is only acpi is using it,
> 
> No, it independent of ACPI. It can be used on any platform with CPUIdle
> support.
> 
> > what's more, I don't think it satisfy us
> > well, because the freeze_enter() is executed before
> > disable_nonboot_cpus() and syscore_suspend(), while the later two are
> > necessary for us.
> >
> 
> Care to explain ? With suspend-to-idle, wakeup latency is much lesser as
> the CPUs are not hotplugged out. I don't think it makes huge different
> with power on ARM platforms. So its is much better than standby which
> does CPU hotplugging IMO.
> 

Sorry for response late, I was investigating the possibility of implementing suspend-to-idle on our platform.
Our user manual says the core1 should enter wfi first and the core0 is the last core which is responsible for some cleanup such as triggering the clock gating off for non-wakeup devices.
If we use suspend-to-idle (no disable none boot cpu in this routine), which core enters idle last cannot be guaranteed, I don't know if core1 can do the cleanup instead, this cannot be confirmed from any document, so have to do a test later, this needs some time.

> > So it seems another 'state' parameter for SYSTEM_SUSPEND can settle this
> > problem, but it is lack in the spec.
> >
> 
> If you still think you can't make use of suspend-to-idle with added
> advantage of reduced wakeup latency, please send email with all the
> details to errata@arm.com as suggested in the PSCI specification.

Will consider this after my test I mention above, thanks for the info.

> 
> > There are diverse kinds of ARM SOC, and divers kind of peripheral
> > devices in each SOC, so even for the SYSTEM_SUSPEND, there may be
> > different states too(deeper or shallower states of each device, more or
> > less of devices are put to idle), the more the PSCI spec supports, the
> > better.
> >
> 
> With runtime PM, you can work out on the peripheral device PM directly,
> so I can't imagine how the diversity there adds to SYSTEM_SUSPEND
> complexity.

Our SoC isn't designed for mobile device, so the peripheral PM is quite rough, except for the wakeup devices, all the other devices can only be power or clock gated off by one operation at one time, they cannot be treated separately, so the runtime PM doesn't fit well.

> 
> --
> Regards,
> Sudeep
