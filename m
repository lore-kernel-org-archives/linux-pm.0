From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH] Thermal: change spin lock
Date: Tue, 24 Sep 2013 13:25:54 -0400
Message-ID: <5241CB22.2040709@ti.com>
References: <1379023514-14982-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3gjXMEuNxMTeXI6EvtnLjHFvx2t6qccV3"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37798 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754462Ab3IXR0Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 24 Sep 2013 13:26:16 -0400
In-Reply-To: <1379023514-14982-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, eduardo.valentin@ti.com

--3gjXMEuNxMTeXI6EvtnLjHFvx2t6qccV3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Please change your patch subject. It suggests you are changing the
locking mechanism in the entire thermal subsystem, which is not true.

On 12-09-2013 18:05, Srinivas Pandruvada wrote:
> Change spin_lock to spin_lock_irqsave and spin_unlock to
> spin_unlock_irqrestore as the data it is trying to protect can also
> be modified in a notification call called from interrupt handler.

ditto for your patch description.


While you are there, looks like your lock needs a better documentation.
I would suggest you to add a description of what data it protects and
not leaving only documentation of where it it used.

Also, in your code it is not clear what is interrupt context and what is
not interrupt context. Now that you have found that you have the need to
use this lock in both context, please document it.

>=20
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com=
>
> ---
>  drivers/thermal/x86_pkg_temp_thermal.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x=
86_pkg_temp_thermal.c
> index f36950e..7722cb9 100644
> --- a/drivers/thermal/x86_pkg_temp_thermal.c
> +++ b/drivers/thermal/x86_pkg_temp_thermal.c
> @@ -316,18 +316,19 @@ static void pkg_temp_thermal_threshold_work_fn(st=
ruct work_struct *work)
>  	int phy_id =3D topology_physical_package_id(cpu);
>  	struct phy_dev_entry *phdev =3D pkg_temp_thermal_get_phy_entry(cpu);
>  	bool notify =3D false;
> +	unsigned long flags;
> =20
>  	if (!phdev)
>  		return;
> =20
> -	spin_lock(&pkg_work_lock);
> +	spin_lock_irqsave(&pkg_work_lock, flags);
>  	++pkg_work_cnt;
>  	if (unlikely(phy_id > max_phy_id)) {
> -		spin_unlock(&pkg_work_lock);
> +		spin_unlock_irqrestore(&pkg_work_lock, flags);
>  		return;
>  	}
>  	pkg_work_scheduled[phy_id] =3D 0;
> -	spin_unlock(&pkg_work_lock);
> +	spin_unlock_irqrestore(&pkg_work_lock, flags);
> =20
>  	enable_pkg_thres_interrupt();
>  	rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
> @@ -397,6 +398,7 @@ static int pkg_temp_thermal_device_add(unsigned int=
 cpu)
>  	int thres_count;
>  	u32 eax, ebx, ecx, edx;
>  	u8 *temp;
> +	unsigned long flags;
> =20
>  	cpuid(6, &eax, &ebx, &ecx, &edx);
>  	thres_count =3D ebx & 0x07;
> @@ -420,19 +422,19 @@ static int pkg_temp_thermal_device_add(unsigned i=
nt cpu)
>  		goto err_ret_unlock;
>  	}
> =20
> -	spin_lock(&pkg_work_lock);
> +	spin_lock_irqsave(&pkg_work_lock, flags);
>  	if (topology_physical_package_id(cpu) > max_phy_id)
>  		max_phy_id =3D topology_physical_package_id(cpu);
>  	temp =3D krealloc(pkg_work_scheduled,
>  			(max_phy_id+1) * sizeof(u8), GFP_ATOMIC);
>  	if (!temp) {
> -		spin_unlock(&pkg_work_lock);
> +		spin_unlock_irqrestore(&pkg_work_lock, flags);
>  		err =3D -ENOMEM;
>  		goto err_ret_free;
>  	}
>  	pkg_work_scheduled =3D temp;
>  	pkg_work_scheduled[topology_physical_package_id(cpu)] =3D 0;
> -	spin_unlock(&pkg_work_lock);
> +	spin_unlock_irqrestore(&pkg_work_lock, flags);
> =20
>  	phy_dev_entry->phys_proc_id =3D topology_physical_package_id(cpu);
>  	phy_dev_entry->first_cpu =3D cpu;
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--3gjXMEuNxMTeXI6EvtnLjHFvx2t6qccV3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlJByy8ACgkQCXcVR3XQvP2XhQD/WkYWx2JQivZo2WihU8PcxTba
eUKMmE6vXInCNEdLDH8BAJzYpjrcn2e2e7fOBgoKoDx1ppd/e2CHi+NSSQC+diWv
=l++d
-----END PGP SIGNATURE-----

--3gjXMEuNxMTeXI6EvtnLjHFvx2t6qccV3--
