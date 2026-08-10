Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFE53F3293
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371513; cv=pass; b=hKTKOrc4sXEfDYMvmdv38ULOK4ZQWblfVudVA02CCfo06S3r+NSlNobOOLaFTzThOECUfBG4qt3EX6Tzx5+bzO0DSYsXOS7lH9Mwbv56Y72+eYQRUiqHpXjuEaUHpyAGzk94Kw5d6v4nN/255P8ISleyqGxMha7ohoLVcgmzTm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371513; c=relaxed/simple;
	bh=N7XTeoAtVgCjUbyUhH6HLUqT7VK7d+dE1+VQTCpWBb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgItQSXPOekVAtEX2LYioDgXTJBs5GSi4hw69D8GPW3bCqAeGXhK6qD70Vb+wPGnN/LlxPqMHM7M/9vsxXCnq9iPTHyN2gZmzFcK6uaXzunArdGhkHvsMsdpRM4nyR+JPUNqdjMZFcIShW8IFq6qJGGF6uum0v4K+C2V7wc9bDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OsMXW/8K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tsbm7O7q; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OsMXW/8K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tsbm7O7q"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACj6p21650635
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 14:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CeUXRKNvrjHpJenJaRbLI76VL/niBIfa6H9KqtDK2ws=; b=OsMXW/8KgmMjHbZe
	AoyvJSO+/JhnfbuDbQ3oyZaLWo0zwkbPAE92jJ3Gcl2Z4Lyh1s71hM5J2MK86gxl
	yQ5J968Sy6B8pvKwAkUzmCImTUoyzjD8uc/RFc2yMqmMEGzxJ73unFlywxF3s35j
	fm6D112FbvpstBUAzFhOqwGrZGbwu6N/dcYRlqDNM2Rn/LI72bCvWOEJ65FlpXru
	umj1WBkHDQauhGpT7E3QmSzO2M+xDGp2mPW4jFuEtSvQuTBUJNcB+0xHks1HwLYU
	IUI7CPLh+giwbX8KwYlr1Pb5szWOTEstMLKUvKQrNiw2AFC2yImIgtvZqkZlGltt
	ltiA1w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8vhhxp0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 14:18:31 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-907c59bd65aso9101556d6.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 07:18:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786371510; cv=none;
        d=google.com; s=arc-20260327;
        b=FRoC24o3FkfO/aE8kjurpny+mIbGzm9iKyEXuLqANPO3ZOXb1CH4ymg5YN4d9RhpEr
         lH2Uz2Mw9gy+3xAhD3XZ3oUVUz8MDzgxeJy/Rbn+9iIu8ZeLbcVusUIFzKMyvbQDAE5i
         5PbhVHz8C2ALK2JLCgLFNS/NdSipEuJv5y+GYG62E1UThEAsEwXJcwIHI1mp97uLVxOb
         3WY5HjNk1SEME84LTcWKCg0hVpc3j6oBFv7vIPxgCNvFSfRSVybHDDMfKAMPdsXxMu0V
         27FImyE00F71MrVV6Fq22424p+J8R6aUyBjipDKO1TmWlTnB6xymDe9aJRElMNacYoN1
         mNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CeUXRKNvrjHpJenJaRbLI76VL/niBIfa6H9KqtDK2ws=;
        fh=JDOc8roF4mx+yyYpyhQlscY8eRUfpkWryObNrnMsNnA=;
        b=g3Jf9gxRm9mkqhZuM8blsvjFSxQxw8eouD1tEx2hFIDqu4X80BleDwZ3qRdE9w60n7
         IbmQyXvxRwTYm9Qen61QN5gv7mraJPgjOBG4mbDyyYxpc5coz3y/OtM2obvcM1ABV5+M
         GixQAYlW1HfAX8a3IxFOMIXgXXdyfBxj4GfhQ6IDqs0Pifqi3rwGHCmgLj8UpbF9WVHD
         MsZzv2pRuZ/1W9v8CdOfJ+c3HWkxwEYX855lWcrzzqv1blrJ1/ClKSJWVT0+OMMN/NSK
         un2cE/01OwkL57v4QTQ1k6NmLO/iXR/Klp+VE+frcInKuaagNKIYMTysxdxR9Ulhb+pP
         MC+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786371510; x=1786976310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CeUXRKNvrjHpJenJaRbLI76VL/niBIfa6H9KqtDK2ws=;
        b=Tsbm7O7qLBKUQbZI8wcGSgMuSOg4QFgN64WS6DnBSYe41SdKCPE6dXYprJ4yJAH9D4
         zI4WBizjdOxAhs0hzvhbNrMaTUPLiuCd1yHBclvm9p0ZJrYnUVc/+dqqDiSDvfjXrP2h
         wClc2AewpDR/j1Xu4JV+Spf8HjHbJBx7uZR1TSmUMa+zo/vnQuUd0wcDZRFEPkPkIrUJ
         fYsqicGSz3DKLjSiEQa4mLuq+htg23e2eENkd4cXUGtYhvEnsRh5vh+IQyHjkNBw8R/S
         9nrnhZs/+TB7IFCX8dKqjUSvZi4AT8MlsTWWAYLWBUKov162YcHKoaQ97k792skMTuvB
         r3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371510; x=1786976310;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CeUXRKNvrjHpJenJaRbLI76VL/niBIfa6H9KqtDK2ws=;
        b=khV1ywfeBncDJVPHnFhf+h2ahI9/nqAbEm2yUvZ7Mg1nZKvkOtEq3CmymiUHJCLJSq
         eswXAUMvpHtEzylID+Ow2uHgIiNs+H2ZrgaE6Ztfg2dimw3jLbp5Va7nNZ2bnQZbzoQW
         lj+xSjCCP8zR5VRuEvy9VB8JzB5mHHhU87Z3GR5nNdxMvo4iw4mRQbi4a6VEwor49S6R
         /X2225hYWI8W4QOIrdyCFSjmCcsWtO01nNY7nU4Qtu4P5xF0M9WEiDX+z4vVvB9Zuuhq
         0jbrfaLHkZZZeAidroDPMpNSTnb736fBwIW0j2rNhfD2E3pRln9zXd5sUJkskT4lPdG7
         +HOw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9vOWT+Znu4hOX0f1YDVvHSAjw5bT1Mi72p4FRvj9uiwHhZdPf83ueyo0Kqf7Xwv4eU6TootBpLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxP+wCLRNt83Wi3G/Po6IiJKBatwJfckWKSsSsHvhQFAdasuHOJ
	LJR3Ax0CR843CN8KBK3N9kavI6vrb08HA4RowFfQwg5ASmJ7xstBmsrejQmdTCtJ+HEqhpAssL+
	CIViaPbo9ppQ9BMb/zCZlnTYhsUeiI4dZk2JgH+JzrXBClWQFrtPdJGCg6h6Xrs8XBe8lBJ+h//
	EvhqfvlRxcujeNyLZXeNLYivAp+SlcvgWqGl05
