Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793166736;
	b=XQNwh4lFYhhZRNzvvMZpG2BSMZXCeYzNJqUe4My3WJLcCQWiP9B7fLClBGt7I7mheGVr
	 5ultmPkV0ANCCbOnNB09N6lgHdbky6cE4tetZ3MKVG3njiqEJixbhY5Zk2fFfn8FEr6jG
	 eyiYUJHwuE/x2gyIkUSLIK+cmzuETAYoDYFTtTiTZDS+9DxwrUZMC+Plu9C0unf5tea72
	 hpokHT3qJK+sGbIfiY/Nxlh574sZy0MMG7avxrwHpmD+K7Fb91AUypHRDp7gU+GXPqrry
	 AuvqK62MgdVK6PGNfKz5rSYVG0PMpjUt2+CrboyNiht7HGxbejLEq+3Ai3kXq2ntF6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166736;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IYwAwKNsQ3Zd8ZLk9m7XPS8ilKZ84ltU/SVOXi75RGc=;
	b=b8J1nG3mS6yz9T0DxCRbkKCX53Dr4fH0h85X5613k+VNsnKfiLrSxi4QPyMzVhvpgfoB
	 rPcqTSegYTt+g/5ejpd1LZRoGLI0HeNB7KfZQ91tg9DBlPaTzgbYBEjuxe2uq4c/75Rg0
	 VNLUqR0UVPl/AY/Fav9ZQBTgjE2WvktvTf18IDEilx5nK0fGauiMIS+ohOD481MEXQ8KC
	 A2BIiOHQNjt6TjBfqXy3pgvqNFgW6L2DnhIp+XgG/KqCU6Wcb5FMQnV/tSOmpDka0pfbO
	 KM2dt6+HGCDvMilAQcugicQAU05K4T6sAR0f8YcHiFgiZ/OxXqGQT2ZneQNdRys1Y4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mxrq5ZP2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="jtYBeih/";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94416606A320
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 05:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94416606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mxrq5ZP2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jtYBeih/
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S4Phro046881
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 05:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IYwAwKNsQ3Zd8ZLk9m7XPS8i
	lKZ84ltU/SVOXi75RGc=; b=mxrq5ZP2SPnzmMiC/Qy696KseD1ZZy1gapprx1mU
	zN/p4ufefQGsT1/fkhjgx7wuSqBcuyBDgjt2fZZ8OSt76nRpeUI1/HLQcfGdDUCo
	RWw2f+u39CrgcOIkt/stfVvRTBVpBWhm8+32a1mecHUZxxO1gr1+ntETzfdc4Fwf
	yBNmLmFK9hpll2pnVKxQbl2SnIfatRZEVDfG90CBE9hPvYS9SvjW8859JIPOT0oB
	jDeGM8Zx9CGD9dGsLi3t8Ch/vh7NTrLgxTcoSUso2ZJsLi8VhZZWMleX8/2e6pys
	jYDviIBiopLaauIsC+viTaxu9+3ZICjOI5HHNbWCc3TvGw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk82trmvk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 05:52:14 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-189d17eca17so229127c88.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 22:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793166734; x=1793771534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IYwAwKNsQ3Zd8ZLk9m7XPS8ilKZ84ltU/SVOXi75RGc=;
        b=jtYBeih/BOrYexQ/bRCSsvlLFMkOTiH65vEo8IvBwae9925icGxp3UpAnHU98BmBaK
         Lfwla8bm4St4JOTecnRQPde8GqxMHS6xSzCpBFZHcsmrRGm8M9eEWox4QMmeVzYMDa7l
         mCxZm6G/1Yop6E5v8JNO4WxZ6eZ3WdbZBFbkx2gVYipImhElRpP1oumDYutD5HYUWQj0
         L5c/6n1UoZk/cSegCEhSGcjNT0YVh1KR0cZZOOpisn3FViVUBLt137PY3quYsSs73N6U
         x4aX9C6IzCAmb1pyA/UmlLNfd1bahWnZ7AAo4pqVNm6us9u8M7/s5Ec0uNk2ujbR+/Zz
         Fr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793166734; x=1793771534;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IYwAwKNsQ3Zd8ZLk9m7XPS8ilKZ84ltU/SVOXi75RGc=;
        b=m56RVnzhIjWFpzfbrUtR2JKfyZ/u9KTpT2ovnZTnsfK19QQWKJJtWNIxAXxReBYLTj
         NiNQ/WZdn+4Cl8Zi+TozedlbplAci4PmHq4mrS94s8XS1bghRZS15eBynX0dv43hZjX3
         pZ+19xbeNXW6YrD0j787P56ihzzNjXCpeL1yV0yv6PGqPblo8t7whm+uk0u0e4sWLwqU
         e4nlYTBYikeF/JPmm6gQ5zPP7dlP5D1MAYWRWmj8PTipbaOSl1xk5QkgrcNpOa7Gztp9
         niGcSlF9yVbWAHf69IFEa6R1BLNHu/s0bV7vycfQtbnmWjU8w79bhfTEgpnm9Sp3gm/a
         QTuQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPIBx3IAY1/xOHbbHTpxx2b06xJ4uQWJ8bj4A7SWt9YvzlnGmZszsOOWA4ZIxPy+dMuYESf4jmiQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0zQqPuSlzTLqWVTi1sDRApEg1zDoqqqt5DOaJNLaUXljiPJmq
	5doum5klQoSVmK2wl+3M+g+8r13LMzE0ZDX5O0ZOq/uRHkey5/s4BbdSW61pb9/iLaqR0LYO2Oh
	VeZnHkcudY0ugfdfqRSA6LGRsUIlqwJQkdoUAUK6yz7w70h4/9kpykjPwaoWH+g==
