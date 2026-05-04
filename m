Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB243101BF
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 07:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881199; cv=none; b=etisLAYJTueBGu47Nr/qDZPlLWXQAByF0XpBleIAVmIRTscPg4l4gZ4C6RYI37+gAAocT66wcxzNXSnQpm+kbQpqXh5TxILXoRqRGz8ayGZqMNxiC6TZh9cobane1ci/9VQo0e06O7M6r2r5MhKFHaEDbDHsKVYK0ZPKcLNAwcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881199; c=relaxed/simple;
	bh=4OoXRR4QkYthl/WwmdE3YXaeSFOh01gjRlYtQBvbWAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e86yzlX2vhCAnYpBnPQGTWDB44CSaF8QvKgvT97gOnhHMtwFOoEM66oX4qvWFNYgdsfEw96EMZqQ8IXYCcV+fZ0ReS6cnzZ+IZXzzRG/nMg7mxhd/EmSxaUGP3IHW9td64QV+XuZG8aD6HD416ssPe1aWvw/sdPNDh94ip5V7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WLxRlFcQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=adAcISAQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WLxRlFcQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="adAcISAQ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6446DCZp4174294
	for <linux-pm@vger.kernel.org>; Mon, 4 May 2026 07:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KUDAx8+5gD5l8P+ilecAiP22roMtio2UtbDIJRNo0XE=; b=WLxRlFcQ5f/yTcUX
	tcIpdQjIhd2UUgmGfsVjMSfuCdzKUguy4IwTyBjwVJ5wIM1qIY4pCqK6dRTwVc7s
	r/IlfxUUoFRFUpcPrMeEJU1GWDcpEIE6xO1PEIkcfW5UhiaM2SU7QwIKgl3CwgUQ
	FpaKYl6CyDyq2i+InQ/mUi61DiCRYVLfeEwVYplNxCBk947WbZibKzh+WJRM0b+b
	VjX5oWd8yrNg+lri+7cpC59hHb9xvmbmn6MncuOLx1TttQKJNBh6B8c67ipE9VOS
	CNK9XkEVg8PbwiavbGDtYuAJ0QrbC03P42QtOS4U4oukaxVRMoCr3qRE278isjTB
	DXFr3w==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw9n8cq0k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 07:53:17 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-611bf61a809so355910137.3
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 00:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777881196; x=1778485996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KUDAx8+5gD5l8P+ilecAiP22roMtio2UtbDIJRNo0XE=;
        b=adAcISAQ8kblJot5NwFliAkTd/H2n0fO49DCYXkC5S/fd+rAz038T9zMjCH3rhEhgq
         BV65hO7bMchLWacOJcPv8gpMrPOhXIse6IfsXxy5yOAxyesc71ELGf4wCTXmbRXkfq5t
         lURb8ybjMESxL07LkaAhqbO9HmNlxyYXLLUZXBLun6vtKk5pffOVN0ibeWqOcYuM2eMv
         339hZ1e8+RojwibGPjHvlZsjYNFrlztNxrcq7UQZArUHouUHsoSVBlsVIp0mF5NInOps
         FmgMBRd3IBRi2d8Fq/vCtmizuLt4JzSEugmYX6taDkgwbw1LOtFDi4hgm1dNFfLxE0WP
         jXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777881196; x=1778485996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUDAx8+5gD5l8P+ilecAiP22roMtio2UtbDIJRNo0XE=;
        b=sKVG5of59OFYaKJpIyUJ8JmNCAEFDow7XVTz8PwFMBRuKSmrpneNUZ9y0iCmIfTZJ3
         2Q/rymPeiCB5Fux9Ha49r6QfjbNoK2Nu88nhkE/qL3SsF6/lWs62xxZzgfI4Ymeyywsv
         pgfgxNUpCnf/9obwKg3NhfgNHqUHFHfW7xkUPXLbbdsVk+1B+7D5q/YJbWGeMtyFUKgV
         dFtnQVyu7bR2VoboRIiTBwwR5h0B1tcaifQ2KZDaTXI1Npdy/bCe6BvQx1ie++gLqAOW
         nE7ug0EHi45Vyu0cXl5GqehajTP7jlMn/1aIcDvPr8Q9lUIzl46Qm+poP/DuEWjamLMI
         U3KA==
