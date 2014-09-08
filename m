From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/7 v6] ARM: l2c: parse 'cache-size' and 'cache-sets' properties
Date: Mon, 08 Sep 2014 22:41:17 +0200
Message-ID: <7211807.u2YLVoXUf1@wuerfel>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org> <3479071.8nx1ubr8a9@wuerfel> <540E12A3.2080705@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:55150 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbaIHUlY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Sep 2014 16:41:24 -0400
In-Reply-To: <540E12A3.2080705@openwrt.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <florian@openwrt.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh@kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>

On Monday 08 September 2014 13:33:39 Florian Fainelli wrote:
> So what we are missing right now is just a 'cache-line-size' property to
> get the maths right.

Patch 6/7 actually adds that already, and it's even required by ePAPR.

	Arnd
