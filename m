Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794046690;
	b=AtF6I5ImuHa3C7vZ+514gFQPtew7534QIhnsZRji2NFqWiBxsdpr0Q5PoYFzhDoD4tEO
	 PfndMoXj+zMt+xRVDzUo7Pru1YPdaIail1tFzPIZ2z9ejGaQdRR67iOMgZliKd2+gLTcX
	 ObCwH/JP/nQLNwz09SU+u858c0le663HeFQJ8rkTd2mU7FTuyGHn+sv8UhuyfkCIzwVFs
	 heY9VGc/oSpfS8JhL9yCpHSTPltFKUxBIpxUBBV/1Kuz2CRmybyHVHapeBXtZVr1jcCyQ
	 igdlXrYkCYVzk3mYarLOdqZXq64Xf+e4SYrpKlFElGdPS8BnMiTDhTEkb1oB5njLl8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LlYZSnhhBhztP5IWsnPRPqtaO1fn+3H5U4xPBBTTlKI=;
	b=O1k6Yu8a+028nmSLeByKTfNeQ6VVthOU/7IILVamDqxNVqGrlL8qzVCTxPn2C3dzHM0w
	 0z5kn0w9NWnZq9Wi/26cyM4XoyPzaT8RJR57rSKhnR153tWcvdYCzlT7ejlCOhzNjexi2
	 cZf2pkcUZ8xa8+Mtt+D/HSFFR1ePIsfFdY7AMn68HFZhLfWQk48RK7dN1qVKmZXPJ69py
	 JwEqJS9tSa2ylYm/qfOf7JqVhr9JGACgTmR1j1l9KPRbkr2AJpSmqw0IG1Svjqn3XvhIG
	 j0eMxEqpGBVDtPEIZJIwv8iqmbS6tRCrvlIHbmojsH7rDi6U1fQkv1qtz5t+9aAANNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lP7jVZlF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E43606D83B
	for <linux-pm@vger.kernel.org>; Sat,  7 Nov 2026 10:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6E43606D83B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lP7jVZlF
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso2377684eec.0
        for <linux-pm@vger.kernel.org>; Sat, 07 Nov 2026 02:18:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794046689; cv=none;
        d=google.com; s=arc-20260327;
        b=BgPA8c2gTHhmEKRL7L+S9n2LUaD5zyJEvY+df5QUM4qm6VQYnY2KcGQ3loFqjxrlxz
         9BjtWrhkhZp+3q/E4NmUDyOL41W6zBBRUm25mAAKPo2BdnB4Fdro8eiSRUFcuC314Wcy
         73PxKKXF3TzVNflo9p9sxZ944thlIQJweKnmO+o3mBgD08jiYHpHYxulkdeiuaYjqznW
         oT0kREsMAqoEZGqVKF6BU/K/F5jvK7w654DvkP0lnPURmrIKXGhzkTs6/lcAHVjp/+Jf
         GlRUG7KsAqvHnXC3iu793L6s4aBfN69FFFBfr/ZOUpHkHwVDVp9O06Do4Saz5UVV+l2G
         Ohaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LlYZSnhhBhztP5IWsnPRPqtaO1fn+3H5U4xPBBTTlKI=;
        fh=VO/9V2I+1pcDnAZxDJhucrttY+Yg0+UlD7xXYb2qvVs=;
        b=gA6rE5tdjZAcEZzaHhRnH/AtX8BEeLUfJz23V5yXQdeeOg+r4zeareFwyr+1lLU2TK
         dymqYyVH/ffiKb3jj0UYDzy3Jr4U3wGGd0KwyecAuWmeAXO/2asnCAz0AiOPRe1Pxjj7
         vTkBCeZzIuU6zbLD/Yj1V/W9c68mbdmeRLOrpXEYp0v8A88mBTKIjpBw6yoGkM7wttmH
         7vvx06EHP1cDKve9vVL+OPfHHuonmjOhMQIQCSgxGr4voP94rsbs+hm/txVSb06A4Cdt
         6n0SSqfDxLHUnOOFNdBgLW+i5PAZ1tCVyXPOe8tPobp2kEctwiv2MUUSvf++Tc9aroof
         SoCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794046689; x=1794651489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LlYZSnhhBhztP5IWsnPRPqtaO1fn+3H5U4xPBBTTlKI=;
        b=lP7jVZlFvy1fTCONhPWDyL4pzmVoRjpo0Cd87RZmlWWt6Q7QRDEuDQkoFslzqtaodt
         1RI7cSRBMHm6M1e25Wg6HMmzjbbdiCgJvEBCN4ODyKT1RR34cQTfuxMTfsvSj5tsrWfi
         weR+zF8KcKUVMUaux8r4g/yNS5S0dOdnTM0HwsT4IgS829GvcVsdfjNkq1J9aCiDAof0
         iLntN44/aK+yT3bzsqtUFByFKhH6mt/ZProSDKGMNziLedQKVy6IuOtecDmcI3rHN+Gi
         PhakD0y9GvzTlClIc+8VbgPe9Gw+fWJfCW5NVAopvJqHPKCtinthbNzdF/WnMxqdFeQV
         zYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794046689; x=1794651489;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LlYZSnhhBhztP5IWsnPRPqtaO1fn+3H5U4xPBBTTlKI=;
        b=rzx68fL9mGFu4/OV/7OdrGbjVyXUWAoVm7UBqRvf0vE8fqSP92qWz6ysiZhcY0Wpun
         atp3W/ISyhYIui6/VS72XhIV8Eem0ibA//OHFI7NQHJwtpjl5npMwjVgOrSuskn7A/jW
         QK1foK9LLpR/fPXLKbO1H6NESjnhdRnThB8Mumx2InwuVdhMi0xtvkCVqhFzWpEox/ou
         XqntnYothQixw0B47tloBX6mdlmsLHjMqHnTH0MtoDbLiu24ftAbReWnpZswpJpVxpAu
         Y7XwAGgI0I30UytmHRS0MUJDeshNpW1cLEm5xeKM8gLl1r8Z85vYR3ZVYpGrSFd/VJ65
         /NHQ==
