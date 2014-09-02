From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/8] ARM: l2x0: move DT parsing for cache props
Date: Tue, 2 Sep 2014 13:43:26 +0100
Message-ID: <20140902124326.GP30401@n2100.arm.linux.org.uk>
References: <1409659354-23553-1-git-send-email-linus.walleij@linaro.org> <1409659354-23553-6-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40279 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754059AbaIBMnh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Sep 2014 08:43:37 -0400
Content-Disposition: inline
In-Reply-To: <1409659354-23553-6-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>

On Tue, Sep 02, 2014 at 02:02:31PM +0200, Linus Walleij wrote:
> The current diagnostic prints in the l2x0 driver will print
> warnings like this if the AUX register i modified by the
> mask and set words passed to the l2x0_init() function:
> 
> L2C: platform modifies aux control register: 0x02020fff -> 0x02730fff
> L2C: DT/platform modifies aux control register: 0x02020fff -> 0x02730fff

Notice that there are two here.

The first means that the platform passed values which resulted in an
actual modification to the control register.  This happens in
l2x0_of_init() to identify values of aux_mask/aux_val which result
in manipulation of the control register by hard-coded platform values.

The second means that the platform _or_ the DT resulted in an actual
modification of the control register.  This happens in __l2c_init(),
after the DT has been parsed, or after the non-DT code paths to identify
any remaining modifications.

I don't see any point to this patch.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
