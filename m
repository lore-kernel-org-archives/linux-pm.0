From: Hongbo Zhang <hongbo.zhang@nxp.com>
Subject: Re: [PSCI DISCUSS] How to implement standby and suspend-to-ram by PSCI
Date: Thu, 12 May 2016 09:42:29 +0000
Message-ID: <DB3PR04MB08125A628F5034749F8109D884730@DB3PR04MB0812.eurprd04.prod.outlook.com>
References: <DB3PR04MB0812DAA98F71C30E8A8832E3847D0@DB3PR04MB0812.eurprd04.prod.outlook.com>
 <572C9BF2.9010004@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, "jszhang@marvell.com" <jszhang@marvell.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Frank Li <Frank.Li@freescale.com>, Marc Zyngier <marc.zyngier@arm.com>, Jan Kiszka <jan.kiszka@siemens.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Peng Fan <Peng.Fan@freescale.com>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, Tom Warren <twarren@nvidia.com>, Vincent Guittot <vincent.guittot@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Sudeep,

On 2016年05月06日 21:28, Sudeep Holla wrote:
> Hi Hongbo,
>
> On 06/05/16 11:11, Hongbo Zhang wrote:
>> Hi Guys,
>> We know in the legacy kernel suspend codes, a typical suspend_ops->enter
>> callback is like this:
>>
>
> [...]
>
>>
>> That means we implement standby and suspend-to-ram in one callback, and
>> these two state can be identified by an input parameter 'state'.
>>
>> While now PSCI is used for ARM to implement cores operations and power
>> management, for the above suspend_ops->enter we choose SYSTEM_SUSPEND
>> function, and this function is defined for suspend-to-ram, then here
>> comes the problem:
>>
>> How can we implement the standby state following the PSCI framework?
>>
>
> Jisheng Zhang raised similar question few months back and we had a
> discussion. Please have a look at the thread [1]
>
I looked through that discussion, it seems better I continue to reply 
there but I didn't book that mailing list, so I add linux-arm-kernel 
list and Jisheng here.

>> I couldn't find other PSCI function which fits for standby well.
>> In the spec there isn't such a 'state' parameter passed for
>> SYSTEM_SUSPEND (only entry_point_address and context_id), can we change
>> the spec a bit, e.g. using one more register to pass another 'state'
>> parameter? is that acceptable? (similar like CPU_SUSPEND then)
>>
>
> Since the standby state is not well defined on ARM systems, it's hard to
> define the conditions like system suspend and hence difficult to
> generalize in the spec. I think suspend-to-idle should suffice in your
> case. Anyways its better to get more information on the definition of
> standby on your platform.
>

On our platform we have some shallow states which maps to cpuidle well, 
and we have two more deeper states:

Sleep state:
All cores are in WFI state,
Core cluster is in standby state, e.g. L2 cache is flushed then stops 
snooping,
Only those modules which are required to wake up the device still have a 
running clock, other device modules in chip are clock gated.

Deep sleep state:
ARM cores and DDR controller are switched off,
DDR is in self-refresh mode,
VDD power to off domain IPs are removed, Only the blocks needed to 
detect wake up and sequence the chip out of deep sleep are on.

For the two states, except for the wake-up devices, all the other device 
dirver's suspend callback needs to be called because those devices will 
be clock or power gated off. So, the kernel suspend process (freeze 
tasks, suspend devices etc) are needed for our sleep and deep sleep states.
In fact we've already implemented these two stated by legacy way, e.g. 
mapping sleep state to STANDBY and deep sleep to MEM, both states are 
implemented in one traditional .enter callback and can be indexed by a 
'state' parameter.

While transferring to PSCI, we met the problem I mentioned.

As to the freeze(suspend-to-idle), it is described as "a generic, pure 
software, light-weight, system sleep state" in the Document, and the 
fact is only acpi is using it, what's more, I don't think it satisfy us 
well, because the freeze_enter() is executed before 
disable_nonboot_cpus() and syscore_suspend(), while the later two are 
necessary for us.

So it seems another 'state' parameter for SYSTEM_SUSPEND can settle this 
problem, but it is lack in the spec.

There are diverse kinds of ARM SOC, and divers kind of peripheral 
devices in each SOC, so even for the SYSTEM_SUSPEND, there may be 
different states too(deeper or shallower states of each device, more or 
less of devices are put to idle), the more the PSCI spec supports, the 
better.
