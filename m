From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 11/16] ARM: mvebu: dts: Add CA9 MPcore SoC Controller
 node
Date: Thu, 03 Jul 2014 14:51:44 +0200
Message-ID: <53B551E0.6040103@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>	<1403875377-940-12-git-send-email-gregory.clement@free-electrons.com> <20140630173755.32793586@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50119 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932104AbaGCMvs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jul 2014 08:51:48 -0400
In-Reply-To: <20140630173755.32793586@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, devicetree@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hi Thomas,


> On Fri, 27 Jun 2014 15:22:52 +0200, Gregory CLEMENT wrote:
>> The CA9 MPcore SoC Control block allows to do some configuration that
>> the SoC could use for a specific use case. In most cases the defaults
>> case is enough. However there is few exception: for cpuidle we need to
>> use the CA9 MPcore Reset Control register.
> 
> I'd reword this to something like:
> 
> """
> The CA9 MPcore SoC Control block is a set of registers that allows to
> configure certain internal aspects of the core blocks of the SoC
> (Cortex-A9, L2 cache controller, etc.). In most cases, the default
> values are fine so they aren't many reasons to touch those registers,
> but there is one exception: to support cpuidle on Armada 38x, we need
> to modify the value of the CA9 MPcore Reset Control register.
> 
> Therefore, this commit adds a new Device Tree binding for this hardware
> block, and uses this new binding for the Armada 38x Device Tree file.
> 
> """

[...]

>> +- reg: should be register base and length as documented in the
> 
> should be *the* register base and length
> 
			reg = <0x21010 0x1c>;
> 
> With those fixed:
> 
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>


I will apply your change.

Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
