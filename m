Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95073C98BF;
	Mon, 20 Jul 2026 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584095; cv=none; b=KyiKw8UfiwvkzO6mjAKSqcIdW7JgwF1YOsCiF+W2obFLkQ3LLAbFNnXssCruf/HJTz0t3E7QSgG1rwd3vvtj00HcSzL+n4fvm1KhdORTBDb92817cu9Nl15LEDjyb9Z4kOS8WW5G03a4D7JGxUfDxubYUi0JedVgL5tsJpFUZf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584095; c=relaxed/simple;
	bh=2IlGTqZQpEd0dOfNli5TZqPpwK0gx01YgJUnZ3l8VII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t677lqxhKhyIw6fJHAoZGvyH34R6uNlancebNPIwH9H7CuhgFtZ8iBLhq0Psr1UV0betIpkhwS7Niw/vwHD62xy7RrQASQBt7qDNoE5XhdDMQSR9XoQ+4KAK1t9GVprkIy2teurK7ayoyd81bf1sx3lolMEpl4EfhXVmy++QZ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6aixEgX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6aixEgX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63011F000E9;
	Mon, 20 Jul 2026 21:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784584090;
	bh=J4eoFhH6gmEKwRw2WseDnQQMVN8sL8rgy37P+Poa568=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B6aixEgXkTy7qgiMoEY6afuTFN9EhfWYVdz6MtIax04oR9Aj1IooCmm8XKinZgpIg
	 sP3SYMDS/mEATNCFsKqlQSxca8GCh3hsWf6mwBPt0V7iTRWHZVknY8p7XCZCMAgkhO
	 rCO68PAq43n9yIf616oO5SOCAsPt5F6KhB/opAxIcTmZ4wk0p/7HxZTG3jejloS/Ng
	 DTovSVWQio0gC+DnevRi23nTnqP3+IiQtoYvQaUqcmdK6THX4L0riDSrgSSBKKkgcY
	 hrGBqpUdGPJ78gMCTgOEcMB7xzzt7/Rrl0wpCaJq0jAJAE5JsSjDHo/EI34cbHtJVj
	 RNUV8Lg/lZO2Q==
Received: by venus (Postfix, from userid 1000)
	id 44BC7180A25; Mon, 20 Jul 2026 23:48:09 +0200 (CEST)
Date: Mon, 20 Jul 2026 23:48:09 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Boris Shtrasman <borissh1983@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests: test possible usb type values from
 documentation
Message-ID: <al6WlrksIVUkhSHG@venus>
References: <20260625160556.54830-1-borissh1983@gmail.com>
 <20260625160556.54830-3-borissh1983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qw4ef3bnkxf6j4sb"
Content-Disposition: inline
In-Reply-To: <20260625160556.54830-3-borissh1983@gmail.com>


--qw4ef3bnkxf6j4sb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] selftests: test possible usb type values from
 documentation
MIME-Version: 1.0

Hi,

On Thu, Jun 25, 2026 at 07:05:55PM +0300, Boris Shtrasman wrote:
> modify kselftest to check for usb_types values from
> Documentation/ABI/testing/sysfs-class-power instead of only checking for
> property.
>=20
> Added the
> "Unknown", "SDP", "DCP", "CDP", "ACA", "C", "PD",
> "PD_DRP", "PD_PPS", "BrickID", "PD_SPR_AVS",
> "PD_PPS_SPR_AVS" values from the
>  /sys/class/power_supply/<supply_name>/usb_type section.
>=20
> Signed-off-by: Boris Shtrasman <borissh1983@gmail.com>
> ---
>  .../selftests/power_supply/test_power_supply_properties.sh   | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/power_supply/test_power_supply_prope=
rties.sh b/tools/testing/selftests/power_supply/test_power_supply_propertie=
s.sh
> index a66b1313ed88..7bf76af4cfd5 100755
> --- a/tools/testing/selftests/power_supply/test_power_supply_properties.sh
> +++ b/tools/testing/selftests/power_supply/test_power_supply_properties.sh
> @@ -58,7 +58,10 @@ for DEVNAME in $supplies; do
>  	# This fails on kernels < 5.8 (needs 2ad3d74e3c69f)
>  	test_uevent_prop TYPE "$SUPPLY_TYPE"
> =20
> -	test_sysfs_prop_optional usb_type
> +	test_sysfs_prop_optional_list \
> +		usb_type "Unknown","SDP","DCP","CDP","ACA","C","PD"\
> +			,"PD_DRP","PD_PPS","BrickID", "PD_SPR_AVS" \
> +			,"PD_PPS_SPR_AVS"

I've picked up the other patch, but skipped this one, because it
does not work. The usb_type property reports back differently from
what the test_sysfs_prop_optional_list function expects:

sre@venus ~ % cat /sys/class/power_supply/ucsi-source-psy-pmic_glink.ucsi.0=
1/usb_type
[C] PD PD_PPS

Greetings,

-- Sebastian

--qw4ef3bnkxf6j4sb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpel5QACgkQ2O7X88g7
+pon0RAAlgetSydT4Qwps4msPFSNF23S76lxFXe6XY3A6mo/GZYeAVqqxDXCL3qc
VRLQxLM/cbIlGfq2vPnbNcebGqggF52Ce4yxKWEMBSIvw8sZVoJe74bNkWw8CFid
OrTJVYWjfD6y3blN7UTQwglETvUhpYfJUW/PvS2SM/mkyHmK9dlv4ieBLcXWlIWa
BgZedSxDwsl7ZzwLac3cxLcKn2hyA/5kLqAtXFUNiX3zDr0y95XlSlRoLuoF2dj3
KrlQ9oZ3UyoSSSbP3+mELrYw05Ts+xTb3zE8juAKCZ95Y/t91/Oxmg2xGzmgKs3o
Jn5dyHNPTtkTXK+UBb2Vi/sHPDb1pefxy7T/sqAKF/zb7V96RLSshBHmBtQojZ+o
71z0Gec1fydayyDMXnPSJwnAgWGABFDUOklFsWZqQofaN3eW8n6RBMAgOJPBSLs5
tAmilcYS1/TVTgXXaPluHfkuAY1E8ht9NiRCNXSMhBcZEhADRtNEkP9QQEBL/lBb
FctsOz8fa20uIHA5DWxB/ZFnPQhvuh4V5XkwOCHgyTk5pmBSqwkQ7OA4Xzj2S/DV
uey+ixVAjaLuNq2b8Q6441Kuyr3gUhYtYrG3/5GqzpqdvVKWe4snOb9kR87ELqYM
lceMYlo8bTg/WtwMIJ55UFEv07No4Kgf9tNJ4EogDpWzPNx3Xfw=
=q0ET
-----END PGP SIGNATURE-----

--qw4ef3bnkxf6j4sb--
