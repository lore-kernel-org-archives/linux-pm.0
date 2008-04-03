From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/3] use new pm_ops in DRM drivers
Date: Thu, 3 Apr 2008 23:23:57 +0200
Message-ID: <200804032323.59133.rjw__22056.7017946907$1207257994$gmane$org@sisk.pl>
References: <200804020207.40278.rjw@sisk.pl> <200804020209.47207.rjw@sisk.pl>
	<200804031150.55967.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804031150.55967.jbarnes@virtuousgeek.org>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Thursday, 3 of April 2008, Jesse Barnes wrote:
> On Tuesday, April 01, 2008 5:09 pm Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Introduce 'struct pm_ops' and 'struct pm_ext_ops' ('ext' meaning
> > 'extended') representing suspend and hibernation operations for bus
> > types, device classes, device types and device drivers.
> >
> > Modify the PM core to use 'struct pm_ops' and 'struct pm_ext_ops'
> > objects, if defined, instead of the ->suspend() and ->resume(),
> > ->suspend_late(), and ->resume_early() callbacks (the old callbacks
> > will be considered as legacy and gradually phased out).
> >
> > The main purpose of doing this is to separate suspend (aka S2RAM and
> > standby) callbacks from hibernation callbacks in such a way that the
> > new callbacks won't take arguments and the semantics of each of them
> > will be clearly specified. =A0This has been requested for multiple
> > times by many people, including Linus himself, and the reason is that
> > within the current scheme if ->resume() is called, for example, it's
> > difficult to say why it's been called (ie. is it a resume from RAM or
> > from hibernation or a suspend/hibernation failure etc.?).
> =

> I like the new ops much better; their purpose is clearer and better separ=
ated =

> than before.

Well, that's the idea. :-)

> I think the i915 changes should look something like this? =


Basically, yes, but with one comment (below).

> Also, what about class devices?  Right now, they just have suspend & resu=
me =

> callbacks, not full pm_ops structures.

They just haven't been modified yet, but that's going to happen.

> But maybe they're not really necessary anyway,

IIRC, there are some device classes that may need them.  Like leds etc.

> I could set the pm_ops.prepare & complete callbacks to DRM core routines =
in
> order to suspend & resume DRM client requests...

That would be the way to go, IMHO.

> Also, it looks like the PCI bits I had in i915 aren't really necessary?

Well, I think some of them are.

> diff --git a/drivers/char/drm/i915_drv.c b/drivers/char/drm/i915_drv.c
> index b2b451d..ec6356a 100644
> --- a/drivers/char/drm/i915_drv.c
> +++ b/drivers/char/drm/i915_drv.c
> @@ -239,8 +239,9 @@ static void i915_restore_vga(struct drm_device *dev)
>  =

>  }
>  =

> -static int i915_suspend(struct drm_device *dev, pm_message_t state)
> +static int i915_save(struct device *device)
>  {
> +	struct drm_device *dev =3D container_of(device, struct drm_device, dev);
>  	struct drm_i915_private *dev_priv =3D dev->dev_private;
>  	int i;
>  =

> @@ -250,10 +251,6 @@ static int i915_suspend(struct drm_device *dev, =

> pm_message_t state)
>  		return -ENODEV;
>  	}
>  =

> -	if (state.event =3D=3D PM_EVENT_PRETHAW)
> -		return 0;
> -
> -	pci_save_state(dev->pdev);
>  	pci_read_config_byte(dev->pdev, LBB, &dev_priv->saveLBB);
>  =

>  	/* Pipe & plane A info */
> @@ -367,24 +364,16 @@ static int i915_suspend(struct drm_device *dev, =

> pm_message_t state)
>  =

>  	i915_save_vga(dev);
>  =

> -	if (state.event =3D=3D PM_EVENT_SUSPEND) {
> -		/* Shut down the device */
> -		pci_disable_device(dev->pdev);
> -		pci_set_power_state(dev->pdev, PCI_D3hot);
> -	}
> -
>  	return 0;
>  }
>  =

> -static int i915_resume(struct drm_device *dev)
> +static int i915_restore(struct device *device)
>  {
> +	struct drm_device *dev =3D container_of(device, struct drm_device, dev);
>  	struct drm_i915_private *dev_priv =3D dev->dev_private;
>  	int i;
>  =

>  	pci_set_power_state(dev->pdev, PCI_D0);
> -	pci_restore_state(dev->pdev);
> -	if (pci_enable_device(dev->pdev))
> -		return -1;
>  =

>  	pci_write_config_byte(dev->pdev, LBB, dev_priv->saveLBB);
>  =

> @@ -527,6 +516,23 @@ static int i915_resume(struct drm_device *dev)
>  	return 0;
>  }
>  =

> +static int i915_poweroff(struct device *dev)
> +{
> +	/* Shut down the device */
> +	pci_disable_device(dev->pdev);
> +	pci_set_power_state(dev->pdev, PCI_D3hot);

I think you may need to do that in ->suspend() too, as opposed to ->freeze(=
),
...

> +}
> +
> +static struct pm_ops i915_pm_ops =3D {
> +	.prepare =3D NULL, /* DRM core should prevent any new ioctls? */
> +	.complete =3D NULL, /* required to re-enable DRM client requests */
> +	.suspend =3D i915_save,
> +	.resume =3D i915_restore,
> +	.freeze =3D i915_save,

... so perhaps define ->suspend() as ->save() + ->poweroff()?

> +	.restore =3D i915_restore,
> +	.poweroff =3D i915_poweroff,
> +};
> +
>  static struct drm_driver driver =3D {
>  	/* don't use mtrr's here, the Xserver or user space app should
>  	 * deal with them for intel hardware.
> @@ -539,8 +545,6 @@ static struct drm_driver driver =3D {
>  	.unload =3D i915_driver_unload,
>  	.lastclose =3D i915_driver_lastclose,
>  	.preclose =3D i915_driver_preclose,
> -	.suspend =3D i915_suspend,
> -	.resume =3D i915_resume,
>  	.device_is_agp =3D i915_driver_device_is_agp,
>  	.vblank_wait =3D i915_driver_vblank_wait,
>  	.vblank_wait2 =3D i915_driver_vblank_wait2,
> @@ -581,6 +585,7 @@ static struct drm_driver driver =3D {
>  static int __init i915_init(void)
>  {
>  	driver.num_ioctls =3D i915_max_ioctl;
> +	driver->dev.pm_ops =3D &i915_pm_ops;
>  	return drm_init(&driver);
>  }

Well, I see I should push the patches to Greg ... ;-)

Thanks,
Rafael
