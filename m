From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 2/8] ACPI / PM: Attach ACPI power domain only once
Date: Tue, 28 Jul 2015 08:47:30 +0100
Message-ID: <20150728074730.GP21114@x1>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1438009443-55317-3-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438009443-55317-3-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Mon, 27 Jul 2015, Andy Shevchenko wrote:

> From: Mika Westerberg <mika.westerberg@linux.intel.com>
>=20
> Some devices, like MFD subdevices, share a single ACPI companion devi=
ce so
> that they are able to access their resources and children. However,
> currently all these subdevices are attached to the ACPI power domain =
and
> this might cause that the power methods for the companion device get =
called
> more than once.
>=20
> In order to solve this we attach the ACPI power domain only to the fi=
rst
> physical device that is bound to the ACPI companion device. In case o=
f MFD
> devices, this is the parent MFD device itself.
>=20
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/device_pm.c |  8 ++++++++
>  drivers/acpi/internal.h  |  2 ++
>  drivers/acpi/scan.c      | 46 ++++++++++++++++++++++++++++++--------=
--------
>  3 files changed, 40 insertions(+), 16 deletions(-)

Applied, thanks.  Pull request to follow.

> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 717afcd..08dc3ec 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1123,6 +1123,14 @@ int acpi_dev_pm_attach(struct device *dev, boo=
l power_on)
>  	if (dev->pm_domain)
>  		return -EEXIST;
> =20
> +	/*
> +	 * Only attach the power domain to the first device if the
> +	 * companion is shared by multiple. This is to prevent doing power
> +	 * management twice.
> +	 */
> +	if (!acpi_device_is_first_physical_node(adev, dev))
> +		return -EBUSY;
> +
>  	acpi_add_pm_notifier(adev, dev, acpi_pm_notify_work_func);
>  	dev->pm_domain =3D &acpi_general_pm_domain;
>  	if (power_on) {
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 4683a96..f6aefe9 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -97,6 +97,8 @@ void acpi_device_add_finalize(struct acpi_device *d=
evice);
>  void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
>  bool acpi_device_is_present(struct acpi_device *adev);
>  bool acpi_device_is_battery(struct acpi_device *adev);
> +bool acpi_device_is_first_physical_node(struct acpi_device *adev,
> +					const struct device *dev);
> =20
>  /* -----------------------------------------------------------------=
---------
>                                    Power Resource
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index ec25635..89ff6d2 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -226,6 +226,35 @@ static int create_of_modalias(struct acpi_device=
 *acpi_dev, char *modalias,
>  	return len;
>  }
> =20
> +/**
> + * acpi_device_is_first_physical_node - Is given dev first physical =
node
> + * @adev: ACPI companion device
> + * @dev: Physical device to check
> + *
> + * Function checks if given @dev is the first physical devices attac=
hed to
> + * the ACPI companion device. This distinction is needed in some cas=
es
> + * where the same companion device is shared between many physical d=
evices.
> + *
> + * Note that the caller have to provide valid @adev pointer.
> + */
> +bool acpi_device_is_first_physical_node(struct acpi_device *adev,
> +					const struct device *dev)
> +{
> +	bool ret =3D false;
> +
> +	mutex_lock(&adev->physical_node_lock);
> +	if (!list_empty(&adev->physical_node_list)) {
> +		const struct acpi_device_physical_node *node;
> +
> +		node =3D list_first_entry(&adev->physical_node_list,
> +					struct acpi_device_physical_node, node);
> +		ret =3D node->dev =3D=3D dev;
> +	}
> +	mutex_unlock(&adev->physical_node_lock);
> +
> +	return ret;
> +}
> +
>  /*
>   * acpi_companion_match() - Can we match via ACPI companion device
>   * @dev: Device in question
> @@ -250,7 +279,6 @@ static int create_of_modalias(struct acpi_device =
*acpi_dev, char *modalias,
>  static struct acpi_device *acpi_companion_match(const struct device =
*dev)
>  {
>  	struct acpi_device *adev;
> -	struct mutex *physical_node_lock;
> =20
>  	adev =3D ACPI_COMPANION(dev);
>  	if (!adev)
> @@ -259,21 +287,7 @@ static struct acpi_device *acpi_companion_match(=
const struct device *dev)
>  	if (list_empty(&adev->pnp.ids))
>  		return NULL;
> =20
> -	physical_node_lock =3D &adev->physical_node_lock;
> -	mutex_lock(physical_node_lock);
> -	if (list_empty(&adev->physical_node_list)) {
> -		adev =3D NULL;
> -	} else {
> -		const struct acpi_device_physical_node *node;
> -
> -		node =3D list_first_entry(&adev->physical_node_list,
> -					struct acpi_device_physical_node, node);
> -		if (node->dev !=3D dev)
> -			adev =3D NULL;
> -	}
> -	mutex_unlock(physical_node_lock);
> -
> -	return adev;
> +	return acpi_device_is_first_physical_node(adev, dev) ? adev : NULL;
>  }
> =20
>  static int __acpi_device_uevent_modalias(struct acpi_device *adev,

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
