Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795608176;
	b=cyHS11S83dg+7oQGnQKuX58J1aQQo/Lm3Iu/nEGTecZb1otGoCD73Vnn0DWH2fSPJ3JQ
	 9Buztrdou7Xh5iMvzJdlfwBdaF5Ci8qKXuUfwdyMnH5z62GJI5ne54TkYoT5SGw723npN
	 MXe05+JrvOOkQDzhkqJxf5DHrWzHg5h9EoHjRYoDriOP5yfwNVf5ftdrmX+J3fXry4/Jl
	 5cznyogw3D+dZ+LYL7YbMpimU8oHuDLlkgCsW+l4FHKocGWvtC911MGZ0G6zCqN8UX6iT
	 h+phzUBJEZmqFmxxQm6J1f6vaM+At+p5gaRSvR5XqYrGVFsodT23cUUwQJxEXWT25Hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608176;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=A9dlQGG/jzBvs7dH7czqRMGYMnw4r7omofK4BoXES8U=;
	b=0bnI1f9ftbXfi+Bujvkm4dolqp9mIVeQfudloEi7+/9/5X+65prLsvYop8d+j2Pqm8Tr
	 Hlxfzep+hK70YhsuuVw9TZzDJqGFHIKfD+pwcwaJugw6ARgfUUtgDmKKb8rLKOJW4Hqs/
	 1a4nLJGgD2gnheo6/jy/1FzVUZqWjjJZXalSvDmUTD7ApqvnHf07XZwmQj+0P/EmdUZr8
	 a/IW8t9Py4iTNUpWC0JFbXzYM8CnTOp803eOXbNWwjlE14wxpSRXw1LOvVIX44avot3mr
	 7WY7jSyeNWiDt1GBi3XMjavgG5kA1+s7l/DY8UipBV6PTnDmyB3DKlZUuWDJ35Qvu9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mhuwtsfP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FmP8qQzt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800C7606A321
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 12:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 800C7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mhuwtsfP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FmP8qQzt
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9metK796853
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 12:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A9dlQGG/jzBvs7dH7czqRMGYMnw4r7omofK4BoXES8U=; b=mhuwtsfPr5AGvE6p
	fwSfZvqeBdTl1/D1nhadjSBV1vUJNEhynUdpZiRx8rOflS6izzyVYmzOmsk6ipJz
	+xmsGByIzzA2UoBOa7dheLVvQc0p7l+mueaQo4A57u8YNeFANZXZ6uhFKSw/bbEm
	QenHMCxQlXL3MSO1k5gsnFFmgsfc6wTKkvYWvsmWzarD1Mlewyd5e4a+oXMtwBrY
	mZkWSjzUeFVMesXkiXpLKhQxAvq/3gSExl+K+1dBD7jg5at3vo9XWH4lAYyK3/ad
	2/CYM9kme/Kugl2vuur1/4/cxJOov4PHSTnExK+BVBuSKAfHfComNKZvM4whoJ73
	GFSFRg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5n6rtjnc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 12:02:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2f05b674e3eso41217145ad.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 04:02:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795608174; cv=none;
        d=google.com; s=arc-20260327;
        b=G5D01s1+KYGqh9cU0yG5PQ5kXNHxsUyl8b/khFg5KC/4srda2cowlRzycgMa0LkzHz
         AG/U/+GtlgBMODK4yRFe8QBwIORUIW1oOSumBtRbDms0MKsKRJSggBHfzRjkxK+dFRHo
         I3lD2H0uGw27dJqytXz87CHDxg6fovnF7/9bJRPOLqMGBietLrjkHJHePXJ5HxFlGXyJ
         rMiMpk4e+A9EJPqtGd9ASGvqZRTzESKluz0QtUoI6xUBNq4fKz6i10UQICwq0u20Xl6S
         qzxiXEJpC2Abrqn+CMQ5RhMk5mAkzDKF7kx6Er+KS/ZlbHmzOkHmuvtRDyh/JrcWAd25
         paHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A9dlQGG/jzBvs7dH7czqRMGYMnw4r7omofK4BoXES8U=;
        fh=zZnWbGHFSGMhWODaxFQJ6ZaSIBAsGA73zR2ZqZRg+xI=;
        b=jIMdRKbza/bHqPt8USt5dc3EbwFmM9jjy3jEL2EEfkyGquaPzEr4f6gH6Nu0JNxDT4
         yJN18l7XQRMkDIEp56ptBYiwH08sWcYLIjDTdTBPVxhv0+O9fOoI2DIZ5LHZlZ+NxdHi
         CO1wb/jkhk6h20GJuVmTIdGZ9NsV0IpZxm+lslq5PqHvi8J/r4D01tJS17cPibYScX2v
         lm7fsfXfzxgI6gK+HLtojHXnnFiYN1RhmsB+K6TGRsypIQ0oDwlR13eWLYz8GTHRv9IY
         nBHRhvEvhVcMTxwG1MCULuem2OKpZjqoGQuZU2RTV9ce4R24OwM/nCMEGWusU8TeWICm
         jDiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795608174; x=1796212974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A9dlQGG/jzBvs7dH7czqRMGYMnw4r7omofK4BoXES8U=;
        b=FmP8qQztCIF6R+95D9bkVvZcGVN7bNvzrSan01M2jzOb1AM5Wp1xkCamlUf0gHtAm+
         GbqW3H2RTaLy+9npsRfHkkVgi9NOJwZgmD6g9Fz6Dbelr9O0cmcwlyOvc1e5FQpjDuIA
         CEp7KIeYkXKwsU7fOuLLI+F6mMpAihPcgbSLFV5GLHDWbEjDyLD1Y48DtPB+SY6hp79K
         DN7YUGoHsPrfEF2sePuTPmCP+b+jMu9Ewe/9KG0I6qmxuBQlbO/a7wbErz9t21hgJkwz
         NyNMokMmtGndUJJig4CqYotINq6jvxs5mQWJUEawGiJ7+0q4NMvv8DIq/PubWQbcLgEw
         yu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795608174; x=1796212974;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A9dlQGG/jzBvs7dH7czqRMGYMnw4r7omofK4BoXES8U=;
        b=MCUHPyUN3u7GS2aB3cvbfZNBYytekGjPwSMIZj4RjrKpAN+p7CbP25TmvLlqmn4cw7
         bq9rRq5+KINImMmA10hHeH7qgmTxuXhTk+1/qRZGw/y9kanfdQrHa04hURei+A9pYFqM
         0oFxTe/mrC0NDnmK4DMV6x6jKlKijq5wJpax+mGDLmoAXSUstiewyWiqrBje6Wj9N95g
         7ibSdtQWKeciqqTKUsGMX3cAw/pkDVuNp/Yo8znbQJgCOFBQPwh7AZ8T6jtWxOM0k6Zj
         PK1dZ5LYiHtyOGPLpWjJPk9LrAwdy0BNR5k7ztetINIiDl69rqiPrGn/fZW3UT5/YSMj
         7IKw==
