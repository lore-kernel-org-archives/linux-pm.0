Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763854;
	b=ZyFPT7l0dpX1fjWXTayduLppX4Rj9AwRUmFcLhYJS0vyAPjtsqF6F3vfA6c8khi3SfVJ
	 ArsRdsY32p5DhKgA223K73ufgtxXV+6oU5I9rzADtoF6g+F1ifNZDdiOC85fscg+SGPjw
	 tIF/70v5eOPfhdxoMZriJDs8qCZM5eh+rf/OeHOL57n/lSLhgRtkqZPqyYBcR1iamGnuq
	 DdJoX0A6hu2OSMqSzwbkIeqGVbCddUSzJVXbm0Eug7+9XQWxpSXSqQD/T25aFT2seyYTw
	 LsqBF/SM8Zt8Tnvq82FXnINUrBffQb3P0L0JvxJ+gFzIn+DH+P/jR/VEsfN+Kv8JGbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763854;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=mwxmEYnSWiyOlicrq2Ih6w4912zotWStp1ZvOmFjz9o=;
	b=23xzzbf0WUZf+0qke7yN61U31lAhzP3U1EhpcPJS1/Kt0uN2H5LSPIVMYN+Szg2/E0Mh
	 pbC/wbnFLCjLWYXcYCw8faJoUYN8pBaHENZTnHXJOq6D+pun1logFg7/op2BBqa/wxK4E
	 FDw1LxE0nRBcJs0Ggt0XMSqDu9pnHidx6QCubD+IsPFH27DODmd9q0E5t7Nr8mRTFHioN
	 sjrsDTfYUNxi0090yqid6k3h79aTDghdOoyQSqH0wWqyUmiHkIQ/+/eIXjKYkKpqFs4co
	 3cKtY0LzqMHHcbFvtJfiTbkfYwBeqsmewpjZ8NOcdvWSp7vvT+Rlgg70LyOlDHZGS0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="X7IeQ2/2";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XrTjmQkM;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4C2606A31B
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 13:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF4C2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X7IeQ2/2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XrTjmQkM
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAAVnf1948398
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 13:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mwxmEYnSWiyOlicrq2Ih6w4912zotWStp1ZvOmFjz9o=; b=X7IeQ2/2/rOM7QHb
	immDKT99CTPdg8Fk7BZOyI3t2VrhYWaSBHcpYrV7VL73Fy0uOv6BLhOSJngW/w9c
	t9jXawe7Fa6B9xw98jZkb2h7/IZyf0Wvw6lNmqKd0iUBe/GFR66O6dVRLYz/gaVY
	FNMxE/c5G8d2sh08nCD2N031xDD+3XbXC60JRPcDHk+bz/RPg+eoec2xbNQW8THr
	HQt4xMuxFNzMlalCV7yfKKFXWdslvgyFS4+Iu5QwcxjL8QNG9Ob6C6PM7KqUQfVX
	+ic69TiaLdc9oBH8WH4dWJ9Gb035qSIpPqiT60toJ5A9zIiiVsO5lx2BH2akt1Oh
	DjsBDA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtv051-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 13:57:32 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7c2b7a15cedso58477137.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 06:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792763852; x=1793368652; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mwxmEYnSWiyOlicrq2Ih6w4912zotWStp1ZvOmFjz9o=;
        b=XrTjmQkMZWKDa+2gKKpQbVHqP0Z+ZHYJ0aKz/hs4PDjdi0cwr5IHI9PQYKpiePOjIS
         a0pX0WoFCQcqbBepgmbwt/lpe0QsbjnqeSd0eX1i6j3ZplneVWEkrgc0uvWS6JGbv+UA
         cGrnhL/9eAuHjIIhllLVOpDYlDqBZj173q6wW8I5EBTkdMtXx2j3T1DdN3iQGYdorBIn
         l3UhTUqfQKxdGlP0Xr2TnEarzT6FPYfLuloNeO6ZWpf+KHM+HlT3ckQRMaqqZ77V3m1b
         g9580dkSQ61LUgSGc4OGTYsQX4rlRFZWpx20X0i8rPRTT/NG9whJn3Ef0fMezdhHfpGc
         E/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792763852; x=1793368652;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mwxmEYnSWiyOlicrq2Ih6w4912zotWStp1ZvOmFjz9o=;
        b=KB4GQ3G7Mmeq9NVumKFUHlvR5754U4i/Be5i/qcgFAYjnuyRYsAjYY9hTw2v78YsUs
         7TzLzUWmDLMxm6m4Sgau2HtikjLpG7J/dTMoE+hjEFEPPD+TAwwXn9gjqdCJUNTag6ch
         psPGGzVGkIfyU6cegdACO8RHNxw7xKvPtok2X309kNfVkAVqvoFsUUxiBLOCxdTlQxLa
         fQSqjEHInZ/fSAlOWBOUhNSRPXeKoU76J2LFiv0+3uZMlFbepzPuGweEEIRF8NZ3uGcL
         e5O8kDjKPTrZYh7o3WA0iWgQblvY1H2BRyu2fMSxrVLfc2DroMeR8hiwchwDFgiqT/j9
         FVbQ==
