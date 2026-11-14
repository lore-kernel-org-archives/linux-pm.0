Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794655525;
	b=fg9xiRjQHosZaWmaZUymyq6Hx2FSyXa+eLx+AdKD/TOCiEV1T8+0y+yFXzRYKqND5hNj
	 ylHIYiqC32sq4o50J9YwTInnrIe/aSnXaMJcGkU2mn8+El2pR1FO9HoadPKTtkvQPIFOe
	 Lzy8ZvjnW+mXMwjeWlYck64M2xWv13p9qLG7gWHcO0Ju/Gph4qbhH1wiJ0tv9j6aGprIo
	 g6J2NXTNUQtk7Ww90/KZng1+5Az63gI0Lz4LmOM79yHqTb5bd8rLHo6uPhuEozE4ccHyn
	 bawQny2zuXflqBWu4URZIe0CZ4gfvx5C27M1eXflO7NTGdaqAeraImdDw62xNhQSRNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655525;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0GF8consLzRBXm7z8P0uLlC0IllouGEyy162epmHymA=;
	b=FrzvXl7T+hAJ0K2Ix8B2dRIDvs5LnhFttNIXoSGosLSwZANMRwTFF+3mVdDqGfh5a8Ds
	 RfoEWNqVkk0I8TXyKTjslnb2qukcohVF3/VZLBMjPr7mAfrUvgPxaIO1CnGy/JIi/0d5F
	 ponBOCh3tdowDlNYfkYwsS0Xo9pXNdZgPYzIj83MYCKJqNg3m6IeXb2X95Df2IR6NJ1bm
	 QVqHV7Fxg+JPHAaltRV+Dxwf0lhTHpC51DeZuUUVFnOXcBsF8DndKcuugol8J/LuJ4+ig
	 wbJS7/38vWsE/9ef0Sy7le/FrQJOM2feUc+G3axECeJ4ATV45GQLvgX+wQwL2AwNwjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QXgSS9Rd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gaRin3UN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28818606A32D
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28818606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QXgSS9Rd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gaRin3UN
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9wOlC2055206
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0GF8consLzRBXm7z8P0uLlC0IllouGEyy162epmHymA=; b=QXgSS9Rda3Kv+k9P
	gzqe3kFPN/uWfUmI7OADtIldqWZDD+slzWtMPC/6dTDxMoFuvQd0N7gxLeJPQzVL
	Gx34zKckA+LaBZxTE6Es8GYa5XxLVKKy317T8OsxSwsgfLMrwNDpbiV3RWna2uNQ
	Q633p0yhEKggDTX7xY11chbADeulqMByJf3qChWKnbWHcJGNHise6+F6CcEqaBXO
	v7Rji8HvkddJBsZBOsexcXlNKMu6jOxc8MdeQ2/nDx6+sCsRyufemJ7r0Jkq9hAj
	v0Ns66yN3GBHSutZp6sEOu6Enxd5pUElkn+mYUsqEfaGQv8mIwxQ2sA9HyaUMbFB
	AVbl5A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmc8k2s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:25:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ae72da2f57so2971866a91.1
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 03:25:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794655524; cv=none;
        d=google.com; s=arc-20260327;
        b=H7T9Z+e33YQmv5NdKTDN3d2ITP2IFHkGDFpV1aVn0wsAosF4+GnwcA22amX/v2NBPZ
         zvNwfPQirHe16CujNeODGekM2iKb3hfz7mXA2+HXYYRYrnjULfbL8trOspovbkKvBmEh
         ZunYJ7aMV70ixLf+/fRqyHm+pxgyycN3oeTTfHgCAg7QBaZ8pfEpSLfa3Cr8qngtOgPD
         LX0h1itl51hnaUQ3amIMBvwwv8yXYBFSyMwcDiat92mfuARs+aZXHNzxgAqcfOnS7FKw
         hPrDhqiBhfA3czuxfSWc70apQoBoWR3axyHnbQo0vfWP5ksZLhJ7JLAHN3BXsqkzDe1d
         0elA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0GF8consLzRBXm7z8P0uLlC0IllouGEyy162epmHymA=;
        fh=TbQ29hjes5XB9HBpOCWKBMhbZ+5dXPKvNOd47k+E75I=;
        b=Fvd7afDRf4SGzyvZCO+rWQOhMDnPdrpHrLqJSlR3o7J6r3reyn9c8sHDg/kdPo/7uJ
         Hl10H4B+/sgj41pHmYvC9pWQ7E0qJybELvuH3xIA23ZV4iH17SXI+8kDweWlKu+qrv/o
         mc/dTeK1IJ6iuseYf63sHkmChj6XeZWi1PU2rm4fnHbe50cVayCRpSqthsxlC2oTnzcf
         oiLTsys10HJ80LoHXMl7X5S7x2WNCwn6sB5F9umczuggBOYJyqjW45Cj+SOWvoPxR0fO
         2lkqDML96lnx5bMDmkin6qH8KPxsVucnghyVCHSJYCxn8MsBWCDHH0Fg0ZVLOHkMG/vk
         +XPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794655524; x=1795260324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0GF8consLzRBXm7z8P0uLlC0IllouGEyy162epmHymA=;
        b=gaRin3UNqXhDB/YURAsg1NbNfWKgh1yehCZFMlaT8YX9rr5tZsfT7Dih5G0GvWJOSm
         xvWb4tmWJAOEb5bHlGg56+NNS9q+LgULUCyLExKDiT8NhgafE+A2c87HJ16ZE7KS4Ypw
         iRv07UvoK2l9mhasYV/lsSSjbxeqByM1+YDJDF0AXu4ygUD0FWum+310aYxT4d07jPMY
         SqKIveZNUmECHZYtQtmW53BJtAo52x5Il/3ROs1nHJqGnP4VRVq1zipQXzv4IFf0eeZD
         xiu9xmBhFKXYP+JKhzZm9XsSZSZKeJu+xFB2j67q0HlAu3L7icoArOYDch6dRql4lSdh
         M+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655524; x=1795260324;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0GF8consLzRBXm7z8P0uLlC0IllouGEyy162epmHymA=;
        b=Tj5nZOhirzrttQ+riPLRLS4oCMH7W2jlcS7f+i5LSuTs+yntqAHE8Bi+zkVGbsEDfh
         Ui1CBKKLQGUjoHUNsVbzIZQJby0FFang+k7VUnWt0ujrqWoLcQQEDFTe+KIBjWw7izwS
         t7JVPgXj1AUqAA2p+AvrcBV4jBr/X7HJJc/2U+kSk7BBxPubeLqq7ga3ZpFGG+GYiZFh
         fxMzJuddwF1SuIeOcx+JrcEShLjkUmmnWhb+lIFwVm/nZR7zgETMpUPP+bKojE0hc9p9
         uuBLCULNfJdZv7JJgQ7fh+fwBjCMrB2PFU0u2352r4sY0Q8elksWEH4hNZrtE0n2Bz7v
         kDrw==
