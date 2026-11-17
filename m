Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936954;
	b=bd8hakarybIuVoyhBYWKURqzitfG08BjqyPLz3VLceNN8Oq6mPo8U5bDZ3Pd1AXTtGHX
	 N7xca09pg7BwoTOVNUyBlQynf9jQKueQOQh44yJUolLKTuxa3y3D+boeZiQznxDSu9mDB
	 rLieMjmcmUHSWafFwyLoSx5DoKBAPwud6guaOneJ/xupflJo6WG+Xrn5pnpKq8lfWZRJT
	 yOiKO/7xET8bBqDwwK8fMLAQeW+yz06Xhl7o/Gre6jA9+A6pV+ZfVfkglCLaATUwn8fNJ
	 0w4TVdo1b/plHijrCQbWJ7fXcZLW2GFChwLQMNdwK3TetzkrIbl4eXkTm6enaQbZXJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ehDPQMS1CgUNGIZmcAtlpOqErWJKhsWUSWC8X9QQDz4=;
	b=ZyxV4NJNiKTNjlUxE4wmS9uvAKsuU472jIztqohMr2UlboJ3xbHY++DuYEFib1Ed+FnY
	 +H2ecoHaQiXXIctGRNUzmPXTuZp3LX+P8KheDkP5vt/pfTujQ2MOpGPlpoyRf14kn8rzT
	 c4h8QlAFtANJB9ufx0EGLs2eLnrxYPe6spE2WwNJnSxkBbiouCwHKsH2EOowPe/BmuKGD
	 VZOTy6BAP6O8bCgPlp4RmqPQ8DXXZT7R4lbyvVP0QVhhQcc4ownnPDhCF1QI7qQGobOoz
	 QfnPA0nbaI16nHSC1+QPy4Kzsltf3Gd7VEjnJHD97x1gApZq0zukuz+79oNNIsbrMQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gpwZ0hRI;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD761606A330
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 17:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD761606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gpwZ0hRI
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c50a4a2132cso682675366b.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 09:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794936952; x=1795541752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ehDPQMS1CgUNGIZmcAtlpOqErWJKhsWUSWC8X9QQDz4=;
        b=gpwZ0hRIJ0pid42fGOtKDjmjtS+n1dGRHvIVeP0VJdOUEpwL+S3/+EMKHqIKY+8nVJ
         ZCwrjZnS3Do5vVK5klQrHrzBTZzCOAJZrqi04dVLBtdAjtfXksm2Icwsax73K9CaaP+D
         hgcdQwC/a37TF3bjUlYprcF1uLFRETn66xIXLjy+KiloUcJ0oFKBJudbT3nZjWkAL/CP
         nCt5p97NnObGwHllTgYBPz6W5H9AdOLDcAclWmvZ1VvyGJ2oz+wai3iKln/NO0QBZ7Zq
         EnT/k+XLPnRZkmlRRqU412/gDWlOzI31rmuU9H19XRhPH9aSIKh1xuKZalopbRABi7dN
         jnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936952; x=1795541752;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ehDPQMS1CgUNGIZmcAtlpOqErWJKhsWUSWC8X9QQDz4=;
        b=WYgaBVAvVtP0agci601eaK+ZlsW4RldtJ21b75sPcn3Vjb9Xu/8kiswqq8QtKgcof9
         I3EzCYMl3+JCKlsNVSFJdfW5is5nz+Jy9EZk4jDjO6vFo65aXX0VE8MeS3Aaq5VWXDkH
         W6UHfkdfukjDw5l6FqHB+hKqjELZrikKz0DXokOD4NOjVoskCRCuUwtNZhlZVO8/kz7z
         EzvuPWceULzqN/JPX+MlIqwpuItC/ZY/uyYeBdaU6o7gc/CT8Fcery/V6rWUiSt3ID0Q
         gvzYuoCMxwMmREU66IYPPDNvDfvjF7CjsylBpZ5OCKfAhYEuL8OUwc0VRdE6PBqgE0F2
         HT1w==
X-Forwarded-Encrypted: i=1; AL+hErGszzn/25bVvS9u96lq4RNyuFgMnpQIYZ+u4y8qgUTjfIoujAwZIOwAcc0yRueRjAFIPEMulbDtqQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Rj2LIkbYyTkb6CWaUDPPNrbq0rbXcrYJmA0YNTsIue2Cxa0uu
	YNr9Ali7NWr5oVHqJ/vDcdx0Ru/18E7zq3wG7h57Ppxu2XXSMySGsQc=