X-Gm-Gg: AR+sD10WaZzDmKG9Ijf52HhijHK8oaPmQn3KgypzZCP4STzkcWxiDmHlskVgfMtH71l
	LxIxMFuLlCM8vPASYtBjgEy2+nCFq5NirNKq/sGxjsn5szeSOV+QnjCxX27UUVURJYTe5FOtUXB
	ETyIKfUsGk7F16Yb+mkW3MqogDsL7M+1MfHnzaPuYEDXp0cylH/yN7FMmsvw==
X-Received: by 2002:ad4:5c8b:0:b0:8f7:40b8:e8ab with SMTP id 6a1803df08f44-9088108f7dfmr495730176d6.3.1786371510116;
        Mon, 10 Aug 2026 07:18:30 -0700 (PDT)
X-Received: by 2002:ad4:5c8b:0:b0:8f7:40b8:e8ab with SMTP id
 6a1803df08f44-9088108f7dfmr495727846d6.3.1786371508926; Mon, 10 Aug 2026
 07:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785941595.git.geert+renesas@glider.be>
In-Reply-To: <cover.1785941595.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 16:18:17 +0200
X-Gm-Features: AUfX_mzXC69ugD711wUFTUYf8_epBYn0SrqMBsnLPgmbzyeuCwMrcI960ZDYq8Q
Message-ID: <CAPx+jO87d7H92KSR7R7ObR05sM2JcHBCo+YuUf_1gE-KwhR7CQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] R-Car X5H CPG/MDLC support
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=MMtQXsZl c=1 sm=1 tr=0 ts=6a79ddb7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=HDY4BLWKCFmduH3Fo1AA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: dHzUks9UwrSchCVehpLAjvrzr1eOdTMN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX+s0fY8qz+/Aq
 eZnZYaHz0hynZm4FNTnKlujfh9CLgrMoZGEt5gpnOamlKgcD1XGdQTW/CoSej2JkQX/QOZj5+nZ
 nuiEgHo9l2MFmWW+JZwBb2/zupdpc+L1VDvB7plrEs72pu1PsYHkT93n99vuWKjg968tGH+SZzA
 ACyrAZ7Nnmk6XUZ/c7hfIqvtvB454eqjRp5iK92DG1c9/J8wiNvty6U0itlMg94HivgE34QUOaf
 x9L3GVDb/6uijZAGpAB90qHsEHySPmrwuq7nb+vPUIMUSV3pDv6mkaeXfneIdBscblr1YxER549
 9+9mJAr0+jC4/bfMwAJLUHXX2Winq+NXfyf5GII63rom51bIuV9plvbxxo3gUSxmEohOG5e0zJa
 C3LrHX0w6jWUUZF3tsEx2mRGtzEfA9z5W+BMezetViOiH+4sBFi9UnK0/wIgg0vy4N/5TGoKDvG
 mAlSZRxLndbJN5QwTuA==
