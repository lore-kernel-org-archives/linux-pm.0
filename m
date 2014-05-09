From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH RFC v3 4/6] arm64: add PSCI CPU_SUSPEND based cpu_suspend support
Date: Fri, 09 May 2014 16:11:23 -0700
Message-ID: <536d609c.0458440a.0ea9.77a3@mx.google.com>
References: <1399399483-17112-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1399399483-17112-5-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:61558 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbaEIXLZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 19:11:25 -0400
Received: by mail-pa0-f48.google.com with SMTP id rd3so4952553pab.7
        for <linux-pm@vger.kernel.org>; Fri, 09 May 2014 16:11:25 -0700 (PDT)
In-Reply-To: <1399399483-17112-5-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <t.figa@samsung.com>

Quoting Lorenzo Pieralisi (2014-05-06 11:04:41)
> This patch implements the cpu_suspend cpu operations method through
> the PSCI CPU_SUSPEND API. The PSCI implementation translates the idle state
> index passed by the cpu_suspend core call into a valid PSCI state according to
> the PSCI states initialized at boot by the PSCI suspend backend.
> 
> Entry point is set to cpu_resume physical address, that represents the
> default kernel execution address following a CPU reset.
> 
> Idle state indices missing a DT node description are initialized to power
> state standby WFI so that if called by the idle driver they provide the
> default behaviour.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Reviewed-by: Sebastian Capella <sebastian.capella@linaro.org>

Thanks!

Sebastian
