Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8DA381EA5
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940794; cv=pass; b=ult6+U6P6Id4Rq2mIwHNQWzcGKCNZgwvq1GMZ5LKayih5iQhLxfw7XFCFIpUtXD2PJyHh5146OCWszZYYcvdEp+icKIWsX0RrhIAGP49Q5wLVG1MXt16OFJH+/VXdja1w+PfkvtSiyI9ZFbsaAr4hahJSCHtVulobqXXr9/kR2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940794; c=relaxed/simple;
	bh=MbtmAi+FOchUB5sRsMcx/CuY+j2+KxEpVaWxKhUk2n4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srZ72LwSceWDpcPMWk3/KgPl5YRQfAHGWKeN29C+z8NmaPEeMslddVMIw4DDylDtakPIB7pFmZbYxdzbDD+kY1FEAyMcz5XHHWI+s5b29yEZAyxITCxURLpWAWliXncmJd5qWs08iwmhq0KX3Fwp4o2nnunMraweInoo22NX1AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DI8Z8pG3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AKUUOrqT; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DI8Z8pG3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AKUUOrqT"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DB3LD5507315
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U9tA3tFtTdnt2OcqRFhofQ3tr91DLiJW+I+IyBckjI8=; b=DI8Z8pG3wdQMwjdq
	NgShZmtTxQEhxFPIhHzG7Y4XzDgWQeVTDEJ8TOU+sxTGh15y8yWG8xKeHQ49dJj1
	e1p0ChIPIxcRutKhsC56jX3fZi9FPHm94PFL2LzrkVexJq/LKYNIMZkY2kKYcSM4
	3SnKeDl8psgTv6f77tztLtl44Iq0WYPTON+OJaMaolB0PJeRapF/1xLuUCtLfzpH
	k7E/XBBdkNABekqxi15zBOSFJJHU/dWX9lSnwoR6piA+mZOqBdO9SRmCmGIEZTod
	aqUbXvFwWjULYAw2EBIt8TtjflJc4IFAv7Sx01pCYRWASjnU3XysIrGW1Z+sCxVP
	RECV1A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fctc8h5us-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:06:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e820609d9so250432885a.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 04:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783940792; cv=none;
        d=google.com; s=arc-20260327;
        b=Ljym2BvNx9OOIWt3ITtubIwlFvPWFp9C3+Qp6hsFURgyga8Xw9EKuziHAuLoXP4Z8U
         FpUtIV1oy1Lrk3s7M6aIOODSXEY26FEEKtZs+6qevjc2fzqMbXkOz+7sFtp7kVT7gsFa
         VETri2iWfrfjH3QO97OwQNjcYNCKnVlXaRKzs/1FsQND7zygDHk9dxGrYmqUSc6dS4Cl
         knLMpiDNwuGd4eADVxbojNjXeJLDxCoG/YbSs47gKICHyiOGzQ8t+iGgf65yvPIwFitr
         I80WzScGc8GRLXKCcwwW73nmJbZ5txT0DwCW1HF8oYodpi6kwioSiQ07XmgvwiL0WTih
         EHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U9tA3tFtTdnt2OcqRFhofQ3tr91DLiJW+I+IyBckjI8=;
        fh=A7arUQX2eL0eFHIcrn3OUFSjGcPSi7gqntQZ3YU5szM=;
        b=mhlg1YtUEqFAUmourS+NnymiCkWbHq50IiI3Q/0HPdBHXBwcWpR/jdiu3t12X/JdOf
         u+yi94fakyQa9cQeBuB9GTqPp9EanOXHxkeHZ6ZjfSUCoKiGFCUEt4bTI5hQqOKJMaqS
         yRk4+e/ghWDtmgyXPXuEYJ7BmvDKDPlgsd5hXSuwq8F2I8C+SryBW4JXWLjXt7slDVfq
         bsj6aZ6LFj9YKt+vva6HzejZB8OChDvlbqxBsgaLnRzeJFRUZaxoCC5ySs4OPEBPDWFl
         n2ngJXCOLsLlTrz+Kbdv5RK34SI9tRN4B6KLHCPs2r2J50E9St8e38HA0Ku/G36S2xU5
         nFOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783940792; x=1784545592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U9tA3tFtTdnt2OcqRFhofQ3tr91DLiJW+I+IyBckjI8=;
        b=AKUUOrqTLJXdRWvkv+DGVWXncK2g9dIjVOkE/mfxGVWPgGipyhRkl/VYKoAu6xoCqD
         elU+slRUNSoXPH33WiFxQoiBM969YW2ggwzSotT5i2zCtvLab4nUnqoEJS2i/3qbl2AO
         AYjMGbjrMd+XclhQ7AtOpQSaUR1gPi6BSIanJHPptfNe5VTwWHFzIraiIJ9kz4XTnQQN
         scHlvn/X5MCWnhRqKuB8Tea/D1I3gNDjWkEoZJMlBX8spoNGkWUz2ZhOMxy6x57PxtSv
         8K4HpwNJSFYK4lMfv9+q314KVISpPbkMt8vEUJhy1EVv9UTNajcRh2n9vFWSVZ/3m+cS
         xTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783940792; x=1784545592;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U9tA3tFtTdnt2OcqRFhofQ3tr91DLiJW+I+IyBckjI8=;
        b=ni78I0K2Y0OIjC0oYIEvnRZmo+FFWI66zLToSTSGld1TwxSNZAnkI6XAUfH+4UzmvM
         kHVhZWK5S4bUVXqBsrLsi/hn3eRKI57R4TAT4Pyk5P95OYeseFW2cpS6vheZNA873Y7/
         k0VJwZr0svTKasHwXOkp2NLcrmt/kWnselMWnfm0bb4eMIEcDdhaFOAvLHPd8TjORLvE
         WJw9C+gQr4VbOMOk+1kNVX3vbVxKph48VRgK7lmFpL+VgDkj10YINXaUB6MM4HYq9VZ+
         /aTjokODkBrQHr5VbY4aM0TyC7UvvWMa7+Zh10q1Gs4m+6KLfZD66KoCZE2jbay74hpa
         dc1A==