X-Gm-Gg: AYBFou3kcX13gqQ+v5H2HlZJ32oIgkg5atD+L9gZbb2/ngcLDN6nPp8+FqmbiRGAQcK
	SQ3b2XSeN0kxxPNDP5QuhRFGDW7kN3Maj3CCF8bM5qIh22E/zwo7L0ykM9YaMGQVQazrr3tNLi0
	zRjRhk9e1E4cDEqiMd0G9C+PWWGloHEjGV3BbUBLT5jW34dE0fQ6gwobBUNfIe8/af/3W6dHGUD
	9TqgSmqm/nGV1Hrnnw0xWJ1VdSRVq0RiPJCLDzCQuanYR5yeoIUlWB7GoDTehkEP9gfmQsxBk2E
	agIopUgwS3j8FyzmgzsMkbR4k5sz92orb60Xo4muTM7VJ7/FJx9zsalmAfubHvkifLHUicjTvOz
	z+zrbaqLthlKbPYTlO3ye7kiN41Ba1G85VZzpftlOeX+JEs0pcOrirftHmAVMXfybcL/DS2+KsR
	iCNIpLB5/wAf5sMJRwxLVMbxSof1WVvtaxD3oR1kQhzwN7LNNkow12RyMyD2aydNGlbTEf+mTDs
	dBgMWE/eDHxDOh6RJZ1WcioCZFc5+/JTZd9bROW0LeLYCbI62vTKJXZR4KLjyAVSvYZznbr/1fx
	qQ3eLQFttgQ9cQmK63Qs5VGmDhHZHG/RpskVkpk2fuKBgDhWLsg1aZjK/Yrbn8kK0KcwQkIbRJH
	bYrGGHDYmDN1/l65Iw4hu//Dbvw==
X-Received: by 2002:a17:906:794c:b0:c41:7e99:c6c2 with SMTP id a640c23a62f3a-c5096409d32mr1211919466b.44.1794936951974;
        Tue, 17 Nov 2026 09:35:51 -0800 (PST)
Received: from sohrab-omarchy.fritz.box (2a02-a44e-4ae7-1-c0e-6d5a-8ae2-915.fixed6.kpn.net. [2a02:a44e:4ae7:1:c0e:6d5a:8ae2:915])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510ca049c7sm6863166b.20.2026.11.17.09.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:35:51 -0800 (PST)
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
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm6125: Add cpufreq-hw node
Date: Tue, 17 Nov 2026 18:35:44 +0100
Message-ID: <20261117173547.1656090-1-majidhhdri@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <a3cbbfa897e960db0d671098be710032@mainlining.org>
References: <a3cbbfa897e960db0d671098be710032@mainlining.org>
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

thanks for the review, and for your answer on the cover letter. Both
mails reached me but neither shows up on lore, so I am answering both
here and quoting the relevant parts.

On 2026-11-16 14:41, Barnabás Czémán wrote:
>> +			reg = <0x0 0x0f521000 0x0 0x1000>,
>> +			      <0x0 0x0f523000 0x0 0x1000>;
> If you check the available sources SM6125 is different from SM6115 the
> size is 0x1400 instead of 0x1000.

You are right. The downstream trinket device tree has 0x1400 for both
regions; I took 0x1000 over from sm6115.dtsi. I will fix that in v2.

>> +			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gcc GPLL0_OUT_EARLY>;
> There is no proof GPLL0_OUT_EARLY is related to cpufreq, the driver
> using the clocks for getting the initial rate from them, it is working
> because this clock have similar rate but i am not sure it is logically
> correct to bind a clock without proof it is related. That is why i
> have made changes in the driver to make the clocks optional.

Agreed that downstream does not tell us where the 300 MHz row comes
from; it has OSM_INIT_RATE and XO_RATE as constants. But that is the
same file and the same constants for every SoC it serves, and the
mainline binding still requires both clocks ("XO Clock", "GPLL0 Clock")
for all of them, SM6115 included. I followed that:

- SM6115 uses <&gcc GPLL0>, which in gcc-sm6115 is the alpha PLL
  itself. gcc-sm6125 has no index with that name; the PLL is
  GPLL0_OUT_EARLY, with OUT_MAIN and OUT_AUX2 as its /2 outputs. On my
  phone it runs at 600 MHz, so the driver's /2 gives the 300 MHz row.

- The mainline driver uses "xo" for every PLL row (xo_rate * lval), not
  only for the initial rate, so I think at least that one should stay a
  real clock rather than a constant in the driver.

So with the binding as it is today the DT in this series is what the
schema asks for, and a node without clocks would need a binding change
first. Whether the clocks should become optional for these SoCs is
something I would leave to Viresh, Konrad and Krzysztof.

From your mail on the cover letter (2026-11-15):
> Also i have added a new SoC data because SM6125 and SM6115 have less
> LUT entries (12) [2] and there are no throttling IRQs there.

That part I agree with, the trinket fixup in downstream is clear. On
laurel the generic data happens to stop at the repeated row before it
gets that far, but nothing guarantees that. Would you send your soc
data with lut_max_entries = 12 as a driver patch? It does not depend on
the clock question. Your branch as a whole already ran fine on laurel
(see my mail of 15 November), and once the patch is on the list I will
boot it on top of this series and reply with a Tested-by. If the
maintainers prefer that to go in first, or prefer your DT, I am fine
with either and will rebase or drop my cpufreq patch accordingly.

Thanks,
Majid
