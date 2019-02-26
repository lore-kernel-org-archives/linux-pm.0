From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 0/4] mwifiex PCI/wake-up interrupt fixes
Date: Tue, 26 Feb 2019 15:28:23 -0800
Message-ID: <20190226232822.GA174696@google.com>
References: <20190224140426.3267-1-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190224140426.3267-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Amitkumar Karwar <amitkarwar@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Ganapathi Bhat <gbhat@marvell.com>, Heiko Stuebner <heiko@sntech.de>, Kalle Valo <kvalo@codeaurora.org>, Nishant Sarmukadam <nishants@marvell.com>, Rob Herring <robh+dt@kernel.org>, Xinming Hu <huxinming820@gmail.com>, "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-pm@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tony Lindgren <tony@atomide.com>
List-Id: linux-pm@vger.kernel.org

+ others

Hi Marc,

Thanks for the series. I have a few bits of history to add to this, and
some comments.

On Sun, Feb 24, 2019 at 02:04:22PM +0000, Marc Zyngier wrote:
> For quite some time, I wondered why the PCI mwifiex device built in my
> Chromebook was unable to use the good old legacy interrupts. But as MSIs
> were working fine, I never really bothered investigating. I finally had a
> look, and the result isn't very pretty.
> 
> On this machine (rk3399-based kevin), the wake-up interrupt is described as
> such:
> 
> &pci_rootport {
> 	mvl_wifi: wifi@0,0 {
> 		compatible = "pci1b4b,2b42";
> 		reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
> 		       0x83010000 0x0 0x00100000 0x0 0x00100000>;
> 		interrupt-parent = <&gpio0>;
> 		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&wlan_host_wake_l>;
> 		wakeup-source;
> 	};
> };
> 
> Note how the interrupt is part of the properties directly attached to the
> PCI node. And yet, this interrupt has nothing to do with a PCI legacy
> interrupt, as it is attached to the wake-up widget that bypasses the PCIe RC
> altogether (Yay for the broken design!). This is in total violation of the
> IEEE Std 1275-1994 spec[1], which clearly documents that such interrupt
> specifiers describe the PCI device interrupts, and must obey the
> INT-{A,B,C,D} mapping. Oops!

You're not the first person to notice this. All the motivations are not
necessarily painted clearly in their cover letter, but here are some
previous attempts at solving this problem:

[RFC PATCH v11 0/5] PCI: rockchip: Move PCIe WAKE# handling into pci core
https://lkml.kernel.org/lkml/20171225114742.18920-1-jeffy.chen@rock-chips.com/
http://lkml.kernel.org/lkml/20171226023646.17722-1-jeffy.chen@rock-chips.com/

As you can see by the 12th iteration, it wasn't left unsolved for lack
of trying...

Frankly, if a proper DT replacement to the admittedly bad binding isn't
agreed upon quickly, I'd be very happy to just have WAKE# support
removed from the DTS for now, and the existing mwifiex binding should
just be removed. (Wake-on-WiFi was never properly vetted on these
platforms anyway.) It mostly serves to just cause problems like you've
noticed.

> The net effect of the above is that Linux tries to do something vaguely
> sensible, and uses the same interrupt for both the wake-up widget and the
> PCI device. This doesn't work for two reasons: (1) the wake-up widget grabs
> the interrupt in exclusive mode, and (2) the PCI interrupt is still routed
> to the RC, leading to a screaming interrupt. This simply cannot work.
> 
> To sort out this mess, we need to lift the confusion between the two
> interrupts. This is done by extending the DT binding to allow the wake-up
> interrupt to be described in a 'wake-up' subnode, sidestepping the issue
> completely. On my Chromebook, it now looks like this:
> 
> &pci_rootport {
> 	mvl_wifi: wifi@0,0 {
> 		compatible = "pci1b4b,2b42";
> 		reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
> 		       0x83010000 0x0 0x00100000 0x0 0x00100000>;
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&wlan_host_wake_l>;
> 		wake-up {
> 			interrupt-parent = <&gpio0>;
> 			interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> 			wakeup-source;
> 		};
> 	};
> };

One problem Rockchip authors were also trying to resolve here is that
PCIe WAKE# handling should not really be something the PCI device driver
has to handle directly. Despite your complaints about not using in-band
TLP wakeup, a separate WAKE# pin is in fact a documented part of the
PCIe standard, and it so happens that the Rockchip RC does not support
handling TLPs in S3, if you want to have decent power consumption. (Your
"bad hardware" complaints could justifiably fall here, I suppose.)

Additionally, I've had pushback from PCI driver authors/maintainers on
adding more special handling for this sort of interrupt property (not
the binding specifically, but just the concept of handling WAKE# in the
driver), as they claim this should be handled by the system firmware,
when they set the appropriate wakeup flags, which filter down to
__pci_enable_wake() -> platform_pci_set_wakeup(). That's how x86 systems
do it (note: I know for a fact that many have a very similar
architecture -- WAKE# is not routed to the RC, because, why does it need
to? and they *don't* use TLP wakeup either -- they just hide it in
firmware better), and it Just Works.

So, we basically concluded that we should standardize on a way to
describe WAKE# interrupts such that PCI drivers don't have to deal with
it at all, and the PCI core can do it for us. 12 revisions later
and...we still never agreed on a good device tree binding for this.

IOW, maybe your wake-up sub-node is the best way to side-step the
problems of conflicting with the OF PCI spec. But I'd still really like
to avoid parsing it in mwifiex, if at all possible.

(We'd still be left with the marvell,wakeup-pin propery to parse
specifically in mwifiex, which sadly has to exist because....well,
Samsung decided to do chip-on-board, and then they failed to use the
correct pin on Marvell's side when wiring up WAKE#. Sigh.)

> The driver is then updated to look for this subnode first, and fallback to
> the original, broken behaviour (spitting out a warning in the offending
> configuration).
> 
> For good measure, there are two additional patches:
> 
> - The wake-up interrupt requesting is horribly racy, and could lead to
>   unpredictable behaviours. Let's fix that properly.

Ack. That mistake was repeated in other drivers and has since been fixed
in those. We need it here too.

Brian

> - A final patch implementing the above transformation for the whole
>   RK3399-based Chromebook range, which all use the same broken
>   configuration.
> 
> With all that, I finally have PCI legacy interrupts working with the mwifiex
> driver on my Chromebook.
> 
> [1] http://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
> 
> Marc Zyngier (4):
>   dt-bindings/marvell-8xxx: Allow wake-up interrupt to be placed in a
>     separate node
>   mwifiex: Fetch wake-up interrupt from 'wake-up' subnode when it exists
>   mwifiex: Flag wake-up interrupt as IRQ_NOAUTOEN rather than disabling
>     it too late
>   arm64: dts: rockchip: gru: Move wifi wake-up interrupt into its own
>     subnode
> 
>  .../bindings/net/wireless/marvell-8xxx.txt    | 23 ++++++++++++++++++-
>  .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  8 ++++---
>  drivers/net/wireless/marvell/mwifiex/main.c   | 13 +++++++++--
>  3 files changed, 38 insertions(+), 6 deletions(-)
> 
> -- 
> 2.20.1
> 
