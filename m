Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0BA3CF962
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696787; cv=none; b=Griuz3jC+Bf1Uil8lpmF3jZj5Y7ATaGsMlf2/wwFGimTFVW2PI2ldqOMxvLzPg0q50tjMjwt80nRyO3runVPTo47QSXY9Ro0FlesbkekJyKwwqi5xwLGXOraV8qML6AXdm8kCy9aOLOT8FC4+TXZsfc3eJ5nevETPZI+bPzk2WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696787; c=relaxed/simple;
	bh=e05F9ezF4PKO3QWRxGecNfgjkdRbxg6z9NAmRbFVpKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YN5yQDh01kc1O5zG13ouLcRJLs/wZF8ozSwegRrNnUWhanSsE2aJDfaZGeFWgztlr2lmL+FQu6LulG2MWG5ftyMA9VokkDbRWTpcP6620hOC2pWohMAKMgUhwW4IfkP7meKDCKmkLkAMNDZLPYDn3jX53NUV1+ZArCiwrONhWCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MNJv3nfM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CbmaBRd9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MNJv3nfM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CbmaBRd9"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E7gJfk4047381
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 08:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ea5w2Lqty5Yt5//TNzt0Du9L4M/1RYPtE6BB0ik7PAU=; b=MNJv3nfMEBeeeFcF
	IWyur0HcemvAYI6S5QEC/7PfYTTelv+LckFmkG2ZUewWRM4REnKJOyX0iZn5avw7
	djG9oEytA5tP+nXvYc/3nzArzQwWwnmYu1i9iENDO0ePq943X2IVOi5dKKmPpCkc
	wqRHtr8iWEYbLLfMawRXh3DXrcBhH3k8lD3KSq0qJ9qo9Rwkc6Uoey5yZcMzTo1p
	Zb8GZ4imxhPn5BWUQjhNeZ+M9OcIPp9jd1SkEI2eVgMFe2N8VIjNr4moXL9fGZ3p
	kn9SW2FYu8UOoZBbt3pCf+DIs4j+7eA7K+LK9mVjTif9yqJh7AHVwqeK0QF1rg/+
	7gkGrg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1hgy3bms-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 08:39:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cf1c86963bso17295375ad.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 01:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786696770; x=1787301570; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ea5w2Lqty5Yt5//TNzt0Du9L4M/1RYPtE6BB0ik7PAU=;
        b=CbmaBRd9uIcUlUoYH3oKcTbVnVSzjn6xD/Icr+GaZDO0WTTDLKacaYeyODi3K1YhiY
         CKAi5x4A6C+KjqLu7VQr63s7crNgLuCBKbSFh7llboIDIxwjRV/zStBYMj8r3GegLFZY
         +8KOo1FgfdigHqdNgTJtOyEBUA8+zPqqVHI/XRnuatlE9zu3yirjZBlZcQtSCTdaU9sy
         luQA7p0Zq2E9f9PcVD/2v8JfcoCLwL7+BSohX3yucVLDWcM+V7o03k57TuuasdQevE1A
         J9PVUn6dMj3CLiiPInIWKemrQhEtVTCnU/SW3OY824l1ALXcc8jpcF8a3mgeQZ8hScGB
         PYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786696770; x=1787301570;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ea5w2Lqty5Yt5//TNzt0Du9L4M/1RYPtE6BB0ik7PAU=;
        b=Qqfs2BqXKYtvje40ARAILws3L5bvCSUk2jkKM9uiFgah3KbJSBUnApEkwjLihzCTr4
         ZBcWjw1v3DDeIjPvqjXoeDPw+pFUNvm7G/4cnfZJTGJtc3r+cCIFkvNlTn5xyXoPlfN3
         V7hIfba3xUw0/tVbyl3fqsav/V1fa/ALdkyeY3zfn6BhAkjg6vsbsY13huWyKHP6yobC
         OaLiALXZl+zQ6w8mb71SaXDibUoT+jkd0/AXG4SWoNgntvKfPWe/zmTft3mYcDOACT5l
         uP/Eqtj/2H21BgewH/Rt9Bw9grZzrzkjI0X3SpoDMlRl/PVOVrYdEx7NHRNU0DpuYpIP
         V4wA==
X-Forwarded-Encrypted: i=1; AHgh+RpZUxA0TWGS4V+i7S2gGHeMqHVTd+XDcNynqxKp7GDwdPHcVM8n4D91ho5NS3wjSqrq7D3YS+drtg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0SpL+JHAhQ8DvTeTN6MvkvmnRlUNRBIA/yOHwLKkKd0j1QJtL
	llyiuD+7CZcJB+Ff9ppQ0fy8dzdbCJn55xgtCK6h2KrqBgKqOdxbYoUh1hCihGhL4tcUiTUZ3pS
	rvJJV+Lvc4vLFK/pkIimwvm0IhQ3nQpPBdAnByR08eU5WB9q7rYW2rHWutegSog==
