Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794657007;
	b=Inee9QmZCrrXMmSFkKqkHyyu6RnUa7RR3K+uKNJ0zktqHRs0kxLT1BPcz/Fpm7QIOr/r
	 XqgGXgyVwu79Y6AyzvcpB0WseRG5Gl2kpKf8bZb8CB6QAi/Roah0XGBOYU4u7hk2+42/k
	 HXT9i6sv+7SpN9gy3dYRdN0gCVshU6DIrjPcX4G9aHylywYa8MaPr7bPoBDpzauXfXim8
	 8CGOcxi/7pagbQ/14cHq1hBtGS5AybDl9S1qE0fHznAQHhtLHTCO2b3iag9vB9vlABRCB
	 DvdilJZ5EGQkbZo2+hXNqV7Q3FKGsOZ+sUraLnZHf4uC1FUFxw1XPEAOWwdPRwN6dDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657007;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xpqEcbdryqmNzCYBxrtc+JnocUXAgJ2tF34/if55qtA=;
	b=bPeGlgQig331Gj3cMUwnSh+vfL3mT3+joO+lJTW/1bnw/KyX2poZD0PLe1nsyraNMylt
	 gu1g0WSP7M0thcm0mc6SMvdynQrsDL5Vtw/fWy+ysW9+U+hWoqCkdbkbw3nylcdJ8Grii
	 10XSnm1+KSfRFu+F4KqyR/mmjTBTWjTncWhfgr7zAM36jNqr2EjiC6sTyarwia77ghpwm
	 W+xVVV45pY4IZNBINF9b2mIY/eEX0zIkqz2idrKjdl8KiFNplFcvUBDj7sljxTP+2ndL4
	 QcNApAWCT47HlJ8f8TBjZrrnsg4VVoeTwfxnsyVpLasV9/+yJ+ldQFx2xJL9vZxZpMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DaxiCRDw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IK9HbKnk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31377606A323
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31377606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DaxiCRDw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IK9HbKnk
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9wT8e2055371
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xpqEcbdryqmNzCYBxrtc+JnocUXAgJ2tF34/if55qtA=; b=DaxiCRDwL3PG3tCb
	P2TkTlCM0rl+gfK85hrsUxG4n2TT9RA/LtbQMPOxeNQi4Xh6rwHSEopBiiCY8l7E
	ZBKdDt4uyDIXHELwKdDd8b44MRuh0pVIdutbdk377XIRVhwiEv+IwdrDfS80eKe3
	ThUGOB3zGZvFG5gIckQK8noAFQcVvXgtIUTulSX/unndBrFQIov93q9yEWoNoZZ2
	8OgVhLb1pxzMiILe7mr8EFsRiCwBU3uHvc4aFCWMAajyl1Cp6VvZcjBtVkQ+ge2U
	SAgKuZHOz7f4wdfZAymOKF7jfMcY1Q7RE/x4E0nrgJJl81pk1TmsuEflwVgTPSet
	SikTJw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmc8mus-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:50:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b167bc8e16so1597044a91.1
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 03:50:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794657006; cv=none;
        d=google.com; s=arc-20260327;
        b=dkTBIWhCF6TDdCmIyUNlOo2ru2IHbnkbr1RFPPg872tooI9kb8DbmQNfC9g30qy06T
         AsWyLs9ZF4jFBnpb+wSd2WvIGuRi1phPNlmZKLc1WxJHY3DPobn7ghULULgvW4xJ+aPd
         Cz3Ou1JrT8VXHN5bhz28s4CDLGqZp4yDbmDJk42qAcJ3saj5vrcTrqhlKwXcs4P3gait
         UNvYF8S7EokyD+NeIB1X5G+LiGpJg+A5IKrRH8YtF20vvjQjFem5TYNXXXVebsnAOHqu
         QjXa7/aU7Na6YcAYKNvNz5//54ngO/k9bI/WVx/ybsmYAjqro8U1slfBConxd4R481m5
         sIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xpqEcbdryqmNzCYBxrtc+JnocUXAgJ2tF34/if55qtA=;
        fh=IbQvS9rx82OTF5HarDjjrQdt4+jsOHDKLkoVOuRSaak=;
        b=ZVxLmUf/LeiacHp1bKalgsDzbvs8lu6Kid4G8jiHbfK6o6IG1T6DUAKgkadcyxbdTF
         GjyU3dgCmSRj9p+OVYn0DTq8/prWMlikUiEsB1Ngas0gnigGHCpv00M3C+gdIY37xFQI
         USjKqpGfWRCW9FT0Bd3QaGPpRG8IMqlPWBSs4miLSEXHq6vzP84jmeL5MAkYNeGGpeRK
         TFLkdDtwPyDZRKwm4ezaUXcYE7itVq4d+0/yQi3Gw6qOzSRg9iHchz5eVuGIft7zubfg
         nkslMgFGKwvQRtXRlexQ+uuVwJ6bH0C6hK4mPPZTsVDcQYV2c6FGZ8NaVQjUmxEzHdw8
         MldQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794657006; x=1795261806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xpqEcbdryqmNzCYBxrtc+JnocUXAgJ2tF34/if55qtA=;
        b=IK9HbKnkGe9S2hSamsqxWCvy1OrPPN0IntMGJY6EVqdPkIZv9XjDTStPBEaGk3BiSO
         LorTJL2UV55mGIQmotnekzqGErOv/MnWApbhsvxbfwBsDnYKllPCw4gKpnpwYQNtz+g3
         /A23UERJzFigWHMd4U4K0UiLFqWNUDMXeWhbW9hQgAupaN0VLqWmNk/jakvkL4r98dmv
         0u+woWy8ypyQyVQLn+PepyN3fZZ9kUaFMskcq8HKOEpiYezrmCdqryIC+YK8CvDlCVlR
         8nxK6b0YuvJORWoN8N3Br+VNxg9ZnHsxevj93TDWeTTyCXJ3YaCnF/ckn8uWskkl+4k8
         REaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794657006; x=1795261806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xpqEcbdryqmNzCYBxrtc+JnocUXAgJ2tF34/if55qtA=;
        b=MBHKU0kXyt7ZTH/1qHqrx7mDf7rvPlz1Xi1ZxaRN/01qYsnYZi3nIn8F7PPg9kk1Id
         Zjf3EKfSVdZTbQE/FA0KEEnZ8UUcJqVsbwpjHbRZ59SitTMh/zEGNeTAIO/iN+RFtE5e
         t3GYhBGo/rafb/PZoY6yfx4KoH3guRMAqEGh2guxKtsQNikgj2NedP/mGNzXCGD8KnS+
         mbDSTcD6opq1Dv7D2fruhQ6Tzj2IaOo9imEm5POU8z6+SSK/JfXmH+ee329W1EKvp3At
         C/rQKNVwKYW1sAyyEiFTTxYTh1KTlDhau0HiZqOChfOWh8+zjefVC/4nq1hyHzTkDVOt
         U8pA==
