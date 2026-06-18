Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C63D3E834C
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776155; cv=none; b=I1y38pN7zWFxPTxX06s+Pwom15vKA2rKqBehIpFpI09AZ0Rz4K9lxz6gHc/Yteg6eKhVjC6Z3YrBxX8c7/UaiINimUD0wD/ZbYByhb489Qvw7TsXRYdnSID6wTmOLq+8PupL6lQHJ9LB99MJjdJEwrfZCBPCZLuK3ndgf/ux5oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776155; c=relaxed/simple;
	bh=CqOnzpYUZ8jTECcLckHB51CXBNWr7PZ6ZzF5YP4P+74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVUhUt59cJR1u3DwqH9tqVyos//DERh2iI3z+mnv+DZHXskB2+UAwuGOeL7zLoaCAxxdc6Qbc9bW+3xzbFQw8651SQWv1uZbHbg5II+JNzrK6CpuJLPVCJ1SW4EQuRrkfpJmMBVT5EdnUkoIrHYE9Y1M2QoYrqLoqKB4ywm8sIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aQFd8ZVs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZVWok5VW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aQFd8ZVs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZVWok5VW"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8FRYZ975749
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 09:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rvIyhITEyAEOhZ65DNKPLUJIvhMXvypBUBYo4XJWBDA=; b=aQFd8ZVsz0D6yGsv
	fxnVX2h5MqNYRkCRULpH519JHRTA+ug1V9C9aqvcqyLTgsHYk+iwB8pGxuoTO8vT
	s+oBCLAm9IlieNsyIkXWaKq9MN2Xyw8i8T7r8+M/WNlA77+OUjYHsLIsl2qfDov3
	ZNVqisZIBwsleFaS+nmHO3VxCfPw+5hQQWSeWYe++na9O82l5NIWECs4YFKyuy3D
	oybKgDHA3OHzYdCEa+eJdLihuZhdQxKMc6OA/vJ3c++Sni14xxdUhNgapXSK6HJE
	8HW02CvstE1lrm9t/dBFYg4vDjLG5c/BnuOJh6I3keon+eENpa7ukpk/iSrYLa1O
	VlZJSw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev1wc2m68-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 09:49:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9160006de85so23157485a.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 02:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781776150; x=1782380950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rvIyhITEyAEOhZ65DNKPLUJIvhMXvypBUBYo4XJWBDA=;
        b=ZVWok5VWVtsi8Ljua1P0NHO5Hry6MGek+BlBKRUwo1zZtPVP5zIXEgLowHiEb1sN/U
         gNe1B0upoQf1WZ8dCMEO0+snUHlWPDhD4BvW8lzJrjlklrWTnTkAPEf5Kg8D/e1uxjUt
         Ri169WJhl8BvqrwemoTiQXcI9IZVHZZ3xHqUlblsKSKPaUtlGsVPfOE54I/nhmtJiiGG
         k+CXlo25QLTvK6BRY6q8H/gQyxnxPXetzUGU8UjbuYeY/lO00TRGKPzBBvwP975dILUQ
         d74NooesONLE/MRH7jwerfm4N+MRqCnmrJhZUwMoqMg1PujgStLBxIRIsswhTAkq65jO
         +OWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781776150; x=1782380950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvIyhITEyAEOhZ65DNKPLUJIvhMXvypBUBYo4XJWBDA=;
        b=UurBnC9f590xMnVSpE3p75XvEA1jM6Exn+zX3QEos50F2Z8F/ElstTHtY5C2cFnQMN
         p+syu4GhQlZqWP/iS8aIonYyb7Imp4II3RaGnPRUh21MYEHK6pKQ8LZ53Oaq3crH6b3s
         75VDQhFKFKOvflmt9ppor0nNKez7mYyLhZBS7nq5EsFnpd/gnlSnysgRzvhHhpiCMQL8
         wPnOj6UYP0+oADlHbdNDCQlb8Fw3jC8PHIUKQF7rIf/KGEiCgflQ+MnoyLsGqySDheod
         9l5xLAKjbD8aTadTH3lJOn5hm7LKvByruM+GLx4D25SsbknidLbbmksdFggeWSQrvf14
         1gcw==
X-Forwarded-Encrypted: i=1; AFNElJ9p4xnaVaPjWCSnORd60LI2FeM3bDW1cT+hzVVewhMNoF355WH74jVvpCoJlqvjzKyPTnh1ZJzFRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd+n0hRqyhz0Pz9ECgu5USHxVmkGfgv9P0rjzfIPg2+EtDNOKK
	zYILa3M2dwaXgxK+QIfciliz2fDGvUJNLavE+0smH5sde5DQgPfjXv9llOwRsHLq6QPFuKmiKYy
	ZkW3DooGvZLh/SZrnpjtrmlOvDGtjJ3wMkcRDQ5e0L33x9788YB12mrBGeYlSzQ==
