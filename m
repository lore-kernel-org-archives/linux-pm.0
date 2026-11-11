Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357749;
	b=JnGNkQytd1bzMcp1dB02sxNBKF+VDFfrcgfkvTur8bRW1ImESxi9moBqM2ytwWLAVAGL
	 Odtlz2dKP68498+D4zAnQ5O5BiG1fMjvWRBneC+ovUAlH4/DMpk7xNel7XN/DyQxiJEGI
	 XljkVS/yTlLS0koKDpGNn769DSJNIayPIeA5ih9FplFQ/8wn/V02elesmmUm8ORS+sAOB
	 RS3/PzUQuyxV8qvYIbbfJ4gYvV3EBepbQkifvUj9L3r74LNj0mVsSRlPCyEEGdPA2dasK
	 p2DcJKGw7B7FHTVzuJ6VwVCc3OE7q2H4D/4nsRYJkFGdj6K8mxtEfmYOWssqCJSNslQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=E7hFxFP7EgFYE6TqTVpyjLDOOIO5uZPKfBtvSc0+v08=;
	b=pGlm9DQ+XUoeXeWZoi0gy3hoJoMIDRXST8IdLKDKs9mMN2xcpKeOempg//kgQ5CFJ0u+
	 E+7r92PTZH6fBSBq32db3nZmEp4ER2bmzHRXkNQPNdvh7BHNuRM8Bmh/2hkf88utpJWEf
	 RXEWed5YbQ6RJB3oZjAkf2mjFezsQxKb0CaeUYInL43gTMEAtxNT6mZ48DB8zq3O9s2zQ
	 JW8ULzSl5qnbKDuqHFqbDDVbGJFRWQ942o47UUezkOfNOEc16KL1emS1vzg2bRjnzIQP6
	 QuMuaDTw1hUyBkszLCHR3JrWJuHIXtbAK1AUR52OvSsZpc+O5RrXvYVI8dIXB7jhoqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=E7sD6QLs;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCE0606A320
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 00:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFCE0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=E7sD6QLs
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-49134c8509fso2163445f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 16:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794357747; x=1794962547; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E7hFxFP7EgFYE6TqTVpyjLDOOIO5uZPKfBtvSc0+v08=;
        b=E7sD6QLs/JTqFWSkB7hHTWPc1IbiQa8RF1Z6jO75nCHyz/qg7g3dDboQtZPPDIa73o
         jNXkNcnZZWoCSsdnYizHXNEFKdE66CXtJJxotbhZgWRFGas+U4/MLtqyh4W5Ii4VKzAv
         LgaRZt7BaNGNYiqaNMPYBMjpaAc9J6eIJSkJlhg9IEIRUmxuBGL+bXhHhh4Mjci574yt
         tlsWqwP2cqR/MFb7Pu88/A5muqd0MwoRIX/+VUwGOwYNc1B0Ty8W2Xa/MC80kzJO+eBI
         I5XYrRXS60dYsmmBk+oY/DrJLFmiZ8vybSN9C1KJ0FJdmkWo4X10ACsfGmNDp/w2kXpC
         pchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794357747; x=1794962547;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E7hFxFP7EgFYE6TqTVpyjLDOOIO5uZPKfBtvSc0+v08=;
        b=SoSbY5Ttk4YGpNSTiu2ujYTsOut+Q+4upFvRklN3A9g4wObtDggG7AWzeEZsCrFWg4
         tB8eFAUAHobFFjrDjw50mbqpjmclywoxxjMK2yB/ws7+9EaBa34CYl/RzT+ffvopPSNN
         OKLyI532J00aumP16kWP2ue1k5LeKqi7ixx5cKHQruPL/lS35HIvP+XWVvMN9XoGph1J
         1Oi2ndNbF9ytOmdN2UGOL7xQyeIR93RJcMNG9WuzLyXJMeVHJWD4AFzEulVDdggewa4e
         MWFCHdBOFMjLAdZ5yQk8P+WN/ua+MSgvUHS55ytLXnS16cLgt4Q+d8vtMeGN6PKvp1oj
         /TGw==
X-Gm-Message-State: APuU4Z90uJmf5/WwsjaT6h03z+XqtYtcXIooi8WuJq/qzJrHepkcjxSn
	sjJHvrR6d3ONgE9XqovgZrugdbqaA+vb7tS7K2/X4lazFOuzREqyS4iFGzIqWuqozdwoDtFxjyM
	kRJvU2DQ=
