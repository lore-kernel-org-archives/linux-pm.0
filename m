From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC/PATCH 2/3] Allow objects other than "struct
	device" in pm list
Date: Wed, 28 Feb 2007 10:24:09 -0800
Message-ID: <200702281024.10384.david-b@pacbell.net>
References: <20061011060138.920913139.dtor@insightbb.com>
	<20061011061030.258583307.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061011061030.258583307.dtor@insightbb.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@vrfy.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 10 October 2006 11:01 pm, Dmitry Torokhov wrote:
> PM: allow objects other than "struct device" in pm list

For what it's worth I'd like to see that global list go away.  It's only
a shortcut to simplify the "walk the whole device tree" during system-wide
sleep state transitions, and it doesn't cooperate all that well with the
notion that large chunks of that tree might already be suspended.

It's straightforward to construct the relevant list on the fly, and in a
way that could let subtrees suspend and resume based on the demands of
runtime PM.  (Like, hmm, a tree of USB devices ...)  Which could achieve
goals like suspending and resuming into the same system state, rather than
having resume force all devices into full power state (even ones that had
previously been in low power states).  Heck, there might not _be_ enough
power available to turn everything back on!


> Any object with embedded dev_pm_info structure can be added to
> ower management list and have its suspend/resume methods called
> automatically by driver core.
> =

> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

This patch was interesting ... was there followup that I missed?
(The patch 3/3, teaching class_device how to do PM, seems like it's
not a good approach, now that class suspend/resume can work.)

The thing is that the driver model tree parent mostly reflects one kind of
relationship -- I'll call it "control", it's at least "suspends after" plus
"resumes before" -- while power management can involve many relationships.

For example, the clock tree never shows up in the driver model tree.  (In
fact it doesn't "show up" much of anywhere, despite being essential  ...)
And for various reasons, folk tend to hide the bus hierarchy found inside
a given SOC ... and the way it's common for devices to use one bus for
volume data transfers, and another for control transfers.  (Power saving
points for powering both bus interfaces on/off at runtime...)

And the only infrastructure that currently exists to reflect other kinds
of PM relationship is the pm_parent ... which never worked for much of
anything that I can see.

Something like this patch might actually be able to make that mechanism
become useful for something.  If not ... then maybe pm_parent should be
removed.


> --- work.orig/drivers/base/power/main.c
> +++ work/drivers/base/power/main.c
> @@ -31,8 +31,8 @@ DECLARE_MUTEX(dpm_list_sem);
>  =

>  /**
>   *	device_pm_set_parent - Specify power dependency.
> - *	@dev:		Device who needs power.
> - *	@parent:	Device that supplies power.
> + *	@dpm:		Object who needs power.
> + *	@parent:	Object that supplies power.

I'm not 100% sure that "supplies power" is the interesting relationship.
Or that there's necessarily only one such supplier; it's common for
devices to use more than one voltage.

- Dave


> --- work.orig/include/linux/pm.h
> +++ work/include/linux/pm.h
> @@ -206,12 +206,21 @@ struct dev_pm_info {
>  #ifdef	CONFIG_PM
>  	unsigned		should_wakeup:1;
>  	pm_message_t		prev_state;
> -	void			* saved_state;
> -	struct device		* pm_parent;
> +	void			*saved_state;
> +	struct kobject		*pm_object;
> +	struct dev_pm_info	*pm_parent;
>  	struct list_head	entry;
> +	const struct dev_pm_ops	*pm_ops;
>  #endif
>  };
>  =

> +struct dev_pm_ops {
> +	int (*suspend)(struct dev_pm_info *dpm, pm_message_t state);
> +	int (*suspend_late)(struct dev_pm_info *dpm, pm_message_t state);
> +	int (*resume_early)(struct dev_pm_info *dpm);
> +	int (*resume)(struct dev_pm_info *dpm);
> +};
> +
>  extern void device_pm_set_parent(struct device * dev, struct device * pa=
rent);
>  =

>  extern int device_power_down(pm_message_t state);
