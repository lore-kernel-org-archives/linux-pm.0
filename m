Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF6E39B486
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774945837; cv=none; b=tDqVUHIdBbXnsTUIx/9fYq9awl22Yp7+rQN7sdC/ALXnoVOII6jVDrbZ5HDbbDCbnSL9eWsCP9uvy70/ck7F7FSU2aNWrIuFiuG+4x3lh7MC5C+3+/rp03u7rfk2DGl45QJEQGgudUo+2GS0hKHia9SDGBXnDx9GXDSZZvgIgmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774945837; c=relaxed/simple;
	bh=zhSw1H3hTV272BHay1QKVTvp6fECnqDFpv0i+7GGyts=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r1CbxZaMvffFuqxsQjwAMIJV91VkGw+H6zp6Ic8rWGDsNvKSvf7P+f/1kBt+EvOMKNSNqOMUGQsCaaxy/givkk/5IqW19rigAskOOMnw5CYlC6Tne4c7F2j/ajhcZTOSxBOsJvwZIJ/XMbcp6q22YxvQu53HQTbfBQOkp4uandU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KU/Ph715; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kf8o2ibl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KU/Ph715";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kf8o2ibl"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V7Hvc23174192
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 08:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ajRkYACtgcrXgDfyFlNx6ATLzPHfdnSorDZkvxC+xOY=; b=KU/Ph715SWzVFZYf
	SayWknkRotlWp2XUt5gZ7bqGtfwZzpWJ87LrjfX2hKpkIm2WTrtfp4fXc4iTdxgl
	2ZpSyLbg5wtPhexmV7xw/P93lkss1uoGPneq7R1y+5RcWqKbPer7saVxJTpdXcAr
	jawbtA9JSbFd9SvQHq05wcWXWrNJajBQUBvKgmsNiQbTqORLBMHxMfCHi/JXUsNF
	Wx3kAmSydj+snCkhVZObDYhCwMLyGW4vVlbdnc5Gv0a90iEVtV4fL/IFRe94Br5m
	Dmwx1WiuglRsQG4bfNk8Xqm7XpStz2+DtNn8oHXwtS1HFIhtO5LfHQtkBx3aEn3r
	Jja+ig==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7q9h4h2m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 08:30:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cfd003bfe2so160100585a.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 01:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774945834; x=1775550634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ajRkYACtgcrXgDfyFlNx6ATLzPHfdnSorDZkvxC+xOY=;
        b=Kf8o2ibl5m7GlKYQL9b2MBb8fU9lt3BYJPPiOq3F9ATXMuv89g54dFmXETrS/7e6Yk
         iUAU6dNSEy2G0je7ddhtR1WOZufZpIFCrQYpyeoIt7U4CZTsl3AmytraYTzeAHWykLZm
         Zeyee/Pcn7Eng/Jfg4tsAxBppI5+NWpiHYjSSOSobLVd7A1QA5snsI2Ourx077ZrDdUd
         adoAsr/jzDHvn4pkywWNyxU/cl+8sSzOG3I8gm8dciVB8unoWUVrqOn8rOTmv16D5Tzr
         F3/6LB78ADW0dBqe/KBKF2DBVOj2OWXTho739p4gOyTWWNOG9MbiJ4tb3ex9lv5lbD/E
         LUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774945834; x=1775550634;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajRkYACtgcrXgDfyFlNx6ATLzPHfdnSorDZkvxC+xOY=;
        b=LC1Mo668IPKE/AEtlObli3NV8CTXlObG3ZxyAhu9aigyOmV97XADWUP1CiM7Y58RXX
         /DmtvHsFQ0OVpDrvByv7HKkAg/60I8u/Nsj+WHpi79xlhYo14iDEqUqZjDERgOZnFMzU
         rf6z/YLyPa7mK+bFwoWF+YGPkVgGXUrGeioCqYt6GVTDdTaJ7a+0PBHlCeCT1mPMbX5W
         Dq2Bz8Fe1IwAlYGUqR0AuUISNDZdf/JRwp+kMV6OZPBvrkwDVHtU0NyKDAmbaNCqZpKO
         9SqrZbs8fPW6zElsl7MqqLxTTxKqM3LzcOvTt7GWc0+lTH6pvnPbL4r04i3qEHOnW2aG
         I/Nw==
X-Forwarded-Encrypted: i=1; AJvYcCV41CXTcGHQ38Rvv3PzK6ovvYGtyGRqaO1Ea8p8UB72IqrlS4j4uOGmzVHZ1zdNLtceCaTrPvfVAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeMp/xOd3md2oOzJfxrmh+5uuCCmhLtGWPAFXws2XQP4DwBYzh
	RvAzeLpC146Hb/kp4ggim0KbCnnZD1+tyDK3MPZqticGo58wEkB2tutLeU7tZhiANBgs4VIiajT
	P0Koo8EybGRyf2FhkrXgBQXgZ3dxdKQSrLM58vVzr+2a+jZ09SJKFkSZJ8/Kkpw==
