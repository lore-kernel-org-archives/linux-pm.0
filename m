Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A11220698;
	Wed, 12 Aug 2026 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572041; cv=none; b=u0sK4L2DiP4a4pbPXwrB3wM75zbLpslkPewR/xHCyPv/oSTc1UcmDOwuqewFfi/Q9B6D8U+aInqZ6z19BDBa9W5Wmmes0Sydg7FmvjT3yOUFTcP7mOO4W0XkfuZcrGJ0t9phpvJ6VF/EYFsD9/MyOv03MftjV+uGw7kGPdFnTRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572041; c=relaxed/simple;
	bh=LnbJ+JeCswXplJXMAQXK07KvINJS1qVW4aAcrmdWAjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHZFOJ3YOzlC+nqIwj6ahhPyD2JOU8xsdktLYWKPnxT7VsA0ltk4MNQice+UzbEm0YL4R2BVSj1O8MjbMoNWpGvo4us/Yhl+ZEGf2UXUlUc/2RZhvbKZfHlA1ba20bFSdmAZlCKkaeHD4dinsyJKuccq+foDoRDvI9lJXSsmJok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUnSbkEV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUnSbkEV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E4B1F00A3D;
	Wed, 12 Aug 2026 22:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786572040;
	bh=/fxcypdfsHQxGrlHyL5T6WH+ue/KrXluoAPpP4CF32o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FUnSbkEVI62Ee+i8OCT2F2DroYYvx3oGuMpeBbXpjlD2j0gs/BJXptvxMXLbZojtk
	 /nOEqkBNsXAAd2OmV81vHLOxdr+RPbSFORuM8FkOlKLhy37V5KKktNa5FVQ9Y03BN8
	 46wvjHFe9lIRHIf2vKlTaH0YzasPpPRweoQwUskmg6nuUFoTFtrfmpxaUAQXJiSf6L
	 L6hAHwkaJSFfUuj97bQkA0YHwpnK4A3/mXUiYLNWx7F2tm9R5icJazF1w07p2ZZqTx
	 tLUWSkOmjdABN7IgflLeClxy1Gw8tE+XVvNgeS0tGsISOO+H15JRR5pA/qoRMPXI6A
	 2amdIDa03iHNQ==
Received: by venus (Postfix, from userid 1000)
	id B68441830B0; Thu, 13 Aug 2026 00:00:37 +0200 (CEST)
Date: Thu, 13 Aug 2026 00:00:37 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Ivy Lopez <skunkolee@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: ds2760_battery: fix NULL pointer
 dereference in w1_ds2760_remove_slave()
Message-ID: <anznUnfc6JODjnVc@venus>
References: <20260808214458.201324-1-skunkolee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b7aughngvmr5cvlw"
Content-Disposition: inline
In-Reply-To: <20260808214458.201324-1-skunkolee@gmail.com>


--b7aughngvmr5cvlw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: ds2760_battery: fix NULL pointer
 dereference in w1_ds2760_remove_slave()
MIME-Version: 1.0

Hi,

On Sat, Aug 08, 2026 at 03:44:58PM -0600, Ivy Lopez wrote:
> w1_ds2760_add_slave()'s failure paths (di_alloc_failed, batt_failed,
> workqueue_failed) are all empty labels that just return the error
> code, with no explicit unwind. This works for di itself and the
> registered power supply, both are devm-managed against the w1 slave
> device and get cleaned up automatically. But di->monitor_wqueue and
> di->pm_notifier are not devm-managed, and are only ever set up in
> the success tail of the function, after the workqueue allocation and
> power supply registration have both succeeded.
>=20
> The w1 core's BUS_NOTIFY_ADD_DEVICE handling in w1_family_notify()
> logs and returns on a failing add_slave(), but does not prevent the
> w1 slave device from later being removed from the bus, which
> triggers BUS_NOTIFY_DEL_DEVICE and an unconditional call to
> remove_slave(). This means w1_ds2760_remove_slave() is effectively
> the only failure-unwind path for a partially initialized di, and
> needs to treat every field as potentially never having been set.
>=20
> Currently it does not: it unconditionally calls
> destroy_workqueue(di->monitor_wqueue), which crashes with a NULL
> pointer dereference if add_slave() failed before or during the
> workqueue allocation (e.g. on a power_supply_register() failure, as
> seen when a colliding sysfs name from a misdetected slave device
> causes registration to fail).
>=20
> sl->family_data can also be NULL if add_slave() failed at its own
> allocation, before family_data was ever set, which would crash on
> the very first dereference in remove_slave().
>=20
> Fix both: return early if di is NULL, and only call
> destroy_workqueue() if monitor_wqueue was actually allocated.
> unregister_pm_notifier() and cancel_delayed_work_sync() are safe to
> call unconditionally: the former is a no-op if the notifier was
> never registered, and the latter operates on the embedded
> delayed_work struct, which is always validly initialized by the
> time remove_slave() can run with a non-NULL di.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217832
> Signed-off-by: Ivy Lopez <skunkolee@gmail.com>