X-Gm-Gg: Acq92OEOBXAgOA0WCe0FjXN7c4d2gal2PzSlg2cdk+8daZA2Yav7kkCSAvllP8V4QNT
	4Vxjx3xXC6okK2y4ajEP/yMGOtSNC5ffVmhhe68cLixoJfNALRzojWS4mf6ZeJlMS4i32aiQ8mj
	yZzqhPo5Osstf3MahFtbd7wA8dagKqHYCiGckJxVhivOv9VjE78/eWc0+umeL7ICPXYeLpC7+zS
	mzTYfCUwIetYP4TfI6bvRRAZ8bWe9XJZvJo4SfWq0vJUX6vGMe4JKdBUG53pBz6Woz2x7gQ7Bar
	ZdU4G/jXAEIcGObxg7IPR23OE/I5KryqxEsc0LvOpnh5aC6l//+C8vNnUze6JZuNbtlf4tUBN6H
	SFoQKNDREtTG3B6e0ImTB0Cp0Lq6jGdsz5t8=
X-Received: by 2002:a05:620a:17ab:b0:8d7:ed38:8189 with SMTP id af79cd13be357-91f24ff5a51mr281467385a.0.1781776150234;
        Thu, 18 Jun 2026 02:49:10 -0700 (PDT)
X-Received: by 2002:a05:620a:17ab:b0:8d7:ed38:8189 with SMTP id af79cd13be357-91f24ff5a51mr281464585a.0.1781776149836;
        Thu, 18 Jun 2026 02:49:09 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb7b6de2dsm919473466b.37.2026.06.18.02.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 02:49:08 -0700 (PDT)
Message-ID: <580db7de-321d-4f4e-99f9-3c9a1cc5a3f9@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 11:49:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: lemans-evk: Describe the PCIe M.2
 Key E connector
To: Wei Deng <wei.deng@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
References: <20260608091702.3797437-1-wei.deng@oss.qualcomm.com>
 <20260608091702.3797437-3-wei.deng@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260608091702.3797437-3-wei.deng@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TMt1jVla c=1 sm=1 tr=0 ts=6a33bf16 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=JePoLz6rm3lXWa06D34A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: _2ZBG3tkDRGRUO5x9EcPxLNE-fkxg9_P
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5MSBTYWx0ZWRfX5NBM4pG0bM+S
 ksTdGrY6VnIbw/ohahRng+qQjh/+OreaXgo0bszLmQ+wLwpldz4eEJtIRnyxIeQpugNdsdr5lwa
 9fYxO9Fwq2aiAAJensR0lB+meR8QZms=
X-Proofpoint-ORIG-GUID: _2ZBG3tkDRGRUO5x9EcPxLNE-fkxg9_P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5MSBTYWx0ZWRfX8IQ0pIguCB5S
 WE/lRpumNLlcoy3ksfeWxc2ttQMjGoQdjKP6XLZYEJm4Y93JOXKsWFGTmXFargLxTbe/q/ipXYh
 RiUfKS3RNdw38cv676hPeKE2yeaFhATNEbuVo62tZTYMAZabZawcPGszbszN/HqbQPhgykMcgnB
 iNCOyAdtwSGB3R0ExNVYEABH3m7U7SK5rUA7E4WRTFN2LSOubFK/BFTHd1AzlpddVt0E6P5XGWP
 CCooqbWvGYt04gBh6LYa8JK/rzSIRn81CSHrmTWS6UiD2LvyIztyACEN6h3qFvmjE7Ki6py83bB
 lKxL6nIYoa05u7Jf6WqEdwR90yHDxUNzabmPMTyW+InPCURbcitDs6qR0xL+v0W18/pdEdDgejX
 7cnCr6Vb/0ot5uqmc0ThyMXsVtQEzk2gPaPHjYUOFH/GBuVqJNliv6dgrOe/zgFcAyde813YvYu
 FuLEU6WOV4kaxENavKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180091

On 6/8/26 11:17 AM, Wei Deng wrote:
> The lemans EVK has the PCIe M.2 Mechanical Key E connector to connect
> wireless connectivity cards over PCIe and UART interfaces. Hence,
> describe the connector node and link it with the PCIe 0 Root Port and
> UART17 nodes through graph port/endpoint.
> 
> Also add 'compatible = "pciclass,0604"' to the pcieport0 node in
> lemans.dtsi to allow the PCI subsystem to associate the DT node with
> the PCI-to-PCI bridge device.

Ideally this would be a separate change

Also, b4 can't grab this patch since there's something wrong with the
threading (multiple series in a single thread) - please switch to using
b4 for submissions yourself to avoid such mistakes.

https://b4.docs.kernel.org/en/latest/

Konrad