X-Forwarded-Encrypted: i=1; AL+hErF+48sf1QUnpMPCVW4m6UbWUk2f1yXN1H39xoUiO7wQ1erBiWyrXqEV3igyz8q6TJraFwRvFe3y/w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/c1s92SpBZsLFGw3DEVfysHzchVq/eEBJzh5Jp/B80/3HH+wsZ
	2ZkOZknYi9hla7ewZ6ytU5cgnMAoXFPOigQTQY+AHtiVFD53NB1cZrEPrryjV/ytFbCy6MfbNoh
	1bUdNh5Uz/vmPQ9V/rVC6Cv6i6kv6dukedrfOIABzuD0qqXOSjr+CeCZeN1GRTRuWxsCG8AHJDo
	mYUIh038RWpFXAGxKSwJ6KkqB2KHyoUa3L6Vn2
X-Gm-Gg: AYBFou0BiFr53atRaSk4mmRNERN/Yv3a86xwoo+K9SvR9q7pqCG+pzWoM+mSXs+9rLE
	fI/akp/jPrwE+uoV1zVViE1Q/AQ5dOcVqsw+gHXCaIO0s79/UcTjP4oik0bgTpQ7czEsywErFGs
	BVH+YbqIXTlAH6ks0ozlhvEO8jESvUcL2n2yEgU2dLch1N1XIDAQvKXkAy9g==
X-Received: by 2002:a17:90a:e187:b0:3ac:9c37:9426 with SMTP id 98e67ed59e1d1-3b1b0ba53d2mr5901017a91.31.1794655523672;
        Sat, 14 Nov 2026 03:25:23 -0800 (PST)
X-Received: by 2002:a17:90a:e187:b0:3ac:9c37:9426 with SMTP id
 98e67ed59e1d1-3b1b0ba53d2mr5900978a91.31.1794655523156; Sat, 14 Nov 2026
 03:25:23 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-xg6846b-bcmbca-xrdp-reset-v4-0-17035a5e8ad2@kernel.org>