X-Gm-Gg: ATEYQzzIbeI6HqiAkp5mX1krJxXM0kJzRI/gsANqH8wyNFDWVO7Z85HoAMrxCPdrFHR
	HcvZhxy7EFsUHk76t9jl3oREjm3kIMa+R7LNYr1PnB0gsbgIMGEsQOe4MusCKN9+O66atR6wn9Z
	cYIHA6ZDL3qFBW6cEF+qYX9I8OgWkUQx4ZxcIUFYKKiTc6x1P0jdfWO000iL/EL8fjzeNkqbaI5
	shpGT//1eruLODh0pHwJeVbAYuPnqlClz+U27o2ibYFhO+IsYh6LOERVDe86YBE3aPlHfJ43uHo
	uVQ+CeGyyXklJYhCY0amTN+0pk0szgYxzp+0klAIcxzBmp5SJK8yz0EfBEE4X95aObfilqs9LS8
	U9Zi+siuKzM+CKC4elEJ7ycMZbhuljrAezyX3lPq3WdFU5K1JX69IxoAfmx2TMP40FDoDYZHKwI
	YCxKk=
X-Received: by 2002:a05:6214:2e88:b0:89c:ec59:87d1 with SMTP id 6a1803df08f44-89cec598947mr131302226d6.1.1774945834295;
        Tue, 31 Mar 2026 01:30:34 -0700 (PDT)
X-Received: by 2002:a05:6214:2e88:b0:89c:ec59:87d1 with SMTP id 6a1803df08f44-89cec598947mr131302016d6.1.1774945833919;
        Tue, 31 Mar 2026 01:30:33 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b225327sm375575766b.58.2026.03.31.01.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 01:30:32 -0700 (PDT)
Message-ID: <ca6c13c2-4e46-483c-bc22-0ebb6db704fc@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 10:30:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] thermal/qcom/lmh: support SDM670 and its CPU
 clusters
To: Richard Acayan <mailingradian@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260330165237.101045-1-mailingradian@gmail.com>
 <20260330165237.101045-2-mailingradian@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260330165237.101045-2-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA3OSBTYWx0ZWRfX4aH5R3aZNvR0
 Q2c8lMs7KamWA5QKK+yAeKENqsq7G8moJFdra/DotkNS0dOK/+cd46H1RJ03KHIaYAT7srKH+Yc
 NN3d/7r+Zo3LmulKt05UFSh/yOt4f91l/6pKButQK/irkGfYBPKq2q1bc9XoSf1xuCLosVqPdg4
 uZVhT6hVvePH78vg4/pc/l653AvdRUKqIPlKA8eins56dmeG8Ntkhzuv/XKQ5uaE9XRxGipE6Vd
 qTof+fDtnJUN0owl0vZhuNu6RnYpmUlA0heZsBuyiyeiRQWyF6+z3JFuuw6BXvy168+NmNpKwxZ
 duSxy0H7egK/0EDXjOVPMHQZCmZy/Z31CPWB64AaovKp76vdGsNKyJR8DcC9w4bh280HgR1u8ma
 PhmpCRB4NDXvLNDFnqZ3h+PZv1/b3+Mf3NBLVc6f6YY0VME+DWY8jRMgmU1TWASQHDoA6fE/ecR
 RerI+J5a8e1XV6SjR5g==
X-Authority-Analysis: v=2.4 cv=AZS83nXG c=1 sm=1 tr=0 ts=69cb862b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=aS_UQZgCiH0XZnXXTdUA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: eolBa7A-n2hi3BZN8pU7Djrg7shdJLLB
X-Proofpoint-ORIG-GUID: eolBa7A-n2hi3BZN8pU7Djrg7shdJLLB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310079

On 3/30/26 6:52 PM, Richard Acayan wrote:
> The LMh driver was made for Qualcomm SoCs with clusters of 4 CPUs, but
> some SoCs divide the CPUs into different sizes of clusters. In SDM670,
> the first 6 CPUs are in the little cluster and the next 2 are in the big
> cluster. Define the clusters in the match data and define the different
> cluster configuration for SDM670.
> 
> Currently, this tolerates linking to any CPU in a given cluster.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

[...]
> +	if (cpu_id < 0) {
> +		dev_err(dev, "Wrong CPU id associated with LMh node\n");
> +		return -EINVAL;
> +	}

nit: try to use 'return dev_err_probe(dev, ret, "....") in the future

Konrad
