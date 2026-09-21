Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D61492188
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991760; cv=none; b=dknvt2JzV9CoBIis4+TvfSbXJEurKJJWNcskCuZ+8Pqcnv5c47qE/uI2IvIwLRqnSvvEIOnFIMFW6kOfhhvME4MuuhCKPVNWxmIzCBb0n47JEeWofsh2s8EQdOiw4xvx5JjOEsU515EXm4B7FlIaoHlwednAus4AY4PTHffN3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991760; c=relaxed/simple;
	bh=QM33p/EnGBtZK0CqjaAx0N/SNwLOCdwqPt4LLx0Q4pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMte7Y1VmhbiPm80XEyczAPmlt+d+75Qzud9a9R5Vf978TyO19myWpi8S9mG6R09FdE11Typ0Ja4KIKxp+RYkdgacNLeVoAEPZ682yy1DrMUax5fulXVzhIeTAxTqBPrRx1WRyj0GuLwYo72rK/d2jgogiv4TD+V/3IqMYjmuSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IZvYpOW3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hfWDJOHN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IZvYpOW3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hfWDJOHN"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAdqBo1217759
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 11:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pCz5R9OTLvUBi0/Cp+vZu+bb
	lXkEmBIy3X7lCeXp+H8=; b=IZvYpOW3b3TUXtoEnOlI72w2mkb6PBMcLXeDSIep
	fBUu4Tj57G9+cvNXcyN7cc1YNgY6IIwp1iHR9zDGrTe7eHREbE5SA9UxFq2ewtsE
	qBOjHCOtwIYh79nYKgl1MgWH7ufkbpaJLEVshw8thvsHobuMyVEvhpCScIx9tU4A
	9m6VX1ZWBcEus83jhCpw7fNJAgY7uDRbsIbD4emcZdWyXlMO5chuDoWefE6XaFBj
	8JkYU4il+uYP83r0jtxpcc33WYAVWOujGjFkijWb17wAnOFbf5vOa88SHmuAlwni
	TK0OruYlK5W+tOeK/oHyWi+hpFbJF/o16Srjwdh8henXSQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu01193qb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 11:55:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-934963b2bc0so458526785a.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 04:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789991756; x=1790596556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pCz5R9OTLvUBi0/Cp+vZu+bblXkEmBIy3X7lCeXp+H8=;
        b=hfWDJOHNb2KKhtiM16HYs/p8sSpoowU7ew/q7W4jwk445BIjQk4LpaUGn6ZX0Nwxg6
         DF1mFs2+WwM2n6scTAspWH7qddWE1SKkkKv4bdamrVbLry9VSyor62zPrXOPCBt2xmQe
         DEjz3A46LlmWUjT+aT3U6q9g64wfCJtjir8bNtAS7oWATd7FoBOfYxrzT2ePNrg991Da
         +18wemGhxD2EmqAsytUIrbWdmgMSmrk/55A5Nt95zUIlf0y+RvfPfSMZGjfDCtycK8K3
         IN3PKVTz6fgKhSGC+ObbuVu7GJgwZXmkSWLXE6Xgp9lhQs0qPij0YE2LJgZRbi3S66Le
         UZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789991756; x=1790596556;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pCz5R9OTLvUBi0/Cp+vZu+bblXkEmBIy3X7lCeXp+H8=;
        b=avvTr/Ykn1XXBqGJDvYT/5eAd/dP3DRIKmjvEyeJjv0Tynh+9qcvzhW657PEUKTrWd
         wDec+EOe2y9ohL0WbiuAYT6bZakaTKAs13NGWNUDRc4N1lt3a/pw+l1NCgmrwC1qoa+Q
         XysmGwN6T2+rFrpqTyEganyKzewa1ySxMarMESqvS8fr/g3v9qGYPlLN3NnWuW9y/Hta
         0yGddZYJbo4qU0vxJ02h/7PTQEAlIp9Ss0f0M9ymGj9Yyn1l+4eGLIrNOkPmW4SQm4S8
         NQ8LQ2lEqoyhf4554Uc0Ixbwct2GWkdwIO+YQKfGXh5Q/T9OWtV+rq3kIHgG0WxN6UgP
         yxBQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRRhm1zM8Y+M2pSuP8A6Jc1RrzYf5hsN4GJUb1WVB3HQbOUvVBOiWFb2X9qVDs2iUn3s/y/Lassw==@vger.kernel.org
X-Gm-Message-State: AFuF++kM3sN7QQcNwz9rSeuvsbH0YxFgJkOsTg1SQ2BqATP1vA+EYURE
	6KEs1u5xk1UrTri4Cn1TQXitimEKHEl7jiLVufuj7T3XUnSx8sJHgEvol6Swk8Y2HhZPNE/UUXZ
	OmflbN6iInUv/Zef0OmKVsAz35PzbIy8scudKXtUgev5SWTLmdbF8Va+Nyu75Zg==
