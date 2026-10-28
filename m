Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182981;
	b=zxTiaosn6xKTXw9x0UJtFbvsXChixN0ndVlV157vqzXYULcR85O7F648nuCXRKKaALTO
	 yN2mogH5xrub+7wT/2J5KSD+jTSXwoku9YUvBrKIgovmD339f7G383pRJRFAZKzsljRp5
	 vHe755feYwDXodYrhpP/9z4zblv5q5ppXg0i/OQdXksFAiwRYR1PLs55SQ/bYVaqh2lEw
	 Knbc68Q7HN1mxqvFfKuN1YZHYnARQJqPV6SYB1bL6aEBCr8DTaHEU5W06Tk0DvIUJxDrv
	 wtAsQDzNUzeSgiTF4id1aRYiYf823U6tPM8Qg4VB+Hk1l1Xwj94elb5lBfGwnjPOnqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182981;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fJLqm9V4jsOFfA6wxHEcJun15GePDPlJxumBUvgqgGU=;
	b=dq5tDaL1TaHGs7kxXjJYVax8y8LEKX6UHDC+eOpzLZfLnWgBMMsVpY95Horcvyp+05dW
	 f6HTjHATyAKJ+UsKyRUxdeDkHwTSxVjLfevRZARQ95rYABf/6KdODL/iR4RfuZZYD02cj
	 FmHdBsPFwpW/kdNHEbVAJ0x5A9kMCBWQlIf/HZ17hbWJferwmp3BujbNDUlJcj0v2FRH5
	 ECO1S/rgLjNBbYUX8F5tx3qzTAp8Eoaf4iJoEle73PBfrUflxGW2hwbimdQ7ra+42nREd
	 OPN1vBwKJHSAv7K4WQ38ZOu7YT5wJiRtM42Ua2Nb4Q4G2TICsegxO1HWKWTdBVD4Ldg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UqJ49b6j;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cEelwyrf;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C67D606A31F
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 10:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C67D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UqJ49b6j;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cEelwyrf
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8KLIY3264826
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 10:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fJLqm9V4jsOFfA6wxHEcJun15GePDPlJxumBUvgqgGU=; b=UqJ49b6jcBEGRk4N
	SMcg+4URhJJuhk3SeW8bv8F4v6ep04YNfItmRsT7kGdv+WqjQJKm8XECwY4SMr0l
	Cw/OBTIt6b7DBmuLNZWP8tSDKfneEmZ9lmTLN4s83EFFQ2wUGYRQgdk3Qmsx/Sqw
	HmjX8jCJG8Ku0powhzuVEZgUKBbyf+LRYDEpuzykx0+rHBLgnExjTCzLMLuaB5Nr
	NXwXvgaq8a8hJvmaBjuRP02xX3M8WljiBZQ84/2smhW8KyRJ9piZfexGD740N+Dd
	l3uF0WZOQ6TPpfwjtKiQUeG2pXrZB6HgovunNh649Zgzo8MWX738zXTzSIzmSdhS
	B5MMcA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy713pt1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 10:22:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f6f4fe531so127536485a.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 03:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793182979; x=1793787779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fJLqm9V4jsOFfA6wxHEcJun15GePDPlJxumBUvgqgGU=;
        b=cEelwyrfGfmlt35tTqod9Uw9EXTfW+0PqqluJChECzfmxHszHmi524Yrh/sCXh9AxM
         sscjoDTAIjs8OQk7wTnXfZ7M5NlZeCrJpwDVRhAFMzml+X0uj2SZxOeeyS8lWbDlBZkd
         RjuhhLSANG4wmC+5ZN1LDpJPsaPpAmv8WKwEN6W4w9YRnv8fWmErGzyLGahakNw+u/6o
         VeqFM0/z0Xcrm2SHQhK4AuGpqs72lseYQJG8BQGDQ037Z11+GelEbTOBHx4Ehz8s0z6s
         6tRg2HpqWbzFXgAEFE4Fh8CyUp/GseaYCuDT8LtUzYpggWrPYOwhv/lxpukkZc3md7r4
         UJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793182979; x=1793787779;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fJLqm9V4jsOFfA6wxHEcJun15GePDPlJxumBUvgqgGU=;
        b=n7wK3mzXpBLvu8s4nNSelN4e/ixXcyR8qy+py6KtkT7ymvcaJ6bYh6bv3ybSAyORWH
         jCzO4uGMmbB5FlD3Axs/xLHJSdoasBehT88dfQc5cPKAHfEG6jdgjvdYvcZ7qgKA1kHN
         Lu5luvp9pFQfRnqoH8ZDBpYOd68Wp2/2PgBzYXbc9/gG2vnGXKB15ALMQOqs2adaZBE5
         /iyjjaaO1ekVl+xFI0m/OngZPoNiu2P/pKvAWd4nO7+sYp7z3nSqXEn/ATNxyrMg9Pf0
         NC6Ryk4GGHFNV4uIf1+t+EGddyOwJ3QvNRE95K3F6fVrdhyFJ+bRmujz2sMdbAE9laDo
         DnLQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3UIF9WN9MdkSXBsCwY2eGLC800AteOS5/fpVBPun0TYOQY70ehor4NZWU++OC6eY41i3k2KNoFA==@vger.kernel.org