X-Gm-Gg: AYBFou0hRGD1P6uu4k7O0fpaBmiKgqQQzFb6Hw1/lmX7KrmMI0zDXPZX+6OcTAf5567
	mx9//FL7LIQuWW0vun7W/b/GqSzCoY5JlazbB7cE1KQI9x+MmkYqTOVqSe1/eTYU7W64wzLJr+D
	0ZdVqsUtkbTeyOUH/v6hS5DsAAT/I/0au02NBAdo31MWrIuERs6nRwoh60Uk6JVx+XA3tb4GyaT
	AF9R8NO4yA2IP3YIfdQlCLaYgaBa8bWgr84HekYYvcddK46moH9dlJn7U5avCrFrf4cSUSYxKhz
	MsvSQ35bH2gtgJwLjRBJ83YD4HOP6dComjolwXNFSEWyScY3FfTx/nKXV4tzymSb5F3TWFnLGJe
	GYdyMbvcmR9mb99ejqvWwPsD4MDezkF2EBRUyQV80clmEwxgdPkU2yIcPCESSftCE3xBc/VKNwm
	fWEuElG7vzTACSh0169XhT9EgBZ13z2FfM/zWVNqAXof+dOgl7/TucLiOXaaEenldq7CQ9uo/Yc
	CKEQA==
X-Received: by 2002:a05:7022:5f1c:b0:14c:efa5:ee7 with SMTP id a92af1059eb24-1a6cd77f303mr1693498c88.14.1793166733366;
        Tue, 27 Oct 2026 22:52:13 -0700 (PDT)
X-Received: by 2002:a05:7022:5f1c:b0:14c:efa5:ee7 with SMTP id a92af1059eb24-1a6cd77f303mr1693465c88.14.1793166732662;
        Tue, 27 Oct 2026 22:52:12 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75d76814bsm2295526c88.10.2026.10.27.22.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 22:52:12 -0700 (PDT)
Date: Wed, 28 Oct 2026 11:22:05 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: qcom-nvmem: Allow generic OPP
 tables
