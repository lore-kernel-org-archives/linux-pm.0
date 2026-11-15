Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794705773;
	b=OmXKEcYsAZFfW19jweP66zCuQTsTKopcU206qlkZirMOzFyFnmAOp+nz6nJuojkf2/OD
	 zGe8QrdWPz3uvgIk76ayf2D+6n/8cIzHLnNgOFp6wG6OxZ4VWNZKIEfHKHpFxCrB/eS2Y
	 Qb5uREXHKp1CGAUEkxyLUXpUmTLSEzRxp9Vlv2rX9R6rL7P8n8EPTKphuiCrLUvCO33dH
	 dyzDtXIPc1UrP6doMzCcI0nUvbafuoDtC7Q6mOoNlQieLQC8ilq7whCDFzcrt3S5z+Dgp
	 MkbATFZ9BD6ClvlvpvyHFFOXnIWu4xrrA+FW6kXP9n8pBxBNrJsSqBCpnsSxOGu0oow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794705773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dp/67JmcNvmFQHE7Njd0ridip6Zcl0Wn6uMgmcNbwbU=;
	b=EQhJmm6ckUg1AK9dKe3MkebNr54ICJZdumRzmXTNG08SA9q4SQxydywt2WgSy/m+XzQE
	 a1GyTVlTzvIg6P/xtn5GE3UM/W85bCqBJYykQMzZbTaPCkzuliRXGTJM/UkQ7poaA0DbE
	 zJtt8E23pa0XI4bWq1SEiO+hUUXVL1oT7cns4Zu7of7ghlhHI/4CFRKtzXZptmJh7dlRd
	 Z0PqIJLPO8kSRuNuWNFILQfeIwz94BMDxbhaeQa0g716Pc60jsIFl6rV5mUa6XE48QqQO
	 /ij8JC9n0KQBFNX77pl/N6oYUbCn+I4VcBsQu7Kt+AkH3rtpjeWxiRuC5IhyaGJUiIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JXvE48TK;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35538606A32C
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 01:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35538606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JXvE48TK
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b633ddfad6so3758540a12.3
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 17:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794705771; x=1795310571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dp/67JmcNvmFQHE7Njd0ridip6Zcl0Wn6uMgmcNbwbU=;
        b=JXvE48TKiy91S9dvEv9At4IP8YWrv9G85CuWVftuPW0Nm42VDo9KFgSl0Wt6vcS56X
         H/qmdvNli+F431Mg85skwEVk3uZHmXjh03Qi1nriXU+eIVvL33jxebJhCOEYHkhdTzpe
         qqZmE/91d+DfQD6wRraqOOfh+6h/j5NhZExktRhovVugD8/uWjdRZ5edtEdRvQKSbyzS
         f2JkGxlgs18vVYYXWbHFihlv83Ce+ekiPSYHXuNjHYNdv4NqwZegVHcEX7C9VocMT2zZ
         HChWwWqXQwoRrokeuXsOueXT9eKfEoso4m9TOGVYvUa0b1HSABp4Vy3dHtUYsJRq4o7h
         Ty0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794705771; x=1795310571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dp/67JmcNvmFQHE7Njd0ridip6Zcl0Wn6uMgmcNbwbU=;
        b=GY32PWi4SShdz4LzACK+F54bmxkOhLGrqx8Us8HimPIzHTaw3eLbsvC96CaC6J7HAg
         JeX/CbQMjckuI4QkOn4+v8HkbGCPKZWFVlZFD++9AeJQ6wBbPuDZokTTFApICJVpyZ4t
         W78b/TafgiFJQuD7HPCuXm41j6QZRr/rtZX/o1cZap8yg7Y2sfSXelJ8PPdy0QQzMvbw
         HojRz2ARvFdq9BlNjkKJAr51xStpbjPiBZOkU4w362LmhtL6N1ESYHJ8Sn88zaNPUv6q
         n3N/pRRQWQGTMkOynKnMtVzzp/cUonGy+m9WPIYY8QhAiUL5IXvV/k+IBlMvzIVj7I58
         9bfg==
X-Forwarded-Encrypted: i=1; AL+hErE+UTtqyY37aQ+o60pZP/zLAiske/0ZpjkuQSlgcBppLmyeGgSUMjg4UaTbV0bwLZNry9Hi3insZA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/gSinKQwQuqhDM9Kdw0vwsyoU6oqzOsOwTcg8K7ZDa8TfwF/uo
	+wPctgL4pInX8T+aS6QKYcxWB3hl2LeHwWm7ZkeF0tiHkpFtLgMsD/U=
