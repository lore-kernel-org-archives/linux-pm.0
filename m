Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794708626;
	b=jgzr6amEr0rzpAYoCxocBYg1Z+jNjTon5Dl2uSq1cRLcYPcOnyFRyUalVAb436KYtV+f
	 s5kBYYZCIwalPPVpo7TEQcxi9UEqu57OkIfRrYtuUcZ3BDW/5RWvBTA77cePfyyyFyplL
	 mnUIf0yyfVWM/gfI9tD6sC5OsxBEx2zxG/lIu/u6wy370/BREuGpn/Ua9pECD+H37K5Ls
	 by6fgZg856oe/+13tdHnUQnVZfxS6N24Efafbz9Ohq8szpKhR0Wa1oA6Htj5IP0LZXuNv
	 /FXqPMDxitzRbC09GYkD+tdTgsx2po8q9PTzFX6mNV8m3voo9KdXJ2/AydWWWX8csFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794708626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Dlr8BYW4D9uRE2kBdvPJxDIlvh4ufcRQvKzhTZs/K1Y=;
	b=obhovgZ6r912la48gRQ49VQNEjUYXEqBe23RX74KwfqCh8OopNRSrBALp3Kqzpxj2/5c
	 DIJsFYN7wukMkjIx2SlZJjG+IN0LiqiI1bAdL/NaikX5dmdOBXTTF80KLz459aZizGFL6
	 AxilKka0mrprnjvzJQs0It6ph1vfpvJezccmDSU9bhn5JTi1ZyjLbb1FBiKtBEoR1P5Iy
	 YyaiGpD+cbokTFf4jG3Md+Jc+KQ+A5Sm5uP6hgEgsJpVwDq4Y5Jq9QZbUeHebetKhyFgp
	 iIqqOOQWhlpizIqzSZXBZNOXJGtbwIx0Gx4zVyD6fp7dca2I5c6g5AJZU4qW+y6Mybg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=txxkvDyO;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11906606A32C
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 02:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11906606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=txxkvDyO
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4d30639709so356332466b.0
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 18:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794708624; x=1795313424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dlr8BYW4D9uRE2kBdvPJxDIlvh4ufcRQvKzhTZs/K1Y=;
        b=txxkvDyOusSB3/VwzuNOTJgzeLQw9KkCBACEspjdt3MsKzdy9hdSWY85SJ4YE5Wjna
         /h4bpo/UXO06tEB2cLUjjB/MI8OtA0++yvXfTUcmj+K48YDI17uQGUGCzNcU/3h8daBa
         6DNisaR0TU58PV6uwD8Yjn/qbhvdiexoVERZJi4nEyo1U/ahQEtYFyaI+A4+tnvZ4Xxr
         SHHSG7rHXn5UkQrpK/SNmoPSjbcxN0C780tLp4XD/IOvxl0Hq28F8mOCDyLMsYqwoQQL
         MpFCujzcEfpXMnx/VgnyCZn/FxOK792bWWuhLEOCsfRfUGsNBPuCgVyAVqn8ksxBSNl6
         A54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794708624; x=1795313424;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dlr8BYW4D9uRE2kBdvPJxDIlvh4ufcRQvKzhTZs/K1Y=;
        b=AgT52aVZLEG3KaEv0VpZ8zk/RU08IYVylRIX4y+2ZragTobDkC5Ky9ji5ZTOI1mn/g
         Dj7TnbygYJ4X+8Aozfhv5P3m9CqIbqdtoOUpQ4dnmGFzejuFNxHOC4mESLkIbheCojon
         s4ssgiwS6UwBgRAI8Cy1bqYR0uIOEnIti4ySax6uMO6iFXA3+3lIa11O/r65Xwftl1T5
         ZL0r2ftFEF3EB34hDR/kfJ/avkRl2Uc1Ew5fBbiwCeJKHE88mfgEJYBM46S1zsBa1RR3
         V0IYZLx5eB3j+Z3t+Cyt4fJ3FR/CQqyfD4UB7NNGIGJPjEXyXnP4MZlfu57uyjnjWrHM
         Jd7g==
X-Forwarded-Encrypted: i=1; AL+hErGZYnBhRMtdOenbwaH6jjtVnrHip8MLX6DPFxRaB1tInE+7TUtLazeJyaJ65GZ7T9VHKX+GrLYb4A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9DMa5neGgS4izknc47qk3ex62inubPSvgc/BtBBAlgJeY3IMh2
	LSchxkIGc1fKZIOyV9vYgZEvdTSgjvSC1XTgvBk8BMPAXy7oN6vsva8=
