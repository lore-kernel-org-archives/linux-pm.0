Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6043E48B
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277590; cv=pass; b=ZGrhpTiMHTumKmX/7EYqV/FLpu2VOUauICKoqDay6m9y9gVDPLZ+rJ3vrKE/tJpaWoNHMb1YQerTpxBZJS/noWOLOflOzcn6YRb0oYuydVj0dxVTEJQ0rFK4VznyLyoRJOFkbSXPv1wuT3NvR3yz3S7OM+UjKy8mO/Do3o7ET60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277590; c=relaxed/simple;
	bh=2hiFglIyELsVUiYPyeBzEQYmuk8ezgG0ZJ820CL46r8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcLFsGmTHLRO0dJF/CYq+u0Lbwfx/dbTJGUn9En11e6/H97qLaAjj6tV6+z83DfX2TuroAR6PrMuHtrVECEi1Cm6KMVmsNlpW0fTObCh8Y5ZTTc/QRMHvPjh4Yyp2JDv7NP/5ISLgaRPB13oDfaxKEu7JkBrNW/N2xgwXKtgRqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bt5M0ggt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mc8G43FP; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bt5M0ggt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mc8G43FP"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E8Y063495522
	for <linux-pm@vger.kernel.org>; Tue, 1 Sep 2026 15:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FeaQdHnyQUVUR9qe3Nys8gzsKwJQV3ZOdTi7d9wCiuI=; b=Bt5M0ggtxbG89sc+
	BirZoRkIMnGGCvu9cLn8DtXIJcsb4LpkHvHlb8fzIUERmgLg/QNZAbGchT/zBlta
	PrSTgamXN8kbQDu0MY00sHlSx9ejf1v1y7jUjEW4ks5UEZ2CVPglweqDJ6Ep8bta
	HZjX/gZA7COIc28EA/LeazfE0kAWNDftfjmc5qy8Hah/K2VHHg3Z/yporOq1cPa4
	8+WeM2u6qBRbjQvFUspS7xo+wQ6k+Sl5AeuVKwKAyC8Eclm6W1yzoepIgnUxYJon
	LLMaEhbhKh3SNPn7K/D/Hs+OnBBqZsp7TqsUvK3Zy5a/Th6ctxBxN0kUcZqIfhLU
	fCD67w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdy9ngsrx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 15:46:27 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso26287a12.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 08:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788277587; cv=none;
        d=google.com; s=arc-20260327;
        b=bKFHvke9u5Lwa/rBEA8AB0BSwR+qFR4hAULcfnolcFWln7Fr2Jqk5EoGDxiaujfSLx
         GXomcSpbtr2FkENj5W7QXmyxa2PlYf6WxLP9mc+DP06s1tnDyVgIw1E9EMosEPsKO8Gl
         inMc7nN8OXMjZGLd2s7OBziWiGBgb71roFFg48HQ2ALIPlHxe5Gq68ShO9H8MqyY5CzE
         P70YTwJHIIuAQGCAWcjV74F1M0wnih4Q7KsFw8B9iCkzHYHTLM69WPg9W5yM3Ruv5iVy
         xItompbbEipG4ue74r93ZyiJd0l9KmJyv0tT1cX8XwmbI/N+y8aZhpZV9arR2djQEle3
         ebHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FeaQdHnyQUVUR9qe3Nys8gzsKwJQV3ZOdTi7d9wCiuI=;
        fh=AO4GaEelFoVEtCVhFmnM2snyyBxdKoQW9kH1xak4a30=;
        b=a5BpNeB4kxeP6fL0PZKmjlgPIelrvUxKkDkIJEcdTxKu6/BPpkgCMA1+H8HAnnz2S0
         sBuJiQHMdfm0wVtyxL+h+WMD8D1PX52Wvoa04osFJvlHdzMqBQ7ieSP2WtwV+LW2QRIB
         wpm+L/aMVN/rWkBBT0tOEo2SulWx9stsocWEbHe9MkdYItKOtdH1IfTWTYP5htTZgIy1
         btP2N80jAmccVctSxfh3cnblfc8+UX86Ry2Wr4RJTPCpV349dAWSPlxOyoEDKaR7XJ6x
         jNCD6Xrf5tkDq7yd+U77zyi1RLm2CkWSB59gf97/b9/I0AFra/5pefH/l1TWbXCYVXIZ
         bsOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788277587; x=1788882387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FeaQdHnyQUVUR9qe3Nys8gzsKwJQV3ZOdTi7d9wCiuI=;
        b=Mc8G43FP4LGrtYT3+YtNrSlh4wylYrOYZGb4BZcrKVa/vt2zZPhysJW9zgr2lVmCBI
         Hu/XLkB0dJjFSMsEKWpc00o+1H2lKEhvegd3QIOMn1aHFe3rYyw6Ngu94YLOYOeRTIKU
         mSyzINRcfHZiHksJov9d4VBU55yO7itgqeWThcO/JlP+kQZHMqT1Q+/xpopyWxVfboLY
         iBhKTnylozXCCvbaYUTD9QXLSlDSSwiTU5YVnJnqYeeeD1aPxlQa+tv1KbYaQbuerbpe
         fCYJ+x+4ty1LhZtH4qCXn2MmJAQUvnjUdflXbwEyoUq7o9uQcSWEqnRqa3Ia/oOPOSkH
         By+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277587; x=1788882387;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FeaQdHnyQUVUR9qe3Nys8gzsKwJQV3ZOdTi7d9wCiuI=;
        b=qlFZ8Bp17JJvtgfs8Nk6OFDQl4Kg3O65aR0R6OVfpRS0SIrnwMe8q1uO07BfvJM/dY
         baDEt/0yERXJ+bLqVABuMVDou2BffckccBfz0po6NtofAiaI7r7Ex1nOGk0/Z52mOyC3
         4ovyDx2+EKrzTIl8tNjNqBV4NP3XImecrPmZ0Pn1V91cT2lLz1GjBc9hmqsqb1Sczq0b
         Dc1ruE9BMwTxArtCMFCDAM52QPlICNUMYe72AIQ9wmiinJoVEIKAbHw1kG/o+KZ5qhu1
         8AsISGXH4kKbmwRNc/OJC/Wdipa5O2qqR71tx7+WlCgqfC7irzLwtVm/cwUBpWvMtY7v
         GV6w==
