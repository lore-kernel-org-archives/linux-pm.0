Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E62E737D
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692253; cv=none; b=OX1X/xtgv4UGi2RtW/kmXaBpZtJ+rjq/MFnETGviA6WLCe5F8bnPRFGCNfh8zzw2MX0m9QdExsA+3jDHPuYUk1qp+TON8KPOKQI5UduptPRrfrs+HdDTw8unL6qm+m0bRVggHfgErRKz4bvdbKrA7QW6G/OYqDYHVAkEl6/NzL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692253; c=relaxed/simple;
	bh=hWmKl4wmptrKz+5XBCLWWbjpeoeG+4z1lfyPJaErS7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAR6Obna3Lw0pJwtlYl8wFnZijrJZJT2N7E0OjzWSf8vo1W/2MHLY2jA2a4PvdrWwqhx5kxNS9MC9GmFYFNarmaxwl/zCaiRPG4ivCK++Aps/ROQJd7SsMPzaUZ+XEqsqwzoTusxzWUzZSqnLpyrduOy8bc2dtR0iXto8dodmoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BbehK0QK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CVnCyikS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BbehK0QK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CVnCyikS"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AD6GsC790700
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 14:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+XJCJtu8fH3qzIlMem7W8KbzE3wBnhOhZ1Ej9WZ5SDg=; b=BbehK0QKnqLrS0QM
	fryYAY3GD1oikiJsEeFEFPbMPJhrcDs2t/T1tnXADN8xvhQr1zLpvmBJV2EggxtH
	xj+phWHork30/qKYMrHV3KSLRT39rBvv9H5oCo9JwkTkW+H82QaL1CrAmiUckS26
	auVT/r1JMulGbKO5Gpr4xKj5JtqjmswvBwOxR9iZL5fxNWyzUpmOjd0MujTQ1VVq
	Zf+0LjEb6hKzn6jHo70at56X9+P3Jl9prHI6BWGQNUgfh+5/YSspx7lqjibfWkWk
	DWZP4pZ34s3rtmXY3FF6a45G7e9Zb+IsnE01DJTt0+y0arip3KcQjEPL7t1Uzn+E
	J1ql1Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajwtbc1e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 14:04:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92eb5f54b6dso24288985a.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 07:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783692250; x=1784297050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+XJCJtu8fH3qzIlMem7W8KbzE3wBnhOhZ1Ej9WZ5SDg=;
        b=CVnCyikSqPZJ8oTT6O1wqyF4Xu/hnjJM2xeqLgi+OhU7pggOiXGq+kxrymz2RzPkXJ
         X26y3EEF2DIkjb0IB9Pa2noIFYNKuVskL+VlUFfCKnRZDpxiOph+QRyWev1SH0XxEcdF
         squRGYVHZpUDL7monpOw+W2jzARhhq6uDBuXoi1vSdA0rEK6Bt3iFfKtXjI3k1KezSiy
         s/Svi/2IfsIxE0Lb+TGnuW/v31dn4VKEOBgIasKXvAp56ZFQMv06TH+0xJSGhwEab/8T
         isbppJXRzQHcBvHvspZUMleJyCOOzT/k8wiWwhHUvwiGIDEELQt1wc8VXZwcsy0NXSzR
         54+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692250; x=1784297050;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+XJCJtu8fH3qzIlMem7W8KbzE3wBnhOhZ1Ej9WZ5SDg=;
        b=YmO2dHemTAettaDmJHxJ1B8cb6LHfKvcxTNk7foUPC7DjIoBSqMFYG/S43JSlYTQ+x
         Kw/bsfJU42FxtMafV6keamsXMXFbC3zcC2sZMpCle6NNzSc5t/KcQIC4O1IKeDiF4Ul4
         SnAi0953jA2Ub+Icc5fxfzbXy16d+Nh3b7Rn0pctl9v2Z8N6vTq4DrF6KRuqVohSwrQE
         3waRA8H58lEw3Shptcy2J6mTKMTx46lJbHa9LCrxjYpdSsFr1b5CCkftzF7GlB1T6zUy
         6tiyY21IOQ7jQU9NNWaCuEqkgLzsVxkuxGkypqIieCYywhiitCR5oZCEUULSmrg4Gbqx
         WKGQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEWzl/OgbAeGKMj6bvQXCM4TltQVMLFvMTlZ3kTpnQv7D7+5Dl4H2W+dOmY1OunzuhpBb/EX6UaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6VIGh6P1F6QFCQA1/9nLkTEeJkLJPqJHTv1IlgAnb7mAfLXAc
	t+RmuVzORmx1rDTy6Ykyr1O8U7mdv20TGR6sRLDNU13FypWiLWKDGqeRLNNzfNS6wO2UwtkNUKj
	rJepdIwdlHHrS02lnTnyN9WzbacUI21l4RTzFXaWMHotys7ZCZM+7U8YW7IbHwYPxkaCI5g==