X-Gm-Gg: AYBFou2hVnh6a9vGU3H1r2JMHefHu7SK19AWfrn1Tpd2UAOQV4YsMy54B+ONvqbz9op
	GJNACYsw3May5Dn5WqSz4bn9JkuNX1m4/LSefnp21+dIm4C1vap1/rCyp3eEHi5JUcrNPzVCwCD
	Wdb5Ds4kIFY+iKt+lX2rWuVZOsZLKCcMkitZmnFz9rPnOqAfKdJg7iR3e9mnggtsO8Ql3a1Rflu
	biZ1j4LLmmRvZXALO6dmz7Hjg8p3FVLYToxf6wtRW6Velktca2obJu8U3TK9LtGOGB2lfk+c91E
	/9UXgc6vm7fFlO1nlxpb4g6hT0jkaLTqBjx8ChKpcAZntTQ+PN58l/NIVQfowNLKQFfdkH2Vn+B
	cc7A32S1MfcijFy/PxaR3CWA4a9C8sXbr5HGwvEo7mDqQCAw+o6te0l8xup8sUfypGLpbzoEgIX
	O8hYtvpUQtbeGic4vHHMfvBxueNP4diJAL3cj1jSRdQSVNgLCfRKoIbqP5r78Lcr1fhx353mhjg
	3R+AYBdYEu616yqX+RWzw3PbTBb3/3bBZRM1EZtGEy+4H9Wpj+ES1wmXp7eP+XD/X6cCXf8DQfw
	eOpNfP6sTWHYIQqzz6a7OYgvL32neI6+sqqfH1KEBvdGO5J7oHR3sYAGuAydSaa5UQkBU0YMmLf
	l/xEcB6h9q/is7L6lVgiNTbJYtA==
X-Received: by 2002:a17:906:f5a8:b0:c50:5e90:5ea7 with SMTP id a640c23a62f3a-c5096853f0cmr525580166b.49.1794708624326;
        Sat, 14 Nov 2026 18:10:24 -0800 (PST)
Received: from sohrab-omarchy.fritz.box (2a02-a44e-4ae7-1-c0e-6d5a-8ae2-915.fixed6.kpn.net. [2a02:a44e:4ae7:1:c0e:6d5a:8ae2:915])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c6a5924bsm2665270a12.18.2026.11.14.18.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 18:10:23 -0800 (PST)
From: Majid Hajiheidari <majidhhdri@gmail.com>
To: barnabas.czeman@mainlining.org
Cc: andersson@kernel.org,
	konradybcio@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	abelvesa@kernel.org,
	mani@kernel.org,
	admin@mswin.me,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: qcom: sm6125: Add cpufreq-hw and CPU idle states
Date: Sun, 15 Nov 2026 03:10:11 +0100
Message-ID: <20261115021019.731462-1-majidhhdri@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261115003158.391171-1-majidhhdri@gmail.com>
References: <20261115003158.391171-1-majidhhdri@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Barnabás,

I should have put you on Cc of this series, sorry. After sending it I
looked at your sm61x5 7.3-develop branch and saw that you have cpufreq
for SM6125 there as well, done differently, so I would like to sort this
out with you rather than have two versions on the list.

The differences as far as I can see:

- Your branch gives qcom,sm6125-cpufreq-hw its own soc data in the
  driver (lut_max_entries = 12) and makes the clocks optional, with
  19.2 MHz and 300 MHz as defaults. This series uses the generic
  qcom,cpufreq-hw fallback like SM6115 does, and takes "xo" from rpmcc
  and "alternate" from GCC GPLL0_OUT_EARLY, so it needs no driver change.

- I booted your branch (cdcfb1386, plus the laurel-sprout board part
  for mpss and wifi) on my Mi A3 to compare. Both versions give exactly
  the same tables:

    policy0: 300000 614400 864000 1017600 1305600 1420800 1612800 1804800
    policy4: 300000 652800 902400 1056000 1401600 1536000 1804800 2016000

  With the generic data the LUT read stops at the first repeated row, so
  the 40 row limit is never reached on this phone. Did you see it cause
  a problem on another device, or is the 12 from the downstream
  max-lut-entries? If some SM6125 board fills all 12 rows I see why the
  limit matters, and I am happy to rework this series or to drop the
  cpufreq part in favour of yours, whichever you and the maintainers
  prefer.

Beyond cpufreq: on that boot your mpss and wifi nodes worked on
laurel-sprout with only the board enablement added (firmware-name and
the four WCN3990 supplies): the modem came up and wlan0 associated. Two
things I noticed, in case they are useful:

- the modem crashed twice during startup ("fatal error without message"
  at 103 s and 145 s), recovered both times and then stayed up;
- ModemManager did not find a modem. On my own tree, which also has the
  IPA node and a dynamically allocated rmtfs region, it registers and I
  see no crashes. I have not tried to find out which difference matters.

I have modem, WiFi, ADSP/CDSP, Bluetooth and IPA device tree running on
this phone on next-20261113, but since you have modem and WiFi in
progress I will not post those. I can test your patches on laurel-sprout
and reply with Tested-by, and if it helps I can send the parts you do
not have yet (for example Bluetooth, ADSP/CDSP or the laurel-sprout
board enablement). Just tell me what would be useful.

Thanks,
Majid
