From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 7/8] ARM: l2x0: support associativity from DT
Date: Tue, 2 Sep 2014 14:17:29 +0100
Message-ID: <20140902131729.GQ30401@n2100.arm.linux.org.uk>
References: <1409659354-23553-1-git-send-email-linus.walleij@linaro.org> <1409659354-23553-8-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40416 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754439AbaIBNTq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Sep 2014 09:19:46 -0400
Content-Disposition: inline
In-Reply-To: <1409659354-23553-8-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>

On Tue, Sep 02, 2014 at 02:02:33PM +0200, Linus Walleij wrote:
> The ARM RealView platforms comes with boot loaders that fail
> to set up cache size, ways and associativity correctly. This
> complements Florian's patch to set up cache size and sets from
> the device tree with the possibility to set up associativity
> on the L2C-220 cache variant.

Do we need this?

If we have the cache size, the number of sets, and the cache block size
(cache line size) which are all ePAPR specified properties for a cache,
then:

	number of cache blocks = cache size / cache block size
	ways of associativity = number of cache blocks / number of sets
	way size = cache block size * number of sets

It's a tad annoying to have to convert between the two representations,
but ePAPR decided on size, sets and block size rather than size and
ways.

See arch/powerpc/kernel/cacheinfo.c line 260 for the powerpc
associativity calculations from these values.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
