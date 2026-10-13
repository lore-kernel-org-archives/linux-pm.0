Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98BB3DC87B
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884029; cv=none; b=Oc4KsSODlGcb5vjoKbPnQDJDV7wWwS4z8+K1xro/yKbOTtu/pwY1/PbcfXvmMIL52VHC0Mj7evtgouVWqUjJ/uIYiVg8biZAJSyWYceH9k2LssypJghYahkvT+USRYmQbxHWXbn8aPbwNqAAN1C0ykvMg03yRYRZW+MgzbYdTto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884029; c=relaxed/simple;
	bh=nLb1b21lzxvN+3LUVcKLtkwh/UVCiSWzv09Ew8JyhUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/7HWJ6/N0CLDS4DsQgsovJJPNotiQuJcfHHxqNn8gsPl770NS4bAnIwvG92REusmCoQCsGNlTvqU7/C08uQ3r06vHpCzqZMq81Yk50r3mOBri8YWU9xZ5MD0Qi95e7ajHCD4N/hdOqZGjcJMfsUOAvGnPJC3TPm507vUKGblBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lMcDl5sq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AbQVWc7C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lMcDl5sq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AbQVWc7C"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D7OaqL015566
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 09:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KYeOkeit35ph64NPvNCMkB86ITDKOLzrRswMYB2OP18=; b=lMcDl5sqN8wEVEP8
	HsyYkfddnslcDF4/8qIWUyq3e7XibpgV7Dc6kudmFMEZUMMA6XTLT+ZPLhhTARX/
	F1Nz1brkVAP1ggGocu0rWlkV1KWTuum7ldiT3q8BMhpacjAAfDufh/qnLjKAJaAX
	HMvGXlfmO2DBShkCS3lggTt1Z6EwDhOvty+B0w0DEYZe/gdYbLZQO8j4xXt/NTJk
	EEfpadfFqtoVbQC4QSIu9PlCBYvkAMwacVzfsyF18j/U81hrSJ5ugrJh3ZI2xscw
	nagv8w/uvX3Ka4TUym8VZBEgOvwLgHBPc+QY4kATF4sBhr/UzHgaO4Wm+qctIMbU
	BkWmpQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9g7ughfg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 09:33:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e82060977so537613485a.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 02:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791884026; x=1792488826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KYeOkeit35ph64NPvNCMkB86ITDKOLzrRswMYB2OP18=;
        b=AbQVWc7C2IX2FLKljFQV07uHi/AvUB2ERFdkcG3Vo2zJ5JeL9lcOlNhc3aGNws1r5q
         8xxSbHU7vGd10JMABRrYrWTwiS1GN+eCAGCG5C+fD3a2zrUDwB0XsFxCLCG3MOcOVXbW
         CMAOfvUUCM5NJ9m3gDj0rOsANXTCetVcdsa0L8q3TV4zYU5GIRql+PLmH/MfR46HCwwW
         4rzuGwPXa9EcE8rnhPs8zOSiVd9Cxxxs703V233tVc5UVC1hwTdjGkAAOuK7wSBGXkHB
         aGijSsbxnOy/wTU8ZddVI2B8eEpWuPyF20gH4i7d+cKuxk3EwpVdXRxSBAjXZJS/bKNo
         1lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791884026; x=1792488826;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KYeOkeit35ph64NPvNCMkB86ITDKOLzrRswMYB2OP18=;
        b=jeJNMV7zd0F280jgSrIW8YPlPMu4IJY0f8wAiFRMlEXtd+stGyputcVbiiAv0hwKQK
         T1BFzH8/KGcfj16gl2Q8TpdYlR5TOGBGgatITPmE/Iwl7erS4AAjrUpw+ukLNioHfWN4
         ysdTV6WFZXJ01Qvar2NZxIGQlAhYCCPJUiz2QcDNCP8XaXnvcCK3+TCXjszxjauaC8Zh
         /eScb3D/mH/cv1g7iIsG4cFhzcONL4OMBvzYZjdDAzMNgVpQwogh47BhYoqUbS/Fn7TY
         Mf8S8CvyeDtLdsLnqsZAW+R6U4VUr0gyqT2kjlcJcWybTAxrq3FOrCQvI+Pujkrezy3d
         mX7A==
X-Forwarded-Encrypted: i=1; AKwUvBxSqqJKAhuIlcOJPNdcNDBh+K7UHXuwopcNQTq9q8kKVTHlpbnWP+grp03GoflXEw26xAL1oZfRZA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJtO0TED2i/8AQr837i5rIGK/b2VQl1giFJgn3dKXag1JZ7dLiz
	eUe7A5bqYLVDvzgwQgl5Bs30kP/MyJeUNpvCkeK6oWf8iWYK1WjdNx1CGpJynA6jp3xi9SgZCIh
	GZ1CUtoJRz7zbkDcCuEUoimJ9MtQtlTE7KgC9wfoaVAhpUH2G0pOaBrD4eDAChw==
