From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking
 support
Date: Wed, 26 Oct 2016 13:19:02 +0200
Message-ID: <20161026111902.GA6447@wunner.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <13957403.ZrB4mMbICz@vostro.rjw.lan>
 <2715729.9U1nlcpFb3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2715729.9U1nlcpFb3@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

sorry for not responding to v5 of your series earlier, just sending
this out now in the hope that it reaches you before your travels.

On Mon, Oct 10, 2016 at 02:51:04PM +0200, Rafael J. Wysocki wrote:
> - Modify device_links_check_suppliers(), device_links_driver_bound(),
>   device_links_no_driver(), device_links_driver_cleanup(), device_links_busy(),
>   and device_links_unbind_consumers() to walk link lists under device_links_lock
>   (to make the new "driver presence tracking" mechanism work reliably).

This change might increase boot time if drivers return -EPROBE_DEFER.
It can easily happen that such drivers are probed dozens of times,
and each time the lock will be acquired, blocking other drivers from
probing.  Granted, it's hard to measure if and in how far boot time
really increases, but somehow I liked the previous approach better.
The combination of a mutex with an RCU plus a spinlock seemed complicated
when I reviewed the patch, but I never said anything because I came
to the conclusion that the effort seemed worthwhile to keep up the
performance.

(BTW, kbuild test robot has complained that the usage of RCUs isn't
enclosed in #ifdef CONFIG_SRCU.  Just in case you haven't seen that.)


> - Redefine device_link_add() to take three arguments, the supplier and consumer
>   pointers and flags, and to figure out the initial link state automatically.

That's a good idea, however it seems to me that there's some redundancy
between the dl_dev_state and device_link_state:  AFAICS, at any given
moment the device_link_state can be computed from the supplier's and
consumer's dl_dev_state.

One could argue that caching the device_link_state is cheaper than
recomputing it every time it's needed, but often the dl_dev_state of
one of the two devices is known, so the link can only be in a subset
of all possible states, and instead of computing the device_link_state
it's sufficient to just look at the other device's dl_dev_state.

E.g. in device_links_check_suppliers() we have this:

+		if (link->status != DL_STATE_AVAILABLE) {
+			device_links_missing_supplier(dev);
+			ret = -EPROBE_DEFER;
+			break;
+		}

When this function is called we know that the consumer's dl_dev_state is
DL_DEV_PROBING.  Of interest is only the status of the supplier. The above
if-condition would seem to be equivalent to:

		if (link->supplier->links.status == DL_DEV_DRIVER_BOUND) {

So the device_link_state seems redundant, but if it's removed from
struct device_link, changes to dl_dev_state need to be synchronized
between supplier and consumers.  Perhaps this could be accomplished
by acquiring the device_lock for the other device.  E.g. when a
consumer wants to probe, before changing its own dl_dev_state it would
have to acquire the device_lock for all suppliers to prevent races
if one of them simultaneously decides to unbind (and changes its
dl_dev_state to DL_DEV_UNBINDING).  Hm, could this deadlock?


Also, I notice that the dl_dev_state is part of a device's "links"
structure, but being able to look up a device's driver state might be
useful in other cases, not just for device links.  Maybe it makes sense
to move the dl_dev_state one level up to struct device and name the
attribute "driver_status" or somesuch (like the existing "driver" and
"driver_data" attributes).


> +	/* Deterine the initial link state. */
                ^
                m

Thanks,

Lukas