X-Gm-Gg: AR+sD11/cwHChlXpi0oNJbzyphBRF8wJ+pmVAg7LqqHgDDw/EW8Ne4pBhKW064q8KXz
	RRiFIHtlJq7lAC4/B2oqTtbQ8W5q239itC/kJJGKAFsW0Hywa4kmetG5vV1Y+hVrhWvwKxMh9+8
	thd6gFeHjkWx+v2l1ZQYmzWQeDVOD3IKfIPmwkFAXXgyYMKqUIlDi1y3aEZt+vLVM0zjt4g/0gP
	ipcVqqdphNZPOf2WTtky7xw4lRajKMfNgEJ9aDCY/K4Xvks8+cJrhUQfLYcUg6YyTrIYhA7PlZO
	6wtfl9tvaNYWb4VSP97NtcfWLfRfqMNwrhqjiaDKkMag31T++QDx2fKmYgamAUtJ0Hnu2CrJuMg
	jqRSqvK1cgDcfWBEjAnVJMzkgQ1+0Rfc+QLOMBhL08mx0GyTJ1Tb9VBz2Ucf8eARBpzMP8vs5KC
	1RtpRKNfHUyt2Jb1c8gCs=
X-Received: by 2002:a17:903:28f:b0:2cc:db7a:251 with SMTP id d9443c01a7336-2d37f5cdcebmr138080765ad.2.1786696770275;
        Fri, 14 Aug 2026 01:39:30 -0700 (PDT)
X-Received: by 2002:a17:903:28f:b0:2cc:db7a:251 with SMTP id d9443c01a7336-2d37f5cdcebmr138080385ad.2.1786696769795;
        Fri, 14 Aug 2026 01:39:29 -0700 (PDT)
Received: from [10.79.117.20] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3ae7ea4cbsm6518765ad.32.2026.08.14.01.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 01:39:29 -0700 (PDT)
Message-ID: <b0f96877-a48d-4b19-9904-426b5993d8b8@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 14:09:19 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] dt-bindings: interconnect: Add Qualcomm Kuno NoC
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-6-5e0ede4a0c72@oss.qualcomm.com>
 <vexqghyxtf5ntmu5mpijgql7atlzhci5fhde2j7gyrw4f2tpdn@pm2qzwtefmrv>
Content-Language: en-US
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
In-Reply-To: <vexqghyxtf5ntmu5mpijgql7atlzhci5fhde2j7gyrw4f2tpdn@pm2qzwtefmrv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA2NSBTYWx0ZWRfX+RRTBxhF/YoL
 6uB9GTcTtnpmkE0fiqkCqDH3sgcDREEpc9vEf6dwzDtelK03TLuzTM2ZxilqrHBk3WIN2uZsVLD
 rVOpjT0n4vKQB10qJp3y6O7xDBlfhefRIXNywpyjEhgJhDKLoGE8jH7B/+CHMJXehC+9kPPnej9
 eciEEBohc4ArVp6J80lzH0pSpkIgBSkJ8YWeqNFww4anmocgk1GKy19nSdpEIboKQc6b4Jk2G6i
 e3/Tfdfgbo7Ty2ZNAhI7iyCsNYVn3kdffkGxchFE4TkY07SpwHcAlzn9Wc3xWATuZHBULz1cLRQ
 94giUpGXkoWKHtaId7aUgujDYmxZcaRrh4kPOwAiLqihe1Dq2h1G9nGZdEB57kTqW27+H21qK+0
 42uwMZ8jr87iExKEkJ+A45R8I3r4sy4DwN1YeZwkHzVpBU5RdinLq/xNbe2GpizAaFy6TqPKuJn
 WUadjdbFyuqWcOcoGJg==
X-Authority-Analysis: v=2.4 cv=AaSB2XXG c=1 sm=1 tr=0 ts=6a7ed443 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4JL2KtdrCnkvdebHkfEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: vumqzkhcJcOwzPJIqQOLDLVgEGPWFSyW
X-Proofpoint-GUID: vumqzkhcJcOwzPJIqQOLDLVgEGPWFSyW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA2NSBTYWx0ZWRfXzB8KUPxZ6+K4
 4soVUpYwEsS6QFvKaHrFtkWWeM8MtdvGLTZTlaDa63EqJrqYN1XcZVlt+0A8Db8UVCda0OZtsJD
 JwgN31HXS1IT6b4/1rGcgdtUpyapJWM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140065


On 8/11/2026 6:29 AM, Dmitry Baryshkov wrote:
> On Sun, Aug 09, 2026 at 12:57:05PM +0530, Hardeep Sharma wrote:
>> Add the Devicetree bindings and node-ID definitions for the RPMh-based
>> Network-on-Chip interconnect providers on the Qualcomm Kuno SoC,
>> enabling DT validation and interconnect bandwidth voting.
>>
>> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
>> ---
>>   .../bindings/interconnect/qcom,kuno-rpmh.yaml      | 72 +++++++++++++++++
>>   include/dt-bindings/interconnect/qcom,kuno.h       | 89 ++++++++++++++++++++++
>>   2 files changed, 161 insertions(+)
> Are there no clocks requires for QoS?

I've addressed the binding-side follow-up in this v2:

https://lore.kernel.org/all/20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com/


qcom,kuno-rpmh.yaml now permits up to 4 QoS AHB clocks
(clocks/clock-names: minItems: 1, maxItems: 4) matching sdx75/glymur,
so consumers can wire them if they choose. The Kuno DTS itself lands
with no clocks= on the interconnect nodes since RPMh BCM covers the
paths — same shape as sdx75.

