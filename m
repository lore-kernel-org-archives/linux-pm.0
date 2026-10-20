Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503638;
	b=DEPpU3OeyRkIoZH7xmY0qc5SHQHWHKmMKuQDcoZwR7F0D/svP6qvtGwb9Z3OaZqGCyZk
	 iFHwBQttMBVq1adCiUsvmgwuk3lIn9gCWXdX1YRs2p2RsDcCUVEOLGdtyaWh/l3kZiI7o
	 D4fVT8Gzbje6cpoX2WyKnSMt4wWNbhY+pWDbdqyc60enI+Aoiu/CZ6n661O/Q7E/v5N0a
	 JgJ/C3Ha82LUSBoAXMxl2qc+1jCpQe8mgrStdK+2UthK9AgzfjGy9Px5jJt8N7lBKYzKK
	 nMfe5WEM6rj1++SWXAQhFDojDQIhA95c9fDuatAwNDxQ46+/m9vEWEDeMgKYkBkecxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503638;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kjoD4zTcGaDNKdU4jZr6UC/VbdfZPGCSWwgF9INjzk8=;
	b=GGyYiHXjvaOLM4nuEkc215ZV+z1xzv8wqRk4vLs45Zbfug5B9xsMeNGNj+EzFQ8Z1caC
	 8qv90sw6+c0WrF/EClj0pi1YukWw+lcjAkC1jVyqSwMqjZsY5BGy+1vIwEw3k17+Cztj3
	 qEe8Xh+/AeGcgdszU0vJZoMUymFoXpQ/uM7Vl0WTR7zR3QDdEVKbIuFt0Qott+JyMDK3f
	 IrFwEMlAD5WjX3tcFhOUjwtTqFzmbdqKldMEJzIgQkv4BBxk1bnNPr2bANYsbak6sP6Tc
	 uplViROOznpIIh9w5DNjxJxUMdjDfHvmhNBrVM192TyswlF/DWrMe/AuEe5tH/+iBgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J+lSBTPp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xerno1ll;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0104606A31E
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 13:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0104606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J+lSBTPp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xerno1ll
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDALCV2214678
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 13:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kjoD4zTcGaDNKdU4jZr6UC/VbdfZPGCSWwgF9INjzk8=; b=J+lSBTPp8au92YwL
	dppsvk97Ir47oVbGtiv4KOuchx4pkFy9PDd8bUDY/mrhbW7QzlBWHrsqzh0dck5x
	7IzlATfYdGkklpaYWcd5nA9LdnB67rTDl2TIACrLnUCUOvDd6sWMcZE5ZGDuEMty
	hUqwzKLOtAAOBfYG7bHhnKgceozxVduKkx4PUZC25GtJQYGwb1BV8fiRBK1r0cf0
	iv/b0KGakppcxeBIeHsO4x0jqOOrLlhOl5x+yw/UTuLNk3ZrVqFrB+SyMcqY+hSM
	MXbVsW6ZsvndvWOR6HUgUll/1fPAfha0V6025kI0nN038Dy1piNrlSV2bLWX8uYc
	JHWeGA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5ntmq8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 13:40:31 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9179ef12a03so15073476d6.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 06:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792503631; x=1793108431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kjoD4zTcGaDNKdU4jZr6UC/VbdfZPGCSWwgF9INjzk8=;
        b=Xerno1llNzdwOOSdwYCePrFJkureNneXwLwss1gnlmYvtd/qr63/KTHUUC0hDUk4UA
         k++h1q6CRlQ6V9WrP76XucKfxDD/qrfoVlJmdXluLcwlgyxQTWwLl4UGrkCHz2qT8YyJ
         TpP+/wdMKPqzVluqoMr4TqQnd4Iqzzj1x16QRrdDzWLK3bnG5fCIjPac2FoQEcU0AVLQ
         q4eJ1r7rBH4ffvRrrJYvQpLWd7w5t+SxkwMCu85ChTT7HJqeUUNQGnIhWfitZDaICJCm
         RAvhSY109Ncpk7pqYob7bfUcc5HVFjhU/I4KotYJr9VD3EEOY+70g/MZTFHDte7fuwOi
         wTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792503631; x=1793108431;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kjoD4zTcGaDNKdU4jZr6UC/VbdfZPGCSWwgF9INjzk8=;
        b=D6uA0EerGg7rPBXIL5U51RsnP9uPttsLx9Ww0rI3jTD5lPLMD8L7jgB04CMYIyqKFO
         i0WsVYn38nZalxa8rxDxydJjn4qkBAbnFQyEO8vK+3QUAmmRktx06BbYc9uQls/2Ky1Z
         T0MYoIAEtaFTm8glNzD46Cd7/3lIZUsdnNA5D3EMyuCsT5IhflDERpcceXtw4OykhhAs
         lwIdJKkhJllScg9SA/9luiHIWTH3mPsWD8wxrdR8O+InK/sGWJI4PjHwToSyEjDjeku2
         1CEZOR6/MefspQKLKnBd/ylSR1/4tRXrCGfbR06sejc87iJhsv96KHc3H9TMg+rV8hLy
         ZW8g==
