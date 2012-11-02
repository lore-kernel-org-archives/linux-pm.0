From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V3 0/4] cpuidle : multiple drivers support
Date: Fri, 02 Nov 2012 13:44:47 +0100
Message-ID: <2013215.jnvfikKFWW@vostro.rjw.lan>
References: <1351701888-19963-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:52115 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab2KBMkl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 2 Nov 2012 08:40:41 -0400
In-Reply-To: <1351701888-19963-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com, linaro-dev@lists.linaro.org

On Wednesday, October 31, 2012 05:44:44 PM Daniel Lezcano wrote:
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
> [1] http://www.spinics.net/lists/linux-acpi/msg37921.html
> 
> Changelog:
> 
> V2:
>  * fixed sysfs output : /sys/devices/system/cpu/cpu[0-9]/driver/name
>  * fixed ifdefs in driver.c
>  * fixed register_driver function loop when unregistering
>  * removed WARN under spinlock
>  * fixed changelog for patch [2/4]
>  * changed cpuidle_get_cpu_driver function parameter
>  * removed cpuidle_for_each_driver function
>  * replaced smp_processor_id() by get_cpu/put_cpu
> 
> V3:
>  * refreshed patchset
> 
> Daniel Lezcano (4):
>   cpuidle: move driver's refcount to cpuidle
>   cpuidle: move driver checking within the lock section
>   cpuidle: prepare the driver core to be multi drivers aware
>   cpuidle: support multiple drivers
> 
>  drivers/cpuidle/Kconfig   |    9 ++
>  drivers/cpuidle/cpuidle.c |   36 +++++---
>  drivers/cpuidle/cpuidle.h |    4 +-
>  drivers/cpuidle/driver.c  |  209 ++++++++++++++++++++++++++++++++++++++------
>  drivers/cpuidle/sysfs.c   |  174 ++++++++++++++++++++++++++++++++++++--
>  include/linux/cpuidle.h   |    8 ++-
>  6 files changed, 388 insertions(+), 52 deletions(-)

All patches in the series applied to the linux-next branch of the linux-pm.git
tree as v3.8 material.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
