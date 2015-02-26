From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 0/7] The power allocator thermal governor
Date: Thu, 26 Feb 2015 18:16:09 -0400
Message-ID: <20150226221606.GB5564@developer.amazonguestwifi.org>
References: <1424977233-15965-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:38396 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbbB0T4Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Feb 2015 14:56:16 -0500
Content-Disposition: inline
In-Reply-To: <1424977233-15965-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, broonie@kernel.org, tixy@linaro.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2015 at 07:00:26PM +0000, Javi Merino wrote:
> Hi linux-pm,
>=20
> The power allocator governor allocates device power to control
> temperature.  This requires transforming performance requests into
> requested power, which we do with an extended cooling device API
> introduced in patch 2 (thermal: extend the cooling device API to
> include power information).  Patch 3 (thermal: cpu_cooling: implement
> the power cooling device API) extends the cpu cooling device using a
> simple power model.
>=20
> This series are based on branch "linus" of Eduardo's linux-soc-thermal
> tree:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.=
git
>=20
> Changes since v1:
>   - Removed a memory leak pointed out by Steve Rostedt
>   - Relax the constraint of the trip points to be the first and last
>     passive trip point as Lina Iyer suggested.
>   - Update how the governor treats weights to mimic the behavior of
>     fair share in v3 of the weight fixes series.
>   - Don't cache the cpufreq_cooling_device and scan for it whenever
>     we need it.
>   - Consider the rate of changes in the derivative term of the PID
>     controller
>=20
> Changes since RFC v6:
>   - Addressed Eduardo's review
>     + Pass the interval to the static power function as suggested by
>       Eduardo
>     + Make the cooling device ops return 0 or -E* and put the
>       calculation in a parameter, like the rest of the cooling device
>       ops
>     + Documentation improvements
>   - Use thermal_cdev_update() to change cooling device states
>   - Add a patch to export the power allocator governor's tzp
>     parameters to sysfs
>=20
> Changes since RFC v5:
>   - Addressed Stephen's review of the trace patches.
>   - Removed power actors and extended the cooling device interface
>     instead.
>   - Let platforms override the power allocator governor parameters in
>     their thermal zone parameters
>=20
> Changes since RFC v4:
>   - Add more tracing
>   - Document some of the limitations of the power allocator governor
>   - Export the power_actor API and move power_actor.h to include/linux
>=20
> Changes since RFC v3:
>   - Use tz->passive to poll faster when the first trip point is hit.
>   - Don't make a special directory for power_actors
>   - Add a DT property for sustainable-power
>   - Simplify the static power interface and pass the current thermal
>     zone in every power_actor_ops to remove the controversial
>     enum power_actor_types
>   - Use locks with the actor_list list
>   - Use cpufreq_get() to get the frequency of the cpu instead of
>     using the notifiers.
>   - Remove the prompt for THERMAL_POWER_ACTOR_CPU when configuring
>     the kernel
>=20
> Changes since RFC v2:
>   - Changed the PI controller into a PID controller
>   - Added static power to the cpu power model
>   - tz parameter max_dissipatable_power renamed to sustainable_power
>   - Register the cpufreq cooling device as part of the
>     power_cpu_actor registration.
>=20
> Changes since RFC v1:
>   - Fixed finding cpufreq cooling devices in cpufreq_frequency_change()
>   - Replaced the cooling device interface with a separate power actor
>     API
>   - Addressed most of Eduardo's comments
>   - Incorporated ftrace support for bitmask to trace cpumasks
>=20
> Cheers,
> Javi & Punit
>=20
> Javi Merino (6):
>   thermal: let governors have private data for each thermal zone
>   thermal: extend the cooling device API to include power information
>   thermal: cpu_cooling: implement the power cooling device API
>   thermal: introduce the Power Allocator governor
>   thermal: add trace events to the power allocator governor
>   thermal: export thermal_zone_parameters to sysfs

I am applying patches 1-3 and 6. Patches 4 and 7 need extra effort, but are
minor changes. Patch 5 depends on 4, so, cannot be applied now.

>=20
> Punit Agrawal (1):
>   of: thermal: Introduce sustainable power for a thermal zone
>=20
>  .../devicetree/bindings/thermal/thermal.txt        |   9 +
>  Documentation/thermal/cpu-cooling-api.txt          | 156 +++++-
>  Documentation/thermal/power_allocator.txt          | 247 +++++++++
>  Documentation/thermal/sysfs-api.txt                |  52 ++
>  drivers/thermal/Kconfig                            |  15 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/cpu_cooling.c                      | 610 +++++++++++++++=
+++++-
>  drivers/thermal/of-thermal.c                       |   4 +
>  drivers/thermal/power_allocator.c                  | 533 +++++++++++++++=
+++
>  drivers/thermal/thermal_core.c                     | 254 ++++++++-
>  drivers/thermal/thermal_core.h                     |   8 +
>  include/linux/cpu_cooling.h                        |  39 ++
>  include/linux/thermal.h                            |  64 ++-
>  include/trace/events/thermal.h                     |  58 ++
>  include/trace/events/thermal_power_allocator.h     |  87 +++
>  15 files changed, 2104 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/thermal/power_allocator.txt
>  create mode 100644 drivers/thermal/power_allocator.c
>  create mode 100644 include/trace/events/thermal_power_allocator.h
>=20
> --=20
> 1.9.1
>=20

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU75q9AAoJEMLUO4d9pOJWe8wH/A12wRy691kuGhZ91shCPnQu
fzpUjkOMllEgbOXNNCxD2OphJwold5Rd66i8u6jH8gmWQjLSGMXdWUNzQCdrVNTq
fHkCCkliFDjEVwwTnquKwL9yjvMWV7wcHokBGBuDqUxrf5whK/gVuDGbAjlI2CC7
GCh9c3ipizrPeQKXhqALGm+mDSHqEBJfxgfnuC+HMpVzdiWZUa/FsUdiE4/P7N33
5p/hEpVad5AN/X0y60+W0KsqH5o5E1Kbu3Tn7u/hi2DP438lhzgXgBpl1vGdYhao
Uf8w3Ovf3qdM4AjWBQ48rv2i4c2F+oess0Sw+SNzQkgypnU+tIEgBc0mZqySFBs=
=XS9k
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