X-Forwarded-Encrypted: i=1; AL+hErHzHyiHfPezlcm18LCbMKuBWvkpdWmCwCFQOl39hAjiNBegp4fMsis7T89xVlS9kt+bqYf1rlew9Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z96hp+iVoeyGSWa/JueiRCs7n/GvzMJuwVt7U8mjLhqdN2LxBBc
	Vo+ByyY2R+qWJFSqROMDKIAhA0TOA7Amqi/TaO33YUlPe987d1QEZ3j02xII0jLj8pku2qk+Y77
	4U3X1KNx5oFa4hzjDd6+ugjZwU2Xob2LcEWhgqmoKQ9gdz/f4DxBtYDYrEa8VlDPXaqL+8spvPc
	deYcs7Xc3BZEgvvcfbSuRuk4i5MrQcYfegGgxF
X-Gm-Gg: AZFdTZceP3hOsrK3s+D2BATD1wvHL0HRMIYZK2UYNNbdNtmilOzg2X3Y7HJL5UeOKlh
	ujvxcpuGD/8sp8xB8oo7G9AK5zcm/5EII9h7dWUQjG4zYa3r9MM4pCZ3z/fOQtddjhMsR+9VW+Z
	jCwDTdrrqGm9GnYgfOXsaTqD6yljGIidmHtdRXsHvXcwVDpswYLiIE9WNzfw==
