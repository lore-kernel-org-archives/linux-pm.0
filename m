Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EDB398902
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534546; cv=none; b=GYFoegtiF6A7cxrJtRvvCyCp4Iq7Zfx8jA6Enpz3EaEdz7vT7eqtqih2lzkkNwwmQio7wdPCijexLzQOZgifB+AILCV8gQaGiGXaJThM8ueADJjHCGzTssnSMoQmYwXwLq6pB/513BeC6z/wDjptB7yOFnMsErxCsbniO1b/Lcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534546; c=relaxed/simple;
	bh=MMEqQkZPvi/5ynADm3zhxHcwi5HLJhKklTvMI8xdjoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6VWkgY8Wfc8lHwsV7y2ZZp/Rvv5avhb+qk96gCV2pO+1X9cFmhKLusbeNYbFhzaA4NKfoFpqA2WSYWj4mUwYNRkA6/sDP70RyirR+uTZ029u9qP6QgfLoJVKurCZBV3Epxpb+ISGfL4onzQ8pqsRc76iEYB/GzTDQqh86m8wJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ojC3OUe/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V0EqyiI6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ojC3OUe/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V0EqyiI6"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB47bG569078
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 11:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	afmtgqRWCUABdl9GO5Xs3Pv0Pb1Zyrxte+NJGpMHlvQ=; b=ojC3OUe/lMh5snfy
	MHCgoBA64ZEm2rChdqsX/nlyrSTAmYpTCw0vXH7DiClIUmxvxbi4lJUrTEU+L1T8
	KT2BydMef58kjptTOz0BiNQ+aadHTJrVVLk11lycRWp4urjuWCR6tE1+Vw4Mpeou
	TTgnkacs/BVuAp0UCQB7xdTQ+r93o74iMBDQRiONOHgq52K7FnvFV+YbBYuAtJnj
	pdZmWW3VVph9NONtekwRebns+NQXfFA+k1FKe4GTzdtiosRRPx3NkP9X9DbWiS6p
	cKQ4e9BzpXSniHOVOx2Q3HVbKehkgzcat3NFkWPUj8fywSgKiNSksjf3jQGhT0x9
	pWsU7Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nut8jdq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 11:35:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52ce64c41efso15012561cf.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 04:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786534538; x=1787139338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=afmtgqRWCUABdl9GO5Xs3Pv0Pb1Zyrxte+NJGpMHlvQ=;
        b=V0EqyiI6mgLZw8j4ttQ4mJglMb1g4q6zqqgL0HiYRMxtDR8PfyV55pwWtisCwzkle9
         miY5/PcFtNDTQXKVMGO0wki4AvEisFj5ZeJy/SbYuoa08FVyE6lNW2QslO1daCon8Jxd
         OtnM/h7TDIxJUHsKOZFbs7cH1HLLv7cktXrY6AY7tRw7+3Yxno/QExjZxK1dLQq2gOBB
         bwaqs+n9P0HdgYN/YYVElTkuYqOHv25ldAb3lBR+yqil88yytULaC595ipEwOoPhASxr
         WG9/D9U9Go1cD5qMc+VgU8LwC3CEX5NWZa0bwhq+lFfPP73GrksP5WzPfiicr0h2vvtT
         yiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786534538; x=1787139338;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=afmtgqRWCUABdl9GO5Xs3Pv0Pb1Zyrxte+NJGpMHlvQ=;
        b=AdgU9Ux6iji2Z71lDQxMzK5m2upQUMImMcQHAWpS1MHiyXIvm1rn7gJtc/ujLI+jNy
         kiFzs+DIIL+91XYQSNSTj76BFz0raJyU+g1uYGqlz8uVv72d4ZdD7eOJgMiKH5SIw+Lv
         gLkkwhEBsdOQGnHqfUK3dDDXYkALLkDBaf7JZcHYbjauRkpSKYL4WpUn0My0MUgcRGnZ
         LtgLARobZBLkqeI9CaM479go2iJdVMgmR7OY1wFW7g6kf2lMfdNmwda8JxQ0eFLVgdDY
         maQRwBboIbw30NCDoPtbdcrY9AxLwZSCGOG6GHBhI8fH9sgLyYjIP2LsNS7LVbiq7Dkk
         Ysmw==
X-Forwarded-Encrypted: i=1; AHgh+RoTM3FMXAmF6OntxEsbsTZLBvcFJio43gJFhcRQIpZRty7Ox5plWhYwEoHBsIgRvg8pSh89ZWo1fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwO4WyoYJxTvXG3xm21bVc78KbwURaQrejytQ7pRomdtpUetGx8
	OPI83jUHh8v0/HEo0LzBjNHkFmoqB0/Bsdn3rBEkrEFK1ClJrZEXtZKRNEH2gQqG3pslpzBp1FH
	ymi9wui/5eWozMtS4dJWRQI0ms7Vv5Jlq8uKJe51sGzZF80LGjNloA2//NwTJdQ==
