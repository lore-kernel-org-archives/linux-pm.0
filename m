Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FD44218A3
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743987; cv=none; b=edWn/nA+a2z6xYZ4VgFX26J6f/n3HHISeoVAJpugYVVL0IbRkfgXbT3X7OePwpX0BAz82TVcauEQmRIw/wu64WgTxHdnOpl3iAN5dCZ7bPTgu4dVtZcErvxHGfBMnU6V74YS7tAUzGa4XPejhyKhcFeClq7lTWg1AcEAOatV0TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743987; c=relaxed/simple;
	bh=liqOCMe7OXo3zkQgVlcw1Eu9AkfS2Wd8nUtDi/XIQpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoi28D/KpVLSF7Bn0La0kiz3K9Pe8GUk9uYq87tnY/LWAAJJvqza5EKTI4wmYg7XofioeVOXjqE8cdagIs6zruuIIq1pvFMnarbn0oXkdDYwf7YJ028k5lnNQ47KKHkUPyOLFSboaV7x5Kq9GGievHaT3mL5H1E6NUZaSVOS81A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PTnjNB9X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NnvG0nc+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PTnjNB9X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NnvG0nc+"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TASv4g2601200
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 14:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5bbBHtidWhRPmnInLMwZken1KORMptwNsSz5+Ls2hA0=; b=PTnjNB9XAbMirFlE
	ndJIFRNsKyu6sxsLjqv+9bRKNiPVTf/hBFDVxe2UEejUOn2LQrHHBd9wZhajwVbv
	wTotbYxEKMU1fO9xaDJDDciJCM3WyiKRx4pxw2d4AUQ7R6Rq5k/HiWOIYo+zAmAA
	KmrhOQdGd26U/m7rE5BqRONr8l08AjDp8asqoLZ5Eeps2DCmDCqb4mi/LR/3cC1A
	dSHsDdFFi3ElSt7QrnXeaAyQeDgImOejXoO4dfBTe47Csvh0nymhNZqeaJ10IlZz
	D+HczX6IfotlQ8S+2VU0DCy1mJImtyqz/Rz5wVKzwZJb1wZHpbGB0bi4FS2rFYJ+
	1Vx/Hw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw9bfp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 14:39:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5cce9948so14369085a.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 07:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782743981; x=1783348781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5bbBHtidWhRPmnInLMwZken1KORMptwNsSz5+Ls2hA0=;
        b=NnvG0nc+W3NQhTENNoZ64kIF4WCjBPYaFFbgGSUWRiRjlWKq+LXgfkLjUf45scGSRV
         kOkbeUSxIIGSNSZLHmXeZurQq+aCiQHyarUzCYhXyXeEiz6KrzWwWdxF8r3JPH9rBiUH
         NnZ7UPHE1EsGF1PSkikZ7bjAkDXKGu+eUj7dYC8KzdofcJEkauVR/FnszqMHfczJ4ZSa
         WAqexQAtkdqsL2ZjuRVgPVHv7gQ9sKTF0E/gLBO+C3/fbtl4T724u76Ng1LDtzQimFTU
         nIubUD6ac8XUhfCRrjEc3p5tnN/CdEDw4BG1zdyjHq98bybHNBQLyvAX5aNYTJsaJAiP
         /QeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782743981; x=1783348781;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5bbBHtidWhRPmnInLMwZken1KORMptwNsSz5+Ls2hA0=;
        b=mW+j2ovT2hZyK4ipHBbNuXy4LOC3cg0XcYYfE+Rfx6940NuA9IHflx6txx+m91TXNJ
         VN2mgfxvu5VWSn3fPvpR5t69/VgdNkxu4acNgX8CFKiNumB5YS/0f/Rjc1QXjbDhBajs
         BPFLu0vWRMpKX2XdAcEyizETBaEqTOjlu99+WkE3DEQ/fWHa0v017RMnvNVWy5w0HElf
         USPzeIcQwDZyJeLomR9t2HjrKJErV/xkrs5A9pAoOQfBWe9px0LEiXOd88U7dAcXtQZ4
         kMnk9AuZrQYADgZ1nPcaXCGbcpFTP1okZigejM++Z8OxywE3MKpYos7k7SD7gOc+g/cf
         G3zw==
