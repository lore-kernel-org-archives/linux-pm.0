From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Date: Thu, 28 May 2009 10:14:43 -0700
Message-ID: <877i01p2t8.fsf__19175.9986374111$1243530943$gmane$org@deeprootsystems.com>
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

A couple comments/questions:

Wouldn't the 'wakeup' hook be better named platform_device_enable().
The _wakeup name seems to imply that the call will perform some sort
of wakeup, but all it's really doing is enabling it by turning it on
or taking it out of idle.

In the process of discussing a similar interface for OMAP, we dicussed
that having 3 states would be more useful.  Specifically, and
_enable(), _idle() and _disable() hook.  The _enable() and _idle()
hooks being exactly what you proposed above, but with the addition of
a _disable() hook which says not only can the device go idle, but that
the driver is really finished with the device.  In this case, more
aggresive PM measures could be taken, such as turning of regulators
that may have long latencies that may not be appropriate to turn off
in idle.

I'm interested in any thoughts there because the line between _idle()
and _disable() remains a little fuzzy to me still.  For exmaple, maybe
the _idle() call in combination with latency constraints in PM QoS
could do effectively the same thing as _disable().

Kevin
