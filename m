From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [Bug] ARM: mxs: STI: console can't wake up from freeze
Date: Sun, 23 Oct 2016 14:31:35 +0100
Message-ID: <20161023133134.GI1041@n2100.armlinux.org.uk>
References: <315017958.66634.5d4fc19c-31cd-4900-8613-af4cadec5da4.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45078 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbcJWNbt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Oct 2016 09:31:49 -0400
Content-Disposition: inline
In-Reply-To: <315017958.66634.5d4fc19c-31cd-4900-8613-af4cadec5da4.open-xchange@email.1und1.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, joerg.krause@embedded.rocks, linux-arm-kernel@lists.infradead.org

On Sun, Oct 23, 2016 at 11:19:26AM +0200, Stefan Wahren wrote:
> Hi,
> 
> i'm faced with the issue that on i.MX28 the console is unable to wake up from
> freeze ( suspend to idle). I tested it with Linux 4.9-rc1, 4.8 and 3.18 (
> cmdline has
> no_console_suspend=1 ) and also with a i.MX23 with the same result. The suspend
> seems to work, but there is no reaction to the console after the freeze except
> an hung task warning after some time:

I bet if you remove "no_console_suspend" (it's not =1) then it'll work.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