X-Forwarded-Encrypted: i=1; AHgh+Rp/J8e0tmF+D8+RNnJkjJ8g8YYJgZXa3OqjERkj2B4Fl44YTOZhoVFu/6MvdSEClt0zborSnzYupw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm00Q/oehPf2pTBoxCFHyNF2mZLwzo7MSDGFkvfhChaiMsTJqf
	75fBW2Y6uy/WEOv6RCfysbLoF5EnfdUKYW/PqWs2NEDFS0sfl9D/NNpvUgLXV9PlHfScjmTjB32
	LTy/JKtOfIS+KWwvYMi3QgacUN00c7L7DmNB6CJ+UfeKEMbeib+zUS56ELGAfFJH9NNc3r24QHU
	9tbOgdp1yR8dFR7aRFuJGfqUj4k+Q/tWKHC8Py
X-Gm-Gg: AfdE7ckHxmjAilgOV8EDkSZMikC9m0siRIjHM1tYnm69WfGPniSgCIx6SMdeFYF5UrY
	J7bQOswozDLVWIstD7TYxtkrd3RLs1oy/1Hcxv2Hg0kpXgIKTDetfj2iQZoibCHR4uaUnMD8ZAc
	yFAFBJynF0M4qh9HHQasRhg4mt/MHXDpgUnBFEuAjEvNu+En85PUvUqJEhbl92Io7Wa0GE
X-Received: by 2002:a05:620a:2950:b0:92e:cd78:9244 with SMTP id af79cd13be357-92ef2e26c76mr815025385a.84.1783940791847;
        Mon, 13 Jul 2026 04:06:31 -0700 (PDT)
X-Received: by 2002:a05:620a:2950:b0:92e:cd78:9244 with SMTP id
 af79cd13be357-92ef2e26c76mr815022285a.84.1783940791449; Mon, 13 Jul 2026
 04:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709084635.24912-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260709084635.24912-1-angelogioacchino.delregno@collabora.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:06:20 +0200
X-Gm-Features: AUfX_myTjQitf9mLWKDNP_7823p7zFAcgW6QTMG2dOgcyWT7UVSwFMCpk7KVrgU
Message-ID: <CAPx+jO-_KLM1Rhu0G=hOx0aLr+XT6X9w9gLui=aHjSBgDkLMoQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] pmdomains: Fixes and add support for HFRP Direct
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: ulfh@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, nfraprado@collabora.com,
        irving-ch.lin@mediatek.com, macpaul.lin@mediatek.com,
        aford173@gmail.com, mbrugger@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, justin.yeh@mediatek.com,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: dECYYVrGMKBMbZw8nIPFiKElAkjnVNbU