X-Forwarded-Encrypted: i=1; AL+hErF33Q4AXhoHqJGfunLfdIIg6+jrFLhY6A5muj2uzMdncxilvrwk6dpmTFLlvKU70BN/L0rG0VREfg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8X7+h8lNRewD312hvjY3P/jWXLjcr1BjVm2DRpUrqFRCtFWpWh
	6+tNA6hTiZQdFWD4SFKmWc3QSk1ETRQIDKUDH1pBO0dQ4qMkasSALUD5tvOJP4ljhhi49/pSQm/
	oCp9JaIRka9nZZ1MaJZqHqdvkdI58KFngxo9k4xCV/Hm6tdgVJOnr81Zn5MN6hpsu6QmnEweald
	42meBIRVZawFQif+5S0WR0o/TIn3AvWRlBteqf
X-Gm-Gg: AYBFou0ZC1b6vAMFDh76SkkK7M/oZCyA/sNCsnd6+7LvSbKEYIVOANXRDNiiz43LBms
	btf34jzLelVbqBCZkQFYmnq9wBV465WNaeGTnG6RgTdgMF47Djzrd062NpnW7tQKowiBxolpyqM
	csg8yiXZGAJKbgSUfmesGaJnb9NZPYkvsGN9W/RIELc8X/OfNSR/PbPzeWnQ==
X-Received: by 2002:a17:90b:53cc:b0:3ab:31e6:12fc with SMTP id 98e67ed59e1d1-3b1b05f1336mr4921131a91.0.1794657005610;
        Sat, 14 Nov 2026 03:50:05 -0800 (PST)
X-Received: by 2002:a17:90b:53cc:b0:3ab:31e6:12fc with SMTP id
 98e67ed59e1d1-3b1b05f1336mr4921116a91.0.1794657005151; Sat, 14 Nov 2026
 03:50:05 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-b4-ux500-pd-genpd-v7-5-v1-0-4b4f256f340d@kernel.org>