X-Forwarded-Encrypted: i=1; AL+hErGcoeQnzAM8HhIRst34ERG65md3QPzPiQVzc7q8OrtUx99QRkxKOwib8WIPAYkuH+3UhL6gZWt9mw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZUEgUoqdwcwEKeqKRATqZSTV+YFWc+8yLUsnPRYrrkWcI+aKU
	qWcRkivGhei7C9eWjUP4WkVkrOJgA5m33kQj0TpKZ6dSwtj9CXW2oG6lEC8oqpLKdIFbReaXKjv
	PyfwSol+TLysiUERquklSdvnwp5T+pUZYh0zU
X-Gm-Gg: AYBFou1jwzIrelQDz2dSjByCMgGI5iuNCOoJ4nw7MFzAqXbi3JhrFKPCnLDnGz0KAOW
	f3UOCrSix6KOEWwYGqSpu4eNXoXhx/AWcaWQIEUHMJblT7W/bHSkt+JlrUYDun+3m7IjqN6lz+C
	Jjyk1VVQrgVenC8RjKJ27okokSXeKiSSP6yDqVZxAUGygwFVuIngDpzo2zy0TqiMNBRBjJvXO5h
	FkgkhRIR9BUtTn7Wi4radLYqDb3VhWjHrUNndHyQOiFcr7RCQWU9zC5UPRk3NbigIetrMr2y45R
	Dam2YqWxx5oSU0i0B0EL3em1bt+n4+UubkDlNcdBpL2TVgQANfGH1D146MDbHpuzqMnLI5SPTPc
	VE49yZXBaY6uC/t7p6TlhUjoAVinKdLsH15ib0r+xZczSpStR1VCMihNKksw32QHDsYS6UN2pEg
	qqiqvnjjdoPHiq94ySxOlIqzdDMPBrRw==
X-Received: by 2002:a05:7300:de07:b0:36a:1294:59e0 with SMTP id
 5a478bee46e88-36f75f2622fmr6160193eec.24.1794046688723; Sat, 07 Nov 2026
 02:18:08 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-upstream-soctherm-t114-v1-0-c875d1921084@tsv-stahl-riesa.de>
 <20261106-upstream-soctherm-t114-v1-2-c875d1921084@tsv-stahl-riesa.de>
In-Reply-To: <20261106-upstream-soctherm-t114-v1-2-c875d1921084@tsv-stahl-riesa.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 7 Nov 2026 12:17:55 +0200
X-Gm-Features: AclHuK_jIEdyr-up9S7mHl7KTEoo-13Z2jwrbx6ifXQMV0tTi0jUUh7MBAiai48
Message-ID: <CAPVz0n2jFCxCa=t=XaxE7S9YxbYyF3WGbwXqBvkkQHjmiErqdA@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal/drivers/tegra: Avoid SOC_THERM calculation
 overflow on Tegra114