In-Reply-To: <20261111-xg6846b-bcmbca-xrdp-reset-v4-0-17035a5e8ad2@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 12:25:11 +0100
X-Gm-Features: AclHuK8s11-7hbgMIVd4tuDyslF9iqGa3b4ELmL8p_Ex5PIsvw1_iyvVguSEqG4
Message-ID: <CAPx+jO9GW7e0ai2o4Ycc4BKBywTaP=7NiWk68=c2kqcD_VrgRQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] BCMBCA PMB power, clock, reset and hardware
 monitoring support
To: Linus Walleij <linusw@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX+yk+QuNLSq4E
 MoULn6SpPWVEY5eux3fvGs08xt8VoqGle2HwEU/dHlvJmX7Blaou6yvZEyvUEEkmd7LUrXflKy7
 07b1BrlNHYwokci2YTuvgh5gNUYhf2c=
X-Proofpoint-ORIG-GUID: 6kk4Rbpr1nohzOO5AK2iz1XVpFz2pKBW
X-Proofpoint-GUID: 6kk4Rbpr1nohzOO5AK2iz1XVpFz2pKBW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX2bzJCmMY/jyP
 0DYYvethUKN+dX7t/TrL/pbYYU/xvUkOZrE+vQykvg/4QNl10VhGhHzNCjuRAYfacmyRg4Aw7Qu
 Gk3ynceMkYI67YRk3GCZ0Ij91Nv0QgI/baCx0I23/tWRnOjgfS+1Gyj5Ui7vGiIdaKcY7fIzFx9
 AsGl05/sz5/jwHi2ngR7Ji7y35dfzgOODJb1lUfHXmKWwaruBbPXdyccsLJ0RWKQ4MS6UOnTypz
 l9KKxRQEi856Fx7rZ5dGR/v1nkg+5lTxuVGDxCVRxC2nyiZFUN5BmKyCH2Rq95zvMx9nlnDHYNp
 xp5krAe9NILF0ccXzv7tjuR16ANtDymdwbbHBtMSwzQie8GNBzlMkMnQfYW6uFna9pguUezufA7
 hQM0mJbog8blkVqeiRSQverb8lwD5LRlGG7RdLA57y9Nap6Z2fk6YHhkIDXgeoYLbrv1dqw/E3C
 r/TgtFH1HKKM8ZFh9dA==
X-Authority-Analysis: v=2.4 cv=Vpy2kO2n c=1 sm=1 tr=0 ts=6af84524 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=vyQqneORv_wdx-tV-QAA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140045

On Wed, Nov 11, 2026 at 12:00=E2=80=AFPM Linus Walleij <linusw@kernel.org> =
wrote:
>
> This is another of these big upfront design binding and driver hoards
> that is the consequence of adding new SoC support.
>
> My stake is to be able to boot and test a full featured Cortex-A7
> system and the BCM6846 XG6846B is one such system on my desk.
>
> It's been cooking for a while in various prototype forms.
>
> IMPLEMENTATION:
>
> The PMC contains various stuff so this needs to be a simple MFD node
> so more things can be added into it later.
>
> Inside the PMC is the PMB, the power management bus. This bridges
> to several individual peripherals which are very clearly distinct
> devices on that bus.
>
> Handle the PMB with an MFD driver with power domain, clock, reset and hwm=
on
> providers.
>
> Expose the standard BPCM peripheral, memory, USB and PCIe domains and
> a combined XRDP domain covering XRDP, the three Runners and WAN. Keep
> the peripheral and memory domains always on. The power domain provider
> now owns zone transitions, leaving the reset provider to pulse resets.
> The CPU and PLL blocks use different register layouts and are excluded.
> This new power domain integration has not been tested on hardware.
>
> The BCM6846 XRDP reset sequence enabled full-MTU traffic on all four LAN
> ports and copper WAN and has been tested on that series. The zone
> power-up sequence also passed direct CFE flash boot in the Linux 6.18
> OpenWrt port; this folded v7.3-rc1 revision still needs hardware testing.
>
> MERGE STRATEGY:
>
> Through an MFD immutable branch once everyone ACKs the subdrivers,
> it will take time I guess. Queue the bindings and drivers in MFD.

 I assume you are referring to patch1, 2 and 3?

In regards to the power domain driver (patch4) at quick review it
looks good to me.

If Lee decides to host an immutable branch, just let me know so I call
pull it in to apply patch4.

[...]

Kind regards
Uffe
