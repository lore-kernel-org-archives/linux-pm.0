From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v4 3/6] drivers: cpuidle: implement OF based idle states
 infrastructure
Date: Wed, 11 Jun 2014 14:24:12 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1406111420450.25775@knanqh.ubzr>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com> <1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:40710 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbaFKSYQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jun 2014 14:24:16 -0400
Received: by mail-qa0-f42.google.com with SMTP id dc16so187867qab.29
        for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2014 11:24:15 -0700 (PDT)
In-Reply-To: <1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <chander.kashyap@linaro.org>

On Wed, 11 Jun 2014, Lorenzo Pieralisi wrote:

> +config OF_IDLE_STATES
> +        bool "Idle states DT support"
> +	depends on ARM || ARM64
> +	default n

The default for default is n already, so you don't have to default to 
the default's default.


Nicolas
