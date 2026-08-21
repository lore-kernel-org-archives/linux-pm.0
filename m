Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85EE3D5652
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787304540; cv=none; b=hTUYAyvElPUVS4Hz9on+7zx04VJeX2vx9DPKfrtxIrsb4kpmcg4GvKs3f8mTyUMdxgfdb/N/9prgWmK/R1C75/CrBOl+ggVpRVHO5j31dtTTrU0FN/esIAJFDUnlb2ulO8y7KSMQdiCx+ztktSbbjphaOid9ZwX51pZ7uoe5V4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787304540; c=relaxed/simple;
	bh=g1XQiireUBPBoYND85H5eKUxq9GGnxW3HI9tjRaxPdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tcakKZks5ukdB+zZNNRL5H354bSgfI3k5pvfGfK86mLjPK5VNeRhCxkXZDZ89SIu6n2rOjh4TFU62Ie3qItZDGxPZhn9edF8wsPMcg8xzuhLfn43KPehALFyVseyZWGnTxBbFc/UmmbV60NaDpIVLxlnsSetzI2RFk2535AOGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G8sNyLWp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ze5Qxd9L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G8sNyLWp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ze5Qxd9L"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9M6rd1896287
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 09:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kx7Y7lMXoZibbxyH99LUreNGF27eEUjSDBZQDSQLdZs=; b=G8sNyLWp+hjdwj4M
	n7aVSjDthbVZi0SemwbF1Fw0YxQGk+7M4CkBypWsTwI4Ssoo6AyaeGgUCMnq8yLS
	k87lUg6i2nqPAYPXx9CS+xIFuHB5qqVKEUPF/DVVOZQthEs1+iMI0gpmZ2aGhdSO
	zZCyo1+Ep7rl4oaGtWcwo6YDCVF0AgBKfqZ8MtJi56M/dlndPiaIM+KI9myC+1MA
	Qug1JF1YQiaDYq2Gg/WX0nWIiiYBKze8iaLwW0xAVdeaOabLDcB7GLdaz536LP9E
	kk+1aSIgzSjhW4q7hLp2utKA6BhetDGtHIjDughlA/Mhb+uEBMuHmXgIIyfjmzGj
	+ep7rA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gdn8wtu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 09:28:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52827090cc5so10054751cf.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 02:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787304534; x=1787909334; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kx7Y7lMXoZibbxyH99LUreNGF27eEUjSDBZQDSQLdZs=;
        b=Ze5Qxd9LsZVx/QsqGu0ftUkm75dl72/h06TJxSccUywY0udv4S/mdOuwEdeNhMxvMr
         5OerpqdyXSWtl+WCQCHpv+AQgRDivKlR1s6SMGJVWVH0XAVNa39kII3Q3zCqDw4HGQ9L
         J4vkqpKYlLdLn4W3rTF8w7p/nZJaeyt7VXBv/myqHw7xxkSpmWI4s2/qBga4XZ4fNgXb
         o5/6wbFR8QXzd+Yc6cx734rX5hGRyEYT+efGr0ZMlm+kvE/DQRTKNaAf+IXeVAyVdAfJ
         boeQ+zu2IGhto4G4WH6U8uH2TjkgimUoDqzRLqpBSNXreO2aF320V0eN0pgQHM7eFUuQ
         YzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787304534; x=1787909334;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kx7Y7lMXoZibbxyH99LUreNGF27eEUjSDBZQDSQLdZs=;
        b=ei96hWMwkPMn8LJwQUtVlDPItrNzNcvIf+DlFjsMh3o3CpdEu56VD4eGxLBLT7OumT
         OWVQ3JVPU7ao7GDmgnAo1DqFS4KWJDbzCIgi7OHRhUov9rRoZr003eTCmrtIPAMGlEKS
         akuAN1Yw4sh7JJAj5HkH47xdW9Tmmr663W1Zl5xR3MakiJ6TN4e+lV3Ls52PtINjUpS6
         91w3Tl3YGRxyw0rC/fkL8eCXxNRkypvCJmOHTinVr20pkULafmwJo0uAV5sGR5ZzhAZE
         /5rnq82JjmPtvYj6C3ojEq3tmuTPqOP83cniPPufivE0OiPfIFZIWCstSYChKm7iAbgc
         +RNw==
X-Forwarded-Encrypted: i=1; AHgh+Rp9VZY0T84K11ohcJxHURzfTdMSVyaX/DgnBLA2kT4JdidQw1Bq0XncjxQZvvJIzHuynYFRfFBHeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIidV38ZmJEVh/+mo/MeJsZUI7zEbuQyK4JCcUrQOhbZC9fGPC
	6s+6d0HmPEXQVpvCOBo1soThrgJVa/wuOWSngLQf/q3RUnT2Z5rTW9tl4bRCWfAsGOXa1dcaye6
	fc8l/VssN8Ws1m0MJujXQawg+qdYPfdpfZdqeMCSiV5a5awqWGvc3EqqCD0M/AQ==
