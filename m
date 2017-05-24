From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 2/2] trace: power allocator: add trace for divvyup
 algorithm
Date: Tue, 23 May 2017 21:04:46 -0700
Message-ID: <20170524040445.GB3501@localhost.localdomain>
References: <1494575248-4166-1-git-send-email-lukasz.luba@arm.com>
 <1494575248-4166-3-git-send-email-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36404 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761509AbdEXEEv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 May 2017 00:04:51 -0400
Received: by mail-pg0-f67.google.com with SMTP id h64so15550373pge.3
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2017 21:04:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1494575248-4166-3-git-send-email-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, javi.merino@kernel.org, rui.zhang@intel.com, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, May 12, 2017 at 08:47:28AM +0100, Lukasz Luba wrote:
> This trace function helps to figure out the divvyup algorithm
> on some platforms.
>=20
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Zhang Rui <rui.zhang@intel.com>
> CC: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/power_allocator.c              |  4 +++
>  include/trace/events/thermal_power_allocator.h | 40 ++++++++++++++++++++=
++++++
>  2 files changed, 44 insertions(+)
>=20
> diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_al=
locator.c
> index f9e3d3c..1929e9c 100644
> --- a/drivers/thermal/power_allocator.c
> +++ b/drivers/thermal/power_allocator.c
> @@ -331,6 +331,10 @@ static void siblings_grants(struct thermal_zone_devi=
ce *tz,
>  		total_avail_room +=3D avail_room[i];
>  	}
> =20
> +	trace_thermal_power_allocator_divvyup(tz, granted_power, avail_room,
> +					      spare_power, max_power,
> +					      num_actors);

Shouldnt we have a way to trace where the power is going to be divided
to? Meaning, to which categories/groups?

> +
>  	/* Share the extra power inside the same family. */
>  	for (i =3D 0; i < num_actors; i++) {
>  		u64 power;
> diff --git a/include/trace/events/thermal_power_allocator.h b/include/tra=
ce/events/thermal_power_allocator.h
> index 5afae8f..03f224b 100644
> --- a/include/trace/events/thermal_power_allocator.h
> +++ b/include/trace/events/thermal_power_allocator.h
> @@ -54,6 +54,46 @@
>  		__entry->delta_temp)
>  );
> =20
> +TRACE_EVENT(thermal_power_allocator_divvyup,
> +	TP_PROTO(struct thermal_zone_device *tz, u32 *granted_power,
> +		u32 *avail_room, u32 *spare_power, u32 *max_power,
> +		size_t num_actors),
> +	TP_ARGS(tz, granted_power, avail_room, spare_power, max_power,
> +		num_actors),
> +	TP_STRUCT__entry(
> +		__field(int, tz_id)
> +		__dynamic_array(u32, granted_power, num_actors)
> +		__dynamic_array(u32, avail_room, num_actors)
> +		__dynamic_array(u32, spare_power, num_actors)
> +		__dynamic_array(u32, max_power, num_actors)
> +		__field(size_t, num_actors)
> +	),
> +	TP_fast_assign(
> +		__entry->tz_id =3D tz->id;
> +		memcpy(__get_dynamic_array(granted_power), granted_power,
> +			num_actors * sizeof(*granted_power));
> +		memcpy(__get_dynamic_array(avail_room), avail_room,
> +			num_actors * sizeof(*avail_room));
> +		memcpy(__get_dynamic_array(spare_power), spare_power,
> +			num_actors * sizeof(*spare_power));
> +		memcpy(__get_dynamic_array(max_power), max_power,
> +			num_actors * sizeof(*max_power));
> +		__entry->num_actors =3D num_actors;
> +	),
> +
> +	TP_printk("thermal_zone_id=3D%d granted_power=3D{%s} avail_room=3D{%s} =
spare_power=3D{%s} max_power=3D{%s}",
> +		__entry->tz_id,
> +		__print_array(__get_dynamic_array(granted_power),
> +			      __entry->num_actors, 4),
> +		__print_array(__get_dynamic_array(avail_room),
> +			      __entry->num_actors, 4),
> +		__print_array(__get_dynamic_array(spare_power),
> +			      __entry->num_actors, 4),
> +		__print_array(__get_dynamic_array(max_power),
> +			      __entry->num_actors, 4)
> +		)
> +);
> +
>  TRACE_EVENT(thermal_power_allocator_pid,
>  	TP_PROTO(struct thermal_zone_device *tz, s32 err, s32 err_integral,
>  		 s64 p, s64 i, s64 d, s32 output),
> --=20
> 1.9.1
>=20

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJQZXAAoJEA6VkvSQfF5T9L0P/12B0UZBfhfx8BqusR/F39UY
TS1R0YjJWaKdAkV2SWrHYP7LQBST4oK3nSqaxPd6+YxFuTiAKtlZ63A2GnDqIn+D
kJmFPC4Ho5mT1jIVUITdFY35h7W8CjzpnWyrtjvhdOoezQQFmNKqcPXpSKjv3NCD
gu/hwOgPi6nWdzCLpGgf65R/Bbl+oqqunD5ZUdVuBrZtXGKn0IKM5AKtGWwft5Ev
E+cwjvozEZLvh4VJvs3zsDkNczCI6ekeBpVMccyjcAMGIi6pSKu5j7kfJwJMzPIY
hRMcZ2+21upOxWfjnm8IrFOpRY1oqAG2n7mMD3nWahUv+ui20UqjI3/TN97wUr4E
+ZBkYnQwslO1JI9xiDQMxGZCE1SuLFKstdPyd8XDhROctm8HK5c39XO5iXwK7NPJ
3A28w8XwK4FlruN2zbtDt8w7zLHrVoDsNERCLeYCnaewBQp0qX9MW+ihxw80s8kr
ehVduMKBcfUphTul5AT6owQ0SybESF+O5i+j4frZLwIOXQBZoR8E7teksmRf4BYJ
Vr3TPeZRsW1UwS6LvGYVgoul8GiP3zYOzZ3srVvbYB5g2kXjqR0QAsgRVFmpF+qe
i5vXV+xDOa70vgG+osyycPO5RXk8adoHkzp2g7ojKpZB0btbU12iHiXSeKTOfWE4
nuCjtzdfySyovyjAycDZ
=JMWO
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