X-Gm-Gg: AYBFou2p+ypTsUS6XZ8Q09Xo+Hv1QK7cnVg7KaqCWowIYgwN/RKRsDBlJ9gd5kpf9J2
	BqQLOnP1J7CqCCLpnpkKil9qLoUy2D+61GkI0NtQsST0/HSla9k0zW/GKnHNRvPf5BfhkwJ47yi
	m4YB+sp0rwmUIiq4Dy7Uz/oPEY4Yf540HNthAi9liqYHtyyhZkhpLunVt3DKOytg0Du2AJbI2Yv
	Z1DzqtX9I5eSTuLk2lSoDCweBPBiFF+TxhO0/LZ16/YMik3QV+/jlL/fOQBohjHmp9q4sAfZZ6f
	uijTJsn9Cp6+9xy6BdDIgcJ7SQkZtD1skmx6YpZIQqiIQzDSc+HJubiiao1Wl3/IvPt7SjNf2Tv
	feRckRJlaKUvCBWE5eOqK+PInnqCHL/AGSH3UCTUKyRPIKjFKz8OKmgzyis3H/gqxAkk77tXsmO
	Iv/l+zcVcjPzm+N1HP3j4MHgoHFeihe/CjV8CCRpgYCa8CcMXMhQAZdy1iibiCz/Knv+RGHnigr
	Qp7YrqpmHzdspj2rLApRtcSAAAyyhQnhJtzS3xvV//KGXfJZJSmphzigBPikcAc3ou6ZxAYRYQt
	F5sCKJBasrCx82TGdXeuOvH+IPjNhVgTQAbAooMYe0ze8b7+QYu/tZ7B3hPzOyAoIj53xGVMBhT
	5reeuq2LdjC8gDxuWb0dCIW0A
X-Received: by 2002:a05:6402:849:b0:6b7:c9d4:6b96 with SMTP id 4fb4d7f45d1cf-6b7c9d47044mr4130497a12.8.1794705771576;
        Sat, 14 Nov 2026 17:22:51 -0800 (PST)
Received: from sohrab-omarchy.fritz.box (2a02-a44e-4ae7-1-c0e-6d5a-8ae2-915.fixed6.kpn.net. [2a02:a44e:4ae7:1:c0e:6d5a:8ae2:915])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c6a5924bsm2636697a12.18.2026.11.14.17.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 17:22:51 -0800 (PST)
From: Majid Hajiheidari <majidhhdri@gmail.com>
To: val@packett.cool
Cc: marc.lainez@gmail.com,
	luca.weiss@fairphone.com,
	barnabas.czeman@mainlining.org,
	danila@jiaxyga.com,
	sre@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	abelvesa@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Add driver for Qualcomm QGauge (qcom_qg) fuel gauge
Date: Sun, 15 Nov 2026 02:22:47 +0100
Message-ID: <20261115012247.621144-1-majidhhdri@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112170841.2189322-1-val@packett.cool>
References: <20261112170841.2189322-1-val@packett.cool>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Val,

On Thu, 12 Nov 2026 14:07:26 -0300, Val Packett wrote:
> This series adds a driver for the "qgauge" battery fuel gauge
> present in Qualcomm PMICs like PMI632, PM6150, PM7250B, PM2250.
> The PMI632 is used in SDM632, SM6115/SM4250, SM6125 based phones.

I tried v1 on an SM6125 phone, a Xiaomi Mi A3 (sm6125-xiaomi-laurel-sprout,
PMI632), on top of next-20261113. Board side: the node enabled with
monitored-battery (simple-battery with the OCV table from the stock
profile), io-channels = <&pmi632_adc ADC5_BAT_THERM_100K_PU> as
"batt-therm" and power-supplies = <&pmi632_typec>.

It probes without any kernel log output and reports sane values:

  capacity            66
  voltage_now         3979548   (vbat_sns from the ADC: 3.98 V)
  voltage_avg         3979937
  current_now         -72631
  temp                297       (SoC TSENS zones: 29-30 C)
  charge_full         4048000   (design 4030000, so the SDAM read works)
  health              Good
  status              Charging

Two things I noticed:

- voltage_ocv returns -ENODATA ("No data available") while capacity is
  reported at the same time. Is that intended, e.g. the PON OCV being
  used for capacity but not exposed?

- status is derived only from power_supply_am_i_supplied(), so it says
  Charging whenever USB is connected. On my phone the charger float
  voltage is limited to 3.96 V with a local patch and the battery sits at
  3.98 V, so current_now stays at about -70 mA (discharging) while status
  reads Charging. I would expect the same once a battery is full. Would
  it make sense to report Not charging / Full based on the current?

Tested-by: Majid Hajiheidari <majidhhdri@gmail.com> # sm6125-xiaomi-laurel-sprout

Happy to test v2 as well.

Thanks,
Majid
