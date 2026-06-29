Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1923B4EB7
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744071; cv=none; b=hoVTj7/Nj4N4pySIAvqkEzgakJrGQnxeuwFL+4LI3IlNNcIELgwUWxHtT5yz74Nbiev7c8pqpD62vAcSYsL+e4GxYED9xA2zsRU6dqztQtC3/ahvwpxt4fqzuYDFmMgqESxcZnjc5lYQ8oQnwtGdGFxqPd+8Vm41WCoOFxxTin8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744071; c=relaxed/simple;
	bh=zjwRCOleLOc/aa7QhScW/iZmDl7IVYNpFmmX2d/CwPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umb7CS7SCZRIrtsUslcpOgZMH75NnqQ42+dxHpxYuCgdvVQa8NvMeF6phPyv7Cid7WeBH7h3RPWMqFPs79i4Y98wGRpqH0v+QXpZSJePiVcdMHDty5Ppb2X+dI4qqVEFV7erfAPK6pFwT2VVgIODJKeNq7p/T4jpwDiYZ+dd8gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SZt7ntB3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OQ4r4K1K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SZt7ntB3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OQ4r4K1K"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TATRdo2592825
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 14:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	23JIWeyj5zcJAjKuALJwskbvtpgcoGyXvoa7QrCnhHI=; b=SZt7ntB3gs39rRbK
	n1kgIs8cZ2FKGZP0W9cFR5/hOijWDiGjjCPRFQr0DmTRk8DUU5/YwSkjz/ZNkMU+
	q4iu8uFtN9NMaQ7MUAEn1wRpI/EiKaDTEMq8F7r0KyXUPlkNhNIdPLIHq/z5blrV
	fhfhcfroFFlD5nwenjMbEAhJxFL7oXINIbZ3cTX5rQB2tRdvpTHzKh1wRWw1x5OF
	xbIHudiT0oVrkz9ts1o0SgJmyrD1Xv5yRbpvbeMGK1/kBK6DhbRCIHcMhpnn7QKR
	IcBnnq3Mc6M7KbpSi+Q7WMFFaF5GMXPJUXz74BHQ/1Ovj/YG2e8DEXgbbMp+O13m
	i+3Mhw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3k7vj5yv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 14:41:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5110c89eso31165585a.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782744068; x=1783348868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=23JIWeyj5zcJAjKuALJwskbvtpgcoGyXvoa7QrCnhHI=;
        b=OQ4r4K1KN01hKoFmwj875Zy+XxnBiCj2SHjh68iYC5fWPu2mv36SxZdnI3ngAIyTMm
         oCbGrwViBCoYE0cVtc8dCu5AExv0MeAoU7YPfsT1WmDhHijOchIX6FLHOoJxmYrFVZqN
         jxDr3sXHWf0f9h0BWcwTSAGH3JeXg6cOHYZFXgfgoEm2e8p+VgF6gopBv+B1LeYBWcoV
         Lsj4tKWfWrvuzBow5H8OAn+14BajNr/lOhsCRtHONf9smVZSgcXyFpPg6GD1Vl8KSYAd
         yCYqq4E68C5WYBZlbVfAkqZdGX1JCJ2DZsJCOF5zR4L/QHNplEpWI9Vc7rNEubuFDbqd
         dmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782744068; x=1783348868;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=23JIWeyj5zcJAjKuALJwskbvtpgcoGyXvoa7QrCnhHI=;
        b=dGBEp5597KPsh4FJ1kmDXvOPQ977lsJZtfJEed462FxqDH6KYR5/c9XTO9cBvx2Sw0
         AYRuGnwmL60K5peYkTfJHOj2aloxWFbqA+g206Mzq8W90BVm10WckM5gSaDuGmg3LAYF
         LbvqI7/QaM2cXjc82EgqiTm8rzTvR2i10fmBWNDYcXInq23uONRfn61rtQjj0tfTxfPn
         Ny9B43fRuT1zkdw/zugN+ctKHnxRVFInt+v19Z+b9AOTeSNFS7Z9EaaJ/xpvJpvop+xd
         FZfUKaHx2bNWpmoLZRbqGUsbfiJqniwGMlNhNlRs+7t9zHZ+BrYZ+I3ipkHABbrn6250
         cO1g==
X-Forwarded-Encrypted: i=1; AFNElJ8Jt6/s4aXaEh7eEouz5hZ/CV7cR8+9to6cTFmB9v9q1UI3nVv1D1nv6el/eyz9E21fxenxS9xJsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRnqT+s2nQy+Koa1QS17VuD+r9ZOKTJI+9LfFa9c4k7mU0qZwM
	p9hUSK0VB5upywcN3t09obq/U+ax2MGl9K/hYIbYWdfu4tPp3X8FzypdSRwHh4jdAnSIL2Y5WtR
	lR4/+F9oNT04jkGCxpNAweXchvJag4KlU9DH/sS20WN+E22hhVazERV/Bh+mCiQ==
