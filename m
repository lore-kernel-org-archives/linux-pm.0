From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC 1/4] power_supply: Introduce charging object table
Date: Sun, 8 Mar 2015 02:00:27 +0100
Message-ID: <20150308010026.GA22810@earth>
References: <1425638007-9411-1-git-send-email-jenny.tc@intel.com>
 <1425638007-9411-2-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35389 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbbCHBAm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 7 Mar 2015 20:00:42 -0500
Content-Disposition: inline
In-Reply-To: <1425638007-9411-2-git-send-email-jenny.tc@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jenny TC <jenny.tc@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Anton Vorontsov <anton.vorontsov@linaro.org>, David Woodhouse <dwmw2@infradead.org>, jonghwa3.lee@samsung.com, myungjoo.ham@gmail.com, Pallala Ramakrishna <ramakrishna.pallala@intel.com>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 06, 2015 at 04:03:24PM +0530, Jenny TC wrote:
> Charging current (CC) and charging voltage (CV) may vary based on
> battery temperature. To support CC and CV for different temperature
> zones, defined a charging object which holds the properties related
> to battery charging.
>=20
> Signed-off-by: Jenny TC <jenny.tc@intel.com>
> ---
>  include/linux/power_supply.h |   27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 096dbce..7aada44 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -252,6 +252,33 @@ struct power_supply_info {
>  	int use_for_apm;
>  };
> =20
> +
> +struct psy_temp_mon_table {
> +	int temp_max;
> +	int temp_min;
> +	int charging_current; /* CC */
> +	int charging_voltage; /* CV */
> +	/* delta voltage at which charging should restart */
> +	int maint_voltage_delta;
> +};
> +
> +#define PSY_MAX_BAT_NAME_LEN 8
> +#define PSY_MAX_TEMP_ZONE 6
> +
> +struct psy_charging_obj {

This is not just about charging data, but also about the batteries
thermal limits, technology and full capacity, so how about

struct psy_battery_information {

> +	char name[PSY_MAX_BAT_NAME_LEN];

char *name;

No need for arbitrary length limitation.

> +	int battery_type;
> +	int temp_max;
> +	int temp_min;
> +	int full_condition_soc;

Please be more verbose about the information being stored here.

> +	int full_condition_capacity;
> +	int full_condition_voltage;
> +	int iterm; /* charge termination current */
> +	/* CC/CV table for different temperature range */
> +	int temp_mon_count; /* number of entries in temp_mon_table */
> +	struct psy_temp_mon_table temp_mon_table[PSY_MAX_TEMP_ZONE];

No need to embed this into the struct. Just point to the array and
remove the size limitation.

> +};
> +
>  extern struct atomic_notifier_head power_supply_notifier;
>  extern int power_supply_reg_notifier(struct notifier_block *nb);
>  extern void power_supply_unreg_notifier(struct notifier_block *nb);

-- Sebastian

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU+58oAAoJENju1/PIO/qaCYcP/0Uki+v1q35N49IOu3sYfIys
GrugB233f5aPI9e236TOjz6b4aaO1yH3waYAA3wJMncAMCgXHOGXDeJx4/GogzO6
8osXVs04HwYZzy+lg4MR2wYUWZguKZSGVHW2EzlEGzHB6t98VsuDHzAwaKTe/0Bw
f3JSk/Yv5GAtlhUJtMrSpG+g6qTC/ZH3I037491UZbE/c3wNVZDdjLAu+umVweQE
ZTGaMwSOWojzt/OagCYbZVwOBLoVcNZ0eyjwTpmr0CkxvrvtlmnbCqtOYwPktgXe
+FzWE2zGtrPVWXmW7jXsx94VNorj7mUXn/18pNP7pG+2/XfRqnZWJlVbQ7q1Xlxw
xBdDE6kycYCP64NKDH3OH61fA0qHppOoFo8ejsm4H0FoubxeWwe9EsTRn+GZgjRA
AA9cHwwTeEziQObEpDjpi/GXdwrNeCVUILLCI1nIKuU3rzilFadQ5RAr9TOsh86c
CV5aBdpAgV18OSxbGBCVcOJttuI622wzsfexBl314ypzXCPr1+7Y6kXv8PU/bokx
ya/Q55f7fCZd7EDjYjF+rJCu/vWJjA26k0mNlzMM7tHKJmMCydpARaaV24tA7/gk
AoxKo8mfFCuq3VoU+PdhzIUz0D0iP5fl5BraRPJ/DOYx8uuE7JRcezJknu0onGLe
PtM03WVIcu+EjFm1Lcu1
=DoJ+
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
