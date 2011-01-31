From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC][PATCH] Power domains for platform bus type
Date: Mon, 31 Jan 2011 15:16:15 -0800
Message-ID: <87tygo3br4.fsf@ti.com>
References: <201101300107.19389.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101300107.19389.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sun, 30 Jan 2011 01:07:19 +0100")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> Hi,
>
> This is something we discussed during the last Linux Plumbers Conference.
>
> The problem appears to be that the same device may be used in different
> systems in different configurations such that actions necessary for the
> device's power management can vary from one system to another.  In those
> cases the drivers' power management callbacks are generally not sufficient,
> because they can't take the configuration of the whole system into account.
>
> I think this issue may be addressed by adding objects that will represent
> power domains and will provide power management callbacks to be executed
> in addition to the device driver's PM callbacks, which is done by the patch
> below.
>
> Please have a look at it and tell me what you think.

Very nice.  I like the approach and the fact that it allows grouping of
only devices we care about customizing, instead of every device on the
platform_bus (I know Grant will like that part too.  :)

I experimented with something similar before I took the easy way out
with platform_bus_set_pm_ops() :/

This approach might also solve the problem(s) we've been discussing
around the conflicts between runtime PM callbacks and system PM
callbacks (that RTC vs. i2c issue.)  With this approach, I shouldn't
have to to add the callbacks like I did for the i2c driver, but rather
handle them in common code.  I'll experiment with this...

The primary question for me is whether this should rather be at the
'struct device' level instead of at the platform_device level.  While
we're currently only using this customization on platform_devices, I
don't think we should limit it to that.  Part of these discussions at
LPC was also about whether or not to move to using custom SoC-specific
devices and busses.  If/when we go that route, we'd want these power
domains part of struct device, not platform_device.

It would be a rather minor change to your patch, but would be more
flexible for the future.

Some other minor comments below...

> ---
> The platform bus type is often used to represent Systems-on-a-Chip
> (SoC) where all devices are represented by objects of type struct
> platform_device.  In those cases the same "platform" device driver
> may be used in multiple different system configurations, but the
> actions needed to put the devices it handles into a low-power state
> and back into the full-power state may depend on the design of the
> SoC.  The driver, however, cannot possibly include all the
> information necessary for the power management of its device on all
> the systems it's used with.  Moreover, the device hierarchy also
> isn't suitable for holding this kind of information.
>
> The patch below attempts to address this problem by introducing
> objects of type struct power_domain that can be used for representing
> power domains inside of the SoC.  Every struct power_domain object
> consists of two sets of device power management callbacks that
> can be used to perform what's needed for device power management
> in addition to the operations carried out by the device's driver.
> Namely, if a struct power_domain object is pointed to by the domain
> field in a struct platform_device, the callbacks provided by its
> pre_ops member will be executed for the dev member of that
> struct platform_device before executing the corresponding callbacks
> provided by the device's driver.  Analogously, the power domain's
> post_ops callbacks will be executed after the corresponding callbacks
> provided by the device's driver.

You should probably add here that the power_domain callbacks will be
called even if a driver is not present for the device, which may or may
not be expected.

> ---
>  drivers/base/platform.c         |  266 ++++++++++++++++++++++++++++------------
>  include/linux/platform_device.h |    6 
>  2 files changed, 198 insertions(+), 74 deletions(-)
>
> Index: linux-2.6/include/linux/platform_device.h
> ===================================================================
> --- linux-2.6.orig/include/linux/platform_device.h
> +++ linux-2.6/include/linux/platform_device.h
> @@ -14,6 +14,11 @@
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
>  
> +struct power_domain {
> +	struct dev_pm_ops *pre_ops;
> +	struct dev_pm_ops *post_ops;
> +};

Since most SoC code is also going to have something called 'struct
power_domain', I'd suggest naming this 'struct dev_power_domain' or
something to indicate it's part of the driver model, so it wouldn't get
confused with other SoC specific power_domain structs.

Thanks,

Kevin