X-Proofpoint-GUID: dHzUks9UwrSchCVehpLAjvrzr1eOdTMN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX15Gs10GmUie8
 HLrFwgf33w3usJMVhIhszM06oWgzTKFWDWcaWbBYr/j5vLQDeoZAMvqjfA73mTFRkbDcX2RZT6U
 H79B2gQSjnTXPGDmf9wm3lmKVT3fPl8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100123

On Wed, Aug 5, 2026 at 5:21=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>         Hi all,
>
> This patch series adds minimal support for the Renesas R-Car X5H Clock
> Pulse Generator (CPG) and Module Controller (MDLC), to aim for replacing
> the dummy clocks in r8a78000.dtsi with proper hardware description.
> These two components are closely related, in the sense that they are
> both supposed to be accessed through the ARM System Control and
> Management Interface (SCMI) on the Ironhide development board.
>
> This series consists of three parts:
>   1. Patches 1-2 add DT bindings and DT binding definitions,
>   2. Patches 3-4 add minimal CPG and MDLC drivers,
>   3. Patches 5-6 update the DTS.
> Note that this series depends on v7.2-rc2, due to the use of
> <linux/device-id/of.h>.
>
> Changes compared to v2[1]:
>   - Add Acked-by, Reviewed-by,
>   - Add fixed-rate clocks to kerneldoc of r8a78000_cpg_priv.map,
>   - Use devm_clk_hw_register_fixed_rate(), drop unregister_fixed_clks(),
>   - Drop fill_clk_map(), as it is not really needed until SCMI remapping
>     support is added later,
>   - Replace <linux/mod_devicetable.h> by more specific
>     <linux/device-id/of.h> in v7.2-rc2,
>   - Add a comment to document only always-on domains are supported,
>   - Consistently use /* sentinel */ for zero sentinels,
>   - Drop trailing commas from sentinels,
>   - Sort MDLC nodes (alphabetically, by label).
>
> Major changes compared to v1[2] (more detail in the individual patches):
>   - Add default support not using SCMI,
>   - Drop everything related to SCMI.
>
> Note that this series does not use or rely on SCMI in any way.
> SCMI remapping support will be added in a subsequent series (old version
> at [3]).
> Full hardware support without using SCMI could be added, too, if anyone
> would care about that use case.
>
> For testing, I have pushed this series plus additional work (including
> a rebased and updated version of [3]) to [4].
>
> While I know it is getting late in the cycle, this work (especially the
> DT bindings) are a dependency for about any R-Car X5H progress, so it
> would be good to have it included in v7.3.
> Hence I plan to queue the clock patches (1, 3) in renesas-clk for v7.3
> (Stephen still hasn't merged my earlier PR for v7.3 anyway).
> Ulf: It would be great if you could take the pmdomain patches (2, 4).

Patch 2 applied for next, but I left patch4 for now as it didn't apply
cleanly (drivers/soc/renesas/Kconfig had a conflict), thanks!

> The DTS changes (5-6) can wait for v7.4; they have a hard dependency on
> the presence of both drivers anyway.
>

[...]

Kind regards
Uffe
