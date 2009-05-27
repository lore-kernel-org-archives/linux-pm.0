From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Date: Wed, 27 May 2009 10:30:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0905271028050.2942-100000__2248.25586560673$1243434725$gmane$org@iolanthe.rowland.org>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
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

On Wed, 27 May 2009, Magnus Damm wrote:

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

Have you given any thought as to whether the platform_device_wakeup and 
platform_device_idle calls should be restricted to process context?

You should consider using a special workqueue for this stuff instead of 
relying on the default workqueue.  It can help avoid deadlocks, and it 
has the advantage that you can define the workqueue to be freezable.  
(Generally speaking, you don't want platform-level wakeup and idle 
calls to start running spontaneously in the middle of a system sleep 
transition.)

Alan Stern