X-Gm-Gg: AYBFou0Jnwi/nYJ/iRiQVJdoDmvJnYxibbrzonjBUQx0Kn5beDdGFAGsVD6YQz4pYYZ
	yPYBTUf/p3WGIOpdwQ7YEns5SavB7FcbZgpkf098l0kHNSMlgsu5U1begT9FQXOYaIkumMf8Qp6
	T9cb5ihp3dvdfytBLnCnfdcLE2ucbtPbqR+Jj9fS07rOFzqkpsXvzjjKcq8w8f7bRLVGJCGxxaG
	oc1mO1al0BPNFV6NPkYff5U0QmP4Ux9U4aEiEdHfH5uyqquHwQXzHGpAvNoETnC5rHAVoCoNIMa
	Rigz/CCIF9b1PUrys8GoGaSdPqY0cVGrf1GckNpDatUsIrRtAmWzuVs0CCwSFwK6QBGGdEqqFho
	o8t5uVW9Aa4QaWrSnYtfo8KDVE5WMTT+Lp4G1t724WmRMQ8PeVZYr0rM3rZTpGg==
X-Received: by 2002:a05:620a:408d:b0:93e:5508:24f8 with SMTP id af79cd13be357-93eb9677234mr2019267585a.32.1791884025743;
        Tue, 13 Oct 2026 02:33:45 -0700 (PDT)
X-Received: by 2002:a05:620a:408d:b0:93e:5508:24f8 with SMTP id af79cd13be357-93eb9677234mr2019265685a.32.1791884025327;
        Tue, 13 Oct 2026 02:33:45 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac3970sm3930449f8f.37.2026.10.13.02.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 02:33:44 -0700 (PDT)
Message-ID: <a5e5a7a2-ba8e-4229-af4f-7479e7e8f37f@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 11:33:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: ti-soc-thermal: Fix the return value in
 ti_bandgap_get_sensor_data() kernel-doc
To: Karl Mehltretter <kmehltretter@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260912062252.42762-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260912062252.42762-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNyBTYWx0ZWRfX7wINgJLMnwjb
 xbiK990cHIpMKgnI82Jqj/PhGRfM9H/jUETyyfokMQ8OTH+jYcF3iwLhv3h0A6ZDAV9oIH/IOTT
 WUOWHyIFt0QSrHfAR8i3nTtg4AVXqWF2zGdFTpzxGcW/voJles84KZy1OPuWtYsNKAcsQV4B1sp
 x2NlemtwmY9dvMkEQnMFd+flM4RW00IvdGxmDjYkJKY7I7vyo0rxhA76/vWOWqJNDyUl3AH+5h9
 8ySv/U0mogPZ2WsLYVugkZhYDzmkvplYtiR6EaOwokB+vr4R91p1PxzNs0L8uNIwaML0cCcuKLz
 qiHgoY2mJEv2MNvzz+b0wFGJSC1uR9S3oc85lOjZygwZnIGN6bMwhiz5nqeq2hh9qf7gT5fl29e
 y/luom369cEtCuflw40L4v4/aRmIL788VartF4cRw7PSDMjJOQGp6gd4otD4wi+NpXd5ESAQVwF
 QC1ml2z+Avim/d3No5Q==
X-Authority-Analysis: v=2.4 cv=Z495j3RA c=1 sm=1 tr=0 ts=6acdfafb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8
 a=Gq36PuiKL5ZAMQJggHwA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: ZiKCT7W9p6OsBGo2pQzC8W8ijs8DhRxI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNyBTYWx0ZWRfX+ZReDIesbPRM
 XjrFrowmoLKxdpr/1tP1g8dDUQ+fKLA4bd10AY21EZyYv5Qs+oGJ8UaQXB4NugO9QswtDIsG/FI
 GbnACOYcThHrWjMjbAgtFmA328zEqPI=
X-Proofpoint-GUID: ZiKCT7W9p6OsBGo2pQzC8W8ijs8DhRxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130037

On 9/12/26 08:22, Karl Mehltretter wrote:
> ti_bandgap_get_sensor_data() returns an ERR_PTR() if the bandgap
> instance or sensor ID is invalid. Otherwise it returns the stored sensor
> data, which can be NULL if no data has been set or the stored value has
> been cleared.
> 
> This mismatch was already present in omap_bandgap_get_sensor_data() when
> the driver was introduced in staging.
> 
> Document the validation errors while retaining NULL as a possible stored
> value.
> 
> Fixes: 8feaf0ce1a04 ("staging: OMAP4+: thermal: introduce bandgap temperature sensor")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
Applied, thanks
