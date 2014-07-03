From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 13/16] cpuidle: mvebu: Move the description of the cpuidle
 states in the platform part
Date: Thu, 03 Jul 2014 15:23:56 +0200
Message-ID: <53B5596C.7010304@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>	<1403875377-940-14-git-send-email-gregory.clement@free-electrons.com> <20140630153202.69f885e0@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50345 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758114AbaGCNYB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jul 2014 09:24:01 -0400
In-Reply-To: <20140630153202.69f885e0@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hi Thomas,

>> In order to prepare the add of new SoCs supports for this cpuidle
> 
> "the add of new SoCs supports for this cpuidle" -> "the addition of the
> support for more SoCs in this cpuidle".
> 
>> driver, this patch moves the description of the state in the platform
>> part. Indeed the number of the cpuidle state, and the value of the
>> flag used will vary depending of the SoC.
> 
> I actually don't really agree with the reasoning here. We can perfectly
> fine have several separate compatible strings, one for each SoC. We do
> this for pinctrl, for clocks, and for many other drivers. Why should it
> be different for the cpuidle driver? I know the function to enter idle
> will most likely implemented in arch/arm/mach-mvebu/ because those
> functions are generally too tightly coupled with a bunch of system
> registers changes, but the description of the different idle states can
> just as well be inside the cpuidle driver itself.

So that would means a different probe and driver name for each SOC?
Indeed it is doable. With my solution adding the support for a new Soc
won't modify the cpu idle driver itself, so the merge would be easier.
But I admit that it is a misuse of the mach- directory.


Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
