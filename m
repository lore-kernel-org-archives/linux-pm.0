From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH] Thermal: change spin lock
Date: Tue, 24 Sep 2013 13:14:15 -0400
Message-ID: <5241C867.8010503@ti.com>
References: <1379023514-14982-1-git-send-email-srinivas.pandruvada@linux.intel.com> <5241BE94.5060203@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HJ7f7RFkG6K3Q5e8iPTLDEJrhCFgS9IgF"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48895 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754293Ab3IXROb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 24 Sep 2013 13:14:31 -0400
In-Reply-To: <5241BE94.5060203@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, Eduardo Valentin <eduardo.valentin@ti.com>

--HJ7f7RFkG6K3Q5e8iPTLDEJrhCFgS9IgF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 24-09-2013 12:32, Srinivas Pandruvada wrote:
> How long it take for thermal maintainers to look at a patch and comment=
?
> Already 12 days.

Well, I dont think there is a hard deadline for this. This specific
period is still within 2 weeks time frame, which is pretty reasonable tim=
e.

Also, adding maintainers in your To: list call their attention to your
patch.

Besides, I don't think throwing such kind of comment would help to speed
the process.

>=20
> Thanks,
> Srinivas
>=20
> On 09/12/2013 03:05 PM, Srinivas Pandruvada wrote:
>> Change spin_lock to spin_lock_irqsave and spin_unlock to
>> spin_unlock_irqrestore as the data it is trying to protect can also
>> be modified in a notification call called from interrupt handler.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.co=
m>
>> ---
>>   drivers/thermal/x86_pkg_temp_thermal.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/thermal/x86_pkg_temp_thermal.c
>> b/drivers/thermal/x86_pkg_temp_thermal.c
>> index f36950e..7722cb9 100644
>> --- a/drivers/thermal/x86_pkg_temp_thermal.c
>> +++ b/drivers/thermal/x86_pkg_temp_thermal.c
>> @@ -316,18 +316,19 @@ static void
>> pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
>>       int phy_id =3D topology_physical_package_id(cpu);
>>       struct phy_dev_entry *phdev =3D pkg_temp_thermal_get_phy_entry(c=
pu);
>>       bool notify =3D false;
>> +    unsigned long flags;
>>         if (!phdev)
>>           return;
>>   -    spin_lock(&pkg_work_lock);
>> +    spin_lock_irqsave(&pkg_work_lock, flags);
>>       ++pkg_work_cnt;
>>       if (unlikely(phy_id > max_phy_id)) {
>> -        spin_unlock(&pkg_work_lock);
>> +        spin_unlock_irqrestore(&pkg_work_lock, flags);
>>           return;
>>       }
>>       pkg_work_scheduled[phy_id] =3D 0;
>> -    spin_unlock(&pkg_work_lock);
>> +    spin_unlock_irqrestore(&pkg_work_lock, flags);
>>         enable_pkg_thres_interrupt();
>>       rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
>> @@ -397,6 +398,7 @@ static int pkg_temp_thermal_device_add(unsigned
>> int cpu)
>>       int thres_count;
>>       u32 eax, ebx, ecx, edx;
>>       u8 *temp;
>> +    unsigned long flags;
>>         cpuid(6, &eax, &ebx, &ecx, &edx);
>>       thres_count =3D ebx & 0x07;
>> @@ -420,19 +422,19 @@ static int pkg_temp_thermal_device_add(unsigned
>> int cpu)
>>           goto err_ret_unlock;
>>       }
>>   -    spin_lock(&pkg_work_lock);
>> +    spin_lock_irqsave(&pkg_work_lock, flags);
>>       if (topology_physical_package_id(cpu) > max_phy_id)
>>           max_phy_id =3D topology_physical_package_id(cpu);
>>       temp =3D krealloc(pkg_work_scheduled,
>>               (max_phy_id+1) * sizeof(u8), GFP_ATOMIC);
>>       if (!temp) {
>> -        spin_unlock(&pkg_work_lock);
>> +        spin_unlock_irqrestore(&pkg_work_lock, flags);
>>           err =3D -ENOMEM;
>>           goto err_ret_free;
>>       }
>>       pkg_work_scheduled =3D temp;
>>       pkg_work_scheduled[topology_physical_package_id(cpu)] =3D 0;
>> -    spin_unlock(&pkg_work_lock);
>> +    spin_unlock_irqrestore(&pkg_work_lock, flags);
>>         phy_dev_entry->phys_proc_id =3D topology_physical_package_id(c=
pu);
>>       phy_dev_entry->first_cpu =3D cpu;
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--HJ7f7RFkG6K3Q5e8iPTLDEJrhCFgS9IgF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlJByGoACgkQCXcVR3XQvP3N9QEAiq8SQz7LTvgO8qQ6pdoSHjSj
PJYIZjy0aVx/8D7ERhgBAK85Adj37mqtdHRuQWRoTRo5X2vVUriZhTRu6NB6fRMq
=3ezc
-----END PGP SIGNATURE-----

--HJ7f7RFkG6K3Q5e8iPTLDEJrhCFgS9IgF--
