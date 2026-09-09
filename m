Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FC733E36A;
	Wed,  9 Sep 2026 19:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983554; cv=pass; b=hSmZC/h5SuZzP+ODBCv2UwUqKCi+ttasgpnqOFGk4a24yzczc4+Zrboiw0dWOHEJXFoDT1n8AxpHMMYGMg8lHzx7WpzQ38aRaKe+JeUFwbRRxbvW3C0By+H6poWn2m7iMVo8bHApMsXnppFpNwvJhdBJUlKTSbyVwXOlARmp8jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983554; c=relaxed/simple;
	bh=BxxQUCpvNrGeJxUkQ/8vF3B5BnzaH1VPpOUrGbpIGA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPKamLC4nu34S0/Spk4HIC3VB/eYodASNlh5fDJ3iaJoA/ofIEC5n/BRMoW+bhka/oJ1mvzGJF23Q9WYbZBSEA1yJRFprZqZtLoEcBv+fT0DTQPL5WwFgF6gQ1YziqIDu5chxYEcZY1cFnZUIegZPgkPagSy8eMkN9wLMg/xwg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=OJJ03vCI; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="OJJ03vCI"
ARC-Seal: i=1; a=rsa-sha256; t=1788983536; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AcEd6OOi7JpokylyGFUNQom6tLyDx/vexs9GSPQvhW5KvcffjTg0Exmc0+5ErfgmyzA2wgxEEM6GKgbE5kIKYjqQO2D77N/8TWik3V/aUZ7Ak8IcqwV4dq6IrmN+pTVVfZu6kpb4P13t1SEhLsOskKnC/+aRCnzFWlwPU0Fbwl0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788983536; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OrZz/o2h9z3RoezewYad1fMoe+vz61yO6dJjys7PAtc=; 
	b=iFEifQjx12JG7dI4nfWUc1fXxFkk6peUtI1enTrb3CbjD1oTGOMwWJpH9CFTG0Dk8cShT8WEZt9qbHYEsLLao315XL3Qlo8jt5nABKMP5/IjU1eUDZb4ii8GLZapmLxYZMBLdyyfKfk2d1kMsmT2g+KebpmVha55SY7YXvcksE8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788983536;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=OrZz/o2h9z3RoezewYad1fMoe+vz61yO6dJjys7PAtc=;
	b=OJJ03vCIXmAxd40t4dbidm0qqWaOiakstiXz0eoqxAUeO6qzjs+TEfFzUUFC2u5Y
	0kgDaQVGmMQAg/gCYodt5nZuBKhkVTWEczA65PVL+POqGQygvsCgcq4+afoTI9YJHYC
	8I0xs3OvQagH/webm54JzXvQ/xLUNS6PzYclTJLg=
Received: by mx.zohomail.com with SMTPS id 1788983535510492.3314755419225;
	Wed, 9 Sep 2026 12:52:15 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 57D29183377; Wed, 09 Sep 2026 21:52:11 +0200 (CEST)
Date: Wed, 9 Sep 2026 21:52:11 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Lee Jones <lee@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] power: supply: core: Allow getting battery info
 before psy is registered
Message-ID: <aqG3p_GKtncRCRI8@venus>
References: <20260909-bq257xx-init-v2-0-deb4076b1f02@flipper.net>
 <20260909-bq257xx-init-v2-2-deb4076b1f02@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xb76igt5xxhlnlu2"
Content-Disposition: inline
In-Reply-To: <20260909-bq257xx-init-v2-2-deb4076b1f02@flipper.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.959.6
X-ZohoMailClient: External


--xb76igt5xxhlnlu2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/4] power: supply: core: Allow getting battery info
 before psy is registered
MIME-Version: 1.0

Hello Alexey,

On Wed, Sep 09, 2026 at 07:41:45PM +0400, Alexey Charkov wrote:
> Some power supplies, such as battery chargers, may need to program the
> device parameters based on what their connected battery allows. Current
> API requires registering the power supply to access battery information,
> which is problematic because a registered power supply is immediately
> available to the rest of the system, but the battery parameters may not
> be set yet in the charger.
>=20
> Given that the battery info helpers really only need a fwnode and a struct
> device to hang devres-allocated resourses on, add a pure dev-based get/put
> API alongside the existing psy-based one, which can be used to query the
> battery information before registering the power supply.

Use the new init callback for that, which got introduced in the v7.3
cycle:

