Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743218;
	b=FJAac/uOSojmDBnvSwRhNP9uIsDJ4tyan+w5dGZs8iajphbfZwJ2egwqnllheINOB7TX
	 vY8l0W7m0/RbEYHb6btoJO/C2T8/pJQMtJSuKdoS14nn4A0dV+uqFpCHnYnTwfeb+SP6d
	 6pzNtJVECw4fwMMnHliUvqh8mS3CDC6znOxMz1u40XCisEIqZG7WfG4hCaXGEu9s76snv
	 8EjZPTNhRB0HfTpMcfSjO/nlE8/vD3qtLFnLoNEdkDDq/n6EJ/2iOKkt2FSaY/dDJ3FRJ
	 rRxY7C93G7DYgUemaEiIxb5g65v72EwwaUhTzfsUHvQo2ch65QdZp8FQ04b2BOB4Ywg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743218;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=w1cR5nFuPtaQunkx4EbNjBSTwiut8OwG/7WqorZUh1g=;
	b=vwlLqAxO415HksVRWEqRKje2wXh1efu3v9h/UnVhzs7WkukExrVdRMY5l4WXucrPrx/k
	 khyRAjaEIOZMuEfCBrVf4c8XNGmW22k1B4nfWX9OqbEyY/PkLi45q0OOPpc0Md8pRrOpZ
	 hMaAgLr3SE1I8y3Ad87Ap0N6DVQiiDQPdLlo/HAr7ioKxHqY8EXutf3ybVHfPcG2fR8YH
	 BALyp0XhdVFgHSLUtADxApU+aErK8mavOxepvLQChWjK3zelZpKWaJV5Fqcrn5hxyuXMA
	 S8hcPb6PUzBYRawCvrMRV1V7PDqYY8wcxFsVP5vcyo0v1zhbN+SSLeDExKO7INHeDzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lHATfJfj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dcZpvE5W;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A242606A32E
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 08:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A242606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lHATfJfj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dcZpvE5W
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FOko1552878
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 08:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w1cR5nFuPtaQunkx4EbNjBSTwiut8OwG/7WqorZUh1g=; b=lHATfJfjVwc/n1xI
	Fq5bTkBZGf8usRg/UOewz83RDXzSqmwUREWgpNUmEA4rwpK8AQ5B/iirmxFauo5l
	T4ELnwXIhbSzqQ5sbFktZNEHIFOFIQfhwn02w/cliaI7ezT1lK+S0nEy2s9r3u9z
	crmxZsLyVxMNNxEMKr8maaAVRRr9saSLCd6Vvw4vUnE8NtyuSDsBoU/L7L+Wd6fw
	50LE3njI2BrwrZWDSxJxaKOwLVt8lAYOM0Mc24dnvUKcd8DwsJlD9f0RX+IXRQS/
	9hR6dKo5NMoNhJNqTqOF5LvN5gcXNzKsWVX9NBCBFhSd042/HX+nB23kVK9/RZnl
	a2Fp5Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmttncm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 08:13:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cac495d99so12031185a.2
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 01:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792743216; x=1793348016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w1cR5nFuPtaQunkx4EbNjBSTwiut8OwG/7WqorZUh1g=;
        b=dcZpvE5WQsS6Cu8SqubR/JkWJ8n0oqlL1iy6sb4eOO/afmNAh0rkL4wzFBcq3X2OAT
         BJaGPH/qv5bKa3zwopCFjd+O9+da9XQV5w3YRJn1NA4n/gYvuMvhzkId+kNkAO/yzvPW
         jP3DszbrsLZR0OMhdcJ1q7/AEy/ncOsmi04q/ruevKIQ2ds/gg7WH1AgWWMdKQjjLuIy
         kfQo0MyE+kiAHelfT0RKtutJHNtU1JG3WnX5sHA/hFamwGTz8TgZuz+T2y3+xk27y6rb
         lGG30qSgekHHBGkxgmjScPc0ep6jsd6kZKNKTX4bZGskrpQJ225y7VSyS9q6+WuF6BSu
         /a+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743216; x=1793348016;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w1cR5nFuPtaQunkx4EbNjBSTwiut8OwG/7WqorZUh1g=;
        b=gHsu36MwJt7OV8KwWjx1MgEoc5Iwmbj9cH+0zknVSFoX2Io2HTEoVg9s8Dvp/PZ6Cb
         OxfRBdu0S2ivRM2xRu+aUfXB6L+Hmr8+pudZArN6Bi8ez9Ey64N5FYqDpqfUAXIGoj8L
         +Mlz1oYaXLQudsUVQ+Zo2EbpIgrYfAvghWj9XSdoxWk5caorn0W7TDEpFpK4a2M7kGwr
         SAdW+VXdLsMiiPEWUS2wxMdux2xbdC140PIm8Hpua4ykH2gztBBdhgFa/AkoSa2zP/sf
         0MV0PXmNWDgpTYL+mgy9MnzuMXkZbmyhuKoKj9UQkBBf3NEmAakqGwzoTKZH5rdL2qbA
         QtRw==
