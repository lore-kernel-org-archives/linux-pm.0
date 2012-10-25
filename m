From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH 0/4][V2] cpuidle : multiple drivers support
Date: Thu, 25 Oct 2012 16:49:33 +0300
Message-ID: <20121025134933.GA1962@tbergstrom-lnx.Nvidia.com>
References: <1350641449-22863-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:4679 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935668Ab2JYNtr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Oct 2012 09:49:47 -0400
Content-Disposition: inline
In-Reply-To: <1350641449-22863-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "patches@linaro.org" <patches@linaro.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

On Fri, Oct 19, 2012 at 12:10:45PM +0200, Daniel Lezcano wrote:
> The discussion about having different cpus on the system with
> different latencies bring us to a first attemp by adding a
> pointer in the cpuidle_device to the states array.
> 
> But as Rafael suggested, it would make more sense to create a
> driver per cpu [1].
> 
> This patch adds support for multiple cpuidle drivers.
> 
> It creates a per cpu cpuidle driver pointer.
> 
> In order to not break the different drivers, the function cpuidle_register_driver
> assign for each cpu, the driver.
> 
> The multiple driver support is optional and if it is not set, the cpuide driver
> core code remains the same (except some code reorganisation).
> 
> I did the following tests compiled, booted, tested without/with CONFIG_CPU_IDLE,
> with/without CONFIG_CPU_IDLE_MULTIPLE_DRIVERS.
> 
> Tested on Core2 Duo T9500 with acpi_idle [and intel_idle]
> Tested on ARM Dual Cortex-A9 U8500 (aka Snowball)
> 
> V1 tested on Tegra3 and Vexpress TC2
> 

V2 tested on Tegra3.

Cheers,

Peter.