X-Forwarded-Encrypted: i=1; AFNElJ80aQdr/MI2J/XwkWLIdlgqFQ3Of3nY6VOFtfNSx0838lwlD3t/TNioJODb7glkvkY7pekDK8H7lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyH/Muq4XhWUUv5eEdRhe7h9+Wns2S0cPcHtUzbXtvhpVWDTLPq
	9ExD2MLxjqkxzMt8iDVzjswUbZjE+aqvj4gr4O+qi1vOJqaF4PKI1hZ4AbjwpUfsJCaQfMzNhjh
	VL/JC82tLL5/k1NB0sX6dUX5mfBiPUF6EktPhE0j8B6QA4z6DqVqhiH4FmcSpag==
X-Gm-Gg: AeBDieulo2Zc3a0h20FSXL2M4MMgCgGNJAWa1EC/ocfLGEHEWp3dC+u6vN7rPk0Sj8Q
	GUNfyK+iSZcNO023kbJTzRQ6vJsn27+kD1xDS9j9WfXV3K1H3IfgsHKra7Rw48kZOFliYTT1IKb
	Ua7TtRQ8CyBxJBlUhT7bV488N87zyI8zb8gc1O3VQRgrQGu0W9qW0egCDi+R/YdcyMaHE7X2JcE
	7Y828seO5kGEvIVa/xyo7Su11YEV/AowojMkbN2snTTtw/86AqI4Go1SpHNkfBjcHnmgudIZxyi
	ml/OK4M0qNvxHC2oKqV17Dg6Ly4+l3DyTgkOmPdpwnKC/UPaZOXkkUFa9q/9T87JFMwOdw4uErI
	TnwHBlbL9K5o7NDHjgk4bmlxOCIhN+AxTj1HNMw5T3cuiNTCwCSF4bwehSzTshD61WB37quAFLF
	2E8ZMRCseBm62HBQ==
X-Received: by 2002:a05:6122:1295:b0:56c:ce6a:90d4 with SMTP id 71dfb90a1353d-5750c7340ddmr1016302e0c.3.1777881196438;
        Mon, 04 May 2026 00:53:16 -0700 (PDT)
X-Received: by 2002:a05:6122:1295:b0:56c:ce6a:90d4 with SMTP id 71dfb90a1353d-5750c7340ddmr1016296e0c.3.1777881195975;
        Mon, 04 May 2026 00:53:15 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc2e55d98f9sm31639666b.8.2026.05.04.00.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:53:15 -0700 (PDT)
Message-ID: <934a644b-270d-4f86-b7e1-db9fbe3db52b@oss.qualcomm.com>
Date: Mon, 4 May 2026 09:53:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: qcom,sdm660: Disallow
 clocks when appropriate
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260503161653.60785-4-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260503161653.60785-4-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZmEQk1KMpGgfvnVaBx1px-YHJTs4gVJc
X-Proofpoint-ORIG-GUID: ZmEQk1KMpGgfvnVaBx1px-YHJTs4gVJc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA4NCBTYWx0ZWRfX6hgrU0h9bj93
 hcZe6pkBCVWOOkcH+QJ/J+Bd7Zf6gR0iogeAQMKKsKg/76IqbF3MV/6mWaBJYG6bIYcgpmDt7G7
 HIpoKz6ALlGxAECNlyAnl769oPO6YEcBl27RzASmrgGII+cKv4XNjqnD33UUgK6JvZF5zia0j2b
 5gJhMGR38ERgsGYnDdroi2TCI14BcYGOuwS2yFZi6x+9zYcP/SZbgV7kCIgVpSVVWCZO/AD6BLp
 ujlGvwc2igVBeOl+Zif1PWkgAeTeZaCpanO/pvX178Ktrip87217yuS7lfre5TmmoR5MIQucKLK
 4ttonz5OEJLz2gqUI6f2FdZZ6Z3FB/HfHRshh67hYgx8tok2wRXRV/PaGIC2MJb+Rp/XUQwOqRU
 OkECQoAB4EVlQxXKZ6ey/IV1E3I3ftMpeuRGuGYu4JhHaujTR3GcbcU9pR+gQftRor5fN/XQNTx
 8FWejQf6BxxadpViqKw==
X-Authority-Analysis: v=2.4 cv=ScjHsPRu c=1 sm=1 tr=0 ts=69f8506d cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=GwjjA_OFujnSjQWLvtkA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040084

On 5/3/26 6:16 PM, Krzysztof Kozlowski wrote:
> Only qcom,sdm660-mnoc and qcom,sdm660-a2noc devices from what is covered
> by this binding have clocks.  Others do not, so restrict the schema to
> be more accurate.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
