Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795331564;
	b=c1idgZUZiczhTE27PbYPwPODykP61uwtZuQiYBCu58ocea4tV9P29O07OU4uOvPZWePf
	 hKAj/lqEmoaKdUARSIx2dHcqgnwt/wJYDw13Fe7zaVRrbjijXkdOWEd2pNQ6VIkFjaKyi
	 aSSXYz9cfiTkUiUeGBp3Y8BOpzhu/NaxO/6aGgHD0OMWuDN1B8deDDl6CcaL9rHbw8Yi7
	 v1zb0aGItATq4X56dzLOwg8IQuZfnn859REMpx1eSVvREQZa5St9YmE3/sl6uWscRxhOr
	 +jRjiYZQHxFGW7Je4Bh8o1p0bpKOUqDXAljlq8qQayvrqr9Ta0OfqewQ8ZBXqtDJcWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795331564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3zVCA/hCaFTJ0zs7I3VxuYhc3vtPcxVWB5oZY5PyGJw=;
	b=gUfFFmyYNLOW8KeFd+7jfiUCh9wda7Kp10k9kNXXNqK427m5FXEfxAn/9tSa3mFjW7BQ
	 9wTs62m1u+ODJO9t9AB8d71VCwit1JC8FjflPm10dtyncC5y0sxFeMR2NLZUEuiskeOW5
	 bUMo69iwQWSrMjGxzKAPZ0T8IkJEA2sgrZRa69axbSw/74L2QBtAdx3+KnbuW039np4D0
	 B5gxjvOPn7ik5/eRmV/Hhzgy84TSWeB4UnZUnGQW1yDXLTHmYk9Nlf13deYZwUw0ydWCw
	 PZoclAdxI5LWkACXixLy8uudkhK0pJI6Mcls/PlMe2kHLUuv8BCn6Dv69jURehV6OQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZnnaOsuc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC153606A32C
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 07:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC153606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZnnaOsuc
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-38692f62b22so3533455eec.0
        for <linux-pm@vger.kernel.org>; Sat, 21 Nov 2026 23:12:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795331563; cv=none;
        d=google.com; s=arc-20260327;
        b=Vm6GjVze/vGONX6bPwArdNGF5g0slxg0r0h7O85aqYd84Lx49uK4npC7GJ1pRuverD
         wkB5mKCBFVLiaUuMzndJzBpfs50MLHlCbg9eWL0DN4lCPvafPWq7dVtMz0ClKVrBhlt+
         Baw6NyX/dSO4Vww/gfs/TfSbczntb1w89gr2W5o+UgBRRelr4gTetAR0i9LSagNd6Ukx
         W5X5ios4aYxlt6r68P2bQfDigfv0be4d5yaewDj8m8gE7MIvv8MMlPTJjX2FefnyaY2A
         ksBWb5KRPc2NZcxD3qW+AVEf/mNbNp7zQFHlVat49NMoa4iFcAiBP+wmYgmikGY+iHMi
         OtzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3zVCA/hCaFTJ0zs7I3VxuYhc3vtPcxVWB5oZY5PyGJw=;
        fh=4tEGpp9KMkHfpJgZsp5BZRgbdsV3YTUpQ6d/OuDVJyM=;
        b=GiAHV/LSxLkjvsDOfxeA8xKlOZJXGnOBspHwZAza22ezH31XO8Y7dXCsvGmamL/krA
         kzhlscZeJf8uNEB7nqOwi/t4cBIPl8qfnnki6x329oMz5BfaMw2/EtveYlG/ZwNdBEI0
         Hih8cvUYsxWTuRSaaWsPwZndO+8ItqomiFCcgPFfceQ0rfezLcVhKr6L0EQD0PdR/IV0
         1iAOyxbBeNN+mBM7LxT2ODfQA+dKqNzEHqOOcZ295AK6u2rxgbKtKmc9V77I87N7BTAx
         JaGvbfC4Uebk/A2kPamDlBl0lvNY23VmEHrgCJJ6PP7HjszIPf1iMXwnqGqbAJj4nka0
         uXug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795331563; x=1795936363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3zVCA/hCaFTJ0zs7I3VxuYhc3vtPcxVWB5oZY5PyGJw=;
        b=ZnnaOsucVYX/DpYqsG0NMRxxNHndwpI3QP2ecJ1bAcia9LOdpB/4xgGkLKF3dCuFzi
         oOFMPUZa8JavQQfbnxRNuO2sgn9X1UT0P2VCoczxfqaGWxPcDo+7CmUmo45nbLDgo8xj
         27KbhSIgL2l36VDw3TXvTlHNcCBt8K6611DkLmiJ1d/stLjd7Qc39BWZvIjz5OfpOwEc
         ROgoAUtEQfi4Ic6SbCaeiWhG+ykCcw3+KB/ppdoxsKn8zPDrM8bE/yhoLf2s7UzGCUvY
         ZcEUsz9WRafKG6cqV+4sEbYzv4vMSQJkFj46CEeF2QwsObFOq84bcvSoEJNRJWc+LyX9
         /54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795331563; x=1795936363;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3zVCA/hCaFTJ0zs7I3VxuYhc3vtPcxVWB5oZY5PyGJw=;
        b=RsPsLDGTTvWvpz5sG1ODzFFCilEJrGlHam8H0juxPhAd4cbqASZXtfrCAHWroN61Hn
         qf/H5750xU/BoWMRwKq0lMMSuZ1DPgI9TxxAW9cNoit+Dq9RZ7Kk+8lhFLqfd17dkwt5
         apvcq19oyk6HLTr26L3hzdOTv7j8ClbB9jbTFedZv29ZdmY7pV65LMKBm+v9oKUxByCW
         GlDeBJC/kG8yqKCQckY2xOUUBtY3FGxO3g6M4FVljp8R1eePuEQD0XjiZBeu8yh3IIIq
         ufJ8wV22Inf9A/v87gfIeixXlXSAvuPTp45Arfl6tVliPqE5UcL13b/rSFY0ktLGOIWv
         DQWQ==
