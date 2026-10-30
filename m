Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357887;
	b=Lp4uW9bi0NpiT2mtjsbz9fk8Uh7MxlDq8HK1H6B5qmCWW/UWcn9BdkpnuBZZkX7gK9cN
	 f52gn07Hsyy8O4Xz6c2Y0HIuidbUYeCRdVdNJJpYDzblSzDaAEiOwY2UR0MHuYvCohcuf
	 Tz751ztuAM2985C/qTmYNEcldfe7SHIYcZ/FWrc9GCYHfdCY+HEWhz1RHwPhz9fywvTkZ
	 m6zl0xxgfk9EU5BuOulZn3XU3jHNwnbhf1rvKFnBYHjdaC4MxbwOSx1m6hGCBZl1de/sQ
	 UUQuTKYux774whYDvWFywDqHLWjfU2kBER2HmrWq1PuT4aBwzVHlUDV1tLkyzcra4tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357887;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ZQ89vXgB1TrUWvEfIhW+c+p7R38YEkwskGy3wdZfINs=;
	b=NaF6JcXncvRY/+U5cPT/Dg2PtZUJfr72DxS6aUvKVhqTvPconW16WB3N8gW1iOBikU4D
	 dT0FA8y9Ar2CFYSm8rPrF8lpArJYe3lAbUE3bgYgP9EdWX3R/qGSJZK86ZuBFxMkpgTft
	 5YfebmNyuIX6fdDoS6PNmQLJ5BMCYqFOLFrxQVLGMNLW/4hnp5yg6/kbAFCMAvSK3hpJk
	 SE7fTuRTKQcAL9YpyH3h/cd2dv90v9V8Y3dp6gMGdBMWy0ynsmAvYcvBCbReDDKArXT+E
	 YzZV/DISD2oJjl5DrDFOEshzEqrkx7dZCd6k2dzMokwUdmmcushJ+HVPBu0rlQ1Juqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOzeonYD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7A5606B95A;
	Fri, 30 Oct 2026 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOzeonYD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCE71F000C1;
	Fri, 30 Oct 2026 10:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357887;
	bh=ZQ89vXgB1TrUWvEfIhW+c+p7R38YEkwskGy3wdZfINs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JOzeonYDU8Qzt6kJeeywRtZ5GmkGvxjGt25W1f/N/nDroDAC4opbFBaquXqR4CneM
	 se1Hu7PoIV2+vZMkiNp6DK0zVKPMIolC0IDgAT4WieFad1hfm0tDeISa8af61NpXQA
	 aARFxg59ZdGM448PxMxraPmygrDyai9XoaJx3T/r6p+75hy36l9OYxmMq++r8KXdBb
	 30RYiwrTMkns3r9IPhdnKMg/7Lfd/GFi9Be213d7An2JwyyKPmA/2pQp0uxsIPTQ0Z
	 9tq/M/SuiH7hjO4gP7ChAwT42it7SdJpaSBa5fqHd3IcdwFDMgk4jARddgO+6voSdf
	 MWwq86yYBzJuQ==
Date: Fri, 30 Oct 2026 11:58:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: christian.koever-draxl@student.uibk.ac.at
Cc: glaroque@baylibre.com, rafael@kernel.org, daniel.lezcano@kernel.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Christian Stefan =?utf-8?B?S8O2dsOpci1EcmF4bA==?= <ckoever@outlook.de>
Subject: Re: [PATCH 2/3] thermal/drivers/amlogic: add S4 support
Message-ID: <20261030-funny-ibex-of-modernism-b995fe@quoll>
References: <20261025192244.209256-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192244.209256-3-christian.koever-draxl@student.uibk.ac.at>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261025192244.209256-3-christian.koever-draxl@student.uibk.ac.at>

On Sun, Oct 25, 2026 at 08:22:43PM +0100, christian.koever-draxl@student.ui=
bk.ac.at wrote:
> From: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.de>
>=20
> The S4 CPU sensor reads its calibration through the secure monitor and
> otherwise matches the T7 setup, so reuse the T7 data for it.

So is it or is it not compatible with T7?
>=20
> Without the calibration the driver reported about -144 degrees Celsius
> on an S905W2 board; with it the readings are plausible and CPU
> throttling engages.
>=20
> Signed-off-by: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.de>
> ---
>  drivers/thermal/amlogic_thermal.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_=
thermal.c
> index 60728de6968a..c58bac633bed 100644
> --- a/drivers/thermal/amlogic_thermal.c
> +++ b/drivers/thermal/amlogic_thermal.c
> @@ -292,6 +292,10 @@ static const struct of_device_id of_amlogic_thermal_=
match[] =3D {
>  		.compatible =3D "amlogic,a1-cpu-thermal",
>  		.data =3D &amlogic_thermal_a1_cpu_param,
>  	},
> +	{
> +		.compatible =3D "amlogic,s4-cpu-thermal",
> +		.data =3D &amlogic_thermal_t7_param,
> +	},
>  	{

This clearly suggests they are compatible.

Best regards,
Krzysztof

