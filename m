From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v4 3/6] drivers: cpuidle: implement OF based idle states
 infrastructure
Date: Wed, 11 Jun 2014 14:38:51 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1406111431080.25775@knanqh.ubzr>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com> <1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:43769 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbaFKSiy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jun 2014 14:38:54 -0400
Received: by mail-qa0-f42.google.com with SMTP id dc16so215409qab.15
        for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2014 11:38:53 -0700 (PDT)
In-Reply-To: <1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <chander.kashyap@linaro.org>

On Wed, 11 Jun 2014, Lorenzo Pieralisi wrote:

> On most common ARM systems, the low-power states a CPU can be put into are
> not discoverable in HW and require device tree bindings to describe
> power down suspend operations and idle states parameters.
> 
> In order to enable DT based idle states and configure idle drivers, this
> patch implements the bulk infrastructure required to parse the device tree
> idle states bindings and initialize the corresponding CPUidle driver states
> data.

Oh and another pet peeve of mine: given we always talk about "device 
tree" all the time, could you s/OF/DT/ in the subject?  It's been a 
while that DT has outgrown its OF origins.

>  create mode 100644 drivers/cpuidle/of_idle_states.c
>  create mode 100644 drivers/cpuidle/of_idle_states.h

Ditto here, including any new symbols you introduced.

Nicolas