c1eb5905fdce ("power: supply: Add registration init callback")

See for example fdece8642eca ("power: supply: bq25630: Initialize
hardware before exposing the power supply") for a driver that was
converted to this.

Greetings,

-- Sebastian

>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  drivers/power/supply/power_supply_core.c | 102 ++++++++++++++++++++++---=
------
>  include/linux/power_supply.h             |   4 ++
>  2 files changed, 77 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 1279785645fb..09473361772f 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -725,21 +725,18 @@ struct power_supply *devm_power_supply_get_by_refer=
ence(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_power_supply_get_by_reference);
> =20
> -int power_supply_get_battery_info(struct power_supply *psy,
> -				  struct power_supply_battery_info **info_out)
> +static int __power_supply_get_battery_info(struct device *dev,
> +					   struct fwnode_handle *srcnode,
> +					   struct power_supply_battery_info **info_out)
>  {
>  	struct power_supply_resistance_temp_table *resist_table;
>  	struct power_supply_battery_info *info;
> -	struct fwnode_handle *srcnode, *fwnode;
> +	struct fwnode_handle *fwnode;
>  	const char *value;
>  	int err, len, index, proplen;
>  	u32 *propdata __free(kfree) =3D NULL;
>  	u32 min_max[2];
> =20
> -	srcnode =3D dev_fwnode(&psy->dev);
> -	if (!srcnode && psy->dev.parent)
> -		srcnode =3D dev_fwnode(psy->dev.parent);
> -
>  	fwnode =3D fwnode_find_reference(srcnode, "monitored-battery", 0);
>  	if (IS_ERR(fwnode))
>  		return PTR_ERR(fwnode);
> @@ -750,7 +747,7 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
> =20
> =20
>  	/* Try static batteries first */
> -	err =3D samsung_sdi_battery_get_info(&psy->dev, value, &info);
> +	err =3D samsung_sdi_battery_get_info(dev, value, &info);
>  	if (!err)
>  		goto out_ret_pointer;
>  	else if (err =3D=3D -ENODEV)
> @@ -765,7 +762,7 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  		goto out_put_node;
>  	}
> =20
> -	info =3D devm_kzalloc(&psy->dev, sizeof(*info), GFP_KERNEL);
> +	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>  	if (!info) {
>  		err =3D -ENOMEM;
>  		goto out_put_node;
> @@ -826,7 +823,7 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  		else if (!strcmp("lithium-ion-manganese-oxide", value))
>  			info->technology =3D POWER_SUPPLY_TECHNOLOGY_LiMn;
>  		else
> -			dev_warn(&psy->dev, "%s unknown battery type\n", value);
> +			dev_warn(dev, "%s unknown battery type\n", value);
>  	}
> =20
>  	fwnode_property_read_u32(fwnode, "energy-full-design-microwatt-hours",
> @@ -877,7 +874,7 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  		err =3D len;
>  		goto out_put_node;
>  	} else if (len > POWER_SUPPLY_OCV_TEMP_MAX) {
> -		dev_err(&psy->dev, "Too many temperature values\n");
> +		dev_err(dev, "Too many temperature values\n");
>  		err =3D -EINVAL;
>  		goto out_put_node;
>  	} else if (len > 0) {
> @@ -892,28 +889,28 @@ int power_supply_get_battery_info(struct power_supp=
ly *psy,
>  		char *propname __free(kfree) =3D kasprintf(GFP_KERNEL, "ocv-capacity-t=
able-%d",
>  							 index);
>  		if (!propname) {
> -			power_supply_put_battery_info(psy, info);
> +			power_supply_put_battery_info_from_dev(dev, info);
>  			err =3D -ENOMEM;
>  			goto out_put_node;
>  		}
>  		proplen =3D fwnode_property_count_u32(fwnode, propname);
>  		if (proplen < 0 || proplen % 2 !=3D 0) {
> -			dev_err(&psy->dev, "failed to get %s\n", propname);
> -			power_supply_put_battery_info(psy, info);
> +			dev_err(dev, "failed to get %s\n", propname);
> +			power_supply_put_battery_info_from_dev(dev, info);
>  			err =3D -EINVAL;
>  			goto out_put_node;
>  		}
> =20
>  		u32 *propdata __free(kfree) =3D kzalloc_objs(*propdata, proplen);
>  		if (!propdata) {
> -			power_supply_put_battery_info(psy, info);
> +			power_supply_put_battery_info_from_dev(dev, info);
>  			err =3D -EINVAL;
>  			goto out_put_node;
>  		}
>  		err =3D fwnode_property_read_u32_array(fwnode, propname, propdata, pro=
plen);
>  		if (err < 0) {
> -			dev_err(&psy->dev, "failed to get %s\n", propname);
> -			power_supply_put_battery_info(psy, info);
> +			dev_err(dev, "failed to get %s\n", propname);
> +			power_supply_put_battery_info_from_dev(dev, info);
>  			goto out_put_node;
>  		}
> =20
> @@ -921,9 +918,9 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  		info->ocv_table_size[index] =3D tab_len;
> =20
>  		info->ocv_table[index] =3D table =3D
> -			devm_kcalloc(&psy->dev, tab_len, sizeof(*table), GFP_KERNEL);
> +			devm_kcalloc(dev, tab_len, sizeof(*table), GFP_KERNEL);
>  		if (!info->ocv_table[index]) {
> -			power_supply_put_battery_info(psy, info);
> +			power_supply_put_battery_info_from_dev(dev, info);
>  			err =3D -ENOMEM;
>  			goto out_put_node;
>  		}
> @@ -939,14 +936,14 @@ int power_supply_get_battery_info(struct power_supp=
ly *psy,
>  		err =3D 0;
>  		goto out_ret_pointer;
>  	} else if (proplen < 0 || proplen % 2 !=3D 0) {
> -		power_supply_put_battery_info(psy, info);
> +		power_supply_put_battery_info_from_dev(dev, info);
>  		err =3D (proplen < 0) ? proplen : -EINVAL;
>  		goto out_put_node;
>  	}
> =20
>  	propdata =3D kzalloc_objs(*propdata, proplen);
>  	if (!propdata) {
> -		power_supply_put_battery_info(psy, info);
> +		power_supply_put_battery_info_from_dev(dev, info);
>  		err =3D -ENOMEM;
>  		goto out_put_node;
>  	}
> @@ -954,17 +951,17 @@ int power_supply_get_battery_info(struct power_supp=
ly *psy,
>  	err =3D fwnode_property_read_u32_array(fwnode, "resistance-temp-table",
>  					     propdata, proplen);
>  	if (err < 0) {
> -		power_supply_put_battery_info(psy, info);
> +		power_supply_put_battery_info_from_dev(dev, info);
>  		goto out_put_node;
>  	}
> =20
>  	info->resist_table_size =3D proplen / 2;
> -	info->resist_table =3D resist_table =3D devm_kcalloc(&psy->dev,
> +	info->resist_table =3D resist_table =3D devm_kcalloc(dev,
>  							 info->resist_table_size,
>  							 sizeof(*resist_table),
>  							 GFP_KERNEL);
>  	if (!info->resist_table) {
> -		power_supply_put_battery_info(psy, info);
> +		power_supply_put_battery_info_from_dev(dev, info);
>  		err =3D -ENOMEM;
>  		goto out_put_node;
>  	}
> @@ -982,22 +979,69 @@ int power_supply_get_battery_info(struct power_supp=
ly *psy,
>  	fwnode_handle_put(fwnode);
>  	return err;
>  }
> +
> +int power_supply_get_battery_info(struct power_supply *psy,
> +				  struct power_supply_battery_info **info_out)
> +{
> +	struct fwnode_handle *srcnode;
> +
> +	srcnode =3D dev_fwnode(&psy->dev);
> +	if (!srcnode && psy->dev.parent)
> +		srcnode =3D dev_fwnode(psy->dev.parent);
> +
> +	return __power_supply_get_battery_info(&psy->dev, srcnode, info_out);
> +}
>  EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
> =20
> -void power_supply_put_battery_info(struct power_supply *psy,
> -				   struct power_supply_battery_info *info)
> +/**
> + * power_supply_get_battery_info_from_dev() - Get battery info without a=
 supply
> + * @dev: Device holding the "monitored-battery" reference, which also ow=
ns the
> + *	 devres allocations made for the returned info
> + * @info_out: Pointer to store the resulting battery info
> + *
> + * Same as power_supply_get_battery_info(), but keyed off a plain device=
 rather
> + * than a registered power supply. Chargers that program hardware limits=
 taken
> + * from the battery node need those values *before* they can safely regi=
ster
> + * their power supply: registering makes the supply callable, so a later=
 probe
> + * failure would free driver data underneath a running callback.
> + *
> + * Release the result with power_supply_put_battery_info_from_dev().
> + *
> + * Return: 0 on success or an error code on failure.
> + */
> +int power_supply_get_battery_info_from_dev(struct device *dev,
> +					   struct power_supply_battery_info **info_out)
> +{
> +	return __power_supply_get_battery_info(dev, dev_fwnode(dev), info_out);
> +}
> +EXPORT_SYMBOL_GPL(power_supply_get_battery_info_from_dev);
> +
> +/**
> + * power_supply_put_battery_info_from_dev() - Release battery info
> + * @dev: Device passed to power_supply_get_battery_info_from_dev()
> + * @info: Battery info to release
> + */
> +void power_supply_put_battery_info_from_dev(struct device *dev,
> +					    struct power_supply_battery_info *info)
>  {
>  	int i;
> =20
>  	for (i =3D 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++) {
>  		if (info->ocv_table[i])
> -			devm_kfree(&psy->dev, info->ocv_table[i]);
> +			devm_kfree(dev, info->ocv_table[i]);
>  	}
> =20
>  	if (info->resist_table)
> -		devm_kfree(&psy->dev, info->resist_table);
> +		devm_kfree(dev, info->resist_table);
> +
> +	devm_kfree(dev, info);
> +}
> +EXPORT_SYMBOL_GPL(power_supply_put_battery_info_from_dev);
> =20
> -	devm_kfree(&psy->dev, info);
> +void power_supply_put_battery_info(struct power_supply *psy,
> +				   struct power_supply_battery_info *info)
> +{
> +	power_supply_put_battery_info_from_dev(&psy->dev, info);
>  }
>  EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
> =20
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 131cafded72f..f42ae4e3bf81 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -865,6 +865,10 @@ extern int power_supply_get_battery_info(struct powe=
r_supply *psy,
>  					 struct power_supply_battery_info **info_out);
>  extern void power_supply_put_battery_info(struct power_supply *psy,
>  					  struct power_supply_battery_info *info);
> +extern int power_supply_get_battery_info_from_dev(struct device *dev,
> +						  struct power_supply_battery_info **info_out);
> +extern void power_supply_put_battery_info_from_dev(struct device *dev,
> +						   struct power_supply_battery_info *info);
>  extern bool power_supply_battery_info_has_prop(struct power_supply_batte=
ry_info *info,
>  					       enum power_supply_property psp);
>  extern int power_supply_battery_info_get_prop(struct power_supply_batter=
y_info *info,
>=20
> --=20
> 2.55.0
>=20

--xb76igt5xxhlnlu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmqhuOcACgkQ2O7X88g7
+po/CA//YKaJPv5gHs2J0+fC5nttPNSwBJbsrz8qnwsWi6XT2pp1E6ec0JsKvqff
5j7YQo3eHXb9JazcO9JXXfdw6nyu1vvqM1fQJqBJAoLWdJrGWviANDbH9aczQ5xr
fhsMVWKsj85qkhuKtt6gTIuO774ZiWvpsXJ/88UEPuh/TlptGGUWAKfouSMijcE8
VyKERMYbUiYH/SuvZTpm9e9eTx2/mbO6KWVQseTrkAOKFurdGbRazGgOEkzT0U88
qJilcrfgoGHMj4D5D/tIL2zcGXohHBV9cIw3ZDyTRhxFy62wHWtUCwWS7HBbb4IH
mS3rVC0VQ54LS1o0TNZfvuUAY56fNKb8SMP+Gz13ex3KMZ/+z9xrithoHrcBPTAO
lGWq9+vDNxXpLAdypmYmZANkGX5c26d7kfhd07/wZ2QM0C0srahpiJb3KGQehOaP
5aWnGpNHLbB4RpajenPi7lJjLHmICvpkAXuSrExKep6jyjuAK8l38iHCnrrTv+uq
LTcYiDlamrLJf7YPQMDgDbt2dH+ly5mOJYDqrYMDHUT8fTHPwXEWVQSSPFdvJskn
z+PuokjMHLNocqDxTA6WCeKdnv9gpG48EKd7GxB6TPS/isvNmA+hZ4UgdazFgJBD
aXRbbibwz/0JPkkT3yToVSMxt7RqUMdgiFP+r7u4BR8MP5OLrU4=
=r6V7
-----END PGP SIGNATURE-----

--xb76igt5xxhlnlu2--
