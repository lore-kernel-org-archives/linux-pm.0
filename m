From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 07/15] ARM: cpuidle: add init/exit routine
Date: Mon, 25 Mar 2013 20:09:08 +0100
Message-ID: <20130325190908.GC631@lunn.ch>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
 <1364234140-514-8-git-send-email-daniel.lezcano@linaro.org>
 <20130325181038.GA631@lunn.ch>
 <51509873.1010408@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:60627 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758745Ab3CYTJT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Mar 2013 15:09:19 -0400
Content-Disposition: inline
In-Reply-To: <51509873.1010408@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, rjw@sisk.pl, tglx@linutronix.de, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, linus.walleij@linaro.org, linux@arm.linux.org.uk

> > Please could you add a comment in the code about which piece is
> > specific to ARM, because its not obvious to me. Its not like there is
> > a reference to WFI for example. It looks like this code could go in
> > drivers/cpuidle/cpuidle.c
> 
> Yes, I agree. At the first glance, the code, as it is, could go in this
> file but more ARM specific code will be moved to this ARM generic code
> driver like device tree description and couple idle states. The init
> function would be more arch specific then.

Hi Daniel

There was a discussion about device tree bindings when i posted
the kirkwood cpuidle driver, now in drivers/cpuidle/cpuidle-kirkwood.c.

The conclusion was that pseudo devices, like cpuidle, do not have DT
bindings. They can check of_machine_is_compatible(), like
cpuidle-calxeda.c does, or they are platform drivers, which is what
cpuidle-kirkwood.c is.

Even if DT binding was allowed, it again should not be ARM specific.

Are coupled idle states ARM specific?

     Andrew