X-Proofpoint-ORIG-GUID: dECYYVrGMKBMbZw8nIPFiKElAkjnVNbU
X-Authority-Analysis: v=2.4 cv=UtRT8ewB c=1 sm=1 tr=0 ts=6a54c6b8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=QX4gbG5DAAAA:8 a=1sG5g2DzjvmgYBam1ucA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNSBTYWx0ZWRfX9tDDLxmeURvO
 +ljmVj1l6l75L316kQMVun2jI3X4gLIZP7r++54HgiT5Z7Oy6Z6qgdrIJ9MRWxpf9sn1OD+2NVb
 yizsECLQAqnlWzYRNSEhPO2I5nMrMVE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNSBTYWx0ZWRfX5L8YjCl0zGOM
 luiatGptuv0/I5rAwVhAquqkEEh6KSNItpqc7PafGPFiabSVLpO8teD81+5spYAC6efsMULLtAj
 a15Ihp7pUa3E1/41lQO7XulJPK38OGY7udm6M3dG47Ehv6Pe3VBO5/V7tobGS4Z1bI0bZ5aBdUQ
 +L2RL3a86hoHNQphFjuUkP9Bqux82vvZ483d3nr4dikA70pBYMgsR9YHQzO0fZymLXRC/SY46BE
 ivurZsM4lzmKU/1PFS1944iqXMZZTlegcCJ+2QbctNOAl5YvISAq60GgqdRMZYsxF8lmU9gyxmt
 uBst7fJ8PLeIMS5RzyWhWAxyjfAlpY1KlCzsZ6VRMiE0aeoEcHb9//7NCN0RloT4i8wRDE/CEe/
 NUpHuO0mLh4qSPXMfX0dV3h8W4zUbhdE5OMArFb3L9sZsv1QcbzW94Sh2DmFac9AyWEM6l1bT1M
 nyAyYPsFSqFTNwIYkCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130115

On Thu, Jul 9, 2026 at 10:46=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Changes in v3:
>  - Added new Fixes commit for possible null pointer kp during cleanup
>    of internal on-check
>  - Added proper error state cleanup support for SIMPLE_PWRSEQ domains
>
> Changes in v2:
>  - Fixed return value checking in power off path
>
> This series adds support for the DirectCTL HFRPSYS power domains found
> on the MT8196 SoC (the ones without HW Voter support) and also adds a
> fix to respect the power domain relationships during error cleanup,
> which avoids HW lockups in case probe deferrals in the specific case
> of "almost fully probed" power domains (where most of them probed and
> got set up but a probe deferral happened almost at the end), behavior
> seen on the MT8189 SoC during bringup (but honestly I have no idea how
> are the current ones working fine without this fix...!).
>
> This was tested on MT8173, MT8186, MT8188, MT8189, MT8192, MT8195 and
> also on MT8196, over months of development, both manually and over CI,
> with no regressions detected.
>
>
> AngeloGioacchino Del Regno (5):
>   dt-bindings: power: mediatek: Add support for MT8196 direct HFRP
>   pmdomain: mediatek: Fix possible nullptr KP in HWV cleanup/on-check
>   pmdomain: mediatek: Respect PD relationships during error cleanup
>   pmdomain: mediatek: Add support for Direct CTL simple power sequence
>   pmdomain: mediatek: Add support for MT8196 HFRP DirectCTL domains
>
>  .../power/mediatek,power-controller.yaml      |   1 +
>  drivers/pmdomain/mediatek/mt8196-pm-domains.h |  27 +++
>  drivers/pmdomain/mediatek/mtk-pm-domains.c    | 184 ++++++++++++++----
>  drivers/pmdomain/mediatek/mtk-pm-domains.h    |   1 +
>  .../dt-bindings/power/mediatek,mt8196-power.h |   4 +
>  5 files changed, 184 insertions(+), 33 deletions(-)
>
> --
> 2.54.0
>

The v3 series applied for next, thanks!

Kind regards
Uffe
