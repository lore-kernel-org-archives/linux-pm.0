Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D3432BF5
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277588; cv=pass; b=eYXjwJV/g8bZpz+Qgs8ESWjeJclmpdJvA+mOvyvOvvdfEtWFOh6yJ3Xi2SRlin8wGJAlzV8qGGXGq88XO4RE1Z0qRZzAZRFvPBLVJhMMcfGxIyaum/VCP33Re9PUsyxzdnjci3Gw+l156hZFTiiKp8BBLEu7m57Z5MQTy+xCc3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277588; c=relaxed/simple;
	bh=XFUUQpQVjHmTX/OMS23vt6bYwXDq4wDECu8gMDnXyKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5vCYuqSvvSuhls84D0dbOiCx0RxkkaHGD+yVUtOpTmENi6+nh6LNKGFo71k2wMdfCmuMdodt+ViO8EvbjbGUWtr7MiSTB+B1E7y6683G3zTztodNB5Y7YiaGL+8OPurKf0BQjUdffqRaMQsPsAqlxSt9WhXaDuRjoZBG6PWXBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dn2uc+TX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eVIgAbu4; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dn2uc+TX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eVIgAbu4"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E8giS2910588
	for <linux-pm@vger.kernel.org>; Tue, 1 Sep 2026 15:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QAZHbB+c1KWBrH19DXPv7Y0Fcx+ytwVPsa2l7SjZi48=; b=dn2uc+TXd6LM8e5N
	jnnwjWOAapq/YOWMDaEoFrFOeBIDw9qcaF15/5VAmvOmGNMj66MbYV0ewcPRKZ79
	sbGACZ3oeO1OFMEmi9OwY9D9VnLExCHrvSRQF60SHV7whqMBhb4Y3eyOMQioBlJU
	vSHKPVsbSHUJ4VBy46m1vYsEY/GbkGTrUE7U3sa2vn9UGV+gDcYeQ7Cb4k/jnxHf
	eyfwOQcrcAfhaR5Lz/d7jIZ5PNctbJ6Y4Wd0AQ3TpgrivnL8mfG2r4ANoGujlQyK
	mD52DMquVUIMMAIxdpBS200NSUd+8D3eu+OmvNfqG5CkgfzxvbfGgs+9hdfEbblP
	lMRRCQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdp7r3779-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 15:46:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb48f41343aso1027013a12.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 08:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788277584; cv=none;
        d=google.com; s=arc-20260327;
        b=qQnCl6WKDfRLWV3N/Ek6SzWTNWrdqzQ1G68+cIZ24pBEStOgQgWUL/mqko2HvnEDFD
         qWSdlOu/wOPGggHkEMbVFd10x8Pu5myGCeB9k6mStBtU7xW6gcPZE4pexY02WOK3owvf
         dKj7vFOUPDy96pftW7hcUvaZKTnfW1p06JjDx0TxhRfZq0PWKeYwFg/4bT1UQ9gyHApr
         ODgGGPqyW/wzkkC3m+p6J1p0w4VHdGMArmNUJk5sjEUKDbSQVRQ51E4Un8zfkpPDgSIX
         KhRSmlR0SWuwhhByyulotmrQYV7Etdo68ZC725pT3XwkXhu+G/LwF7cr/AsK19RvigZk
         6hPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QAZHbB+c1KWBrH19DXPv7Y0Fcx+ytwVPsa2l7SjZi48=;
        fh=gzzF5xkH2RskWjVT7hRF9Z9i8mVi3fS2IY+04itykbU=;
        b=dyRpL69SuYfdnWHlpvOAT6u1695hlWqqquhff+zGyJLysOQ7AS11832y8I7L5LNbLa
         EYfy8UhIQ/nf/DGQlujNH1ZvhW3BOFQof/bCVxQgr7w0jN2kbuJwPgNPAuQaj2tKQHHm
         H9Ott9qTAhkzNb0VTraro0K6eVqSmTrG5pkbzClSsnoqekD3KEhCz9fam8/CFtdJpq0h
         muGTkH7EBYWTbunNeMZPb7kjxNwpmtUkEgb1s4avFDpJuVq8n9WlgA1jehWVaVbEv4NU
         BtTnQMtBntZOM/xfqgrnDx4iqJh2JUdT8EzSE9JiPVWLEXlFypsQZrWEJsExssYbLzn8
         8J6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788277584; x=1788882384; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QAZHbB+c1KWBrH19DXPv7Y0Fcx+ytwVPsa2l7SjZi48=;
        b=eVIgAbu4HFPHFu4TAvgA7+2S2sT3XmJdp2PwB5PpI7gzaogiPEi4A9BIjMD/RnIBLs
         CrLqEbFMs9/ZDXaJdlqPE07GWJOJZmeq1XAN/X2xWPIPF598hSWsqgvmZJi6SDgB3sRJ
         F9l3ne/kItqtbKhyrq+OnTsL0erdyT8QAjc7apisErp+QFJ9pvBGt1G4FD0dRRVLU+Vo
         DVpL73yMt2e70+d4kCIu8JfCxO2rRWMdvnMIUqDbCM6jH2prYoA+1TvmvBF96YVqvJvO
         7MkjEvOfNP+LxYue/UwbnLBkWH1tMFA+MnDbQmJrZvxJRdcOXIdMGKNXGUoqCtzHC52b
         YoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277584; x=1788882384;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QAZHbB+c1KWBrH19DXPv7Y0Fcx+ytwVPsa2l7SjZi48=;
        b=IqwQJxKTOE7oWMglDUOKNm0IkvH4iP5aDXDuURkWh9sSmRuKZ/h1d/+YzPQOJHfcAA
         fV190a9PdVE/5WJCj8C64PIQAPI/lTuylfiYScxwH1NgFRVNZwXw4XplLlfeKqbhDB/t
         Z5ajC8X3cKMLwKpk8RJ++9rcYDEY7+lrkaP+nvlaRL7CPGGF6EcCuBoYaTFMYs6Dsew5
         Pw0QYg0odEy55t9akOqxx8XO9tRpnpxc3oQ3Utx7gw/jRw9uJLxMhGI6gkUC+JSa1b9y
         Lj1B8en7D3l7sIaerNh7+6CnS9+WYzchfZaKCul8isQ34pHsHZCGQdrEuUcZ28/mcr1D
         4AlA==
