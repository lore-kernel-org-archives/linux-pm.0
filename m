From: Caesar Wang <wxt@rock-chips.com>
Subject: [RESEND PATCH v2 0/2] fix the TSHUT issue on rockchip thermal
Date: Thu, 22 Oct 2015 10:30:46 +0800
Message-ID: <1445481048-20789-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33438 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbbJVCbM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2015 22:31:12 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, dianders@chromium.org, Eduardo Valentin <edubezval@gmail.com>, Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@arm.linux.org.uk>

We need the OTP pin is gpio state before resetting the TSADC controller,
since the tshut polarity will generate a high signal.

Says:
The TSHUT temperature is setting more than 80 degree, the default
tshut polarity is HIGH.

If T > 80C, the OTP output the High Signal.
If T < 80C, the OTP output the Low Signal.

On the moment, the TSADC controller is reset, the tshut polarity will be
Low in a short period of time.

So:
If T < 80C, the OTP output the High Signal.
If T > 80C, the OTP output the Low Signal.

In some cases, the OTP pin is connected to the PMIC, maybe the PMIC can
accept the reset response time to avoid this issue.

In other words, the system will be always reboot if we make the OTP pin
is connected the others IC to control the power.

This series patchs are depend on Doug's patch.(https://patchwork.kernel.org/patch/7454311/)

This series patchs are based on the Linus master branch.

518cd44 ARM: dts: rockchip: Add the OTP gpio pinctrl
83e0bab dt-bindings: Add the "init" pinctrl in this document
150426c drivers/pinctrl: Add the concept of an "init" state
ce1fad2 Merge branch 'keys-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
1099f86 Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
911b79c KEYS: Don't permit request_key() to construct a new keyring
37850e3 net: bcmgenet: Fix early link interrupt enabling
afc050d Merge tag 'wireless-drivers-for-davem-2015-10-17' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers
e277de5 tunnels: Don't require remote endpoint or ID during creation.
740dbc2 openvswitch: Scrub skb between namespaces
....

Tested on box board.


Changes in v2:
  - Add the 'init' pinctrl more decription in commit.
  - Fix the subject to make more obvious in PATCH[1/2]
  - Resend this patch v2 since fix the subject to be specific.
  - Add some commits for more obvious in PATCH[2/2]

Changes in v1:
  - As the Doug comments, add the 'init' property to sync document.
  - As the Doug comments, drop the thermal driver patchs since
    we can with pinctrl changing to work.
  - As the Doug's patch to add the 'init' property.

Caesar Wang (2):
  dt-bindings: rockchip-thermal: Add the "init" pinctrl in this document
  ARM: dts: rockchip: Add the OTP gpio pinctrl

 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 5 +++--
 arch/arm/boot/dts/rk3288.dtsi                                  | 9 +++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
1.9.1

