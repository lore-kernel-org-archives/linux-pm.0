From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 03/04] PM: Add platform bus runtime dev_pm_ops
Date: Sat, 30 May 2009 01:23:17 +0200
Message-ID: <200905300123.18367.rjw__1573.82346592403$1243639593$gmane$org@sisk.pl>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
	<20090527100650.29671.82139.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090527100650.29671.82139.sendpatchset@rx1.opensource.se>
Content-Disposition: inline
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

On Wednesday 27 May 2009, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Wrap the platform device bus dev_pm_ops to allow runtime
> pm and regular suspend and resume to coexist.
> 
> Platform device data is extended with flags that allow
> us to keep track of which dev_pm_ops that has been called.
> 
> Basically, if a device has been frozen by the runtime pm
> code, don't call ->freeze() again when hibernating.
> 
> Architecture code can use platform_runtime_dev_pm_ops to
> call driver dev_pm_ops associated with a certain device.
> 
> Enable with CONFIG_HAVE_PLATFORM_DEVICE_RUNTIME_PM.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  This is a bit of a hack, any better way to wrap dev_pm_ops?

I'm not really sure you need to wrap them at all.

There are a few choices:

(1) You can use the platform_pm_* functions directly for run-time PM, but
in that case you'll need to make sure that the "suspend" ones return 0
immediately when called during system-wide suspend or hibernation (there's the
question whether the "resume" ones should still put the device into the full
power state in that case).  For this purpose you can add a single flag to
struct platform_device and set it for devices that have already been
"suspended" (this flag, when set, will make all of the "suspend" callbacks
return 0 without doing anything until the device is "resumed").

(2) You can add separate platform callbacks for run-time PM that will execute
the drivers' dev_pm_ops callbacks and presumably do something else (I don't
know what that may be for platform devices, though).  In that case, again,
adding a flag to struct platform_device and making platform_pm_* check it
should be sufficient to prevent devices from being suspended twice in a row.

(3) You can add separate platform callbacks for run-time PM for both the
bus type and the drivers, in which dev_pm_ops will be totally separate from
these new callbacks, although of course you'll need provide some kind of
synchronization bettween them all.  That also may be done through a flag
in struct platform_device IMO.

Now, since other bus types will most probably also need a flag in their
_device structures, it may be worth putting it into struct device (we've
discsussed that already).

I'm not sure which of (1) - (3) are the most suitable for the platform bus
type.  For PCI I'd probably choose (2), because the current PCI bus type's
dev_pm_ops callbacks are tailored to system-wide power transitions.
Moreover, PCI devices can generally be put first into D1, then into D2 and
finally into D3, which only makes sense at run time, and some of them may
have to be put back into the full power state before a system-wide transition
(apparently, we'll need a separate flag to mark such devices).

Of course, if you decide to add separate run-time PM callbacks for the
platform bus type, you won't need to wrap its dev_pm_ops callbacks any more,
but you'll need to modify them to check the appropriate flag(s).  For example,
you may choose to use a two-bit pm_suspend_level field such that

* if pm_suspend_level = 1, platform_pm_prepare() will return immediately
* if pm_suspend_level = 2, platform_pm_prepare() and platform_pm_suspend()
  will return immediately
* if pm_suspend_level = 3, platform_pm_prepare(), platform_pm_suspend()
  and platform_pm_suspend_noirq() will return immediately

(and analogously for the hibernation callbacks) and make your run-time PM
callbacks set this field appropriately.

Thanks,
Rafael
