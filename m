From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH V3 0/4] cpuidle : multiple drivers support
Date: Fri, 2 Nov 2012 13:19:50 +0000
Message-ID: <20121102131950.GA4432@e102568-lin.cambridge.arm.com>
References: <1351701888-19963-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:45969 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab2KBNTz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Nov 2012 09:19:55 -0400
In-Reply-To: <1351701888-19963-1-git-send-email-daniel.lezcano@linaro.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "pdeschrijver@nvidia.com" <pdeschrijver@nvidia.com>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

On Wed, Oct 31, 2012 at 04:44:44PM +0000, Daniel Lezcano wrote:
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

V3 tested on TC2, hence, on the whole series

Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

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
> 
> -- 
> 1.7.5.4
> 
> 

