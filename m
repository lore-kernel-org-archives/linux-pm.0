Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015501;
	b=vR0qeCSTQES1W3BWF/21Sx0u6duUvlhnsQyNSws8KM8QVA/MBqOzFz1jq1zmNPGBZjeE
	 3OY9MNQVnEu/6E+58bAUC6Sy4Yd/4lrTVK6d1wTod5Nn+FRINapcSo1M6FnObetzCe3Za
	 xSQT/Te04RgkLqPHyiraU7lvqVB6hNXqOi9gfkJdg96rYvEkf880ipPg/3X+41SW/poIr
	 f4N+6GrpmJg8vlxsISPvwOQ2Zk7e+kOAEWKz/5THfj/m9R1SFVs/IbA3zYr5KudFyumiI
	 uNr8vqNr6kfOi2eEtSW39pfGgFbjD9NZDNZdJ+dXSop5K6t7dj/IGMFxyQ/WCD0zmtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015501;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/DFWAQQY1zY++oRBXWRTyotn7tN5airZcvKlxRljH5Y=;
	b=HBGC5N3S2YhAdSZGvX8TbJsd+SS+Fd8S3NBk9iNKwL6ZUTqFIpyWzWHci5kNn0b8Kb+W
	 cuFOm8iW/oEBNwWvj1kwq7Z2FCP6WePapSOMyQDuLjokeHOz4teWAHhwLjqXi/VY6ickz
	 o8ixCZpw7NjTnT7AEh3DMZXkb9HhLAaTbxWcTQNTFImuofCoivcPcwxleX4E4/jTbsIGe
	 Rj+geDHNUDk2W7X9kXwd16MNqOLBZ2GxMSXysR7sbrv8RTm1VYNMlLdY3uT86XvXy84J6
	 R3YVtHiEN37w7w+t6tsNJ0fd16IQq3jrGxNFY1Z+vE9lF91yNskz+9nfnV15wEpbMRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UnU7jHou;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hhTIZCh6;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21A9606A31D
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 11:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D21A9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UnU7jHou;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hhTIZCh6
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAsvJM3561850
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 11:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/DFWAQQY1zY++oRBXWRTyotn7tN5airZcvKlxRljH5Y=; b=UnU7jHouAnx1JUOw
	nwRKhafg8Pu+P8w0LFnzR4p4hgbje6zCIbrgvVtY6WllaFAHE6pz31CmL7qzb/Hr
	xYigkiYqBGUbqpH1iAKg0vZBR9MBwKLvvzIpvyOFESR+kpMxRlh30ZD788O6LrKa
	cOBaiFhwJFp6bq2BGL86XqY2qOIW0c0Dpp/ILHp3mC6BpmRg/Gja0PsFUcXZoh4C
	AHDpct4hvtMZYVIzX2HHcrYrXXdWQ7n9A/ZMgOVOqqbINWSqeNUw60t/tAMFl92h
	OSXcQq40gXSPGZv2Hke/dMmFmAs5eNymYfF7gRFZkNgOzbR1hEBRDFIEId8LXPlN
	RLVpkw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4s90dek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 11:51:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb1091fffso22063485a.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 04:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793015499; x=1793620299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/DFWAQQY1zY++oRBXWRTyotn7tN5airZcvKlxRljH5Y=;
        b=hhTIZCh6hhFn0UOPOo/9DEmTBg5I4kjZq/ERm+Je3yju3i0l7WWPYieDRVKEmTzMjF
         MwWP27FLljyjcQF9cbNLsbM6A07lzcyntZIP1+WKp+7ck87fQeh9sVwTMLFiWWnzHO2Z
         huFUh5UAr8bi+vyKy1IPzSwQfATFLhHm25Wfi9AXvX8YRE7L3YdPgCPeTvL2bZoK1PcA
         0D/k/Gvl0gXKP9O2PBWm7P0jqRT01fnWH23hyE8ys7SiUYmQkZ1IihCm7nHVBF9qnOrL
         rioJR4wEPVXbkER1qXAkC9RJj01ZcbJRvLO+uGMGks6RdN75KmxjjddHt+btr6MXThoG
         /30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793015499; x=1793620299;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/DFWAQQY1zY++oRBXWRTyotn7tN5airZcvKlxRljH5Y=;
        b=uJksNvNxH6oeiGhJCPxm3a3faBey2vLW3jqSlQYGJkgW/pXAQF/w8bh3NrzntPlsp2
         2Jg8hM1JVOfclrT6/ZIzy5EbAsuOdZFvDBQ+iK2KEOdmjkOid7yXMJLgFMoeBFqAlv0N
         07q+gp3OrtUdOdcvSXC9et72uYt35982nZiCukMS4UlUvKlORSE0n7dlUhX+Xk5O0QVi
         pCpXRSmw3bQzUQwvaEsmcPTW3gQcdzwl8ZYGAemnVFDV+IoBdMqinU4sEPeKdEMF3dcp
         Hn8DziPE+O1bF3XEntmlaCCReQ32n21tJiqcZl5N2Q56VJD54O3EnJVtI4yQruL+I/Y7
         SAbw==