X-Forwarded-Encrypted: i=1; AKwUvBw/0y1U+w6kAo/WgmpEx0OxYXwT1UCkNCVL5OfZXpJQ3nccEgDUjwJrKE95brdmJkGAsMrnr9oNGQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nIxHsGLEZE4rGEeQqjDE3iV4nnTr31aT7cN9Pcxj09hrjBa2eW
	64acB/0Q5W5YtBypWiAUzRKZYRiiSRdi1Z1lv9cf3SMO72cpsegq6PI0DCoONvo4k/wUur7zX8k
	agcw7wHYZ0rq5bLshdx6L52W7hCsi6lH93yCG3g7QbJnXu4zGcaq2XLLe2r7YG+NR2uBSGjRsX4
	sUtBqVd5E5OOojNI9buZPRw3lEY9r3PdwDC6AR
X-Gm-Gg: AYBFou22Mqvbrq0hO/D8wuPW4mJtZBTpZLRUSEZKmAnpZP3QmRq7Q1ymhUzaxzAitVz
	CwJVysa6u/LGSlkUlzPPoIsyKVutqYRbh0o/eCoEO2XOQfyouMq8o0T0VDNPv8wfaCgy7cD6RqR
	0jPz+CHzGPRgNEBLcRg+6HvyapsQSeaT+AuFCApqp1bzyYRij5M2wsFnygMA==
X-Received: by 2002:a17:90b:164c:b0:398:baa7:4c2f with SMTP id 98e67ed59e1d1-3990f79ddfcmr3891985a91.5.1788277583835;
        Tue, 01 Sep 2026 08:46:23 -0700 (PDT)