X-Forwarded-Encrypted: i=1; AKwUvByE5utS5Z9nFgsUUz2FNR6nXA31ScteImFtWgP9gD1LUygmlLzd3DFX2ch/diMg/AIGuKNDO1sqcA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJZkZpkXSN8HiGhdtm+UQ+8Adc6qzTksv6je2CuruHMi1d2QSa0
	3zFhEf7cphRd5G2mxnbkqpt3VISNwxPsAYtwNXq3iTR46HvC2BexlMMZ2lAaiQ2tUYNfwHiWUfR
	91CcRw1Aid5gm8Co3oJ+LPu4lYXNzwxzLAfqUHX8QYMRDodArCRVvdwegpbY6cOdAJHr0jQ==
X-Gm-Gg: AYBFou0/5wdH/xUTxyoL2Wu4FNdnnbMoHa0BgoW2vVB0VuLPAaZHEejSIWgDT1+6yRX
	GK5cWW2lJCXaBwWCZtdE4fhFKZ2spmbCz9H082p+1qFepVbezt3YPeENrk7A1gEHY3rtdxOZpPZ
	YASXlt/gB8AgfwL14rtlnmgq3y9/9dfx73KDExVwTSCnkVN6obxK59ArzmnTgwBlQcfI5neGYx7
	UIEcs0jyR9rPH/i4Mixip18874txfz51LCApNRy9ZZzdaTG/7ItpPOIjANC0TqCkqYuP86jJlDw
	PW21AC6rDG/PPs6npH35DTDSym/jM5lff3JWRXfxXTe5iRv5MZPH2cf0sBJzsnLqaDPNp5UcJqX
	lolmgUmTcj3HY2rlhh/A7ew==
X-Received: by 2002:a05:620a:90c5:10b0:93f:1fc5:f07b with SMTP id af79cd13be357-93f6f7d8a2cmr297172985a.2.1792743216452;
        Fri, 23 Oct 2026 01:13:36 -0700 (PDT)
X-Received: by 2002:a05:620a:90c5:10b0:93f:1fc5:f07b with SMTP id af79cd13be357-93f6f7d8a2cmr297170785a.2.1792743215985;
        Fri, 23 Oct 2026 01:13:35 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46b378b3b8sm10988766b.25.2026.10.23.01.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 01:13:34 -0700 (PDT)
Message-ID: <63cf18bc-5c89-4a55-aa15-2550dc47c155@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 10:13:33 +0200
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
Subject: Re: [PATCH] power: supply: qcom_battmgr: do not report power_now on
 SM8750
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>, linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261013002124.332111-1-xiaqinghuan@mail.ustc.edu.cn>
 <5bf3636d-be7a-4800-9914-808d2fc5ebd9@oss.qualcomm.com>
 <179259054168.209323.8102186130128474174@mail.ustc.edu.cn>
 <52fc4222-508d-4acf-b38a-7b4e5aeff3cb@oss.qualcomm.com>
 <179274197125.1374502.18211548118625978753@mail.ustc.edu.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <179274197125.1374502.18211548118625978753@mail.ustc.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb1731 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=IjCPCkZtk2ssS8GsjjsA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 8kPNZjQgPBq_p3q8YdLt4zPwgMM9zJaL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfXwmkPF6AzDbdP
 WxWUn+A7r5z9WrXhC2I5K3KqPGY2etrm+sX4z5Bn1J9iz6m53Xpk+T+kecGalKylCsuESnUuaGj
 wgr1T4gnv4IzlfrQeY2qdAfFU09xzX1nP+Gsc6R05sUII1CnSwbJ5rrYEAaDbYKF2QJoegWH0CS
 85bdZji5/FZc8iH1mO2ptjj6zk7vnrFwoXwLzfwK35BknN/9Bik9KUh7zwTgXgaFKZHGfO2vBFe
 LxtD77+LAOEqiQvsO2UTq1LzSgpQfVR4KjKC/h8ThZH/ZqS3SyvrUCSToQGurWms3TFeblt+b2m
 2qX4hojC5uCbigZuxk0ms+JJyqonRFmVKqb0YwDCUdOAIXvajz43Qm359kklKInOiRJLzbaAYoG
 XeKO0cxgCdjDBf5fihB9f1kI2VwAN5r41uQvfKV49Sk9nz6xlmR0kNHacv8g/e7QnmvF2icSDXS
 q7lu3TVgr2bAJhQMXyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfXywOOQV2hHqge
 8FZnmniWzALmB8eIh0MguMSEoixJ4h2qw8pVeHJQ1nq2B5p3SIlyXvqjnrHvALU+tVbaxf/GFZM
 rmgiuDRH9HUiPsh2DpEKqIGli5Q4yUg=
X-Proofpoint-ORIG-GUID: 8kPNZjQgPBq_p3q8YdLt4zPwgMM9zJaL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230032

On 10/23/26 9:52 AM, Qianhui Xu wrote:
> Hi Konrad,
> 
> Answering the three questions directly, then what I can offer instead.
> 
> (i) Downstream kernel sources
> 
> No. I have no downstream kernel source for this device. What I have is
> the prebuilt Android boot image from the vendor plus its extracted
> config, so I cannot statically check how their QBG/PMIC GLINK client
> populates the battery property buffer. Anything I said about the
> downstream side would be a guess, so I am not going to make one.

Did you try reaching out to the vendor?

Konrad
