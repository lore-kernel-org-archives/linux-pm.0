Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9743890FB
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148749; cv=none; b=EDqt3nbNn13Azk8NPzyb2T4+zm0sqzfZ9+3KUSA+G4WLCeFoenYw9gHvxf8D9MF3EteuyHB5bqxhikIZMevreMlHNvlCxx7iU7W5wOQNvNkTDMtySz7k2SB3FlzM/Kh4pYSBtMQKxP2FdNrUm4bhHnyAw+0LaqDGup+IlNMsViE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148749; c=relaxed/simple;
	bh=/khvW3bMtNiwmRmjVP4eRzL+G34Q4GoWDP3iKoAkJss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5P6hrZkUYxYow5Hb4APU7uPdFbBnag9hTUzQj1/G5sLYcdvjHV1YBiYkeuj0zU3JPXOWKdAUqlpyi6u4ilTAAIpmtQH4oRSgxVJTgUiDTjgIHxX+lGGOz4dOoO5/39Ke8ulbBedWt9G55oeEnl5tafBa6hpAOa4ZHgCKU+Gcuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kCcoZ1Al; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=anBKYRat; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kCcoZ1Al";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="anBKYRat"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RAM0w53758448
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 10:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rirpZ15MuUspahvcoTWz6yvpA/xN4qTQ3zXvKQRTz10=; b=kCcoZ1AlmyL6TqvK
	/moJCZb7TcK3AaHJsbpp8ptQ4+LwX03mlLzI+30cS4lEyQ2hNEyf93MdOp/K9rR2
	wyVH+KfxULDJx3civxUFDDrx7+Jo/FJFrqE4/q96aGbz9ElCZ5Jvj0ucJk8pLhR2
	54BC000OUSbYmntFJPwd+oYGkKwkeFLqAipVunfmgFu5gVrPtRPF5CvjptW99rz3
	K2xmNdXP0Oq5uncQD/CxDZfwLgT/aDX73BGhpVgCmeTAN4aFpUO5tRoX4njB6yjk
	l+lv2WbMo38gbhZPATwR/MsFoIyDnCN+XCMSYh20AHEy/lzdSDUENChXi9Qurtqc
	7Q0Nww==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4c60cvh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 10:39:07 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84885a4fcabso2996899b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 03:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785148747; x=1785753547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rirpZ15MuUspahvcoTWz6yvpA/xN4qTQ3zXvKQRTz10=;
        b=anBKYRatqmS188gPDEpQ5QvA1tBQeLdb0+XOsV3IuFE45SZnu6iiM7KHg6x6/m7JLD
         VjGmpkKRk6tOyMVEFBjyNgPX0EdGhInv6rwt1X8f3wa3hly2xODxpPX/CE/aRy5HCYuO
         zYeBpwdPPPCSANAnxZZQonvZJYErqO8XRHnVY3xidR91Y5RQoeB7Qpr4sVCHCE5bVfhy
         oSKaBkJD8rSYzBJBKN/pcGC8GNNUHR1cHeihNL0DvJludedB1VBQVSblLa9pTu6Loa92
         782l1BQudEtM1RofzUS0WUMmQ6/NB5r1b0cuFkWqZnlGc8/O7VE7Zx+hNboBB8cAJgxg
         cgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785148747; x=1785753547;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rirpZ15MuUspahvcoTWz6yvpA/xN4qTQ3zXvKQRTz10=;
        b=QMOfCFbt+xrgRLv3etEhQ8dg3ec8YHnsFZDv6pdxzedDt2vIDhV8huzERK4GZmXddw
         cVPxZ6H+mU1aelDq6Al8QtPhEa86QNqQlPF8VyQrd5ZEypj6noIY0VxcUjTiQ0lXH2hK
         XRf7YuSKu6GNkoUBxQoPIIaJY2dHV/oyYx4eEcftWa0INpDcJDZDG+fJy358LnFBWHr3
         aHGIerzSsI9kaM9f0ENe1vY8/yXIwLGVu9nGl1ukWqtcdSj4ZePYdwkFde+E9ZkZ+axR
         awRc5EeUuPG99if/zHb8G3Q5OesnRHAeOAhaALLpcuPqxzgXOib+oOb2rN8d/wDek48G
         D3jQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzSVblU3Iv8sYMyQAFkcE/hSbdEKmC8DUsKB1vnIvebcfJWqvPtrHeIihvEDtM7NDXhmz9O7qevg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZwID/LdLbDJ4wGlExr5sMCA4KoRfCc9jRK+rG/ZQNFRA/g8P0
	j1GYHq/zQl8ab4n8wLuhjaBdN+3DQnNFW0iMY/HayFMG8JMLd/M5LXHq5xSn8OACQo/5XzjWI/s
	2ossmKduG2Q2FOgdKSITLD4OhKMPyoMARRAqCJk+WHAgA7F0fyb1fPNb6WvqrVQ==