X-Received: by 2002:a17:90b:164c:b0:398:baa7:4c2f with SMTP id
 98e67ed59e1d1-3990f79ddfcmr3891921a91.5.1788277583296; Tue, 01 Sep 2026
 08:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 17:46:11 +0200
X-Gm-Features: AcwNN1UOgtX_S0RX4JszYubxSoHCtUSFoVM1QL-GMxkUwhBphaMhOq7ZdQsciOw
Message-ID: <CAPx+jO8u_w417z-z_2fkQcody_sYbijHWTowZ-RsKH4Yw3xW5g@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] Add initial support for Qualcomm Kuno SoC
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=beZbluPB c=1 sm=1 tr=0 ts=6a96f350 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=_uS-18hJZPm8K8KRSTQA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEzOSBTYWx0ZWRfX3qJGuRK0YhPk
 R0RKtUbznbZYb/I7OJPXYVkdqdSjoJAQzmY2i7YJ6FsIXGQh5ltyytChnMstHHMnc30RtVWYMiT
 k3A+eDX34ojlxRJOKdaOvH5+k9MlcaTplQ0BuSM9W+PICmlBuASvPO29bFYvVFOQk8VruZgpBo8
 0LCgAapMUpS63b0KNrlY/pKNMpZXbpE9EbJrJg0AAGsY8oVx/F6AagGBTzL9LEMBk/ktX6o42Bk
 Nskxmzb3qcegQn7WuprH98+rLnvRVJMRy7ija00YMp/gjvTysonlRjvX/CVaz6yL1bbcWGVhxnL
 rCNItzICWZHntqWB4Qr8imRWPRg3ihIL9D5DHj0pFZiWxcqD9O8C/r7SNGZUg7D8pS1OtXhajn6
 f7f1V9Fq0Wpmyj35b+js7dXFGg3gX8Vw9cS2G+jntRzA8uGihUspyPdVkMY2xQekiNSw49JFLfx
 pF68TkZwwrFgI34D2Sw==
X-Proofpoint-GUID: WvcmXbyCxjQ2oKeArqip8Kx3zBYC-njX
X-Proofpoint-ORIG-GUID: WvcmXbyCxjQ2oKeArqip8Kx3zBYC-njX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEzOSBTYWx0ZWRfX3swyMcKC1OH9
 VPSUO2zPmHppcEwBPrJ8dM7T8+CgTFsXID/Itx2rUVu/VN5HVo1+yPrjfZAdUx19paBFajQpal1
 N2PkVa1mRVCxwTRUs0+jO6rOcdqJ2wo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010139

On Thu, Aug 27, 2026 at 7:51=E2=80=AFPM Hardeep Sharma
<hardeep.sharma@oss.qualcomm.com> wrote:
>
> This series adds initial support for the Qualcomm Kuno SoC and the Kuno
> IDP reference board.
>
> Kuno is a 32-bit ARM (Cortex-A7) Qualcomm platform. This series brings up
> the essential SoC infrastructure required to boot to a serial console:
>
>   - Global Clock Controller (GCC) and RPMh clock controller
>   - RPMh power domains
>   - Interconnect (NoC) provider
>   - TLMM pin controller
>   - PDC interrupt controller and SCM firmware interface
>   - Devicetree for the SoC and the Kuno IDP board
>
> The soc: qcom: geni-se patch allows the GENI serial engine driver to be
> selected on 32-bit ARM Qualcomm SoCs, which the debug UART console
> depends on.
>
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---
> Changes in v5:
> - Selected QCOM_GDSC from the Kuno GCC config. The driver registers GDSCs
>   (added in v4), so like the other Qualcomm GCC drivers it must select
>   QCOM_GDSC; otherwise, in a configuration where nothing else enables it
>   (e.g. COMPILE_TEST or a minimal Kuno-only build), gdsc_register() retur=
ns
>   -ENOSYS and the clock controller fails to probe.
> - Link to v4: https://lore.kernel.org/all/20260827-kuno-soc-support-v4-0-=
dd34f235fc1a@oss.qualcomm.com/
>

Patch 2 and 3 applied for next, thanks!

[...]

Kind regards
Uffe
