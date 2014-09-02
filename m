From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/8 v2] leds: add device tree bindings for register bit LEDs
Date: Tue, 02 Sep 2014 14:24:06 +0200
Message-ID: <5686741.QjIvGO0Jfo@wuerfel>
References: <1409659354-23553-1-git-send-email-linus.walleij@linaro.org> <1409659354-23553-3-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:59403 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbaIBMYW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Sep 2014 08:24:22 -0400
In-Reply-To: <1409659354-23553-3-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>

On Tuesday 02 September 2014 14:02:28 Linus Walleij wrote:
> +LED sub-node properties:
> +
> +Required properties:
> +- compatible : must be "register-bit-led"
> +- offset : register offset to the register controlling this LED
> +- mask : bit mask for the bit controlling this LED in the register
> +  typically 0x01, 0x02, 0x04 ...
> 

How does the driver know whether to do byte or word sized accesses?

	Arnd