X-Gm-Gg: AfdE7cn5ujSE45CpDFaDV3hmnEz+cMMld/y/qFrDcrKuqllLRIA9gxdtmB1LuKD5xok
	UXqk6B1okOt58lyHM5a8G/JuHHc7HmxAqdj5fTltRXH0bsGp1muofAXmcRcgdQOHVdSdjBDmIlp
	Kd/ew5Ssql2g1jBwYwL9hqtpXMmMuMbH0MgeK0FLEFTOhAySiRV9XpwgoVgig3C2mO2hQhguHVU
	/WxH9JczbsFiFAuKFv8JgimUDU004NJ5daKuQTbxp1vk/a0CrNC4sh4b7lznom2mFOA2bI7dQSo
	pZwcz0wjfTcmjaUaPCvJ+6lLJMXrUR7ayd3/UOGhPKvsRoZsNhyj0OOe1u02MKqN/TJxOw9jJY5
	CSjKJaow1lenJrvkBbGIRxHympKkIVtAWTQo=
X-Received: by 2002:ac8:5fc7:0:b0:51c:4fd:9a1f with SMTP id d75a77b69052e-51c04fda1c7mr18956171cf.0.1782744068176;
        Mon, 29 Jun 2026 07:41:08 -0700 (PDT)
X-Received: by 2002:ac8:5fc7:0:b0:51c:4fd:9a1f with SMTP id d75a77b69052e-51c04fda1c7mr18955731cf.0.1782744067384;
        Mon, 29 Jun 2026 07:41:07 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1276ec6c96sm108700066b.43.2026.06.29.07.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 07:41:06 -0700 (PDT)
Message-ID: <a26881da-b5da-4d74-9d48-54dbaba1c25b@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 16:41:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] arm64: dts: qcom: shikra: Enable TSENS and
 thermal zones
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
        linux-pm@vger.kernel.org, Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
 <20260608-shikra-dt-m1-v4-9-2114300594a6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-dt-m1-v4-9-2114300594a6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bKkByAepDGL-7n7ccVByRx2CSZJ9gw45
X-Authority-Analysis: v=2.4 cv=CqCPtH4D c=1 sm=1 tr=0 ts=6a428404 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=6o-Bo2YM3VKyGZF6QcIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEyMiBTYWx0ZWRfXwji9o/ciYdj1
 bIRP7T7Vx8y+2OTtMq2XSGmnIVhrDdMgCix/n5R20DB0NNe3SDHiGmxBvfgfhNMFrKfk+4f+pdQ
 r8cxNbSPLnroXm4vh9B8r6SUDdFV9Yk=
X-Proofpoint-ORIG-GUID: bKkByAepDGL-7n7ccVByRx2CSZJ9gw45
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEyMiBTYWx0ZWRfX6i7bSoe5/Nl4
 cFaCOb/MU8aN/MydKq+STPJC4GpyXjLqKmKfLrcKTDeEMS3BQKZZIJbRFfOJB5oWVrCtr6qN0N1
 5nUjTw80dog68Fj54l8K0svgwHTr69OpEYkJP2cfFT78QMr6aXqYWaWNJRrcaQGzfuey0BqYAA9
 rUAOqW1fmEJS0xjGf17xvBJ2G8GhOn4vwRcIrth5Pr/3uB+ix5u6Mi5eJB5qvewphiQljZgVZC3
 UkzQC/N5OV8T0y85w6HDzkR6NsLgGftEcRaviDupQacK3lMn7nvvxqMzDZjWvVKSqfoV0cRyM1V
 1uvh3SXe2uIIcUsr3fcbDi2l0VNhZ19NoGXsTNmYObIFntcLkDfC0Wr4/2ZYvS5L+Drr2w/rHuO
 0EWz+EIYuAPT6dsL2xoQMMgHCKLXDpZGAgQltsgj3D1r2OjFzxdIjUycb/1R9VcNucsBH63bJlw
 8tEFs/gepYAczUNNP1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290122

On 6/8/26 3:10 PM, Komal Bajaj wrote:
> From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> 
> The shikra includes one TSENS instance, with a total of 14 thermal
> sensors distributed across various locations on the SoC.
> 
> The TSENS max/reset threshold is configured to 120°C in the hardware.
> Enable all TSENS instances, and define the thermal zones with a hot trip
> at 110°C and critical trip at 115°C.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
