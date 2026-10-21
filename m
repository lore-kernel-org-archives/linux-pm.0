Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594057;
	b=mjKXxiBHYp8RZ5RCxpGfkJ2k7DuycimvgzrLI0ngWfnK2rs3wWFwPelDHAc5ZLoEYUv1
	 +tUrYf+Z6ZL0Jw3paXUbvcBIphpafnpDBXoTKZB7P7BGwSPlLl/hvxC4dbRriBinW1czf
	 NVUt4BLp9uh3bl9ekhe88Y6lutFtDfny34N3rNyI8PcBfWwle4otgiSbTflN0rGlPSmFs
	 5VgQzNlxSYEDqENkSBLv5+bgS+ap5t6tv2V2gyqAlVxmwKyPmZRGJH5FmzEWF3LATk1Ex
	 u3QO+dpckcj/y8Zp2V2VSJVRFSa7LE09xJt+rzqZ75LqWNGUpWsjkk20SSGDLyURvUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594057;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=AyeYzDYt4cAMFd1jhQBvi9BO1/zfrHrFy98deBZRgJk=;
	b=hWyTcRWky36yaOQoItxjxMoDYsc8HWswsKUJcouBQKlrGr8wSn7PS80tVlDkbbqhzKO8
	 kqKeBlNFD1L9abpozeSfuWMcpWFANep7KE1/D7FtkcVWz0SHj+vFjKJOm+H4smCzluUPA
	 CiXayg3ANUlI+/PBqNp6D4icnKpq/X4H1+r6sxl1HiVlXeqKOJDtOIH7dYqj2sjoz11Ip
	 UU4PqKy7dLxbFs8Ln9EXsoVULvEuzLVJKQiqfDRQveYo9xkziSeBggjgXJqEfPXjT/EWo
	 Os7+Duq4kD00sNekUz2mzk9zTynVEjEu2MvNFFqhTxHQLUxJ2AY+C2duE/lBve9KgRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WQjuwJ7m;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O33eyoqK;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83F606A31F
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 14:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D83F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WQjuwJ7m;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O33eyoqK
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LEF2AV3557815
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 14:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AyeYzDYt4cAMFd1jhQBvi9BO1/zfrHrFy98deBZRgJk=; b=WQjuwJ7mva7l4S0u
	1n6h5f1vWLqkLfPrN1jxiFO8cOcbeZNyfrs37ynpbHAbqI8jaMuwuSYKK9QL45hm
	NHLwikBNOpE9tu2ao4ji4SqZU4Ojt9m7aZm06zD3v2GUUrOzzeVpcYIrNbOlo4Et
	oDHBW64tRIgiBxH80KXBauGO9z8n18F/F71R0oFG09L/Q07fHct7on4BamJpjfyA
	ED2yba+o9UZ7nQgatiLUOgyF2gQJTxwrcm1/fPTsJKtW7GyteXqrDSIVPrY8VPnl
	pqenldnqATZdvx3HbnG7MNmMIXw6Ha6+5FsqcG1x/uen/V5Da3eThBbK/Y/SosnF
	zxBCAg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hesy79kxv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 14:47:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9308eafb465so250605685a.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792594055; x=1793198855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AyeYzDYt4cAMFd1jhQBvi9BO1/zfrHrFy98deBZRgJk=;
        b=O33eyoqKxzUoNy/Dhjy5H+sbEDZsbHjQFNR9whkoh6+/ohu/4AwfzWv3C02owKHQHI
         IyxR3bb5idg4run51/MsJuXN1/mz0k4FmVgNxX1fh3OEXZ0LT0hRaz6EvuYzFz7wQMFR
         +0G6k+uI4/9tljX5TmLYtJvQctNt7arao/cH/iNMTq55iKTrUiz9rFfKRrr9EJvITkWi
         /aqlZJFdF00uhYdd4rRrFdw9beCovUsTevnF+tOBE66Uu8MNE/Qn31G35F0FaGb8n069
         56FNmfFLofdIjrCzbfahkbQoHCrpW0Ngv3tbGA/3yAE+yYshIGUv2JL0aL1rho01Z7Ew
         CVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792594055; x=1793198855;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AyeYzDYt4cAMFd1jhQBvi9BO1/zfrHrFy98deBZRgJk=;
        b=E3NIU4sw1UsruYVBPy5bVzS2prUZFLzUDhnjfTMlYg11uNqdmUg+H2px53OZ2DBQYC
         rq4GciXzeslBezHTMc942mVPQWiFBrpheqBMv6jdpKWehYCLaTFi393sEWx2mhEIGRxU
         LD9LEmkvYsma5HoyiypU49Q7Yl3YxG99YBGp3eIhX8kZhTSxW+6RPHcbR6gANvzgQBY0
         EmlMHsJVrj3NXbVkh9PSkBE5WvEsIPXcloRqwdcq3XsUREz4dsgtIuO4waOyUyXnfSb7
         9uPnyR27dsu8QsA5v266tYcFGUxopkclfdAoxA6kWtroWH4k1SsOgsw/QRlXWpj9tUJl
         R61g==
X-Forwarded-Encrypted: i=1; AKwUvBywzX5RO+qF37llq5jHNMtVkjQ2gnJOfFVYpbsotT1LXWAvwm//PyEtPFOIHkGyOc558yYqhHyNbg==@vger.kernel.org
X-Gm-Message-State: AFq9FYK+kvanIFan9FvQLQW+6iYF7WaqqWnhZfPeHP0Xx7S16/vrdWw7
	7slQ2R1H1IvvbhFID8PFuKcNSs6BBkm6Mtysq0w3Yypt7qhZ5psx0DMmx8u+A1ngh7gnsd+QF/O
	Nfk3A63Y/5FbgvTb0vziKPCjWWcmkslvyG/IKsp2Q0A6pqi6g3+FzXSrJmF4dPA==