In-Reply-To: <20261104-b4-ux500-pd-genpd-v7-5-v1-0-4b4f256f340d@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 12:49:53 +0100
X-Gm-Features: AclHuK_axNgphK7IhZrFmTH49ktgMX-pB6-EJIJzy-Lm68sB7H48ZpM-YM9QxRM
Message-ID: <CAPx+jO9x8h5GU7QN5DGzdyecwCBQSQNExgdZwkc1+Uk8Xdk+Rg@mail.gmail.com>
Subject: Re: [PATCH 0/2] pmdomain: st: ux500: Implement DB8500 EPOD power domains
To: Linus Walleij <linusw@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NiBTYWx0ZWRfXzyTHfg2b8e4s
 pCqL+ykf8ud6rkzS4FJmnOOO2KSOQDKxdaO42ESPJf44XaryHYyVT7uwq1EONPF6Il+fMKOA/dY
 JqoY/oeVUzSrLfwLJezWCPBkQPA4zoo=
X-Proofpoint-ORIG-GUID: dQcQoBiUI4PyzwjMiV0mrGYiZYxfO_Kh
X-Proofpoint-GUID: dQcQoBiUI4PyzwjMiV0mrGYiZYxfO_Kh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NiBTYWx0ZWRfX5aHUZeoDg5Sj
 afxVqiD4Yx4+xLPFdEgiV9ublopRfpeupgx/VxA8F9TBvVR/zBVYDucLbxWqWLhIutIJfHUEPlN
 9sgh6CnbkLdMqxwZDOGMr/d6KRgEIaSAPbu5YcX6NMnPUFpXCizw6DemXKPjiVN+qfuOCGQdzpr
 AwVwK1iQTMUaUq3Qu4+HA2ge2DOOz4RZ876BR7pl9n086G3z1b/QCHw11QJvO1U99Zj+AtIRw93
 PnNrCAE1Pmw3WF9Yo/LtZzZprt2UpuX9KkT4nJIZqM597sxmruTHU3sGb5jCW+b7ujgdgQQJUk3
 4gsFk1UsFpXQJcSPITEskj49drOv8r1/XtQX3yjfauZfR/rQe1KK5mvfijczpdlmkGOb9haYrVG
 t4aDlHgRbbYaQVatrEMMubhcNTnnhTjzBubv8ZFCY2+5aoTL0un+pq75G5BFdF74+3rAVCC+oS6
 f6zSd9HbRtmGCwcDovg==
X-Authority-Analysis: v=2.4 cv=Vpy2kO2n c=1 sm=1 tr=0 ts=6af84aee cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=u7PySJCRRj_KX966CyMA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140046

On Wed, Nov 4, 2026 at 11:51=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
>
> Populate the Ux500 power-domain provider with the DB8500 domains and
> implement hardware EPOD switching through the PRCMU. Voltage domains
> without a hardware EPOD remain bookkeeping-only domains. Keep the legacy
> EPOD regulator driver mutually exclusive with the power-domain driver.
>
> This two-patch series is based on v7.4-rc1 and targets the v7.5 genpd tre=
e.
> It contains only the provider changes from the wider Ux500 conversion.
>
> The related patches will be submitted independently to all affected
> subsystems once these patches are merged into the genpd subsystem. This
> includes the MCDE, DMA40, SRAM, audio, regulator/MFD, binding and DTS
> changes.
>
> The idea is to land these independently in each subsystem for v7.5
> once these patches are landed.
>
> The patch is split in two, if it feels unnecessary churny, just
> squash them.
>
> I authorize the ux500 Kconfig change as maintainer.
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> Linus Walleij (2):
>       pmdomain: st: ux500: Implement more power domains
>       pmdomain: st: ux500: Control DB8500 EPODs
>
>  arch/arm/mach-ux500/Kconfig               |   2 +-
>  drivers/pmdomain/st/ste-ux500-pm-domain.c | 269 ++++++++++++++++++++++++=
++----
>  2 files changed, 241 insertions(+), 30 deletions(-)
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261104-b4-ux500-pd-genpd-v7-5-1048f61bc405
>
> Best regards,
> --
> Linus Walleij <linusw@kernel.org>
>

Looks great, applied for next, thanks!

Kind regards
Uffe
