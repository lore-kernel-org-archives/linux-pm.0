From: Florian Fainelli <fainelli@broadcom.com>
Subject: Re: [PATCH 0/3] power: reset: BCM63xx reboot support
Date: Tue, 21 Apr 2015 11:51:32 -0700
Message-ID: <55369C34.5020201@broadcom.com>
References: <1427242632-7971-1-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:42846 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499AbbDUSwj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Apr 2015 14:52:39 -0400
In-Reply-To: <1427242632-7971-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Cc: jogo@openwrt.org, cernekee@gmail.com, computersforpeace@gmail.com, gregory.0xf0@gmail.com, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com

On 24/03/15 17:17, Florian Fainelli wrote:
> Hi all,
> 
> This patch series adds support for the BCM6328-style software reset hardware
> block commonly found on Broadcom BCM63xx DSL SoCs.

Looks like we can utilize the generic syscon reboot driver instead of
open-coding one, let's do that instead.

> 
> Thanks!
> 
> Florian Fainelli (3):
>   Documentation: bindings: add BCM6328-style soft reset binding
>   power: reset: add Broadcom BCM63xx software reset driver
>   ARM: dts: BCM63xx: add soft-reset node
> 
>  .../devicetree/bindings/arm/bcm/bcm63138.txt       | 16 +++++
>  arch/arm/boot/dts/bcm63138.dtsi                    |  5 ++
>  drivers/power/reset/Kconfig                        |  7 ++
>  drivers/power/reset/Makefile                       |  1 +
>  drivers/power/reset/bcm63xx-reboot.c               | 80 ++++++++++++++++++++++
>  5 files changed, 109 insertions(+)
>  create mode 100644 drivers/power/reset/bcm63xx-reboot.c
> 


-- 
Florian