X-Gm-Gg: AYBFou3aJnErSuFiPcnpQ/AxoSf2H5T/Y78zwrTkJcN9tIa1ycg5+rXYSl8KglTWk3D
	LNT7fYHfYBd1ZBNUB/TZ1DCfUCcVZrReff3JlLIPMvBmKwkVe/66+FmOLSW3vo2rVyCv1d0nu6B
	vM++5epVWhF58yit+hHhvMfuaddA/lsITsBsOCgWr5zzIsRcLZFDfMqkNn33RRFoj7QeC0mfgDv
	/oTgha/P9V55iLM+tlrfkNWrORFCcNXv1D89jONyRefo20AuyJFivJqCXlPRI5A1UNSFYcxr3xd
	l+fG2u2SAkhcL78GBH00zN64E+/S7xJtkapEaKvIAQAqSAhJ7fv5ANBNKkY6MRsNIKut7dWp+Sk
	BCMTz9AFH2TrAKFZwjwj1vQfmhr3c5YPmVLNVXQK4UU95CY0jhweW0RqrJQI=
X-Received: by 2002:a05:620a:4505:b0:93e:c12c:fbc4 with SMTP id af79cd13be357-93f57f9f3c7mr426544785a.81.1792594054628;
        Wed, 21 Oct 2026 07:47:34 -0700 (PDT)
X-Received: by 2002:a05:620a:4505:b0:93e:c12c:fbc4 with SMTP id af79cd13be357-93f57f9f3c7mr426540885a.81.1792594054089;
        Wed, 21 Oct 2026 07:47:34 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8d9e:b00d:491:1503? ([2a05:6e02:1041:c10:8d9e:b00d:491:1503])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cd1sm5814797f8f.22.2026.10.21.07.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 07:47:32 -0700 (PDT)
Message-ID: <f223c867-fca5-44f2-9cc8-dd3ca99e1387@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 16:47:31 +0200
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
Subject: Re: [PATCH] thermal: Share THERMAL_NO_LIMIT between kernel and DT
 bindings
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261021134243.35103-1-daniel.lezcano@oss.qualcomm.com>
 <CAJZ5v0g5a+0eaULxGG=RFm=JN8Gh3_A=7mGUTmFUiXsxVKvpDQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0g5a+0eaULxGG=RFm=JN8Gh3_A=7mGUTmFUiXsxVKvpDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: U1T-IghKxyW8eSm0jUm0nKvobefFbg6k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1OCBTYWx0ZWRfX3cbPavdpc+oX
 la90M2z7Fvgd4431/5ZdxxMfmn1nYxZAfllKY3g5HcLI11mZ0qTJYJYZ6ttK/+YxG0Zwpm6s4vX
 h/G/I1NaWqJndQ5EWcIC/yU9E6kUKDLQWLAVbLHx9IH4Ew5mz2sb+vUWj/uepCqlWlAx4J9vTYD
 FJCs99fytPq/av6UX8ROu2kYeamqBTWDH34CG8UWqjUy/UWgU8EuDqF+wl1hVBk6FsYLr3hMKf6
 yRjgUcWMU9YNHdI/nfJlu9UFmM0GZgpPOs1uJ+PjDXWaSwYRrNfcOE5fMJIe8CTEVg4J/9rBAMA
 yaXoA96eCyi3huXui43y4gU78gVCzmWDKFU0Lp31/ARoDgB1ERhSU1Ry3S/0QH4UOPib1q3F6BS
 obXaYzHMnazLq5iAI5t3XubO3qMhO5hc4xEWJlKFpZqKfdPGj6R/Maz1RmGKKURl/YZ6WY3lYlj
 nSsvlpSpVYtdCsvMzVg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1OCBTYWx0ZWRfX85tbOLMGUI6K
 ddZk2bAP/o/T3IaE4nf0RX+sHt0ZZ4xVYqPRTddE9vu8IddkrJowHnWCm9Ot5hlDx1OWDirU/ab
 AR9WXG3+lUMeg4DBRrLpMGlWaFLwRXU=
X-Proofpoint-ORIG-GUID: U1T-IghKxyW8eSm0jUm0nKvobefFbg6k
X-Authority-Analysis: v=2.4 cv=IPaXmQvG c=1 sm=1 tr=0 ts=6ad8d087 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=1H47zwKHx6KseS8sNJwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210058

On 10/21/26 15:48, Rafael J. Wysocki (Intel) wrote:
> On Wed, Oct 21, 2026 at 3:43 PM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
>>
>> THERMAL_NO_LIMIT is defined separately in the thermal core and the DT
>> bindings, using different expressions for the same no-limit sentinel.
>>
>> Define it as 0xffffffff in the DT bindings header and include that
>> header from linux/thermal.h. Remove the duplicate kernel definition so
>> both interfaces use the same unsigned 32-bit value while preserving
>> the existing DT encoding.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> 
> But THERMAL_NO_LIMIT is also used by the core on systems without DT,
> so why is defining it in DT bindings not confusing?

Yes, you are right. I missed ACPI relies on the THERMAL_NO_LIMIT default 
for the cooling spec
