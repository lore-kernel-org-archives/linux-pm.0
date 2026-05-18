Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686D1384CEC
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779130249; cv=none; b=LGKexjmtxw8nVKsT/1eT2Q75oFr99kKKLNCYu0ns/VwleydUJ2KXCDoVP55CPnCcItS6n9V5wcmW7v+ffPSTegucIcf//JUIwsy0kkPAZ+xAkxk34csH++SlExzgk2HVOAzduqXvJG6Wq3fBR66DWMyOn647xgX/kdIDIpysb6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779130249; c=relaxed/simple;
	bh=tbM9L4T0r4kFyTO4HhHvWPVRONa0Qs2FI83+6wrG4zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWjFR4+hpx6zp+BrnBU2QULu65Yqtw39A3e0FqnUim2NUvyyb5ZjQrZPZZ6MF7/zkJD3zn6vCJ63WRKful5fG6XYV1F8Y3QMefL2aTY401CthSVKagQ8ZVPOib+Frh4AKjxKqUb8cetj+x0Ip3bwfFaBAZ3L5dFbGkjc3Mhhx8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hfCil12s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B2Lvc10w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hfCil12s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B2Lvc10w"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IH7wSk2685062
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 18:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h/SPZpX2kxTAUi5Y+kkH45w7LW+kUEovdQcoR2rE+ic=; b=hfCil12sybDGxC87
	Syyx6rLB01+b/k1NXqfOSmvWaHhsdDZfmecjGMedMBvZblK7WyRjn85e1JDCcN+T
	2Ua1Tf2RuzKrAuFmVW368w+/On6JyDjA9frsPfDekBQ2dN9KooeOW+BOS7e7nthT
	18z/zx/DC9+knWTFwuUDC+LBJ0VZEDjnKfRjeq4m2b6Gd1oaCrowTKTbkqWsI82k
	wUfA9YH/o7Az3rJOc68pkcZ1HntebXUZ0OqCdrA0ANyCvBcAQOsBP09FAuP7nv2R
	nlaHMCqzjXrUTSTmmQsowz0wxmtH2rgUm7e39VUCccYYGoheHvCvezrvP/b2RaIh
	uPu/5w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7vrbu8eb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 18:50:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-514a182b90dso37634201cf.1
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 11:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779130247; x=1779735047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/SPZpX2kxTAUi5Y+kkH45w7LW+kUEovdQcoR2rE+ic=;
        b=B2Lvc10wEjxY22NaxCn5UECnrwTR/HSrnPU6fn96tGHQ25Bl4jFRRjmOTAnYx8PiHK
         6MP9ARC+sj3Bi5ptLv/ObtA7fRAzvTqH+ZgUmvmDiD24BEf/8b+eonQC5k7pK2TiGlyG
         +IiO4cTzz66YNGnYnemVjJ5yFWcCLcmSd9dGfyYxIrhv9k0z266qT9qQv7dZe0g0Fpl5
         VHXiYp3aBpD7qx7yGu+pjQTv+JE7iQ6eS33YWHBl13ZFEvfEnXY1CaKFitgbwUZoA2oQ
         4HdkiLxyEZEl1sF5UP+M+De7g+PoXDf/bHtd6FN0XAWPYGYiUY0uikqVznPbbXWbXRzT
         tsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779130247; x=1779735047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/SPZpX2kxTAUi5Y+kkH45w7LW+kUEovdQcoR2rE+ic=;
        b=NCeCNZQhvL3iDbLQARLfdES42OAQMj3K+RD1xg9VWTrkhkN+f6z/S0IFDilaQr/U1H
         wa45lEIgTMProGsMHX+Nl23EmYWZadRk4cXZU7lZW1AjdyperaEBlfxL1MoEh7cW98EN
         IdygeII+jSb0Eak665Y/nGQTxqiBCbAceaJLUu23+eBr8n/DztXo/YafiIcznNLNyvYW
         A/lSHUPHkq5dbGgUmR+tLN0/ZZ6286sUlb2eqobAo5hgEF70UlgsQFaiWN/aULzrVL1Q
         IRopcGTS/ODb3gbm0fdW2e/rqro50S0UkuzFnDnEOXr2anpVTHavgC7YzUSNfYwg2v+w
         ffTQ==
X-Gm-Message-State: AOJu0Ywi2ucMz2SwX6GEzIp6Qi2KR08/X0c08Fwx9tS/8DunRBS1l+nu
	FH3brQAFJxQURlpKnRDcvGH+ZyH2T2YuPfX6ZxN/0UgkGAbq4w775LRQs8zu+bnlVeIvplmLIn9
	t/mVq+uv7Ur0+zN6c2Obbucl7e+BXpLJLvrrrrD399s6N/zlrx6CC5xsNjf5+Dg==