X-Forwarded-Encrypted: i=1; AFNElJ+R2+rcex231wt6XtM9NToZ6qF1LmRG17oX132nNu9HO/RmGKzB+O6easYS7uOFBiAr8oeqBE90Tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKCYba6k0DBnLiPXha+6RJwAvWU42tLrnjCDDIkAKM4CQAcQNW
	FbTaLDemttcy2TmeP1dsz8Rv24oJHNuaizOFD/sOhPiuabv1PihkKDWgKka79WvpVMW1Dkt+Ej8
	hoxy7PWbMP3wyDlmpeyJuZLDE7OvloJ18kR8yejhK/K9U+ScUP2BVN128CxzsSA==
X-Gm-Gg: AfdE7ckDRNn2ykp80hHg3SajIZoWvTMDNR3BMSQ+w7kmT7epmJGmNsIJVd4X/Nd3DJ3
	BUCXEm6NxHSfe/mwlxZThU4uprU+W23WNQ+2wGl/RnH2e9vfTP1ELFn0a4v7xmHsWTgpNmv12sI
	ELl7Z6AIG5TyfudoLYaM+6Xkh2qULl0hDdQh3JBSDCRu1EPERVGouRbHkC6Wz9qBuApTsj4F0ob
	ZNMZC2xmKeATZrpAIJMIIrbEMuMXP5PJJt/Rh0cuwoHJVbWExfBsCNfanv+jsrvR+fMr0oKAyF4
	TlHudrSD7GMRNDN4/FBoHEEjiuJrlqszReot85pgmLF/qdAsCu8SdnP3MO2//jBk7k14Exa4k5m
	r2HG/6cYQOlynY/gL3niu49qCHQm069zI3KA=
X-Received: by 2002:ac8:7e84:0:b0:517:57c1:bbdc with SMTP id d75a77b69052e-51a72a8dc41mr164992901cf.6.1782743980691;
        Mon, 29 Jun 2026 07:39:40 -0700 (PDT)
X-Received: by 2002:ac8:7e84:0:b0:517:57c1:bbdc with SMTP id d75a77b69052e-51a72a8dc41mr164992561cf.6.1782743979990;
        Mon, 29 Jun 2026 07:39:39 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12376df39asm449075466b.16.2026.06.29.07.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 07:39:39 -0700 (PDT)
Message-ID: <021fa1fb-7033-41d9-927a-5322be71768a@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 16:39:36 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] arm64: dts: qcom: shikra: Enable CDSP, LPAICP
 and MPSS on EVK boards
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
 <20260608-shikra-dt-m1-v4-8-2114300594a6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-dt-m1-v4-8-2114300594a6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEyMiBTYWx0ZWRfX5J5uMDQFTfy2
 B5zZPk60pEm9dPAcorkJHUQIrJt8Ui3aba9ETl/XEojRme7aqGnl7gReFWKqoQokxDQp/UyPYXH
 vv7vl9luVS2JFY6kn/NWQOOST55xbaI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEyMiBTYWx0ZWRfX83krDcJleF9/
 Ni/Pn9LpfXIov3LUJpxhkyY92lLRSSQeQxMqpAaXJptd16ffVZ/r0L1csH42+NvVoKE00FPEeEU
 UmKyQJ2ZRmYO+SvvW1W5oHSGtLoeYvKegHZmp3Q28/P46KnLJB9GvEh7EuP505MHsQnlYPCe9Fh
 AV9rD2N4aqdi//zqsplmX1+5irACBzbHlvUW+L59rMAn9fjXwJsQeO/U5kwnXOVZOxNwcngTPUQ
 r48akGl1JyZImHOIQYTwdpt73MMI7Uj/4tMBkXg4oIAG0jgXieaKU0ziOlU4lTetlBY7bmFeaRx
 Esp7JP4KBm5MBbe5m8su4MKYhH6DVvsR7xIwLaueBWoxCizgi660savd0hvBpQ1RwNaUpwD7KYR
 3hcnOEXLU5MMLRLIMBbZYGCHYh35ZW5ND1C/xZTtelx/jQGwexpHMwuSBqv3KEM44rcKSgXOCyy
 vHLo8sZBwpBVrCOITtQ==
X-Proofpoint-GUID: VzbNpDArizrQyrMl-pwxZgvKbUlo79Nd
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a4283ad cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=2wNq6JH_cIzNK18R0_EA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: VzbNpDArizrQyrMl-pwxZgvKbUlo79Nd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290122

On 6/8/26 3:10 PM, Komal Bajaj wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> Enable CDSP, LPAICP and MPSS for Qualcomm's Shikra CQM, CQS and
> IQS EVK board.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---

[...]

> +&remoteproc_mpss {
> +	firmware-name = "qcom/shikra/cqm/qdsp6sw.mbn";

I think cqm-evk etc. could make more sense but I guess this
is already shipped, so might as well

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