X-Gm-Message-State: AFq9FYI0APcqq5+J1KDnm6lUVpSNQ9NsFSLCQVuVKUbIQ6WJkitQqfEM
	6Tq2hjRV/oLv6hvRm5haLZymgwftCQlh4t5I+OPsOT1LGbo4jngDHLos4rADTm8LCkAiAeT4G0I
	VIswaAAySAZbMkqBpPnoGnK2POvWt37WH8fe+jsdKPmDj54TTM0eKjACbuRRcnw==
X-Gm-Gg: AYBFou0zZfZlNdx90+ZbdOT7parfl5GuzAnLM4Nog9yuMbXnFhWX1ulQ9iaJIxw4dA6
	6nEwILqxsJj4Sr+1Nmxi5jlIKZqvusvUjqRklLBGwHjejbX0lcPXU0t3QJZDqxzemYptmQqprZB
	xk7xnI6kRM6YlJ6UOPc/EHoORLjf7x8p3HfIlChyjHuiFLhQ1jzr0UTypE45d2ehctLu19d2DNU
	c99JihBx1pRxrauj4ldvzKrvDmXtLfS/UDQbRKyL16kiE1kJy6BKcUkz44nAVi95Tk4KZWt7Td/
	pOxuqCTvuSzSi5J5nc+EixxEvJ+JAuX4nbpDHoJVMlc5dyftIcyeGoUsKGY8CqqzsBAVBTgcjNI
	+XT1p80TCfym8G7oT5x9bsgSROFiTFYSU/Qc3KT5TDzj0CCNuvwR1RNGo2J0v33bLiIWsdjOkiB
	KP
X-Received: by 2002:a05:620a:4008:b0:93c:7d49:7b69 with SMTP id af79cd13be357-94408d42e06mr227997385a.60.1793182978714;
        Wed, 28 Oct 2026 03:22:58 -0700 (PDT)
X-Received: by 2002:a05:620a:4008:b0:93c:7d49:7b69 with SMTP id af79cd13be357-94408d42e06mr227994285a.60.1793182978265;
        Wed, 28 Oct 2026 03:22:58 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a976010ca7sm36225665e9.1.2026.10.28.03.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 03:22:57 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH 0/7] arm64: renesas: r8a78000: Enable GPIO support
Date: Wed, 28 Oct 2026 11:22:55 +0100
Message-ID: <179318297302.16022.6984836476337905961.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1792776697.git.geert+renesas@glider.be>
References: <cover.1792776697.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0MSBTYWx0ZWRfX3ELONEzxO/XO
 uyEOKKRvV9cd3OodYxIamFaP5dfAUJfGqwx0bvb3X9uIZdfZeYGH/v0B6T0x1pQK1i3xjbzWXVa
 bHEJRZ9znyWq2vm4i2Fd0JW3LbUcT/WV8a22hxDLaO8KdXP7Y+B04VXInfB161c/lDm4tAAU6mQ
 rRbVk/Pmzk2rgdSjOl0Oc1YMqhEQ54jK9fXtsXgp0bhmS7m00+3/onmsqltraX6Zd2viBJghBsX
 OziK9OQJLdrwvh1P9sBZeBBlc6CzHHjzTVgN2RYqKwT9TkTv+iVHNsp5jGkYgoCbkUusLr0I9sF
 TCcAZbPmVjXHxAgSR6KV139pwUB4xVsJzrLRounLoXv7/d4+p2pdtMPgV6vdR6wj+GgS6ipirsh
 vx5MBO/jRIe4QS9bAj61ePn5ed64evUY/ep7HHG5GBjavSw/ceoPG3YXPjEsFh4dU4dOebuuFUy
 6zVa/dFO1zvWPht50Zw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0MSBTYWx0ZWRfX3ltj6Pj2Pwcg
 GncyPO5ywloTS+6BFKJAj56RPRARMMylK/hrVMz3FgoOBwVU/1WlPBDN8RelMWTnnrROpuYPQU2
 /okUgRP/y2/I5jMhCz5jVbMVKDYrmJM=
X-Authority-Analysis: v=2.4 cv=JspkP84C c=1 sm=1 tr=0 ts=6ae1cd03 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=0_pEspLTn5AsfqPZqEwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: n8JDp8lkxaUFqRKOxwbH40BPizox5h7K
X-Proofpoint-ORIG-GUID: n8JDp8lkxaUFqRKOxwbH40BPizox5h7K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280041


On Fri, 23 Oct 2026 19:50:38 +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series enables GPIO support for the Renesas R-Car X5H SoC, as
> found on the Renesas Ironhide development board.  On this board, clocks,
> power-domains, and resets must be accessed only through SCMI firmware.
> 
> The series is a bit special, in that most patches are not meant to be
> applied upstream yet:
>   1. The first patch, targeting the GPIO tree, restores the abily to use
>      the R-Car GPIO driver on a system that does not have pin control
>      support yet (pin control is not yet supported by SCMI on Ironhide),
>   2. The second patch, targeting a shared DT bindings branch, adds GPIO
>      clock definitions,
>   3. The third patch, targeting renesas-devel, adds GPIO device nodes to
>      the R-Car X5H .dtsi file,
>   4. The remaining patches are marked RFC or DNI; the latter depend on
>      code or DTS that is not yet upstream.  More detail can be found in
>      the individual patches.
> 
> [...]

Applied, thanks!

[1/7] gpio: rcar: Convert to gpiochip_generic_{request,free}()
      https://git.kernel.org/brgl/c/5e826d71d4839d8471784d968274823f1f492eb5

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