X-Gm-Gg: Acq92OFHJjVFbmt8eggazjToL9OH071D8ZyZelZCvUvO9vCWkATfRBDxZKwEFX+8T3P
	Z63n9B7fWSNg9s2YUoNVOce4Fz+D0CKvnlBomzlWc+2RuHXgZQnadD3ob/6Q3ihguVzaNTTBcAp
	2PGdyovxreFHhkT5wymNberpIUhD+ZMeuNCWyA1eMjoRoau7LuMuD5IouyzItwzYShNuR60KG0v
	E73LbtyuovskYJm9tlM5wKlvjx9FBi0CYEdd1vU6c6hgMHQOWdEkvWNiisEwjHuU3kkKenphp23
	QvPsnQhg12lzP2mF5Fg+La4+TSVTqeOcd0cwp4ns0LYZ0t0ZPDs9e8KPeXF3NPvI/u+P+FkCHO8
	QJ0ren1anK/uJqU6uh9RUqx0YmqBVoi5Qx2z6WCSvNSBL52ibF2QxjUxnflZexy/B/vLOzPxE7/
	4H6URAkhOa
X-Received: by 2002:ac8:5c92:0:b0:50b:4755:94b9 with SMTP id d75a77b69052e-5165a2963e5mr226585561cf.56.1779130246620;
        Mon, 18 May 2026 11:50:46 -0700 (PDT)
X-Received: by 2002:ac8:5c92:0:b0:50b:4755:94b9 with SMTP id d75a77b69052e-5165a2963e5mr226584941cf.56.1779130246116;
        Mon, 18 May 2026 11:50:46 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:e390:12f5:ed3c:ffd9? ([2a05:6e02:1041:c10:e390:12f5:ed3c:ffd9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3b18fsm36447611f8f.11.2026.05.18.11.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 11:50:45 -0700 (PDT)
Message-ID: <e748de00-f2d8-4daa-8716-629e7c683911@oss.qualcomm.com>
Date: Mon, 18 May 2026 20:50:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] Update the thermal support for imx93
To: Jacky Bai <ping.bai@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Li <Frank.Li@nxp.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Alice Guo <alice.guo@nxp.com>
References: <20260430-imx93_tmu-v6-0-485459d7b54f@nxp.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260430-imx93_tmu-v6-0-485459d7b54f@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _3PegFO0SLe9-H5fGovt230a96Osd3kA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE4NSBTYWx0ZWRfX1C3PBIsNjCzu
 yWfj6r2PqE05hkjWYWesY5JaW9MNADay1w60ecaZoTRNt4eDYqbTwPll+fSSb449ERbnfvV203S
 /0suI3UUe+FjBoIkDCGmc6m2WY+3nTJ4ggmjGb1LQ2gEZ5XAVFyYufAcABT22O7a3LlIbK3uXxC
 FQuqZ6CNo3YAETi4gJ0U4ZUdphvfUgicyFObGcYkxDJx3DMbdFLrAf8TKf8G50zGRMFu+Atynuf
 9BkII1hF9PvsgUefOCT0DWMDfBfIUcuFzuJJzRquShm4sH4we6ik9kQFR/9UFve4OpsKpDcKYHD
 sOLPVMW/obsWXnLeurtnL5eXdxtUkulYrWnrMwTkZ7YmSmDKa8L1p9pTwH85PbbGwd0D168i5Yq
 MslpPu54pBQggNQXkIrrsVU2Lzrp84mr3moCErDEvI9SnAtGffef/vSNvzdXeX4IoW5CkWorVgw
 jNm1DG2LV6HgxYk+9mA==
X-Authority-Analysis: v=2.4 cv=KZ3idwYD c=1 sm=1 tr=0 ts=6a0b5f87 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=8AirrxEcAAAA:8 a=IGtpPHPLznOUk2rqc38A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: _3PegFO0SLe9-H5fGovt230a96Osd3kA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180185

On 4/30/26 04:53, Jacky Bai wrote:
> The TMU (Thermal Monitoring Unit) on the i.MX93 requires specific
> configurations and workarounds that differ from previous implementations.
> So, using the 'fsl,qoriq-tmu' compatible string is not appropriate.
> To address this, a dedicated compatible string and corresponding driver
> changes need to be introduced to properly support the i.MX93 TMU.
> 
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> ---
> Changes in v6:
> - Drop the unnecessary local variable
> - Drop the first errata check in get_temp function
> - Link to v5: https://lore.kernel.org/r/20260421-imx93_tmu-v5-0-05ea1969bb9f@nxp.com
> 
> Changes in v5:
> - Drop the unnecessary macro defines in patch 2/3
> - Add the drvdata info for each of the platform as suggested by Daniel
> - Link to v4: https://lore.kernel.org/r/20250821-imx93_tmu-v4-0-6cf5688bf016@nxp.com
> 
> Changes in v4:
> - Include bitfield.h to fix the build error for RISC-V
> - Use macro to define temp rate threshold related settings
> - Link to v3: https://lore.kernel.org/r/20250818-imx93_tmu-v3-0-35f79a86c072@nxp.com
> 
> ---

Applied patches 1,2 & 3

Thanks