X-Gm-Gg: AfdE7cnPKtuY+hw+QDfuYkatZn9oGiiMAUnYpsunntGPoQLGaGs6BjjGidHeRryDC+K
	C7EGM7rBFAg8wFx8VNyDW1Ybau7Hjp4cyfkWUM4Z9/fqBD4tVRRrdxfiWLuZRrXE/oFNb3VV3EM
	EyrrSiY4hbp/wLmWTSqjSGHYJozfA8IffN2q6inzfHhBJsAZpkYEgNC7aHDAHt24JLHnbwjd8xo
	pSlUk2j790ViNXkCU9PyRcO6djsVPOF+34LTmNEGmq9WFMfte2tUZkIkRuc9g7yjbSEq8EJbfDA
	Boz70RRNhFHytrN8+BFpqZ1CPwFByCDwtfBxEv/XW/fnPahPd+//8JU39p7LOByhdo8EuD7VZou
	DtiJOx+LigM7RlSdLm6cE2aT2cEvCSegE/To=
X-Received: by 2002:a05:620a:454a:b0:92e:5ef1:9072 with SMTP id af79cd13be357-92ed77c7d64mr698108285a.2.1783692249869;
        Fri, 10 Jul 2026 07:04:09 -0700 (PDT)
X-Received: by 2002:a05:620a:454a:b0:92e:5ef1:9072 with SMTP id af79cd13be357-92ed77c7d64mr698087085a.2.1783692247367;
        Fri, 10 Jul 2026 07:04:07 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15de6c565fsm311138366b.2.2026.07.10.07.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 07:04:06 -0700 (PDT)
Message-ID: <0acb2194-3894-4cdc-8f74-a88ec3670d4e@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 16:04:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: milos: add OSM L3 node
To: Luca Weiss <luca.weiss@fairphone.com>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Koskovich <akoskovich@pm.me>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260710-milos-cpu-opp-v1-0-ae7f4b09bc77@fairphone.com>
 <20260710-milos-cpu-opp-v1-2-ae7f4b09bc77@fairphone.com>
 <bf766035-54fa-4e98-8abe-22cf0a229ffa@oss.qualcomm.com>
 <DJUY0I0R3DGG.1YC9D7H4AAI0J@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DJUY0I0R3DGG.1YC9D7H4AAI0J@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XOYAjwhE c=1 sm=1 tr=0 ts=6a50fbda cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=_B_-jDzFwVDfZiktVnwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: neZASK3_iJWoqAt8vvlb_08164tdBlAn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE0MCBTYWx0ZWRfXzbHnfcN3mBrg
 IgHmBpKtfw1fxo+ezFQJ/wnVYnWXrq8psixroQdcsUJUO574oa/LhPT3DDc4tR2kDY7LnkDo7+h
 flS/Q1Fkd0v3Wes6tASCmDCRV4OoYPE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE0MCBTYWx0ZWRfX2nqCNgrw6HGL
 v5/w0zIxihQfvystxcKAaZh2e8H3ZWt8YkFpLCzYUcFntHV9zsURzo3nT5QSmT0vTwmNkh4Bltk
 l5l73CPraHaoWtLyz/G538ca808wtE184u3t2tHvLQl5GB6AbkAYxzhIwfL65YCj3wg0VoFMqFY
 pfDHf7M1GSo+JiTlBTF9rrwoEcPh4mUYkZnOgUeUZhC0WeP4NXk3u6XHfTb4KVkGNYp3dJfLnB9
 K+MDMU2bZz9l1NLNLoJ8ZssAwYjdKZPnZZSGiuda0SEkljC3mPzbWZgR2wsFXr8t0DwtE0HT7GH
 msoaVV6SDBI6jn6KHP5Fy/Rs9+VzBz44npZxsWSCvWaS0M0S0XsQavERTNV+j5JHIk+mdHFeYKP
 7GmFGt6i0MBQto+8Pz6pNsAzxbnOD/d7FzzYFIksCOfdNvrxxQ/VT/S2do6w+Vp/efPf7nXfLiv
 r3cyYOdsXJ+Ja3tZzJw==
X-Proofpoint-ORIG-GUID: neZASK3_iJWoqAt8vvlb_08164tdBlAn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100140

On 7/10/26 3:58 PM, Luca Weiss wrote:
> Hi Konrad,
> 
> On Fri Jul 10, 2026 at 3:44 PM CEST, Konrad Dybcio wrote:
>> On 7/10/26 11:22 AM, Luca Weiss wrote:
>>> Add the OSC L3 Cache controller node.
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>
>> I'd suggest to squash this series into 1 big patch, without patch
>> 3 applied the OSM driver will engage and perform sync_state (with
>> 0 requests, so it will vote for 0/lowest) and the system
>> performance will be tragic
> 
> Fair point I think, I took the structure of the patches from sm8650
> which had it split this way but yes, it doesn't make too much sense in
> terms of keeping system performance alive through bisection.

Please carry my 

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

for the squashed patch 

Konrad
