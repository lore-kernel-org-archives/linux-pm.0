From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Date: Wed, 27 May 2009 17:32:17 -0700
Message-ID: <87prdut6cu.fsf__49593.5552324683$1243470790$gmane$org@deeprootsystems.com>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
	(Magnus Damm's message of "Wed\, 27 May 2009 19\:06\:25 +0900")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Magnus Damm <magnus.damm@gmail.com> writes:

> PM: Runtime platform device power management
>
> [PATCH 01/04] Driver Core: Add platform device arch data
> [PATCH 02/04] Driver Core: Add idle and wakeup functions
> [PATCH 03/04] PM: Add platform bus runtime dev_pm_ops
> [PATCH 04/04] sh: Runtime platform device PM mockup
>
> These patches extend platform device and driver interfaces to
> allow architectures to implement platform device runtime pm.
>
> Upstream runtime power management needs to be improved to fully
> make use of hardware power saving features found on embedded
> platforms and in common SoCs.
>
> For runtime power management we today have cpuidle, the clock
> framework and qos. This allows the cpu core to enter various
> forms of deep sleep, and for devices we may stop clocks to save
> power. Modern SoCs however allow disabling of power to parts of
> the chip, and we have no upstream interface to handle that today.
>
> I propose adding the following simple platform device functions:
>  - platform_device_wakeup()
>  - platform_device_idle()
>
> The idle function is used by the platform driver to let the 
> architecture power management code know that from now on the
> device is in idle state. When the device is marked as idle
> the architecture specific runtime power management may decide
> to do various levels of device power management, ranging from
> stopping clocks to turning off power. The dev_pm_ops callbacks
> may be invoked by the runtime pm code to save and restore state
> whenever the device is marked as idle.
>
> The wakeup function is used by the platform driver to notify the
> architecture code that the driver wants to make use of the hardware
> device. If the device has been put in sleep then it needs to be
> woken up. This wakeup call may invoke dev_pm_ops callbacks.
>
> Have a look at the last patch for a SuperH mockup that shows how
> it all fits together. We need this or a similar interface to be able
> to enter deep sleep states on SuperH. I believe other architectures
> have similar requirements.
>
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Speaking on behalf of OMAP PM developers, and as maintainer of the
current OMAP PM infrastructure, this is a major step towards a generic
runtime PM that we would use on OMAP as well.

In the PM branch of the linux-omap tree, we currently have an ad-hoc
but working infrastructure for all of this, including device-specific
save/restore hooks for supporting some or all of the on-chip
powerdomains to go off during idle.

However, our current approach hides most of the details behind the
clock framework, custom save/restore hooks and in some cases custom
platform hooks passed using platform_data.

I like this proposed approach much better as it generalizes the
approach and allows us to share the infrastructure across arches
as well as decouple device idleness from clock management.

Kevin