To: admin@tsv-stahl-riesa.de
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 6 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 22:32=
 Patrick Fischer via B4 Relay
<devnull+admin.tsv-stahl-riesa.de@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>
> SOC_THERM calculates each sensor temperature in units of 0.5 C as
> THERMA * capture / 2^13 + THERMB. On Tegra114 the intermediate product
> THERMA * capture has to stay below 2^24. Above that the hardware sets
> TCALC_OVER in SENSOR_CONFIG0, clears TEMP_VALID in SENSOR_STATUS1 and
> the sensor drops out of its group. On a Tegra Note 7, 80 out of 80
> samples matched this rule: TEMP_VALID was set exactly when
> THERMA * capture < 2^24 (largest valid product 16747731, smallest
> invalid one 16877718).
>
> The fuse calibration itself is fine. As Mikko pointed out in the review
> of the Tegra114 series, the fuse corrections are in 0.5 C units on
> Tegra114 just as on Tegra124 and Tegra210, and
> 2 * NOMINAL_CALIB_XX + shifted_xx is correct. This patch keeps it that
> way. The problem is the range: with T in C,
> THERMA * capture =3D (2 * T - THERMB) * 2^13, so a sensor only gives a
> valid result for T < (2048 + THERMB) / 2. On Tegra114 THERMB is close
> to -2000 (between -2117 and -1812 on the chip tested), which leaves
> almost no headroom. On that chip the sensors were valid only up to
> 45 C (cpu2), 53 C (pllx) and 32 C (gpu), and cpu0, cpu1 and cpu3 not
> even at room temperature. The gpu zone therefore always reads 0 C, the
> cpu zone stops following the CPU at about 45 C, and neither the
> throttle levels nor thermtrip ever see the temperatures they are
> programmed for.
>
> NVIDIA's downstream driver runs Tegra114 in "lower precision" mode for
> this reason (tegra11_soctherm.c: "We must use lower precision (0) due
> to cp_fuse corrections"): the sensors count in 1 C units, the readback
> is scaled by two and all thresholds are in 2 C steps.
>
> Do the same with a lower_precision flag in the SoC data:
>
> - keep the fuse calibration in 0.5 C units and halve THERMA and THERMB
>   only in the final rounding step, so THERMA * capture stays around
>   2^23 and the sensors report the same temperatures at half the
>   resolution,
> - double the readback in translate_temp(),
> - use a threshold grain of 2000 so that thermtrip, the throttle levels
>   and the trip interrupts are programmed in 2 C steps.
>
> The use_lower_precision option in v3 of the Tegra114 series and the
> downstream driver halve the calibration temperatures before the
> calculation instead, which applies fuse_corr_beta at twice its weight.
> Here the result is exactly the current calibration divided by two. The
> PLLX hotspot offsets are left as they are, as in the downstream driver.
> Tegra124, Tegra132 and Tegra210 are unchanged.
>
> Tested on an NVIDIA Tegra Note 7 (P1640) together with the shifted_cp
> fix: THERMA * capture now stays between 7.7 and 9.2 million, and all
> eight sensors report TEMP_VALID in idle and after 60 s of load on all
> four cores at 1.12 GHz. The zones read cpu 43, gpu 39, pllx 43, mem
> 39 C in idle (board thermistor 34 C) and cpu 63, gpu 55, pllx 62, mem
> 53 C under load. Before, the gpu zone read 0 C and the cpu zone stopped
> at about 45 C. The thermtrip, throttle and trip thresholds are
> programmed as 51, 50 and 45, i.e. 102, 100 and 90 C.
>
> Fixes: 9d522a877b6f ("thermal/drivers/tegra: Add Tegra114 specific SOCTHE=
RM driver")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/22816196.EfDdHjke4D@senjougahara/
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  drivers/thermal/tegra/soctherm-fuse.c     | 15 ++++++++++++---
>  drivers/thermal/tegra/soctherm.c          | 21 +++++++++++++--------
>  drivers/thermal/tegra/soctherm.h          |  6 ++++++
>  drivers/thermal/tegra/tegra114-soctherm.c |  4 +++-
>  4 files changed, 34 insertions(+), 12 deletions(-)
>

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegratab (P1988)
and ASUS TF701T