X-Forwarded-Encrypted: i=1; AKwUvBwNzkA7UjDt8f7G2FvOL4gP4/Nq7buiEPSiU7JY2vIz7psMiSy2Px36zEm1yYbzrh/KQdcLgK9KYw==@vger.kernel.org
X-Gm-Message-State: AFuF++kIaZQDdDeJu1xTii6FrwiHMaGo1GlXuZdKZBAWebdljCHWNQym
	XDl3Xlr/LINRhDnvDXaat7MIDw067RJn2QlyUuIzn4uPmllktthZPabak95vYLtCCPiWV+9Qlha
	89cyl8EHmZ/BItABLnce7u/mRiN8SYg4gW3DqeMjrBEmGVCUBvRwnnbpNyadUmOPBsWqvagZJkp
	DoGR3a6RrwvQoBCjeBawoLjqC6DnA2S1GrXAQV
X-Gm-Gg: AYBFou29O97hEpjEe8QLkIMRVPtZRH0H47AEEqQLekccMbkQJ5JszXEEMfvzqjtErQF
	Jq01opQ1HtNrmmXqdcs6dMZPYdSCvykICazXGURuIbIkaufcB+howRoPokv/j0TUWypGP+dUZ7o
	byZ5L07GPd6thjN1A3zmG0lBvEKQvuxN3nYL4R2vJ59qiVWu6ryDXarilzeg==
X-Received: by 2002:a17:90a:dfd0:b0:38e:b400:a860 with SMTP id 98e67ed59e1d1-396d0fccf78mr56207766a91.13.1788277587275;
        Tue, 01 Sep 2026 08:46:27 -0700 (PDT)
X-Received: by 2002:a17:90a:dfd0:b0:38e:b400:a860 with SMTP id
 98e67ed59e1d1-396d0fccf78mr56207640a91.13.1788277586732; Tue, 01 Sep 2026
 08:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901092447.3028-1-sreeshankar0910@gmail.com>
