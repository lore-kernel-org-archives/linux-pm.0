From: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/2] thermal: introduce thermal_zone_get_zone_by_node
 helper function
Date: Mon, 13 Jan 2014 12:05:26 -0400
Message-ID: <52D40EC6.6050509@ti.com>
References: <1389263879-10483-1-git-send-email-wni@nvidia.com> <1389263879-10483-2-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0Lea9lcubt9djsM82JRtCvwxR83rruXmG"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389263879-10483-2-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: eduardo.valentin-l0cyMroinI0@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--0Lea9lcubt9djsM82JRtCvwxR83rruXmG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09-01-2014 06:37, Wei Ni wrote:
> The thermal framework start to support device tree, this
> patch adds a helper function to get a reference of a
> thermal zone, based on the zone's device node.

I would prefer if you could provide a better justification why we need
this API. Think of the scope of this API: would it be used only by the
of-thermal code? only by the drivers/thermal code? or any driver?

So far you have provided only one user, and that user can already work
with existing APIs. As I mention, DT does not support name duplications.

Unless you enlighten  me with better uses of this API, I would prefer
not to have it.


>=20
> It will add a device_node *np member in the struct
> thermal_zone_device, and initialize it when create a thermal
> zone. This funciton perform a zone device node lookup and
> return a reference to a thermal zone device that matches
> the device node requested.
> In case the zone is not found or if the required parameters
> are invalid, it will return the corresponding error code (ERR_PTR).
>=20
> Change-Id: I4d65f849e84425dddd387f70886a9c7c4c2002f2

For your next patches, please done include gerrit change IDs. Linux
Kernel does not need to be linked to your inhouse development history
via gerrit IDs.

> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/thermal/of-thermal.c   |    2 ++
>  drivers/thermal/thermal_core.c |   33 ++++++++++++++++++++++++++++++++=
+
>  include/linux/thermal.h        |    3 +++
>  3 files changed, 38 insertions(+)
>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.=
c
> index 04b1be7..53f2d3a 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -804,6 +804,8 @@ int __init of_parse_thermal_zones(void)
>  			of_thermal_free_zone(tz);
>  			/* attempting to build remaining zones still */
>  		}
> +
> +		zone->np =3D child;
>  	}
> =20
>  	return 0;
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> index 338a88b..eeddb94 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1672,6 +1672,39 @@ exit:
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
> =20
> +/**
> +* thermal_zone_get_zone_by_node() - search for a zone and returns its =
ref
> +* @node: device node of the thermal zone
> +*
> +* When thermal zone is found with the passed device node, returns a re=
ference
> +* to it.
> +*
> +* Return: On success returns a reference to an unique thermal zone wit=
h
> +* matching device node, an ERR_PTR otherwise (-EINVAL for invalid
> +* paramenters, -ENODEV for not found).
> +*/
> +struct thermal_zone_device *
> +thermal_zone_get_zone_by_node(struct device_node *node)
> +{
> +	struct thermal_zone_device *pos =3D NULL, *ref =3D ERR_PTR(-ENODEV);
> +	bool found =3D false;
> +
> +	if (!node)
> +		return ERR_PTR(-EINVAL);
> +
> +	mutex_lock(&thermal_list_lock);
> +	list_for_each_entry(pos, &thermal_tz_list, node)
> +		if (node =3D=3D pos->np) {
> +			ref =3D pos;
> +			found =3D true;
> +			break;
> +		}
> +	mutex_unlock(&thermal_list_lock);
> +
> +	return ref;
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_node);
> +
>  #ifdef CONFIG_NET
>  static const struct genl_multicast_group thermal_event_mcgrps[] =3D {
>  	{ .name =3D THERMAL_GENL_MCAST_GROUP_NAME, },
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index f7e11c7..288d272 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -162,6 +162,7 @@ struct thermal_zone_device {
>  	int id;
>  	char type[THERMAL_NAME_LENGTH];
>  	struct device device;
> +	struct device_node *np;
>  	struct thermal_attr *trip_temp_attrs;
>  	struct thermal_attr *trip_type_attrs;
>  	struct thermal_attr *trip_hyst_attrs;
> @@ -286,6 +287,8 @@ thermal_of_cooling_device_register(struct device_no=
de *np, char *, void *,
>  				   const struct thermal_cooling_device_ops *);
>  void thermal_cooling_device_unregister(struct thermal_cooling_device *=
);
>  struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *=
name);
> +struct thermal_zone_device *
> +thermal_zone_get_zone_by_node(struct device_node *node);
>  int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned lon=
g *temp);
> =20
>  int get_tz_trend(struct thermal_zone_device *, int);
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--0Lea9lcubt9djsM82JRtCvwxR83rruXmG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLUDsYACgkQCXcVR3XQvP2/5QEAmWSwEG3P3kMfIrVXoLDnrG2I
5G4l0+nWZq6cvuJUOvEBANBvImh5eqtVwXJshxClcRSNTTSsjb6p3G8khajR7mUN
=3cZ/
-----END PGP SIGNATURE-----

--0Lea9lcubt9djsM82JRtCvwxR83rruXmG--