Message-ID: <auGNhbKwIMGsOsbK@hu-varada-blr.qualcomm.com>
References: <20261015-opp-v1-1-f18fb6f9bae1@oss.qualcomm.com>
 <20261017-calm-tangerine-marmot-2e8bfc@quoll>
 <athPyI5nvYG4vmfl@hu-varada-blr.qualcomm.com>
 <cfc75bf5-eb1c-4433-a4d0-770c56778392@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfc75bf5-eb1c-4433-a4d0-770c56778392@kernel.org>
X-Proofpoint-GUID: fXRu-pHg2xkAiSJ2skLvIk_1sed8G5Lq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyMyBTYWx0ZWRfX0H1PAVeJ9b1K
 hhVTmiVsBl+uobhkbnzmCe9gEF+n2on84oTkeYxiIulJTV5VXQX6TyeFjH189L4cWZnQeZucPeq
 M4JZrErrTteVvzmNNzBQcl5nOxB+kJc=
X-Authority-Analysis: v=2.4 cv=Tr1zFzXh c=1 sm=1 tr=0 ts=6ae18d8e cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=g1hkF5I6mjiIX44rm_4A:9 a=CjuIK1q_8ugA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: fXRu-pHg2xkAiSJ2skLvIk_1sed8G5Lq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyMyBTYWx0ZWRfX0AiESUMBTkyR
 nJS+g0zdIjJAqIzjfC9GD15r7nWaXlyg37eDay8U7uFhhGsxEdP/ukHMLP41I9HIK9uj2p7VlQy
 Nrx78tLczaZodYrm8fTXM1fNVGLcRTeHiOdtIeyC2rYzcs0OSiI4kF5pN1stFA7LGm6zf9uIw5O
 TsWiKUb/IcDuYrxe1w49iqVc8F7yIe4DnpJsL8VDTOSybHJ5k+1yfnm40l9z0HtTbGxsjWBTmio
 pNHxTD3QhRgdKlLHdM6Q3Yl2k1bqB4OsTOIr9S0CCiRytwMLfLM1Mu0rZiVO2/zfHjOeuZQqWiJ
 PSH/z94AIl8Lb+pQ621OVHRNg8HED962/S2XpxzeQ3oowaYdrsOUJuCWdDVs5J/ZbinBn75CRQa
 fPojyQElJVYg0S+6vrjogfc15S3amI3nADE/sKTgVN6lcNmogxBwe7HbRgj6UFvolbzXhajPQYn
 1nRo12DKiQmIc2FLU4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280023

On Tue, Oct 27, 2026 at 04:50:56PM +0100, Krzysztof Kozlowski wrote:
> On 21/10/2026 07:38, Varadarajan Narayanan wrote:
> > On Sat, Oct 17, 2026 at 06:45:53PM +0200, Krzysztof Kozlowski wrote:
> >> On Thu, Oct 15, 2026 at 04:25:28PM +0530, Varadarajan Narayanan wrote:
> >>> The OPP table node-name pattern also matches peripheral OPP tables on
> >>> supported SoCs. However, it only handles Qualcomm CPU and level OPP
> >>> compatibles, causing unevaluatedProperties errors for generic
> >>> operating-points-v2 tables.
> >>
> >> But the select should not select them. How can I reproduce the issue?
> >
> > Sorry for the delay, it was a long weekend here.
> >
> > With the attached patch, I get the following error.
> >
> > $ make LLVM=-18 ARCH=arm64 CHECK_DTBS=1 qcom/ipq5210-rdp504.dtb
>
> OK, I can reproduce. I wonder why do we need qcom-cpufreq-nvmem.yaml in
> the first place. It duplicates top level compatibles and opp
> compatibles. For qcom,qcs404 it does something useful - enforces cpu
> power supplies. But for others?

CPR capable SoCs are added to this bindings file. Not sure if all of the
SoCs present here are CPR capable. Will have to check. However, CPR
capable SoC like IPQ9650 might need this and will face the same issue when
I2C or SPI opp tables are added.

Kindly advice how to proceed.

Thanks
Varada
