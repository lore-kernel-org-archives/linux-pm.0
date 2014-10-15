From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: dts: exynos7: add support for cpuidle core power
 down
Date: Wed, 15 Oct 2014 14:02:18 +0100
Message-ID: <20141015130218.GB20034@leverpostej>
References: <1413354920-20165-1-git-send-email-k.chander@samsung.com>
 <20141015090047.GA26484@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:34871 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750866AbaJONDD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Oct 2014 09:03:03 -0400
Content-Disposition: inline
In-Reply-To: <20141015090047.GA26484@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: Chander Kashyap <k.chander@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>

> > +			CPU_SLEEP: cpu-sleep {
> > +				compatible = "arm,idle-state";
> > +				local-timer-stop;
> > +				arm,psci-suspend-param = <0x0010000>;
> > +				entry-latency-us = <20>;
> > +				exit-latency-us = <150>;
> > +				min-residency-us = <2100>;
> > +				status = "enabled";

While status is a relatively standard property, it's absence implies
everything is OK. There no need for it here as-is.

Additionally, the canonical value is "okay", not "enabled", so this
would fail were we to use of_device_is_available in the idle states
parsing.

> status ? This is not a documented property. If you need it please explain
> why, define its bindings and we can see how to accommodate it.

Do we expect that some idle states won't be available on some boards
built from the same platform?

Mark.