This should get a Fixes tag.

> ---
>  drivers/power/supply/ds2760_battery.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply=
/ds2760_battery.c
> index 142c7492c3c2..3c2433f6b5e9 100644
> --- a/drivers/power/supply/ds2760_battery.c
> +++ b/drivers/power/supply/ds2760_battery.c
> @@ -723,9 +723,13 @@ static void w1_ds2760_remove_slave(struct w1_slave *=
sl)
>  {
>  	struct ds2760_device_info *di =3D sl->family_data;
> =20
> +	if (!di)
> +		return;
> +
>  	unregister_pm_notifier(&di->pm_notifier);
>  	cancel_delayed_work_sync(&di->monitor_work);
> -	destroy_workqueue(di->monitor_wqueue);
> +	if (di->monitor_wqueue)
> +		destroy_workqueue(di->monitor_wqueue);

Considering the driver has mostly been converted to device managed
resources already, I think it makes sense to simply use
devm_alloc_ordered_workqueue() in the probe function and thus avoid
this problem. Also while at it switch INIT_DELAYED_WORK to
devm_delayed_work_autocancel() to get rid of
w1_ds2760_remove_slave(). Just make sure to do this *after*
allocating the workqueue.

Last but not least use devm_add_action_or_reset() for the
unregister_pm_notifier and simply drop the complete
w1_ds2760_remove_slave() function.

Greetings,

-- Sebastian

--b7aughngvmr5cvlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmp87QIACgkQ2O7X88g7
+po4ZQ/+JrT+aJQZAGyNOXIOm490f7clxMKbAIT7xkzKuKZU5UKeVZMEtIJ2a1qO
tzEWrhpV+ISMIxTJnblwbFzAKLaZdL8TDWSbu5y/EObfa06OPzcHebOEALa0X6KZ
KYslZBj1FHaN90NhNbt25rFIA4vurFA3jz/53RGjvCAZh9vuXmWJGnIgN9/mGYPr
P0gnOhh38PKXKk9RhcK74u0+oaIaVMbWBZ2cTtzEk4iuV6ipQ1G5U3cYd8hj4iO0
IGmkzWQeA2KTwdFTrpEHlAuNjP9ROdVoLiQO6XAEgU2PEScKl+ROCg9o/TvGSPQl
1bmFBsuuDW10zrIIlB6FS4NkDrZ2mLiXRhgigFpeXdH8ES4hADRO2/TmmiXOMC3D
lHmJ5mD4CgLn4PyKrh8mT99yxrY1Ycb9WX8YYNKllLqWEpU1HHlAwFh/8xC4manh
Upu1WHgfYgvFv9yBhoxShGuHKj1qK2qu7yX1EUZlJzDKxPgWlK8fCctPlMkG8gjY
MIE8L5y8YC9AXXhCzDRrX0smpxkxLOPMu9HbcGZB68LSKpg4V2PDlK/yph/Cjgbi
+lPTUn4EBMGC0MnV5VIz9nwS3X/CuLELOHUXWFt/reg0iNF6D4dwOds68kSM8uhL
c4RG2AWgs/LMmBTSCBYAo3AUOCWVTiI4gTQTIHVzIpMVyN8GPAM=
=BIJh
-----END PGP SIGNATURE-----

--b7aughngvmr5cvlw--
