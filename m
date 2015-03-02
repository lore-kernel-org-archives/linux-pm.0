From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 0/5] Subject: The power allocator thermal governor
Date: Mon, 2 Mar 2015 13:28:50 -0400
Message-ID: <20150302172847.GD8925@developer.hsd1.ca.comcast.net>
References: <1425316643-31991-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425316643-31991-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, lina.iyer@linaro.org, broonie@kernel.org, tixy@linaro.org
List-Id: linux-pm@vger.kernel.org


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2015 at 05:17:18PM +0000, Javi Merino wrote:
> *** BLURB HERE ***
>=20
> Hi linux-pm,
>=20
> Introduce the power allocator governor, a thermal governor that
> allocates device power to control temperature.  This series is based
> on branch "linus" of Eduardo's linux-soc-thermal tree:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.=
git
>=20
> Changes since v2:
>   - Address Eduardo's review
>     + Turn variable-size array in divvy_up_power() into a
>       devm_kcalloc() as suggested by Eduardo
>     + Remove #ifdeffery from thermal_core.c as suggested by Eduardo
>   - Bring back cpufreq's CPUFREQ_UPDATE_POLICY_CPU notifier in order
>     to update the cpu device in cpu_cooling.c when cpufreq changes
>     the policy cpu.


Can you please elaborate a bit more on the issue you saw to decide to
bring this functionality back?

Can we keep the cpufreq changes as a separated thread? To me if the
issue happens to power allocator, it also happens to the other
governors. I don't want to block power allocator due to the cpufreq
chanes.

Besides, cpufreq changes should go via the proper cpufreq tree, not the
thermal tree.

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
> Javi Merino (4):
>   thermal: introduce the Power Allocator governor
>   thermal: add trace events to the power allocator governor
>   thermal: export thermal_zone_parameters to sysfs
>   Revert "cpufreq: remove CPUFREQ_UPDATE_POLICY_CPU notifications"
>=20
> Kapileshwar Singh (1):
>   thermal: cpu_cooling: update the cpu device when cpufreq updates the
>     policy cpu
>=20
>  Documentation/thermal/power_allocator.txt      | 247 ++++++++++++
>  Documentation/thermal/sysfs-api.txt            |  52 +++
>  drivers/cpufreq/cpufreq.c                      |   3 +
>  drivers/thermal/Kconfig                        |  15 +
>  drivers/thermal/Makefile                       |   1 +
>  drivers/thermal/cpu_cooling.c                  |  34 +-
>  drivers/thermal/power_allocator.c              | 538 +++++++++++++++++++=
++++++
>  drivers/thermal/thermal_core.c                 | 110 ++++-
>  drivers/thermal/thermal_core.h                 |   8 +
>  include/linux/cpufreq.h                        |   5 +-
>  include/linux/thermal.h                        |  37 +-
>  include/trace/events/thermal.h                 |  58 +++
>  include/trace/events/thermal_power_allocator.h |  87 ++++
>  13 files changed, 1184 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/thermal/power_allocator.txt
>  create mode 100644 drivers/thermal/power_allocator.c
>  create mode 100644 include/trace/events/thermal_power_allocator.h
>=20
> --=20
> 1.9.1
>=20

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU9J3FAAoJEMLUO4d9pOJWcjEH/jp3t68779rJb5Kt5fEEJVpo
fvOUqCAmkzwonlbUVNLTkzgVjRGgZxCZBwnhxlSf7c5cBFaElTcQIPY/uIGQTDYD
uIByWBKim2zlkXjBiaqw/x0zhM1j4g5WYWd6zcMJvPtzy4U3qR+cxEe/qr/UfKOd
k77belfWn0Oc/RbXX0LStqXWGuuioZTbv+HAGJkSbH9WToXHLowi+KtyR4QjAMob
kmYBcR7PocbnQT4WmCZdW/q+2/V6VVcgZz28GNdmz0FzN6aQe+/ka3yYvT8CRIXD
yS3u/+w+b7doTpz8SOyypPbTqAfANe30hgom3w3YeJLJ0BtEGcICji+Gi+5FzAI=
=Mm7I
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