X-Received: by 2002:a17:902:ecc4:b0:2f0:3c38:9133 with SMTP id d9443c01a7336-2f0c5f91aa0mr49108825ad.43.1795608173746;
        Wed, 25 Nov 2026 04:02:53 -0800 (PST)
X-Received: by 2002:a17:902:ecc4:b0:2f0:3c38:9133 with SMTP id
 d9443c01a7336-2f0c5f91aa0mr49108355ad.43.1795608173161; Wed, 25 Nov 2026
 04:02:53 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-xg6846b-bcmbca-xrdp-reset-v6-0-bf2104a25095@kernel.org> <20261122-xg6846b-bcmbca-xrdp-reset-v6-3-bf2104a25095@kernel.org>
In-Reply-To: <20261122-xg6846b-bcmbca-xrdp-reset-v6-3-bf2104a25095@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 13:02:40 +0100
X-Gm-Features: Aa3M54qQSa1-iu_NQ3Vu-hbUnlJTISMBYoMz5cyhIaJ8PjDAWNwA46R1m2mVESg
Message-ID: <CAPx+jO9Q-kSftm2iZn+5LJ84G2ANRO5HyxGmUZ6RAySZf5ZnGQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] pmdomain: bcm: Add BCMBCA PMB power domains
To: Lee Jones <lee@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        William Zhang <william.zhang@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
        Ulf Hansson <ulfh@kernel.org>,
        Benjamin Larsson <benjamin.larsson@genexis.eu>, mfd@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0NyBTYWx0ZWRfX5E7yhbZ2nRf/
 YyGMFGXnC7Qw6Pk5KUQcgOxMYEDaWkvtuKWNHQEGyEeIruWb0jLtq1aQCCK+JQJlDQeyKoVj3Jz
 QuncTuMpV2xWMS1GonVbHk7IiUc+Iur7mm9VzFrY+41uBRT7Ep7ynGGvuutnMbdK2K/sdVzPXp+
 rQhqbSgMg79sgRN1unpTYyFKj3csS6eaykZWfD3JoWwjM8TBYuuzE1iOHXjyEjOZEfP9zGtVNoC
 EBD2kDZButd306jdu2aLUWNrCS1jOPd3BCChyl7HaU/cD3nhWKAZLoDgNSW5qqrscX1h2wIlspb
 6mScAbayKmPxJco3PYIsgjm02uP+vzJHgYcK8dNSt9z2g/3M+QnTHZJFV2VoA/OV+UUyoI9nXns
 yy609KQYhglqFycOXMZXWchXWlG0qlAWJotN1dBwN/jkEfZza3L5yICmqOm7xORnTmxjs3FRhD+
 nT3XJsOmtY9w5rzIzAw==
X-Authority-Analysis: v=2.4 cv=Voa2kO2n c=1 sm=1 tr=0 ts=6b06ce6e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=K0o9GnANF0TDe8bVdfEA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: WDxhkYEuPdR_MVzLB9Ug-DQxOhWFaYGR
X-Proofpoint-ORIG-GUID: WDxhkYEuPdR_MVzLB9Ug-DQxOhWFaYGR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0NyBTYWx0ZWRfXzCsvJCzRZKq1
 TA6UippRTY2I0zHBrnUeRTejo3mqtDJv8TeTqqnnh7lbRnVM3+3ZE4hQ1cBy4PW1BB4+U+y0VEj
 pFs2mAZo4gq0Hc9OI8wuMMqRHh3s8MY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250047

On Sun, Nov 22, 2026 at 9:32=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
>
> Implement BCM6846 BPCM power domains.
>
> Group XRDP, its three Runner cores and WAN in vendor xrdp_pmb[] order,
> so consumers can power the complete packet engine before resetting it.
>
> Also expose peripheral, memory, USB and PCIe domains. Keep the peripheral
> and memory domains always on; exclude CPU and PLL blocks with different
> register layouts.
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>

If Lee wants to route this via his tree, that's perfectly fine by me.
Otherwise, I can pull an immutable branch with the DT changes as well,
doesn't matter, just let me know.

