From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/4][V2] cpuidle : multiple drivers support
Date: Thu, 25 Oct 2012 22:29:43 +0200
Message-ID: <4190590.cE8oL2xMlM@vostro.rjw.lan>
References: <1350641449-22863-1-git-send-email-daniel.lezcano@linaro.org> <20121025134933.GA1962@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:37745 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935274Ab2JYUZr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Oct 2012 16:25:47 -0400
In-Reply-To: <20121025134933.GA1962@tbergstrom-lnx.Nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "patches@linaro.org" <patches@linaro.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

On Thursday, October 25, 2012 04:49:33 PM Peter De Schrijver wrote:
> On Fri, Oct 19, 2012 at 12:10:45PM +0200, Daniel Lezcano wrote:
> > The discussion about having different cpus on the system with
> > different latencies bring us to a first attemp by adding a
> > pointer in the cpuidle_device to the states array.
> > 
> > But as Rafael suggested, it would make more sense to create a
> > driver per cpu [1].
> > 
> > This patch adds support for multiple cpuidle drivers.
> > 
> > It creates a per cpu cpuidle driver pointer.
> > 
> > In order to not break the different drivers, the function cpuidle_register_driver
> > assign for each cpu, the driver.
> > 
> > The multiple driver support is optional and if it is not set, the cpuide driver
> > core code remains the same (except some code reorganisation).
> > 
> > I did the following tests compiled, booted, tested without/with CONFIG_CPU_IDLE,
> > with/without CONFIG_CPU_IDLE_MULTIPLE_DRIVERS.
> > 
> > Tested on Core2 Duo T9500 with acpi_idle [and intel_idle]
> > Tested on ARM Dual Cortex-A9 U8500 (aka Snowball)
> > 
> > V1 tested on Tegra3 and Vexpress TC2
> > 
> 
> V2 tested on Tegra3.

Do I assume correctly that Tested-by applies?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