X-Gm-Gg: AR+sD13Vuopb2DdELS0UHCspUTNpWPQronJ/tsRHrIvosk3avcNJzX1+/AubXuXwoDD
	Y4vK5R6JbukT2OUmUg8SMGa0MxWXMfBJRSLgeEdBxwKbui8pWiTdvhWAKnCaM6kqBDJ+e8ad5ip
	tpkBW6hovzWFPnyoJTbYjmVs2FlvRX8e+deexY6IfdU3hoIgX8h8giT5OIhqkxwvbTsFnmj9S8h
	mBRSl6rKh2F350M7MFYKNQTh285JU6xtQxDjE6aL1Zwdt/f8iTYTROc8skxamZT+ZPaIg+0lt0y
	OdzEYonN59PoKXwY7urVe8qVPumib916oWQEYYCNc+cpwWRIT4N4KyddRNVM6H88IFq6GIuPJto
	0JVyMTuSyW4TIeZ0jOlP9SGBXQwskQsscGc1r20lVF4or6Wmx7fQIqfBQAZblptE=
X-Received: by 2002:ac8:5704:0:b0:52d:3ff0:62ad with SMTP id d75a77b69052e-52d6482da14mr30373011cf.29.1786534538272;
        Wed, 12 Aug 2026 04:35:38 -0700 (PDT)
X-Received: by 2002:ac8:5704:0:b0:52d:3ff0:62ad with SMTP id d75a77b69052e-52d6482da14mr30372651cf.29.1786534537885;
        Wed, 12 Aug 2026 04:35:37 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d71e:6d83:9df1:6316? ([2a05:6e02:1041:c10:d71e:6d83:9df1:6316])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b353138sm43885075e9.3.2026.08.12.04.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 04:35:36 -0700 (PDT)
Message-ID: <991ee675-0a5a-495d-a857-ed03248b02c6@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 13:35:36 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] thermal drivers fixes for v7.3-rc1
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        "Bryan B. Lima" <bblima@usp.br>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
References: <91946ecf-05a2-4479-bade-3d0803bdcba2@oss.qualcomm.com>
 <cf0365de-77ee-4ae9-96bf-0652c172f425@oss.qualcomm.com>
 <CAJZ5v0ibXHOsa4Pp=A00cKCOiBnk9SMpSk_n9JE2qSYTRZzYrA@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0ibXHOsa4Pp=A00cKCOiBnk9SMpSk_n9JE2qSYTRZzYrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX/hzFlmUBXcAu
 /rKhx++3rGvPAlQn9/0zBv1M2GgZ2KLmtmQZxZRla2T/RSWoA2wyiU2EbfH9XiyGDrCsF+suPI9
 fiTMQ3W/pIB9M9bZsQz7wPcYKfDSQJE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX7jFG7ICTCNNX
 tJLK2plG3ixd70TekBLnaCsAhNxIupxR9TAtPtEDsG5xR56lUHgG+TM1dmXGnaGODJR7SnpWvOI
 M8BWFSICUuKTHzDNuck/AL1I8HUqDiWUxts+1fFEqCpw7d8N1oME295HVuLC357UOJwawdVYJA7
 mQKGaf2ZQUYOaon8ocQTBmt38+/iIhbWVo2f9DGKgeFl4oPuYurYeXGyjM/y50TqIhu9DhR/7zJ
 RhzbjtYCz1CDldx08p0CZLMLGKC4CoZNHp9cVQEArJnvw2z1xG8GNk+vTuXPzgbe89OQK3sl49k
 7gGrUiwqnu9nRVJsX2hvhzwsKzBWzsJ2l+abYEGWr/gd7Q5fbB8PNWI5mIhXo/xh+EkmccsCMKU
 JX4w64TUoneJotK2fQxu4Mwa+kxvEiXdPIvTSHDLH4mCrfG7nv28MAXMkOkt2hhaxo0DTHwLsUQ
 vcHS+BrKjaHol/U+3UA==
X-Proofpoint-ORIG-GUID: _Pwd3lKGho0gY5oShF6blM27yt5lvpYH
X-Authority-Analysis: v=2.4 cv=POA/P/qC c=1 sm=1 tr=0 ts=6a7c5a90 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=zjcX0NPPdoIEq7RTRpcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: _Pwd3lKGho0gY5oShF6blM27yt5lvpYH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120093

On 8/12/26 13:28, Rafael J. Wysocki (Intel) wrote:
> Hi Daniel,
> 
> On Tue, Aug 11, 2026 at 4:48 PM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
>>
>>
>> Hi Rafael,
>>
>> please ignore this PR because there is a missing SoB.
>>
>> I'll fix it and meanwhile update the linux-next branch so it will fix
>> the build issue.
> 
> Well, the build issue is still there in my thermal branch though.
> 
> I've now remerged my linux-next branch to avoid exposing the thermal
> drivers merge I did previously and I'll wait for another PR from you.

Ok, thanks
