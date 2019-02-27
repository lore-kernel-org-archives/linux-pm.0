From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 0/4] mwifiex PCI/wake-up interrupt fixes
Date: Wed, 27 Feb 2019 10:02:16 +0000
Message-ID: <d67512fe-42b4-513f-d27a-fed85c19e9c2@arm.com>
References: <20190224140426.3267-1-marc.zyngier@arm.com>
 <20190226232822.GA174696@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226232822.GA174696@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Amitkumar Karwar <amitkarwar@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Ganapathi Bhat <gbhat@marvell.com>, Heiko Stuebner <heiko@sntech.de>, Kalle Valo <kvalo@codeaurora.org>, Nishant Sarmukadam <nishants@marvell.com>, Rob Herring <robh+dt@kernel.org>, Xinming Hu <huxinming820@gmail.com>, "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-pm@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tony Lindgren <tony@atomide.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

+ Lorenzo

Hi Brian,

On 26/02/2019 23:28, Brian Norris wrote:
> + others
> 
> Hi Marc,
> 
> Thanks for the series. I have a few bits of history to add to this, and
> some comments.
> 
> On Sun, Feb 24, 2019 at 02:04:22PM +0000, Marc Zyngier wrote:
>> For quite some time, I wondered why the PCI mwifiex device built in my
>> Chromebook was unable to use the good old legacy interrupts. But as MSIs
>> were working fine, I never really bothered investigating. I finally had a
>> look, and the result isn't very pretty.
>>
>> On this machine (rk3399-based kevin), the wake-up interrupt is described as
>> such:
>>
>> &pci_rootport {
>> 	mvl_wifi: wifi@0,0 {
>> 		compatible = "pci1b4b,2b42";
>> 		reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
>> 		       0x83010000 0x0 0x00100000 0x0 0x00100000>;
>> 		interrupt-parent = <&gpio0>;
>> 		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
>> 		pinctrl-names = "default";
>> 		pinctrl-0 = <&wlan_host_wake_l>;
>> 		wakeup-source;
>> 	};
>> };
>>
>> Note how the interrupt is part of the properties directly attached to the
>> PCI node. And yet, this interrupt has nothing to do with a PCI legacy
>> interrupt, as it is attached to the wake-up widget that bypasses the PCIe RC
>> altogether (Yay for the broken design!). This is in total violation of the
>> IEEE Std 1275-1994 spec[1], which clearly documents that such interrupt
>> specifiers describe the PCI device interrupts, and must obey the
>> INT-{A,B,C,D} mapping. Oops!
> 
> You're not the first person to notice this. All the motivations are not
> necessarily painted clearly in their cover letter, but here are some
> previous attempts at solving this problem:
> 
> [RFC PATCH v11 0/5] PCI: rockchip: Move PCIe WAKE# handling into pci core
> https://lkml.kernel.org/lkml/20171225114742.18920-1-jeffy.chen@rock-chips.com/
> http://lkml.kernel.org/lkml/20171226023646.17722-1-jeffy.chen@rock-chips.com/
> 
> As you can see by the 12th iteration, it wasn't left unsolved for lack
> of trying...

I wasn't aware of this. That's definitely a better approach than my
hack, and I would really like this to be revived.

> 
> Frankly, if a proper DT replacement to the admittedly bad binding isn't
> agreed upon quickly, I'd be very happy to just have WAKE# support
> removed from the DTS for now, and the existing mwifiex binding should
> just be removed. (Wake-on-WiFi was never properly vetted on these
> platforms anyway.) It mostly serves to just cause problems like you've
> noticed.

Agreed. If there is no actual use for this, and that we can build a case
for a better solution, let's remove the wakeup support from the Gru DT
(it is invalid anyway), and bring it back if and when we get the right
level of support.

[...]

> One problem Rockchip authors were also trying to resolve here is that
> PCIe WAKE# handling should not really be something the PCI device driver
> has to handle directly. Despite your complaints about not using in-band
> TLP wakeup, a separate WAKE# pin is in fact a documented part of the
> PCIe standard, and it so happens that the Rockchip RC does not support
> handling TLPs in S3, if you want to have decent power consumption. (Your
> "bad hardware" complaints could justifiably fall here, I suppose.)
> 
> Additionally, I've had pushback from PCI driver authors/maintainers on
> adding more special handling for this sort of interrupt property (not
> the binding specifically, but just the concept of handling WAKE# in the
> driver), as they claim this should be handled by the system firmware,
> when they set the appropriate wakeup flags, which filter down to
> __pci_enable_wake() -> platform_pci_set_wakeup(). That's how x86 systems
> do it (note: I know for a fact that many have a very similar
> architecture -- WAKE# is not routed to the RC, because, why does it need
> to? and they *don't* use TLP wakeup either -- they just hide it in
> firmware better), and it Just Works.

Even on an arm64 platform, there is no reason why a wakeup interrupt
couldn't be handled by FW rather than the OS. It just need to be wired
to the right spot (so that it generates a secure interrupt that can be
handled by FW).

> So, we basically concluded that we should standardize on a way to
> describe WAKE# interrupts such that PCI drivers don't have to deal with
> it at all, and the PCI core can do it for us. 12 revisions later
> and...we still never agreed on a good device tree binding for this.

Is the DT binding the only problem? Do we have an agreement for the core
code?

> IOW, maybe your wake-up sub-node is the best way to side-step the
> problems of conflicting with the OF PCI spec. But I'd still really like
> to avoid parsing it in mwifiex, if at all possible.

Honestly, my solution is just a terrible hack. I wasn't aware that this
was a more general problem, and I'd love it to be addressed in the core
PCI code.

> (We'd still be left with the marvell,wakeup-pin propery to parse
> specifically in mwifiex, which sadly has to exist because....well,
> Samsung decided to do chip-on-board, and then they failed to use the
> correct pin on Marvell's side when wiring up WAKE#. Sigh.)

Oh well...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