X-Forwarded-Encrypted: i=1; AL+hErEWWjj+tQ2F9AFR78C81a0J6rFDzkRsmvprmF+myQM+8PhhosgU4N7nQlMFveDHEdXwLXyaCrDIvQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+rt6om2AIiCBaf+pB8huAyF99G/W6s6TCQa3T7e0sTDFRqvBAi
	QZAu0CIp03lRfRIAlSuf9lFJSpuRXdXtbbT5JiRpWbxF/sahCHEmhkCnq5vAtwn89U4+anAdyF3
	jP0ji8ThBaB/YoWePfJWPpKx0Cy9cAvw=
X-Gm-Gg: AZFdTZeTKBE0HLkFDo4Hy8khCw7hIAQrlB+2tOCUJzqT/yiyNpgaCpYMn0epW0duHY5
	kr5NDmtXAGvBbfQ5ft2whXWLYlZmyZpy0JMQrmtEIbYd6t0XEIpw9G0P683H79c/wmVxNZ9eAWE
	gLarOkr0UrxbwswKR+RZBL+/9mVRuZuk0n5cdiAkpjboGS+5X9NLAjgbNhVK3wvmobgQvPnroyL
	IyW+oHzbfPCUf4zVmsPrVyXeWFDC2wNHRHcjh0LWqGKBBmt3AE4R9qKKnSNs3TNe7/GvFOq1f8T
	PP223S88AV4ds+G7VBd3F5jXuh8ahzj9VSaQXPG+w4rGujoLQNaxH0W+OpKh0mRLLvBjmlN9vFm
	nrKfmszvTTQ2Q7TvC0FZmT949jhR+p2F2VeHW6p/H6b3f0S5uTf99xvb7pfDGlecyAQBKtOFRoU
	rLTjJXd5aqwGYYnKGpvYeDNM1JIczds3U=
X-Received: by 2002:a05:7300:ce11:b0:381:a037:b060 with SMTP id
 5a478bee46e88-3856e63b3dfmr8855384eec.9.1795331562732; Sat, 21 Nov 2026
 23:12:42 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-b4-tegra-soctherm-shifted-cp-v1-1-528e3621226c@enser.io>