X-Gm-Gg: AYBFou38yG40TBr3vVnAh8FzOCucH/uQj5sq7xYkI7ZgGonzN4r47SE4OLtG1zbY/Vj
	+0Jz3IkHLOiw3VN6KJ6q/mQgqXwElggxw+nZksc7DkthYKAyxH4ALGdgyAInOfp7cEnCxCpeeUF
	BArn2wT7UWn9HYQwxKshxhphzxJtvOFvXNGwvxlh//bGWiIjUM6NYwZqjjXKIKr0Xi06zpiO5v5
	u5MKkmAsMq20tU08+ZRZuMjrsFZaM9vlNmQML+oWN0wxOxPrON7mY0OwRFKJTDsi8NUROCpH4AM
	T/J/qoGQsu1ooP+og9yi0NFJ5xUEdGjcYTLmeX8lwhud5KiR2XTh07WHYgle78LD6phoDH9H6eN
	lp97TUceeUOBD1p2p3mf4n/EQ3H6GhoG+6KtonQ2WMVsSGZRmBbhE74NA2DpdtfJiHUwof7mi+N
	vx36xGbV9lp9gh5X5cJjx/GXlnI/ED2aBKRud9Ngiy51fnPoQyYZW5nUyVh7N+0p46JqNt1kIXY
	ecy55IKEFM6fQEmG6JNlStrJLvV0B5P6fn8aGVCtwzHQmNamz5+CpEWkNaEGnt1NBCbQgumT7Oc
	ivhiXXebnEkGBLS4HiXgnQ4qeu1itan8NLGPxWtXbYYR5xCMWwoQjiPC9JHunwSj7BUfD8xbiv4
	zDNZhJadrSS843A==
X-Received: by 2002:a05:6000:248a:b0:48c:466e:9d08 with SMTP id ffacd0b85a97d-499c792df18mr850020f8f.43.1794357747215;
        Tue, 10 Nov 2026 16:42:27 -0800 (PST)
Received: from localhost ([94.4.85.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49836b8eb11sm8383111f8f.57.2026.11.10.16.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 16:42:25 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 00:42:24 +0000
Message-Id: <DMRYQFZGG5ZI.2T97YA5MCL74Y@linaro.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
Subject: Re: [thermal: thermal/linux-next] thermal/drivers/samsung:
 acpm-tmu: Rename platform driver to "exynos-acpm-tmu"
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: <linux-pm@vger.kernel.org>, "Daniel Lezcano"
 <daniel.lezcano@kernel.org>, "Tudor Ambarus" <tudor.ambarus@linaro.org>
X-Mailer: aerc 0.21.0
References: <20261026-acpm-tmu-fixes-v1-11-0637431b7268@linaro.org>
 <179389375857.1009794.283716939057872036.tip-bot2@tip-bot2>
In-Reply-To: <179389375857.1009794.283716939057872036.tip-bot2@tip-bot2>

On Thu Nov 5, 2026 at 3:49 PM GMT, thermal-bot for Tudor Ambarus wrote:
> The following commit has been merged into the thermal/linux-next branch o=
f thermal:
>
> Commit-ID:     ba446bdd27d4a2a6c0cb267f51a6ecc47cf19cf9
> Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/li=
nux.git//ba446bdd27d4a2a6c0cb267f51a6ecc47cf19cf9
> Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
> AuthorDate:    Mon, 26 Oct 2026 16:01:28=20
> Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
> CommitterDate: Tue, 03 Nov 2026 19:51:51 +01:00
>
> thermal/drivers/samsung: acpm-tmu: Rename platform driver to "exynos-acpm=
-tmu"

Also, the fix for this problem was sent here earlier:
https://lore.kernel.org/linux-samsung-soc/20261020-acpm-thermal-drv-name-fi=
x-v1-1-71f72280583b@linaro.org/

Why taking this one and ignoring the fix that was sent earlier -- this
should be at least explained.

> Rename the platform driver from "gs-tmu" to "exynos-acpm-tmu" to reflect
> that the ACPM TMU architecture is shared across Samsung Exynos SoCs
> (such as GS101, AutoV920, and Exynos850) rather than being specific to
> GS101, matching "exynos-acpm-protocol" in drivers/firmware/samsung/.
>
> Suggested-by: Alexey Klimov <alexey.klimov@linaro.org>

I don't recall suggesting this. Reporting -- yes, but not renaming to
"exynos-acpm-tmu".

This was reported months ago and was never fixed in the updated
series for acpm-tmu.c.

> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
> Link: https://patch.msgid.link/20261026-acpm-tmu-fixes-v1-11-0637431b7268=
@linaro.org
> ---
>  drivers/thermal/samsung/acpm-tmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung=
/acpm-tmu.c
> index 42b338d..2324efc 100644
> --- a/drivers/thermal/samsung/acpm-tmu.c
> +++ b/drivers/thermal/samsung/acpm-tmu.c
> @@ -597,7 +597,7 @@ static const struct dev_pm_ops acpm_tmu_pm_ops =3D {
> =20
>  static struct platform_driver acpm_tmu_driver =3D {
>  	.driver =3D {
> -		.name   =3D "gs-tmu",
> +		.name   =3D "exynos-acpm-tmu",

It is minor but it potentially clashes with exynos-acpm-tmu firmware
file name. All other names in file acpm-tmu.c are "acpm-tmu".