In-Reply-To: <20260901092447.3028-1-sreeshankar0910@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 17:46:15 +0200
X-Gm-Features: AcwNN1WvPfOmS-pECGpZIzaJnQAiHHylSoHG1ZWEkcxRplBgBJFHgfUmrIeCkM8
Message-ID: <CAPx+jO8XfaAJzjrO1uL5=0hadRLGtZsvVz7c-9P-+NBFwa-2Kg@mail.gmail.com>
Subject: Re: [PATCH v9 00/12] Add initial support for Qualcomm SM7250 SoC
To: Sreeshankar K <sreeshankar0910@gmail.com>
Cc: andersson@kernel.org, sboyd@kernel.org, bmasney+clk@redhat.com,
        jbrunet+clk@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        konradybcio@kernel.org, tglx@kernel.org, ulfh@kernel.org,
        radu@rendec.net, abel.vesa@oss.qualcomm.com,
        taniya.das@oss.qualcomm.com, danila@mainlining.org,
        davidwronek@gmail.com, mani@kernel.org, robimarko@gmail.com,
        linux@gurudas.dev, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE0MCBTYWx0ZWRfX17bS6Zmv+hKK
 vlyC6zWN+SqMbpt3wDxkAzgZjPrNnsaVI7csUKG9YSzsmvMpEi2ghmn4g4SmPl6Pe+WdZmBZVwy
 C8o2TNs2cKBSzYxjomwTIwtL3NioKho=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE0MCBTYWx0ZWRfX9ZuGv/SaxZQy
 EtBEgC5MzVnDkNYYmwybIMXph01SEqyG0snQhyIFSRGje1on/Mwu+o8uvyvacNsXnSYgLuXUV74
 PK+UAKQ2oLZIT3hl14mZtRoIwOOtxBu8Iu0e48hiiU+fAHnL68BDZyIEQAR2MnujaPw1xF1Z2RL
 t/7ayulz+BPDCrRxpovHutMk0/VWdqmBXvhTwLuKsNG3hP868UDBe2VQ9TSjZBSYxmvL7S2RGMZ
 36vNPYYbkwGCoA7pJuUJC+jUyY5ttTUj34znuWCnTkJUjcwmYH4XSSkHVn14+dpYeMaxSFu3Cex
 rUKBt6ZUH4aLDFqfDv4i3PgnO9uNYnVwSaHNp93z0bN2sAPOsIGjZi6KlI9fEvzbIXYzQbaIcBY
 rFKLbYX8M3qdFdOb758sIfSSu+Fi5XV24p0Jzqtg3ZzuToi70YFBROIv4hv4hPbyBgpSdd/BaVO
 vTv0tGIYaphV8IN20xw==
X-Authority-Analysis: v=2.4 cv=e/02j6p/ c=1 sm=1 tr=0 ts=6a96f354 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=Z-QAWnQ1IDuNMEsj6QcA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: 4P8V6X7V8CMCcDCuRyp02BCd7CR0esil
X-Proofpoint-GUID: 4P8V6X7V8CMCcDCuRyp02BCd7CR0esil
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010140

On Tue, Sep 1, 2026 at 11:25=E2=80=AFAM Sreeshankar K <sreeshankar0910@gmai=
l.com> wrote:
>
> This patchset introduces foundational upstream support for the Qualcomm S=
M7250
> SoC (internally codenamed Lito).
>
> SM7250 is an ARMv8.2-A platform manufactured on a 7nm process, featuring =
an
> octa-core Kryo 475 CPU configuration (1x Prime Cortex-A76, 1x Gold Cortex=
-A76,
> and 6x Silver Cortex-A55) and Adreno 620 GPU.
>
> This patchset is organized as follows:
> > Document relevant device tree bindings (SoC ID, Kryo 475 CPUs, SCM, PDC=
,
> RPMh clocks/power domains, GCC and cpufreq hardware).
> > Add driver support for SM7250 in socinfo, rpmh-clk, rpmhpd, and GCC.
> > Add the base SoC DTSI (sm7250.dtsi) defining the cpus, PSCI,
> interrupt controllers, clock providers, power domains, and reserved memor=
y.
>
> Dependencies:
> This patchset depends on the following patch:
> > [PATCH] dt-bindings: clock: qcom,sm6375-gcc: Merge SM7150 into SM6375
>   Link: https://lore.kernel.org/linux-arm-msm/20260817082457.64797-2-krzy=
sztof.kozlowski@oss.qualcomm.com/T/#t
>
> Changelog [v9]:
> > [PATCH v9 04/13]: clk: qcom: Add Global Clock Controller (GCC) driver f=
or SM7250
>   Make all clk_init_data instances const across the driver.
>

[...]

Patch 7 and 8 applied for next, thanks!

Kind regards
Uffe