X-Gm-Gg: AYBFou2aFVmiKJWv+6d8JyKsQM4NPrZew0zV5aWEUTIWMVlz0zSSx5svLoZo9lkQBPp
	btQ26MZvAEHrathr8ADMDOUCMWPLOCn3+nElZZ20ghA0cuU1K2hRnVRFPzdQgtsyiWO+aTHX+Tg
	wssOKnftG1oUtlx+wHFc8hT8FcdorlT8GiYgRJuplrP13h2vCBGhiV4a9+ppOFolfPuyvsiL5d5
	Ff+/uN1zL+L4aH3UVX1ju/QknokV46Ga49g9hEpAtntpwUFWIkP4KA+6besB4eHTj26mplX3Sl2
	FydAWDDBq9tmnEDMMT+HURXE4ndygJ2PvUmOw75gYHt6DjANrQd/C+dg+y69XkrW7AqLI9YD1kN
	1FlNTvf8N1WjvaA0=
X-Received: by 2002:a05:620a:17ac:b0:939:b482:d474 with SMTP id af79cd13be357-93c15e77468mr17493885a.35.1789991756126;
        Mon, 21 Sep 2026 04:55:56 -0700 (PDT)
X-Received: by 2002:a05:620a:17ac:b0:939:b482:d474 with SMTP id af79cd13be357-93c15e77468mr17489985a.35.1789991755512;
        Mon, 21 Sep 2026 04:55:55 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487245645cbsm32971631f8f.20.2026.09.21.04.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:55:54 -0700 (PDT)
Date: Mon, 21 Sep 2026 14:55:52 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 04/11] arm64: dts: qcom: ipq9574: Wire up USB3 PHY PIPE
 clock to GCC
Message-ID: <xac3umbsecmny7sul6zonikbuc7v2wgdoox2suvbpydzpqjdmp@ga4g3umtvjit>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
 <20260921-ipq_clk_changes-v1-4-d242e3d49648@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-ipq_clk_changes-v1-4-d242e3d49648@oss.qualcomm.com>
X-Proofpoint-GUID: biNoFG0Z_rrYPwXl3CVO5btiqHkRxSUP
X-Authority-Analysis: v=2.4 cv=dPczC+Zb c=1 sm=1 tr=0 ts=6ab11b4c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=h3Rc7G0Mu9zKJFVqRbgA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3MiBTYWx0ZWRfXyVfJyBNna/uF
 iU51oaPorDmfUddiQEIDg+z4pgRUjBKoB3fSdFxNTHstdZZ6Sx/mvWBm2GvczU5r03gFWV+BqD9
 igwMO1dD3n0w0OBQBdYP+9kmXmh7Dl2U5lBYAzOGZETqGbjfypaPGudDlLwp8zBmuuiZIVzTVAj
 8PdqS+pneBNZUvQf99QsF4/hHFRFcXdvzzQ1Hz7i68xOHLs0KyNHn3GiaMX6GSFKciKaVtrsjez
 eUEkffsfpGH4K320NXQK5qfGvzEi5jbDj8QK/fmEaY8nTN27uBZkNWyxX0Q6unno8a8BKxVYgnd
 n/ONRAN2sKk1xK8+MGw7HLhFoMl0BWloxFnF7b9XErG0v41uavMEWOKNdjIBAiEqoRIt3iXp+Mf
 O2MVHoQE29WVCo5ZHEMyLqfD/KGY9JN2tS6x/w2mRoldPGz0WhwzL/tLy+EPpu6Az5Mqx+0Fydc
 AFXcZfsJ6orTh0zN+gA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3MiBTYWx0ZWRfX17LLDWtpZ20Z
 dbnK8ni08IPR8JtK5jaTKSEvbpPtGBpTAoTQcT6n4q7yVT2zn4OpwdamdmKoWQE4YxAri0UCJ4h
 LloaUMuQrDdl0AXQVhAt6CHDK4IpDEA=
X-Proofpoint-ORIG-GUID: biNoFG0Z_rrYPwXl3CVO5btiqHkRxSUP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210172

On 26-09-21 11:49:37, Kathiravan Thirumoorthy wrote:
> Connect the QMP PHY USB3 output to GCC so the USB3 PHY pipe clock can
> propagate to the USB controller.
> 
> Cc: stable@vger.kernel.org
> Fixes: a98bfb31f676 ("arm64: dts: qcom: ipq9574: Add USB related nodes")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
