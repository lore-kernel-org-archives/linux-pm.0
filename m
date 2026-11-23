Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795446206;
	b=WwREQg3Ji5EUBD3fyVvDbi6xnycaqaN1f3hECXziOH8qpFqSX7XvQVO8R/sCr2jaKRnp
	 QOSyDD2VNU5RgYKHWexAKkHgjEqGntGn7hwg03e8p/+NgkGiOFC7oruEaPXLQBAucUtZ3
	 2EF1tUc+UyETszJf2kKdL9ZDBR7vaywbaWVGQlF3gq/SyeXU/MA1AiityUxkm85g22cDZ
	 LRVwpvnmplP0KMvh/7gTn8JAXtRpZPG+uWDPa7znJTF+oW0sLyY/1TuxdVNBiKVSVHVWH
	 djlH6eYImYp54iujpoksPyr+xBYa4MXz2l5sEwlOJYtCvw6kmNXQ/NskXizrt4Z5iTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446206;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sZmn/sNxwAfKWKSIqSCT0pljBWlXHOxHLlaVhxvwNo0=;
	b=V3Qh8Thgxb7NcGUqR4+gzXjPRj03DuhJ2wSnKf5BnAlFayxdhQ0bjCTqf9oAYhSufIqi
	 OikDS6y+pONg0QhattMf+0KCQZFDim2tTKK3WCRHmQuqGWwNgcHUcXWNYfAkCEniaSx0a
	 kFFbzVw7eG7flpv0ZWW9EOarJkK27YE/aMf/QCeqZLW8RwgSqSSXkA17H6WjuO+7aRNHt
	 myJHD8Oc8jEQ6Er2huJn+6oY715TiVnGfd1MRAdkBur1+h2zJWJgMmUCxRieA3XACXrGQ
	 cyW3iIjjUh/kvyWB43HQd18YBZCqBnWHvNAJhCIcz8i3Y4n4t+AqYghiAEl1GyWxx9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IbfO81VA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GKICQHrW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DB7606A321
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 15:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0DB7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IbfO81VA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GKICQHrW
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDKsmO1974135
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 15:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sZmn/sNxwAfKWKSIqSCT0pljBWlXHOxHLlaVhxvwNo0=; b=IbfO81VAygWqws1q
	TyYwzZLUHWgB64GgdO9dyaTt3zpAjoZJTDLgfEK+Re46q144zQ/jXm7UXcLujI3H
	3704UyUwCzMPStRZkWgk0SAvSYRVpYoQqPVCPMbG1rBBjNGXvQRthDqmm/VLgGmq
	eua9pk6y4yQJJboujmd9FOPeCnKeMLAi1zWreYZmb4BfbxKi6k8Usii2edWf3Qf2
	TPZ6mQvAySOhb7U/BEnLigjn1K43367diJYkpo40vAtzLfnyiP79fe+z1XO1Yckd
	yeY0KLT8BbSG1ND5//lKn9wXU+qJrzCeCaaZuhg7/Ttmcx3Impz72pohCAly1rYE
	5wYCbg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4m7urvxe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 15:03:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2f03a137f6aso29045895ad.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 07:03:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795446204; cv=none;
        d=google.com; s=arc-20260327;
        b=nbE1WLajI2R/TWGsPYkAsLZ+h7Civ3Q/idqun9InsqHmZAvfq1fW2vCVwS+UrCD7ur
         s6NyojUe1Ghmfbj7FIeM9Be+HDH7e7EKA2fjTE6ZJwqAES1GLmBI/uDK7Sn1WOpi4FbQ
         kaqSN/iYiw7yzlq2hf7r2ghLYuv81nUJFMKm4G7O0S1sDh0nDutWp5Ww0aohsRTcLTc/
         0kqOC2oP4YqFshoVvbPs1+lzntqVfRESEzhHgxEf2KWCaWog53kEgCrTJHihSkig85gG
         MpgJtOcv6rjA508WMnJtyIdnuhLhsrnjBgnZi7UISVlE76K/MkVr8RmQU7dPDJD9tNtk
         HmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sZmn/sNxwAfKWKSIqSCT0pljBWlXHOxHLlaVhxvwNo0=;
        fh=DONi9Jos/Fi1VQJCpM9Vs0ZVS0PvpFbSbWJn/+z5FUk=;
        b=QTilVYPbbAU1uviI8YxjSaEn58xsm6baMhCh880kSUM6jjU3StkeKBT8nemGxBbz4C
         JDJVAQ9BwF16nHtkrjYdTz5nHeCe59S0vO6ZGvC299G9907FupP4zh58ckWJzLR32Pkm
         +NY97VVi4TJzLeiDY+WA0X9NV0+E7HkuIzzcbj5XlWQ8dg8GdnZaR23wpomnkAXfbyvq
         YTekoq9T4nRWZTrE7bZzskaRyGq4NgFgz28/fpEeIdcsO4VD79C3mCyn/FwP7qTzDXgJ
         wAFGE697vUkZGO0vmiUnwnKhJV2xOKfJ2SHShvljj4TGy/+l7gw8oMCTsDRBEA9Xlr57
         nsjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795446204; x=1796051004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sZmn/sNxwAfKWKSIqSCT0pljBWlXHOxHLlaVhxvwNo0=;
        b=GKICQHrWbgWhknoFx7eGKV/FO3UKhvO5gjVJbDKkY543yjzGMcE2t7BuK7HZ9AO2Zi
         hfkgFQLhUurfXexc6zf0+rbKDh2rzr4hiawZYjps1mpL3MisKE3nwr+e/mvpVG/g+wLL
         06+BjLjHV0h3OTJrFle2DbezFOnCzyLf5Pdw9e3h0Ep0gUIQfPdilDJ/wSbtTCBzleDS
         YYTShYUmS6AL8wJR2zKTmYkro1UmukdH2jzLqn/sseVAcNvsvtKbvajTNhEYA4Su0e6A
         6VC9xocqc4wecWos5HDF0F8B2OIZ0BV+QcPHPZdncWKCK3YhKTU0yb6I/uHzS+n+PFYV
         KCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446204; x=1796051004;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sZmn/sNxwAfKWKSIqSCT0pljBWlXHOxHLlaVhxvwNo0=;
        b=cgvzC2VVXruo87CcQcuqstt23Af/XY5qOolFVjpPmT1rZOf48LiYztkfNd0f1jdiBr
         01dTuI2mIPbrC6t5AelUwzfkdVoyZ1idorUlOR8qzcRUB4Wip2cUvfEVunmG6jNr6eNI
         1iHTedR0/AxLAsOhDmG7K877ShLTidy374PDEC3zxAY4uOid73TS8CnTQHrhJLQ7UyMa
         E+XedPNmxai+6pk5jiKDcEp29/qJWTWytPG0y1wnhyIGxwyP0JFzH4SGqEVmJNOl8FOP
         jk8NzOENIkczUKj23MWsCGSUY8Kc/WbLBo/6sXhmt25i+L/2ONHUa87IMzUm6rbeZvOX
         eXjg==
