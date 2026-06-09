Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51586398910
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005493; cv=none; b=LA8s6Zt+fxqkBkG43YtjSJ5uLPNuxIj0JMtpNyXgOhGO9y4CzUxp+K0UEhx5YRspku5xE4+rl2Rw2ZC5oYCHQdvTA4anlhTapB/ulYmNUKDzjHa3MHVoqaMJFJIohFPaj2p/+vHucIV/dxi+aALl1BXmZErrI348RCHYzvBclVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005493; c=relaxed/simple;
	bh=YygPCiAmXiWrvewKwYWtyCzbkJfaFZJYqrm32SMOdfc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bDoZWWzMuLZXXd17bGDUiaTWFTlaMBpFx+CZXXtsSOm10m0ge5rTssr67pWBQ0HE87JAivfu3rFH9YuEzjxuy6vFfocOxvkHmoPgj/gIolW8SP5GR8o0yDB24mITfY/J22thctWFUohtUu1914WJFnu8HXmibE4wLhiVf3sJNfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MtG26ii1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MtG26ii1"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68b90fc6a1dso172195a12.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 04:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781005491; x=1781610291; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jVtKsScmZpYoItkBLWZrzYfhywAVGgLQpel9i66ubjc=;
        b=MtG26ii12BO+NUu9y/zgI2ET6cVwpxJJsjdg8MLjQwNSQzb8ec8s3U2O4zcikD/mbz
         VYAvyW5NWnIf500OmAHtNokBj8DT4vSyAV2qlnAHPRDY/VZ4ZiI6Q0qqw/t9BCx+91zR
         1ITZQHkekqPktZufU1PXlje0xF3aYwQ0AbmweRCvgLJBei7S6Q4WpIIpsYcXfn79ajqk
         mWTo4Z8pTAoDAT24ViMaZnDnGwFQhMLc4XR1Uf+x9MQIdeMzyQAtPgpUplTDGBPYE91M
         XrbkOHhhom7sLE8D2i7Fbw4n/PMy3o/08mtIxiNk41ZRkb6Iu9AqZ6UNoWnwsP7fRoau
         yTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781005491; x=1781610291;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVtKsScmZpYoItkBLWZrzYfhywAVGgLQpel9i66ubjc=;
        b=rf2rJ/CMU5+e47pnhENsvHJS775bbbFuKs1bVsozQA4HjfUoPeegUaQF+BnLL50SR2
         EjzitAKHPOqzu1f4BPhg/6s3ICtrICFbyFWVDPrtHodmt9GHriSfmI9V63dGB4EL3D9d
         2dJVsIni/8FnL6/pV/VDPsQiTYfeHqRunW6sEHhFXqE95+l/E4rLhvh9PPGUIRnOexWS
         zgO+CSBKlMO1dMT3vhSpVg57Lvdkk1eYJP/bnWfmn/Lom8jl5YfS8+d32YFw2sKl28EX
         zAmvHeZUXovjUUDPCsQSI6O33Q5x2Bb6WbSr7oATUvlYv7mtvlXwx8U/4pPkoTS9gV/p
         sWvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ibafZ6BiE+i5arV8nuAo+8LJInlRq3gT7Z+L4c1j06PYZYX+m955dsJtuEt8gnFLLiC/SiJL6jw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcy3dAw4rk4j6oC+eZdKQZnuqsjzsAMRUIIAxfl6V0XU7YHDPB
	vx261x9GK8VkXRpRtL8aM8VeIsJQHT8uvaFEEJfEGVI5FpuabreSQL9/8R8Kn4AJRWo=
X-Gm-Gg: Acq92OGo/4Iw6UlEJI0djLnwhb9lF0/tnp1CwQnktaYjROjmZAw5DdlNu/KLj4+Sm8I
	gPMx2ACQQyVbAO0xgTlrhaMZ/62Sb32VZEhsRPk6W0VGB214loiFzBXLAUHNMVop55Rh19HZ9Vv
	pm38ajh8FWOW5LX7URhdmWfdi94GtTPZn/NIEvnZdme/qNg4HkUNduTY9O7fnRPfAe0C8a/f+uo
	YEhJKHp8alR9+rdOlIe88OvQUhdWZ2iScYkQL+WMvIf2t4Ys8aTHLRAyruXp5bVypfs3Jsa3Jru
	nm6GJiNc+t/JPH1ffiwbGGCR4cqryqSdGV+N9CyvVeltBOHU8wYk5FimYmXuwoigCpk2stOUf1U
	OLTaZaHTj9N7nT2k+ddNyQjtUXYKvVyJ/3uYeq5u9s7dgCclQ2JHk/ihff+OiYk40k/QWAryieu
	Bh0JMzHrIejSKdVcpUW19oCl8tD/baQ6fUxW1qrcJH+DeUB2TaDy3PqdA=
X-Received: by 2002:a05:6402:4250:10b0:68c:3439:945f with SMTP id 4fb4d7f45d1cf-68ff217a53dmr5586490a12.12.1781005490656;
        Tue, 09 Jun 2026 04:44:50 -0700 (PDT)
Received: from [192.168.107.26] ([80.233.69.159])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6914f3b583bsm4516495a12.29.2026.06.09.04.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:44:49 -0700 (PDT)
Message-ID: <08d7299968e14e5fc07fa4791479abd9a2b11c2d.camel@linaro.org>
Subject: Re: [PATCH v8 4/5] arm64: dts: exynos: gs101: Add thermal
 management unit
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, "Rafael J. Wysocki"	
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui	
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski	 <krzk@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva"	 <gustavoars@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, Alim Akhtar	 <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Date: Tue, 09 Jun 2026 12:44:47 +0100
In-Reply-To: <20260603-acpm-tmu-v8-4-0f1810a356e6@linaro.org>
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
	 <20260603-acpm-tmu-v8-4-0f1810a356e6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8+build1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Tudor,

On Wed, 2026-06-03 at 13:00 +0000, Tudor Ambarus wrote:

>=20
> [...]
>=20
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/bo=
ot/dts/exynos/google/gs101.dtsi
> index 86933f22647b..b6866ef99fb3 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>=20
> [...]
>=20
> @@ -639,6 +647,15 @@ watchdog_cl1: watchdog@10070000 {
> =C2=A0			status =3D "disabled";
> =C2=A0		};
> =C2=A0
> +		tmu_top: thermal-sensor@100a0000 {
> +			compatible =3D "google,gs101-tmu-top";
> +			reg =3D <0x100a0000 0x800>;
> +			clocks =3D <&cmu_misc CLK_GOUT_MISC_TMU_TOP_PCLK>;
> +			interrupts =3D <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH 0>;
> +			samsung,acpm-ipc =3D <&acpm_ipc>;
> +			#thermal-sensor-cells =3D <1>;

Vendor-specific properties should always come after generic ones
(samsung,... to move to end here).

Cheers,
Andre'