X-Gm-Gg: AR+sD11KrMEu4cKDs9SgqiZX7Ry+nizXZBv1vgpDE9hJ8wEthpZ688RUdSPKi++gA/d
	lSYLOWmS1E6ln89W9Mkqm4/SHbNpl57F/Rhn3WwM5MV//I2yzrr6/eLPgwclK0fzYwH0DFoINSV
	5fZHsB7Aq8vKf7tr5aUN54JtvNBCVkx2RPkyjsF8CCc2dEU6dGY7yerfsRRUu3bEhgZucc6i4q2
	gXJS3B3wVNZDcNnztJCoDpqa98HDsXJpgxPnx81iA2peIKeU56llgkYcFoRumKorRs7jTgEUmvq
	SVrtPVyfWhAUr0W4Z/WHIgb+A1c6wlBZmEyF1uyiI8Zq68DERt5P3Ixkmw/gQvphpboAJuaag6N
	iL3cY2cheonr6XIztIYhlSEOlFojWClYgcA==
X-Received: by 2002:a05:622a:54c:b0:528:ce0:e9f8 with SMTP id d75a77b69052e-52de2efef81mr117503021cf.3.1787304533743;
        Fri, 21 Aug 2026 02:28:53 -0700 (PDT)
X-Received: by 2002:a05:622a:54c:b0:528:ce0:e9f8 with SMTP id d75a77b69052e-52de2efef81mr117502721cf.3.1787304533344;
        Fri, 21 Aug 2026 02:28:53 -0700 (PDT)
Received: from [10.111.142.131] ([212.136.9.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c45d1sm14274789f8f.30.2026.08.21.02.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 02:28:51 -0700 (PDT)
Message-ID: <6d5dfbaa-f0e0-425e-bacf-f177185d1eff@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 11:28:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpuidle: Deny idle entry when CPU already have IPI
 interrupt pending
To: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260403-cpuidle_ipi-v2-1-b3e44b032e2c@oss.qualcomm.com>
 <CAJZ5v0jXwtBz3z4h3ehJTuaqYN4z7=wOv_LGnjQ4LQMP0TBKmA@mail.gmail.com>
 <5cfd774e-8797-4765-a36a-c3dc2d6ac004@oss.qualcomm.com>
 <bc9c2236-6411-4ff1-a03c-d97997b5f780@arm.com>
 <8b728c1a-f783-4660-8ed0-eb131875f2d2@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <8b728c1a-f783-4660-8ed0-eb131875f2d2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2OSBTYWx0ZWRfX5eloZeLrNSk2
 bo8HV0TU0u+EeY65TJQ1I+ExY5Sbznd+Yar9xDp2vPaOEr2jIZmvZI9AlfgbPj+UCmDBoTqP6FT
 3ciYCCZlqH8pnLauEIvgx96Qszd34M8yFLHLFvuFgLK1wfRhUCnHsVGD8XsvZfLSIMSK0hno3dt
 irDhPYRqY4U2XwFYeNzXNl9Hb5sVsfldfQrIVZkv8xPWTMJMCvQ+6nJu6V2++DhqBLoEwakeSlo
 o6AxpJXH/WMD8/lctS9nYfJspG6/lw9/nimccL2Bd++yXtl7bpo0wQr06xiZhv4pFh6Sxz/v+FG
 bGR3IYNewDJmLwA+DkcHd1MUPiRMu3LQq60k3W8G6mhnYzfBlhr05X0xu1bftLrxiyYrTLYdVhh
 UslIzjINcpMP96MWM/CXtMEELzEALaUJd02bsSYRN4CjtkzM9rrhu6ITNf/sueh+mZFrGwFchwx
 Ls/FZHrpAnkvdmE7lZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2OSBTYWx0ZWRfX550Bw7yKXBMm
 K6QOFSf0MnU1a/TU0ko4Qcge0n+V5jfLfkDZX1d4NRsaQJzZkcio2NylIifGAoYE1+s5a0NoMnU
 vZi/KcHnHPzjqC+jJ614CpL0WcBz4e0=
X-Proofpoint-ORIG-GUID: ay8cSKKPxd_YhR-GBP9oN1hcO2Vyd7e_
X-Authority-Analysis: v=2.4 cv=BJyDalQG c=1 sm=1 tr=0 ts=6a881a56 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=yd9EuNj6BTMe0Mr_PBgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: ay8cSKKPxd_YhR-GBP9oN1hcO2Vyd7e_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210069


Le 21/08/2026 à 07:03, Maulik Shah (mkshah) a écrit :

[ ... ]
>> What do we do about the cpuidle stats in that case?
>> I'm thinking primiarly about last_residency_ns and rejected here.
> 
> As the idle entry will not happen (call_cpuidle() is not invoked)
> the stats would also not required to be updated.
I agree, with the IPI pending it is like the idle task should have not 
be scheduled, so the idle call is aborted.