X-Forwarded-Encrypted: i=1; AL+hErGSNG6FmZ+b6oIc9oYN7Y7l6qp+MvxH1itihPOxuywSQ5BX/786lTBw4fIANNyg9BwuoEKQdB/ncw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9jVsQbkYd6HQuwokOlVCcflmDJFAVF2Xql58MXiZMGpOKnuasU
	kd7r6z1VhgdfbXr39kgi+a0hJcpAIhLZUsHqk/LTxXUZ6H7hYDZW6nQ4C6Wa8eavk0CtduDWlEV
	TJEIR0HrS7aLHXBfaHc7NYzZkRJdadrUdQxRFxVn1wcQLRfgZ1GxD3dMP/CGw7j5QlbHC0LtQ49
	Uf91urSmW6OIY3At/MA+fI9h0f8VBpY4PHKCeb
X-Gm-Gg: AZFdTZcyfxZWcYLBrXFDePvv7jIcRYDB4DNU/WfG97vmhoyHbhxwvt3N4Z6oeShx4ul
	GzLlyWyYk7hM3qNf0/Guj9MmdzlUwXvUuQh9RzJqIFmaXsY0387639Bx9HT2txSVxkW9t2pV2Ou
	siqbl49S3jm2+9e8i+3gFMXGoyL6ct0TPLUFNw+UnXKPiNKgGEBWWo961zq8Q9RfZG27uxZyzny
	pYabvKjApKjIpxk
X-Received: by 2002:a17:903:1c9:b0:2ef:fcd8:df75 with SMTP id d9443c01a7336-2f03f18847fmr120968285ad.36.1795446203020;
        Mon, 23 Nov 2026 07:03:23 -0800 (PST)
X-Received: by 2002:a17:903:1c9:b0:2ef:fcd8:df75 with SMTP id
 d9443c01a7336-2f03f18847fmr120967425ad.36.1795446202035; Mon, 23 Nov 2026
 07:03:22 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-pmdomain-rockchip-v3-0-b7039ca30b87@gmail.com>
In-Reply-To: <20261113-pmdomain-rockchip-v3-0-b7039ca30b87@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 16:03:09 +0100
X-Gm-Features: Aa3M54p3bvaqL4-4P5a9q3TQOKbyz1uWNRpSG9PtFinKLWfQ4vS-W5Tpi3kneLA
Message-ID: <CAPx+jO8KYfvm+=UXKYZv+xBAmGNUU7xtYH9+cJRtOrnQh3GmrQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] pmdomain: rockchip: fix the probe error and
 deferral paths
