From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC patch 02/11] cpuidle / arm : a single cpuidle driver
Date: Tue, 26 Mar 2013 12:17:29 +0100
Message-ID: <20130326111729.GQ5627@lunn.ch>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
 <1363357630-22214-3-git-send-email-daniel.lezcano@linaro.org>
 <5151249D.4000602@ti.com>
 <51517F5C.3090505@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:33028 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754214Ab3CZLRt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 26 Mar 2013 07:17:49 -0400
Content-Disposition: inline
In-Reply-To: <51517F5C.3090505@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, andrew@lunn.ch, magnus.damm@gmail.com, ben-linux@fluff.org, nsekhar@ti.com, rob.herring@calxeda.com, rjw@sisk.pl, kevin.hilman@linaro.org, horms@verge.net.au, kernel@pengutronix.de, kgene.kim@samsung.com, plagnioj@jcrosoft.com, linux@maxim.org.za, jason@lakedaemon.net, lenb@kernel.org

> > All above code is completly generic and I would rather create
> > some thing like "drivers/cpuidle/generic-idle.c" where it can
> > handle all the registration stuff for all arch's rather than
> > just ARM. There is nothing ARM specific in above code IMHO.
> 
> Yes, it seems generic but it won't be.

It very much sounds like you are going in the wrong direction.  You
should be moving towards generic code, not away from generic code.

Yes, you at some point will need ARM specific code, but that should be
a minor part and can be placed somewhere else, and called by a
function pointer, or the generic code can be in a library and called
from the ARM specific code, etc.

     Andrew