X-Gm-Message-State: AFq9FYJ7aRtr7TaMkHOoqayAaHtHP9SHakH80VlPmWZs9vYqooH9F3Tu
	YOha+Xpf5AH243NGXllMRDur5MSdAj1QEgi+pgpbadoMvIlfNfaCOthMGw33jWdqDJgPCfPG5MX
	kxIa3jjXMezngEFV6tb6D8XrXujm9Es11G2QHSiqSOB3aHuMggFYhv8wHHTpl/A==
X-Gm-Gg: AYBFou0SbnOoJ9OjCJJDL1mgjjyuGjx3V1SCShFl8euTOmyXmZoshofRaI3AOg602L+
	z1HdoqzsUKGJNu+vrBLf394GY6d/32rcU1quqECB/akHRZJ4a/4/aeUN3LcIuks6/v+mdx8H4/C
	sDwBDI09PfggQPs7X43TPn6vsd4hyuD3d6JZaLuh5cAo3EEQwCc+eww6UU2c44vnO5JyGyBLqqh
	xqW387ih4DgMeTk2yd7yXho/Y5U3wyc4r+dsZLNajsT8BVvqquFCXJ6eauOkzIMkiAOb9Pb97zr
	p7Bk7bRvVe49uxlU0imelv4WT5HSN1R+XEPD/Dtwqwv71QMNvssZnPQRM+221QKeWQ9lN4LdhKB
	rGTI/v9UFTwOl7+TJ65dzGA==
X-Received: by 2002:a05:620a:899:b0:939:eb09:4458 with SMTP id af79cd13be357-940ef8dcadamr1000468085a.3.1793015499117;
        Mon, 26 Oct 2026 04:51:39 -0700 (PDT)
X-Received: by 2002:a05:620a:899:b0:939:eb09:4458 with SMTP id af79cd13be357-940ef8dcadamr1000463885a.3.1793015498587;
        Mon, 26 Oct 2026 04:51:38 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e9968sm310083866b.17.2026.10.26.04.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 04:51:37 -0700 (PDT)
Message-ID: <e7788a12-3cad-4bd4-9f79-82cd118e0049@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 12:51:33 +0100
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
Subject: Re: [PATCH 4/6] thermal: qcom: tsens: add hardware-bin trip-point
 filtering
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap
 <rdunlap@infradead.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>