To: aiyengar1990@gmail.com
Cc: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Kevin Hilman <khilman@linaro.org>, Caesar Wang <wxt@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yao Zi <me@ziyao.cc>, Igor Pecovnik <igor@armbian.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: VVtexxZDZZbwHCwyStBKOqaWqc_b9ms1
X-Authority-Analysis: v=2.4 cv=KurYSmWN c=1 sm=1 tr=0 ts=6b0455bc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8
 a=0OowS_b49qHy5rEh488A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: VVtexxZDZZbwHCwyStBKOqaWqc_b9ms1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1OSBTYWx0ZWRfX1RocibkHFHTH
 U9d1tC4a2Xxd2E+pyTkO1idXoRpRcPOZ8pIjdOMJa3UNKc27c5588pLzsKF/v+Y9iX3jbGn0k2n
 8bEhtklyfsS47vYMz1wKiOvJno13jiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1OSBTYWx0ZWRfX4WWA3g2F4JAu
 usE5MEgsUalZGE/q73IstqYTP+Hpwsu3iDHP520ZgRulPBvEEA/TfcHtMlJEPLVCQTDCCpM1EzH
 XTwDjI1FWCN7BkxA3VOOS1vvP57G9JQNo6E4D55DhreJNPlC+o1DNssZX86c/Kd0/3UtkpodmXY
 R/9nH5sAImzF6aJAoJyj7SkXTvxblv2CYfaWP55F5j3OrbjErcU2vX6SFacdlD8qsSUPRx4KU4j
 nrSz15I7p/5e+u+aozoK5m0unfmeKYLnNk8Pl2lyFy34tL5RJk8sXkva+xw/OIWSxj8de9KMKuq
 tijL6PQPGPSE+rlLPYLPE/5fCIOd0Ga6QFIXpuOpXnQ2/6SSGZ9RGIqsa9nfpPw9ssG1z4gjYrV
 M4lWmbitw+0Uw+yQR1A4fv7QVgT0s+uvJ9W5FoNJQJfEvm14RQzMtsKX+TbKIaim3ThCI7m/Jdz
 OaNbFxavAgwEsl4Mzsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230059

On Fri, Nov 13, 2026 at 9:42=E2=80=AFAM Arun Iyengar via B4 Relay
<devnull+aiyengar1990.gmail.com@kernel.org> wrote:
>
> Fixes for a Rockchip power domain controller probe that fails or defers,
> for example on a domain clock that is not available yet. They apply on
> top of 1/2 of Yao Zi's series [1], which has to go in first; patch 2
> replaces 2/2 of [1]. On the pmdomain next branch, 1/2 of [1] conflicts
> with "cycle an optional power-domain reset on power-on" in one line.

This sounds messy.

I tried to apply patch1 on my fixes branch which failed. Please
re-base this and send a new version.

For changes that are targeted for fixes, please send them separately
from the other improvements.

Kind regards
Uffe

>
> Tested with v1 on an Orange Pi 5 (RK3588S), v7.3 based kernel, with a
> test device tree that makes the PD_FEC clock appear late: no freed
> domain left on gpd_list, no -517 errors, and the controller binds later
> with all 26 domains. The v2/v3 changes are build-tested only.
>
> [1] https://lore.kernel.org/r/20261105001257.1368266-1-me@ziyao.cc
>
> Developed with Claude (Anthropic), which wrote the code and the commit
> messages. I reviewed every change.
>
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
> Changes in v3:
> - Split 2/2 into the fix (2/3: deferral, pm_qos error code, callers'
>   messages) and a clean-up of the other messages without Fixes tags
>   (3/3) (Yao Zi)
> - Shorter commit messages and comments (Heiko Stuebner)
> - No code change from v2 apart from the comments in 1/3
> - Link to v2: https://patch.msgid.link/20261112-pmdomain-rockchip-v2-0-5c=
d942a23df7@gmail.com
>
> Changes in v2:
> - Dropped "pmdomain: rockchip: put only the clocks that were got on
>   error" for 1/2 of [1], which fixes the same bug
> - 2/2: drop the callers' messages and use dev_err_probe() where the
>   errors happen (Sebastian Reichel)
> - 2/2: a pm_qos syscon error keeps its own code
> - Link to v1: https://patch.msgid.link/20261110-pmdomain-rockchip-v1-0-6b=
9fa6ebaa86@gmail.com
>
> ---
> Arun Iyengar (3):
>       pmdomain: rockchip: remove subdomain links before the domains on er=
ror
>       pmdomain: rockchip: don't report probe deferral as an error
>       pmdomain: rockchip: use dev_err_probe() for the other probe errors
>
>  drivers/pmdomain/rockchip/pm-domains.c | 131 +++++++++++++++++++--------=
------
>  1 file changed, 76 insertions(+), 55 deletions(-)
> ---
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> change-id: 20261110-pmdomain-rockchip-3497a2e7fdf5
> prerequisite-patch-id: c2f0c5eb6651baa744f66342db63485a6685fb71
>
> Best regards,
> --
> Arun Iyengar <aiyengar1990@gmail.com>
>
>