X-Gm-Gg: AR+sD10frS95QUvzPx4bSioDclG5x/pu8eWUX46jOgu4AlNN5Ar3+qM5zKJ69fHLghk
	JXNdljB8BI8vFACYSDVdNyYiGwjic3Mgn9lqGsQmAV3q60Wow25WU2iK8Q0flNbb86cqfQms7nU
	ZeeAdJ7ZVOCnjV8lMVsDE55L2h/MuWcRN9Tb1/tJcsrNvciommtsHF7F+X4bsGImels6F8DBl2k
	yPN45nznqvRdn43PKGXFDQQC5xvEwPtZUyvnzXM4QUv+/+FEzT4v0pmgWfOZEPSzNmJEia7r1r7
	j5ydfYl+L//t29iN+li1v/zp1+9vG4/N03wMRJ0sCVSIu51h4lGWgHVj9BrZIeLkTTBsMEf93vX
	LagMNw9h/C1bcYX69YBXF9oCgawyTtA==
X-Received: by 2002:a05:6a00:4099:b0:848:8445:6956 with SMTP id d2e1a72fcca58-84e5945aa27mr6209375b3a.18.1785148746850;
        Mon, 27 Jul 2026 03:39:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:4099:b0:848:8445:6956 with SMTP id d2e1a72fcca58-84e5945aa27mr6209350b3a.18.1785148746415;
        Mon, 27 Jul 2026 03:39:06 -0700 (PDT)
Received: from [10.239.133.197] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5327f22fsm2837892b3a.13.2026.07.27.03.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 03:39:06 -0700 (PDT)
Message-ID: <5265823c-9b69-417f-80cf-5b06b1106b42@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 18:39:01 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: powernow-k8: Fix possible memory leak in
 powernowk8_cpu_init()
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <20260727093553.98246-1-nihaal@cse.iitm.ac.in>
 <5zxdn4jnqu22k2s7roo3wxykwsusah7mp4telybmzlc5zgilac@pf5svblpx7nj>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <5zxdn4jnqu22k2s7roo3wxykwsusah7mp4telybmzlc5zgilac@pf5svblpx7nj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eYQNubEH c=1 sm=1 tr=0 ts=6a67354b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=cUNOWOM62mzdd20HkL0A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEwNCBTYWx0ZWRfX7PBKwSyB1Po0
 ZBPjCa27vHEX9jNZDbXMtKG3b6gjQrUxZ8MYhN7YXhKp923xqy5KP3b3IkRbVvmU1MHcFeUPXRF
 RYAQlJXGzeP6TAWr7d6rHSWX4vHibWQ=
X-Proofpoint-ORIG-GUID: DHrtria_1W-lNbzKpkieGbbRuJ0QZ7vW
X-Proofpoint-GUID: DHrtria_1W-lNbzKpkieGbbRuJ0QZ7vW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEwNCBTYWx0ZWRfXz8eXTIaNWmz7
 IXpQmxeIdf5zQ+48kCqePmoGXnPx5bQJUK7RLhFu2t6ItKuE4MvaPwvJ/kjZOXx0OWgxF7i8aKG
 +0eSzFhi2l9qafXHVeCIr1nCQ3FNJLcNVeCqk5hxHd3avuJ4Ekg7DdsKzkS6mlVz5npofnNtPQx
 I581NCJ1g5bi8eoW2SqxlR4pj8gxhZoftzJhZtXI1UXVE0rPTmomPwu01gVuE2pUYMqwK2wtSGf
 cnjB1MMNaMpHTPlg5CZZwNnfvLC71J/Pq/D/zzxViRtozTCkFRw49dsOhlgrOMIUbWZ7jGg79hx
 plJDGVaATh4NGeNqmr3sUeG/0l/3ZYAuSG3dFO5EgOvFXvmcZVcQVZInGnP9hL5pUYGt4Q8befO
 VbvVcBJWQsMwn+qwxPwQBoUpETSEjNFaaPviizokgn5+sy/lffzU5UdPuWBs7UTf4OHkMR9Mhul
 sFA73QYpWfrk458wHQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270104

On 7/27/2026 6:20 PM, Viresh Kumar wrote:
> On 27-07-26, 15:05, Abdun Nihaal wrote:
>> The memory allocated for data->powernow_table inside
>> powernow_k8_cpu_init_acpi() or find_psb_table() is not freed in one of
>> the error paths in powernowk8_cpu_init(). Fix that by adding a kfree().
>>
>> Fixes: 1ff6e97f1d99 ("[CPUFREQ] cpumask: avoid playing with cpus_allowed in powernow-k8.c")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
>> ---
>> Compile tested only. Issue found using static analysis.
>>
>>   drivers/cpufreq/powernow-k8.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
>> index fe1f499b4fc0..c9bcc6f0ab7b 100644
>> --- a/drivers/cpufreq/powernow-k8.c
>> +++ b/drivers/cpufreq/powernow-k8.c
>> @@ -1085,6 +1085,7 @@ static int powernowk8_cpu_init(struct cpufreq_policy *pol)
>>   
>>   err_out_exit_acpi:
>>   	powernow_k8_cpu_exit_acpi(data);
>> +	kfree(data->powernow_table);
>>   
>>   err_out:
>>   	kfree(data);
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

-- 
Thx and BRs,
Zhongqiu Han