References: <20261002-thermal_bin-v1-0-5a29be7e8ec5@oss.qualcomm.com>
 <20261002-thermal_bin-v1-4-5a29be7e8ec5@oss.qualcomm.com>
 <7cd708de-a58e-47fd-acd4-0e37be77de92@oss.qualcomm.com>
 <e832301a-6129-4697-a5e4-94671072622b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e832301a-6129-4697-a5e4-94671072622b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfX0OoBzFHjnvuY
 6mY7aXl6n7uemacRosehP4AIGxETGKa5HCIUuWVaAXu9yKsbj9aYmuKNxO4zBdJG7Gnorb9EuXO
 GHYQuCjKwByPhwRbbpezvtQYOrrm7CS5lRo9DX0IkpLaQP68u78Hf3+7n7ufYHJ+4stocqV8+P6
 gLHTh4PwuoYIBchyCxN3hhE9eXl2PCuJQ5V58g43ujqInOQUCleg42PqM+PCUkRue9HuuYEZ6sc
 IgrkpQMI6N24f0ISRm7iVRDZD43wpxrDDmi96/jBEZGxRkN/HWNmxfRcvmMGsFxYbpDdeN3rLQ1
 jlXlYt6RWYvgfeIHiqmJG7jUnSfSjDqHod/iXi6mJHwFScbxWcPcr4VtYtPCGcQeqBnMK2dDGs+
 wWwG8EJDSwYT+Ofz/5XHRDWMO5xvufXvdgWjntF9aSym7a4n45f6FHQCZ7zGPdr8D66mlu0Osue
 Yim3738qygkrY6JObNA==
X-Proofpoint-ORIG-GUID: 0cNQkEfrrMngReXj5c7Vdev57EYmt5Lm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfX304PxMsCiHav
 vlKO+zji3IdtmWnzOijXlQpJuwSiccQtveQlyD1FHLsty3hi4NmHN0gXmJzJpar7RJ+RLjhHHtk
 gJAbrQ5H7IEgVXT7j/RDBYKCh0gnytg=
X-Proofpoint-GUID: 0cNQkEfrrMngReXj5c7Vdev57EYmt5Lm
X-Authority-Analysis: v=2.4 cv=HKhWhYtv c=1 sm=1 tr=0 ts=6adf3ecb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=_EuTZlPCPfvd7hdiCfkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260047

On 10/23/26 12:01 PM, Gaurav Kohli wrote:
> 
> 
> On 10/22/2026 2:39 PM, Konrad Dybcio wrote:
>> On 10/2/26 12:46 PM, Gaurav Kohli wrote:
>>> From: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
>>>
>>> Some Qualcomm SoCs are binned at manufacturing time and expose the bin
>>> in qfprom fuses.  The thermal core's supported_hw_bin mechanism filters
>>> trip points by hardware version; wire tsens up to feed it.
>>
>> [...]
>>
>>> +    /* Hardware-bin values for thermal-hw-bin matching in DT. */
>>> +    const u32 hw_bin_std = 0x1;
>>> +    const u32 hw_bin_elevated = 0x2;
>>> +
>>> +    /* Higher thermal profile identification for qcm6490/sc7280 bins. */
>>> +    const u32 tsens_chip_id0 = 0x197;
>>> +    const u32 tsens_chip_id1 = 0x198;
>>> +    const u32 tsens_chip_id2 = 0x20e;
>>> +    const u32 tsens_chip_id3 = 0x20f;
>>> +    const u8 tsens_feat_id2 = 0x2;
>>> +    const u8 tsens_feat_id3 = 0x3;
>>> +    const u8 tsens_feat_id4 = 0x4;
>>
>> Isn't that (also) exposed over SMEM?
> 
> Thanks Konrad, for review.
> 
> SMEM has related socinfo data, but there is no exported helper for the
> exact fields needed here, such as feat-id, which is also used as the bin
> value.

Is that different to qcom_smem_get_feature_code()?

> This jtag-id/feat-id decoding is Kodiak/QCM6490-specific, and the
> thermal-bin mapping needs both values. Other/future targets are expected
> to use only the generic i-temp fuse bit, like Hamoa.

So there are variants of kodiak that ""incorrectly"" set the feat_id?

Konrad