X-Forwarded-Encrypted: i=1; AKwUvBzcBNYBqhoHF2bMfOE1hsS9hsV/DNW/K5TRUJQkV8WpNvRLCmO13Jq7+ddhKK4/xy1CA4CJMDmKFw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKIo0v/m4U3/r2Y1dSFghoidxKII1Ie/eEwjzP3enM3s84eVZ/8
	QQZmfHiXJyinFR8c63oUBcK3qlRy+/qSbQEJhiGb8r7hPy5UqYxBudBbRDqRMuFL8ldaU79C+Gd
	R91eCFF1+c4LEA4qOksL4XVFwez2RTr2KDkZKQKjgff3MaZw82OniMRagVDE5nw==
X-Gm-Gg: AYBFou1+yYX9s3FLHUIjybIA9jtm+PUyTIV/MMHay7vRVVCphy/BhkCQVjnu4txNtGX
	UzaCSm6tN+LmOAPqMSmwYGfFEG05eu1ZZUJpx1BuRKvNWHkQOC0doifs9D4Jybnog25/LVOmTVJ
	1d3ML6+H/RcnfCT24nhfUabvhItcUe1x7XcR0vIQFVgb/25Ff/gdIPAqhqdW2zSe2FlBWEZW5cr
	B6/Ehj4pb3jJz12O5lsmaLyThgqBBu82UFFJh9pAdrCo9Boh3ytbdmBpk8fJy/c5X2/golbDJ13
	WD84M4w4MCDsFUDBVNidYHVhqhsFtQYC5e6ozyWb1WezV3NquWOTrtdSsMxiyoZVEeQgQQCv1uk
	16GYk3wJ7FyKWB9bn9ThfHA==
X-Received: by 2002:a05:620a:3904:b0:93f:977:5d9 with SMTP id af79cd13be357-93f29a13be3mr1922212385a.0.1792503631161;
        Tue, 20 Oct 2026 06:40:31 -0700 (PDT)
X-Received: by 2002:a05:620a:3904:b0:93f:977:5d9 with SMTP id af79cd13be357-93f29a13be3mr1922204285a.0.1792503630475;
        Tue, 20 Oct 2026 06:40:30 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091eb165bsm477628566b.71.2026.10.20.06.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 06:40:29 -0700 (PDT)
Message-ID: <d3670f1b-57ba-426a-bdfe-be560740f516@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 15:40:26 +0200
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] power: sequencing: qcom-wcn: support SW_CTRL wake
 IRQ
To: Linghui Wu <linghui.wu@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com>
 <20261019093911.3199891-1-linghui.wu@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261019093911.3199891-1-linghui.wu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1NCBTYWx0ZWRfX5qqz4Zm/0HwO
 EwsMcKu44Jl6tDtOO6b/a9Z0SrujxY7HNJuFtGcqe0ucldGzH2ZIUq1j7/xUZ/a7/u0cO8WQVmK
 yQ2o2Saxr53h7k9KoNoABUFw3/JcUZI=
X-Proofpoint-GUID: lLY6BTm0k5maqPauVxuTMzK5beD09oX6
X-Proofpoint-ORIG-GUID: lLY6BTm0k5maqPauVxuTMzK5beD09oX6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1NCBTYWx0ZWRfX1Brs0IX47aqX
 5d6axgM7//xgt1QKXwNb1Jc4YkpEiiljsHatPQCCfdhAFmWz6uF/Tdk4eRXxGTMADBXu0EhRZ/8
 OAtNCRs3eAmQ95sFIoYdDMNpA1EY9XkrjMCfne0hE7vTcO60qec3TzH85QNF0PdDSGXKnAvh6Oc
 q+pmDOOjvgLdNC5Ayk9sgfup3+efM4TAndjQJiSc6VfDk/ndZHetm7U/rjhcxNSZ66OVTUOLNZO
 EswkjwRu5rq/iL0EgRiRv/U3pON5zx+4Y4iUloVjexpscs061LlJSvhXyH8i5prCSvr1naMAj5m
 AZrvZp8YQj+O6k1ghS65oNu0B5GUrgv0vpXEbME4bAWHmz6oEkDz0423RB4p2gpBrRvNAwl13Ug
 IMR7Q16gUOK3yNr36VHpEDjvIPfeWmQu1ZfTrKe3zCkxr+LgL3G+p6W3JD17NJWpEO2SIoJ9Qg2
 gsMUcRfQSu0b7sMnQeA==
X-Authority-Analysis: v=2.4 cv=TcsDJhQh c=1 sm=1 tr=0 ts=6ad76f4f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=nQyRZacoh_ZcsPQd3roA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200054

On 10/19/26 11:39 AM, Linghui Wu wrote:
> Some WCN3990-family devices use the SW_CTRL GPIO to indicate that
> resources need to remain available while the application processor is
> suspended.
> 
> Teach the Qualcomm WCN power-sequencing driver to use the existing
> SW_CTRL GPIO as a dedicated wake IRQ when the power sequencer is marked
> as a wakeup source. The PM core keeps the IRQ disabled during normal
> operation and arms it for system suspend.
> 
> The series documents wakeup-source for the WCN PMU binding and enables
> it for the Shikra CQM, CQS and IQS EVKs.
> 
> The series has been runtime-tested on qcom-next and kernel 6.18.y on
> Shikra hardware.

qcom-next is currently based on v7.3-rc4 (for whatever reason) and
has 1398 patches on top of that. Please pick the presumably 2 or 3
you need to boot (I don't know, I'm not following shikra) atop a
clean linux-next/master and retest.

Konrad