X-Gm-Message-State: AFq9FYLEsqkrCdGSDjAl2T++YUm5f7K6tHJwPHFXcF8Czo6EZP5eCz3z
	KS3PAfiO7+h56CKgnXpNbglohYXs2F9mhhEk6En2LBtGEjxWCUb9L7pK6r791Aqq1Qt7jCkJFH8
	Xh3D4GE60xPX/RjnXMlmgjuYukt4WByou0KbBIjcU1g9+WcGZ+3rbSmfOFKFkA/7Y6KroRQ==
X-Gm-Gg: AYBFou2V789SN5GWUNagg34IZquxoVNeheW3tUOOWEMvlVua0+8qVOsSb23KEnXUZre
	4vmr0DJgPVFI5/WDf2idpDfRR0H38uOf5bDl3fhYIVTts0jbvkqukftpUi6IJF9sFxtm2SL7u0M
	OpS6zJpYKhv91T7lezqWeoIN5HJ+gAc4yV2pUAa3Q9H+aozx01NFVjOpO5quuE54osQiLcwVkLQ
	gnXR1dh3t4z3rn0nYwy/0IVhGzvhHG+KsNRjnYM8RA5itEKMHNs4mxCPj7BChGEZtrkqFvOlVKk
	i/OJYN42IF66N7lqEuNmxyuOURj/U7b9sAuXC5p/agLz6zL+qzvFi9jAgH8XBw83Bqd8KW1hLIB
	cT35dBWcqWm0/jYea32CFIg==
X-Received: by 2002:a05:6102:a187:10b0:7ae:545d:f97c with SMTP id ada2fe7eead31-7ccc3338886mr871911137.3.1792763851880;
        Fri, 23 Oct 2026 06:57:31 -0700 (PDT)
X-Received: by 2002:a05:6102:a187:10b0:7ae:545d:f97c with SMTP id ada2fe7eead31-7ccc3338886mr871901137.3.1792763851419;
        Fri, 23 Oct 2026 06:57:31 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b432c96badsm1086874a12.14.2026.10.23.06.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 06:57:30 -0700 (PDT)
Message-ID: <84483ae1-1fbb-4219-a829-5867feb8bb17@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 15:57:29 +0200
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
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: linux-pm@vger.kernel.org, sre@kernel.org
References: <20261013002124.332111-1-xiaqinghuan@mail.ustc.edu.cn>
 <5bf3636d-be7a-4800-9914-808d2fc5ebd9@oss.qualcomm.com>
 <52fc4222-508d-4acf-b38a-7b4e5aeff3cb@oss.qualcomm.com>
 <63cf18bc-5c89-4a55-aa15-2550dc47c155@oss.qualcomm.com>
 <179276335779.97093.2561281074827129812@mail.ustc.edu.cn>
 <179276342356.98176.10645303509497652146@mail.ustc.edu.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <179276342356.98176.10645303509497652146@mail.ustc.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb67cd cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=eWD3Invf5OeqgJs9q70A:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: E5r_KDX5Ppi8Kwjc1pYkWyBa9UmX7XMT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1NCBTYWx0ZWRfX2FoUg8qr738s
 uYArliocex/01sVQrSn99r3T/Duf5MLEhWNUpPcSj/xF5fAMdk0cIm20kWjZQg5zxUkrQJ5MVKz
 ool4TZ3yWkaq0c9q11f6KemALxJ7p6/FF3JeTMqREwVO/kRw94fIZ1adMKyu3YnC1QimSVf5Q2Z
 HvpafMlhNi9ktkmpwLFcbJatM42lPCVQVzTNSxdz2Uyc+ZeFIeX02NXY1yDssAiQEaDTp+m4z1j
 LV1W8uiEJZTUY/VsKM5cBhQA5n29PO9QhJDiv6xC15yDof4QBQkkDZ75pJiJ42XMxWc0oI+n/0o
 mYQXhE5BR9y+ZJJ/eEC0xNKxoT6vXJzehEga9WT0dqZbQ6glImAgU7PI1ZVej/Mgn1BCkbOxPR6
 NqsQ+8gqVNDEjorjvyD5eaSeezNXQEpjLFYlXC08jW79Ok3ZOZ6ewWNr7DBzuFpJ3lSvkyf0OiL
 HAPFuAFphUrDxBOqkUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1NCBTYWx0ZWRfXx584Sli9yLh/
 cWRbJNfBkg1SE1F8vPKKcv09Id7EUjjFqpBWwON6gAjZpr9ivlk4N+cxHeHtW1XS0onanamQZZr
 Hpim3Ij4UXSusfQZhEI1m8A2rOaMtSs=
X-Proofpoint-ORIG-GUID: E5r_KDX5Ppi8Kwjc1pYkWyBa9UmX7XMT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230054

On 10/23/26 3:50 PM, Qianhui Xu wrote:
> One correction to my previous mail before it misleads you: I wrote that we have
> no vendor sources, which is too strong.
> 
> What we actually have is the OEM's public GPL drop for this unit
> (android_kernel_lenovo_sm8750 + -modules). It does contain vendor sources for
> display (qcom/opensource/display-drivers), touch, camera, wlan, audio, video.
> It does NOT contain the battery/QBG path - there is no drivers/power/supply
> vendor code and no qti_battery_charger in the drop at all - which is exactly the
> part your question is about. So the answer for this thread is unchanged, but the
> reason is "the drop does not cover this subsystem", not "no sources exist".

Not sure if that's official but i see the drivers are here?

https://github.com/lenovo-basements/android_kernel_lenovo_sm8750

Konrad