Reviewed-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  MAINTAINERS                       |   1 +
>  drivers/pmdomain/bcm/Kconfig      |  10 ++
>  drivers/pmdomain/bcm/Makefile     |   1 +
>  drivers/pmdomain/bcm/bcmbca-pmb.c | 279 ++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 291 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1857e720ce3a..cfe64722a708 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5449,6 +5449,7 @@ M:        Linus Walleij <linusw@kernel.org>
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
>  F:     drivers/mfd/bcmbca_pmc3_pmb.c
> +F:     drivers/pmdomain/bcm/bcmbca-pmb.c
>  F:     include/dt-bindings/clock/brcm,bcm6846-pmb.h
>  F:     include/dt-bindings/power/brcm,bcm6846-pmb.h
>  F:     include/dt-bindings/reset/brcm,bcm6846-pmb.h
> diff --git a/drivers/pmdomain/bcm/Kconfig b/drivers/pmdomain/bcm/Kconfig
> index b28c9f6d256b..fb0c2baea156 100644
> --- a/drivers/pmdomain/bcm/Kconfig
> +++ b/drivers/pmdomain/bcm/Kconfig
> @@ -31,6 +31,16 @@ config BCM_PMB
>           This enables support for the Broadcom's PMB (Power Management B=
us) that
>           is used for disabling and enabling SoC devices.
>
> +config BCMBCA_PMB_POWER
> +       bool "Broadcom BCMBCA PMB power domains"
> +       depends on MFD_BCMBCA_PMB
> +       depends on PM
> +       default MFD_BCMBCA_PMB
> +       select PM_GENERIC_DOMAINS
> +       help
> +         Provide power domains for BCM6846 blocks through the shared PMC=
3
> +         Power Management Bus regmap, including the XRDP packet processo=
r.
> +
>  config BCM63XX_POWER
>         bool "BCM63xx power domain driver"
>         depends on BMIPS_GENERIC || (COMPILE_TEST && OF)
> diff --git a/drivers/pmdomain/bcm/Makefile b/drivers/pmdomain/bcm/Makefil=
e
> index 6bfbe4e4db13..ed8a1d3d4c10 100644
> --- a/drivers/pmdomain/bcm/Makefile
> +++ b/drivers/pmdomain/bcm/Makefile
> @@ -3,3 +3,4 @@ obj-$(CONFIG_BCM_PMB)                   +=3D bcm-pmb.o
>  obj-$(CONFIG_BCM2835_POWER)            +=3D bcm2835-power.o
>  obj-$(CONFIG_BCM63XX_POWER)            +=3D bcm63xx-power.o
>  obj-$(CONFIG_RASPBERRYPI_POWER)                +=3D raspberrypi-power.o
> +obj-$(CONFIG_BCMBCA_PMB_POWER)         +=3D bcmbca-pmb.o
> diff --git a/drivers/pmdomain/bcm/bcmbca-pmb.c b/drivers/pmdomain/bcm/bcm=
bca-pmb.c
> new file mode 100644
> index 000000000000..9a631b7b0360
> --- /dev/null
> +++ b/drivers/pmdomain/bcm/bcmbca-pmb.c
> @@ -0,0 +1,279 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Broadcom BCM6846 BPCM power zones, accessed through the PMC3 PMB regm=
ap. */
> +
> +#include <linux/bits.h>
> +#include <linux/mfd/bcmbca-pmb.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/power/brcm,bcm6846-pmb.h>
> +
> +/* BCM6846 BPCM zone control, in PMB words, with eight words per zone. *=
/
> +#define BCM6846_ZONE_CONTROL(zone)     (32 + (zone) * 8)
> +#define BCM6846_ZONE_DPG_EN            BIT(8)
> +#define BCM6846_ZONE_POWER_DOWN                BIT(9)
> +#define BCM6846_ZONE_POWER_UP          BIT(10)
> +#define BCM6846_ZONE_MEM_POWER         BIT(11)
> +#define BCM6846_ZONE_RESET             BIT(12)
> +#define BCM6846_ZONE_POWER_OFF         BIT(25)
> +#define BCM6846_ZONE_POWER_ON          BIT(26)
> +
> +struct bcmbca_pmb_power_block {
> +       u8 bus;
> +       u8 device;
> +       u8 zones;
> +};
> +
> +struct bcmbca_pmb_power_data {
> +       const char *name;
> +       const struct bcmbca_pmb_power_block *blocks;
> +       unsigned int num_blocks;
> +       unsigned int flags;
> +};
> +
> +struct bcmbca_pmb_power_domain {
> +       struct generic_pm_domain genpd;
> +       struct device *dev;
> +       struct regmap *regmap;
> +       const struct bcmbca_pmb_power_data *data;
> +};
> +
> +static const struct bcmbca_pmb_power_block bcm6846_periph[] =3D { { 0, 0=
, 4 } };
> +static const struct bcmbca_pmb_power_block bcm6846_memc[] =3D { { 1, 8, =
1 } };
> +static const struct bcmbca_pmb_power_block bcm6846_usb20[] =3D { { 1, 10=
, 4 } };
> +static const struct bcmbca_pmb_power_block bcm6846_pcie0[] =3D { { 0, 18=
, 1 } };
> +static const struct bcmbca_pmb_power_block bcm6846_pcie1[] =3D { { 0, 19=
, 1 } };
> +
> +/* Power up XRDP, three Runners, then WAN. */
> +static const struct bcmbca_pmb_power_block bcm6846_xrdp[] =3D {
> +       { 1, 12, 3 }, { 1, 14, 1 }, { 1, 15, 1 }, { 1, 16, 1 }, { 1, 11, =
3 },
> +};
> +
> +static const struct bcmbca_pmb_power_data bcm6846_domains[] =3D {
> +       [BCM6846_PD_PERIPH] =3D {
> +               .name =3D "periph",
> +               .blocks =3D bcm6846_periph,
> +               .num_blocks =3D ARRAY_SIZE(bcm6846_periph),
> +               .flags =3D GENPD_FLAG_ALWAYS_ON,
> +       },
> +       [BCM6846_PD_MEMC] =3D {
> +               .name =3D "memc",
> +               .blocks =3D bcm6846_memc,
> +               .num_blocks =3D ARRAY_SIZE(bcm6846_memc),
> +               .flags =3D GENPD_FLAG_ALWAYS_ON,
> +       },
> +       [BCM6846_PD_USB20] =3D {
> +               .name =3D "usb20",
> +               .blocks =3D bcm6846_usb20,
> +               .num_blocks =3D ARRAY_SIZE(bcm6846_usb20),
> +       },
> +       [BCM6846_PD_XRDP] =3D {
> +               .name =3D "xrdp",
> +               .blocks =3D bcm6846_xrdp,
> +               .num_blocks =3D ARRAY_SIZE(bcm6846_xrdp),
> +       },
> +       [BCM6846_PD_PCIE0] =3D {
> +               .name =3D "pcie0",
> +               .blocks =3D bcm6846_pcie0,
> +               .num_blocks =3D ARRAY_SIZE(bcm6846_pcie0),
> +       },
> +       [BCM6846_PD_PCIE1] =3D {
> +               .name =3D "pcie1",
> +               .blocks =3D bcm6846_pcie1,
> +               .num_blocks =3D ARRAY_SIZE(bcm6846_pcie1),
> +       },
> +};
> +
> +static unsigned int bcmbca_pmb_zone_reg(const struct bcmbca_pmb_power_bl=
ock *block,
> +                                       unsigned int zone)
> +{
> +       return BCMBCA_PMB_REG(block->bus, block->device, BCM6846_ZONE_CON=
TROL(zone));
> +}
> +
> +static int bcmbca_pmb_zone_off(struct bcmbca_pmb_power_domain *pd,
> +                              const struct bcmbca_pmb_power_block *block=
, unsigned int zone)
> +{
> +       unsigned int reg =3D bcmbca_pmb_zone_reg(block, zone);
> +       unsigned int value;
> +       int ret;
> +
> +       /* Request power-down and cancel power-up. */
> +       ret =3D regmap_write_bits(pd->regmap, reg,
> +                               BCM6846_ZONE_POWER_DOWN | BCM6846_ZONE_PO=
WER_UP,
> +                               BCM6846_ZONE_POWER_DOWN);
> +       if (ret)
> +               return ret;
> +
> +       return regmap_read_poll_timeout(pd->regmap, reg, value,
> +                                       value & BCM6846_ZONE_POWER_OFF, 1=
0, 10000);
> +}
> +
> +static int bcmbca_pmb_power_on(struct generic_pm_domain *genpd)
> +{
> +       struct bcmbca_pmb_power_domain *pd =3D container_of(genpd, typeof=
(*pd), genpd);
> +       const struct bcmbca_pmb_power_data *data =3D pd->data;
> +       /* One bit per zone, tracking only zones changed by this attempt.=
 */
> +       u32 changed[ARRAY_SIZE(bcm6846_xrdp)] =3D {};
> +       const struct bcmbca_pmb_power_block *block;
> +       unsigned int i, zone, reg, value, mask;
> +       int ret;
> +
> +       for (i =3D 0; i < data->num_blocks; i++) {
> +               block =3D &data->blocks[i];
> +               for (zone =3D 0; zone < block->zones; zone++) {
> +                       reg =3D bcmbca_pmb_zone_reg(block, zone);
> +                       ret =3D regmap_read(pd->regmap, reg, &value);
> +                       if (ret)
> +                               goto rollback;
> +                       if ((value & BCM6846_ZONE_POWER_ON) &&
> +                           !(value & BCM6846_ZONE_POWER_DOWN))
> +                               continue;
> +
> +                       changed[i] |=3D BIT(zone);
> +                       /* Enable dynamic gating, memory power control an=
d block reset. */
> +                       mask =3D BCM6846_ZONE_POWER_DOWN | BCM6846_ZONE_D=
PG_EN |
> +                              BCM6846_ZONE_POWER_UP | BCM6846_ZONE_MEM_P=
OWER |
> +                              BCM6846_ZONE_RESET;
> +                       ret =3D regmap_write_bits(pd->regmap, reg, mask,
> +                                               mask & ~BCM6846_ZONE_POWE=
R_DOWN);
> +                       if (ret)
> +                               goto rollback;
> +                       ret =3D regmap_read_poll_timeout(pd->regmap, reg,=
 value,
> +                                                      value & BCM6846_ZO=
NE_POWER_ON, 10, 10000);
> +                       if (ret)
> +                               goto rollback;
> +               }
> +       }
> +       return 0;
> +
> +rollback:
> +       dev_err(pd->dev, "%s power-up failed at bus %u device %u zone %u:=
 %d\n",
> +               data->name, block->bus, block->device, zone, ret);
> +       /* Preserve zones left powered by firmware or an earlier attempt.=
 */
> +       for (i =3D data->num_blocks; i-- > 0;) {
> +               block =3D &data->blocks[i];
> +               for (zone =3D block->zones; zone-- > 0;)
> +                       if ((changed[i] & BIT(zone)) && bcmbca_pmb_zone_o=
ff(pd, block, zone))
> +                               dev_err(pd->dev, "%s power-up rollback fa=
iled\n", data->name);
> +       }
> +       return ret;
> +}
> +
> +static int bcmbca_pmb_power_off(struct generic_pm_domain *genpd)
> +{
> +       struct bcmbca_pmb_power_domain *pd =3D container_of(genpd, typeof=
(*pd), genpd);
> +       const struct bcmbca_pmb_power_data *data =3D pd->data;
> +       unsigned int i;
> +       int ret;
> +
> +       /* Powering down zone zero powers down the whole block. */
> +       for (i =3D data->num_blocks; i-- > 0;) {
> +               ret =3D bcmbca_pmb_zone_off(pd, &data->blocks[i], 0);
> +               if (ret) {
> +                       /* genpd keeps the domain logically on when power=
-off fails. */
> +                       if (bcmbca_pmb_power_on(genpd))
> +                               dev_err(pd->dev, "%s power-off recovery f=
ailed\n", data->name);
> +                       return ret;
> +               }
> +       }
> +       return 0;
> +}
> +
> +static int bcmbca_pmb_power_is_off(struct bcmbca_pmb_power_domain *pd, b=
ool *off)
> +{
> +       const struct bcmbca_pmb_power_data *data =3D pd->data;
> +       unsigned int i, zone, value;
> +       int ret;
> +
> +       *off =3D false;
> +       for (i =3D 0; i < data->num_blocks; i++) {
> +               for (zone =3D 0; zone < data->blocks[i].zones; zone++) {
> +                       ret =3D regmap_read(pd->regmap, bcmbca_pmb_zone_r=
eg(&data->blocks[i], zone),
> +                                         &value);
> +                       if (ret)
> +                               return ret;
> +                       if (!(value & BCM6846_ZONE_POWER_ON) || (value & =
BCM6846_ZONE_POWER_DOWN))
> +                               *off =3D true;
> +               }
> +       }
> +       return 0;
> +}
> +
> +static int bcmbca_pmb_power_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct regmap *regmap =3D dev_get_regmap(dev->parent, NULL);
> +       struct bcmbca_pmb_power_domain *domains;
> +       struct genpd_onecell_data *onecell;
> +       unsigned int i;
> +       bool off;
> +       int ret;
> +
> +       if (!regmap)
> +               return -ENODEV;
> +
> +       onecell =3D devm_kzalloc(dev, sizeof(*onecell), GFP_KERNEL);
> +       if (!onecell)
> +               return -ENOMEM;
> +       onecell->num_domains =3D ARRAY_SIZE(bcm6846_domains);
> +       onecell->domains =3D devm_kcalloc(dev, onecell->num_domains,
> +                                       sizeof(*onecell->domains), GFP_KE=
RNEL);
> +       domains =3D devm_kcalloc(dev, onecell->num_domains, sizeof(*domai=
ns), GFP_KERNEL);
> +       if (!onecell->domains || !domains)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < onecell->num_domains; i++) {
> +               struct bcmbca_pmb_power_domain *pd =3D &domains[i];
> +
> +               pd->dev =3D dev;
> +               pd->regmap =3D regmap;
> +               pd->data =3D &bcm6846_domains[i];
> +               pd->genpd.name =3D pd->data->name;
> +               pd->genpd.flags =3D pd->data->flags;
> +               pd->genpd.power_on =3D bcmbca_pmb_power_on;
> +               pd->genpd.power_off =3D bcmbca_pmb_power_off;
> +               ret =3D bcmbca_pmb_power_is_off(pd, &off);
> +               if (ret)
> +                       goto remove_domains;
> +               /* Always-on domains must be fully powered before genpd i=
nitialization. */
> +               if (off && (pd->data->flags & GENPD_FLAG_ALWAYS_ON)) {
> +                       ret =3D bcmbca_pmb_power_on(&pd->genpd);
> +                       if (ret)
> +                               goto remove_domains;
> +                       off =3D false;
> +               }
> +               ret =3D pm_genpd_init(&pd->genpd, NULL, off);
> +               if (ret)
> +                       goto remove_domains;
> +               onecell->domains[i] =3D &pd->genpd;
> +       }
> +       ret =3D of_genpd_add_provider_onecell(dev->of_node, onecell);
> +       if (!ret)
> +               return 0;
> +
> +remove_domains:
> +       while (i-- > 0)
> +               pm_genpd_remove(onecell->domains[i]);
> +       return dev_err_probe(dev, ret, "failed to register PMB power doma=
ins\n");
> +}
> +
> +static const struct of_device_id bcmbca_pmb_power_of_match[] =3D {
> +       { .compatible =3D "brcm,bcm6846-pmb-power" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, bcmbca_pmb_power_of_match);
> +
> +static struct platform_driver bcmbca_pmb_power_driver =3D {
> +       .probe =3D bcmbca_pmb_power_probe,
> +       .driver =3D {
> +               .name =3D "bcmbca-pmb-power",
> +               .of_match_table =3D bcmbca_pmb_power_of_match,
> +               .suppress_bind_attrs =3D true,
> +       },
> +};
> +builtin_platform_driver(bcmbca_pmb_power_driver);
> +
> +MODULE_DESCRIPTION("Broadcom BCMBCA PMB power domains");
> +MODULE_LICENSE("GPL");
>
> --
> 2.56.1
>