In-Reply-To: <20261122-b4-tegra-soctherm-shifted-cp-v1-1-528e3621226c@enser.io>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 22 Nov 2026 09:12:29 +0200
X-Gm-Features: Aa3M54oEQYrdYNxdmGboCbVhjm2_VcZfJC2F9W-WuGPrYliNjD9ZCNd6ydzWpMw
Message-ID: <CAPVz0n1wm2jNu5n0DXMea70mw1Z1uSrQQLVDA1PLHYbh+-h4Ng@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/tegra: Sign-extend the extracted shifted_cp
To: emcp@enser.io
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Wei Ni <wni@nvidia.com>, 
	linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 22 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 07:1=
2 EMCP333 via B4 Relay
<devnull+emcp.enser.io@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: EMCP333 <emcp@enser.io>
>
> tegra_calc_shared_calib() extracts shifted_cp from its mask and shift,
> then throws that value away on the next line and sign-extends the raw
> fuse word instead:
>
>         shifted_cp =3D (val & tfuse->fuse_shift_cp_mask) >>
>                      tfuse->fuse_shift_cp_shift;
>         shifted_cp =3D sign_extend32(val, 5);
>
> shifted_ft, two lines above, is sign-extended from the extracted value,
> which shows the intent.
>
> This was harmless while every supported SoC placed the field at bit 0:
> tegra124, tegra132 and tegra210 all have fuse_shift_cp_shift =3D 0, so th=
e
> masked extraction and sign_extend32(val, 5) name the same bits. Tegra114
> has fuse_shift_cp_mask =3D 0x3f << 10 and fuse_shift_cp_shift =3D 10, so =
it
> reads bits [5:0] of FUSE_VSENSOR_CALIB instead, which belong to base_cp.
> actual_temp_cp, and with it the THERMA/THERMB coefficients programmed int=
o
> SENSOR_CONFIG2, come out wrong. The hardware then flags most conversions
> as overflowed and never publishes them.
>
> On a Tegra Note 7 (Tegra114) seven of the eight sensors report an
> overflow with TEMP_VALID =3D 0, their thermctl group registers stay at
> zero, and cpu-thermal, gpu-thermal and pllx-thermal read 0 in sysfs. Only
> mem-thermal reads a temperature. cpu-thermal carries the passive trip and
> the cpufreq cooling device, so software throttling never engages. The
> hardware thermtrip compares against the sensors directly and is not
> affected.
>
> With this change all four zones read plausible, distinct and moving
> temperatures (cpu 32.5-33.5, gpu 30.5-31, pllx 34-35.5, mem 31-31.5 C on
> an idle unit).
>
> The code and this changelog were prepared with the help of an AI coding
> assistant. The submitter has reviewed both and takes responsibility for
> them.
>
> Fixes: 65b6d57c24ed ("thermal: tegra: split tegra_soctherm driver")
> Signed-off-by: EMCP333 <emcp@enser.io>
> ---
>  drivers/thermal/tegra/soctherm-fuse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/tegra/soctherm-fuse.c b/drivers/thermal/tegr=
a/soctherm-fuse.c
> index 8d37cd8c91..2de1d0cb67 100644
> --- a/drivers/thermal/tegra/soctherm-fuse.c
> +++ b/drivers/thermal/tegra/soctherm-fuse.c
> @@ -102,7 +102,7 @@ int tegra_calc_shared_calib(const struct tegra_socthe=
rm_fuse *tfuse,
>
>         shifted_cp =3D (val & tfuse->fuse_shift_cp_mask) >>
>                      tfuse->fuse_shift_cp_shift;
> -       shifted_cp =3D sign_extend32(val, 5);
> +       shifted_cp =3D sign_extend32(shifted_cp, 5);
>
>         shared->actual_temp_cp =3D 2 * NOMINAL_CALIB_CP + shifted_cp;
>         shared->actual_temp_ft =3D 2 * tfuse->nominal_calib_ft + shifted_=
ft;
>
> ---
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> change-id: 20261122-b4-tegra-soctherm-shifted-cp-a3b27f666f1d
>
> Best regards,
> --
> EMCP333 <emcp@enser.io>
>
>

I wonder if this is AI slopped, or straight up stolen?

Existing patch sent 6th of Nov 2026:
https://lore.kernel.org/lkml/20261106-upstream-soctherm-t114-v1-1-c875d1921=
084@tsv-stahl-riesa.de/
