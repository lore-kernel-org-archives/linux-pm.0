Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73F53B103B
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408390; cv=none; b=Lu7bN5dSXYxNLIT2is/eadDR4Oijxa5EAbtLSMfzEcrRN3bWQQb1UFaVMMp/ImOxbU+BjcEsx5zcEffbVYBqaxsCTD3zqq5h4RNq9LAl/Oylw0hFdIGHkTnyoXEzIYnSapEdrQC8MRWFNMVBqRXW+iYCsi2ICvtMZlMn6M6mhJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408390; c=relaxed/simple;
	bh=RKUXnkn3kG+KyzbpMHUFDJz3jceHXML2hV0X48H9lh8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bjzqPHm/mvYscmDLn8ymR4ygSQxkscmkUN+L+smAxgIKszrQoid29sAJRXT0YiMBPjEyjyO2jCj5H1p88aZV4zLZmQ+lQRTc6lRdpqefQFgFfxS/i+yA6akUk+b/5WFO1IHAuSL552IbGkIqs96ISUs+rH45BLGvlq9Kyjwjm0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L6Kv9q5y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dvNDIg8L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L6Kv9q5y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dvNDIg8L"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA2Ri11663958
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 10:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dFFXcMVLSjkSWsAM8kW8KeWkJEhI6rbMU10SrXB4XOs=; b=L6Kv9q5ykWcpSpo5
	OnY+12CFJe9Gz3+/LXgjEOR+FgI8fLrggsJR1nRxg6nmx6nVqt1IwygFqEaL7Zy8
	iYtUz9zi9KL/P3uiX46R+EevD8jtOPbi+s/QyJ55PmoUWlkjO+SYSETW4Y7qqV3p
	+i9OOpW3+9S680g/GnaaZEwpw27jtmP1pWsFn+wMhIJ7oKlhtRXt9136Yz4J76Ak
	uriZNdV4B4qIWOWpP0YbWi73astqaAmNYpNQLf5Ow8qydOn6dOOj+4a0EHST1pOe
	8hzAWWcDJ1a4Hzi8KGB1qDo9s08LTiXEDLq5Y0gZR0lMi/jBszjYJ5/IqO5h5sX4
	Mg01dw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr3h1rgmq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 10:46:28 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848544a8496so2363054b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 03:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785408388; x=1786013188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dFFXcMVLSjkSWsAM8kW8KeWkJEhI6rbMU10SrXB4XOs=;
        b=dvNDIg8LJxFRK2Hu8xrxqeN19XJ6dolPTKsQw3c7yCfboyJCM12uxRYuu4QRshPjSh
         2cDaoFDR5vIG74uGsA4ZZrVYF2mLz4NPCnv31AnERBer6JCF/J92kMqLj61oRV8ezgKC
         Y4NZkgBBVBphJXP97CSIZaAef18rBoL3SFLttsZZNfUQFG2BzMijTmsWQZjOZJhvxbPC
         KsW72ER2Y64QKWOBxJVxnp1qzlhADAYI0YMAObv63Wq8nfFwQGCL0+WvltinbOb0F5J8
         tznj5j8BkMDwcnontY6Iv5cewX8SiPH9j8r3BD72TRdAFdvuSBl3sJ2YrJuXwfbnmRVt
         ARWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785408388; x=1786013188;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dFFXcMVLSjkSWsAM8kW8KeWkJEhI6rbMU10SrXB4XOs=;
        b=l3ybOkoPj0/UlNljIZ9YCMQUmJ3u/ZyBunCfZAg+K9OUrTpPMfjnIWv+NqflQ2Iluq
         oe0DIoIzc7depANSILG+9Ul2s8mP+38U9dGRTdyT25DQsHKi4fyfxaUqU9QGV1WMgZi9
         dNuxC1/onEhDRasZecWr3uwUNB4GRVnd7XkvSMFrbimDAbTU7CPz5h3CUbaBvohEO/Kc
         upFeRTRBWtkJwSzTQQLsqeMmNEKVQIKofsk3cRghDqXhcv/w7+r+M/9Nrj6W2PcOMd0j
         dLluMOadQbCec3jhTwKuTMCLAOghe8PuXJF4cIic1ioy6Z3yGU4m+RnOjIaGsx4RNWXU
         Pftw==
X-Forwarded-Encrypted: i=1; AHgh+RrC/PL5Xn8t0Hl/GWueckwAaghIwnxE2fmzzIVJd2kJPvJNIlkTR/OJ9x/+aLnXIn9Zjy12AM5+qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZDHcMqhnw5rDno0XfEN7Xo9uqogK+o4WRUnKto2Uq7Lkv58jq
	FqZn8zPT9JTwaQahMcW9Sixxov33kgOhQNKT7aU6JW5+L1yNrdEoAmyeNAoBFXjiSyopf/+5DdT
	Ecu6i/UAYZnp+l6Smj4bJzUx+0NFkKmcVFajeL6TQoF10AwpDwLMETcu0RX8I
X-Gm-Gg: AR+sD13i2udwZKFMqh6wCX0kh8QIplhPfNyIj80QIHxjrlv9SCeUoWFCf/uXyRu4BKH
	0dTnfui0aRQMHlohmbmKuDWX913yXZEj7Ax1CTRknhO2Q4/7TYdckynKhnoMD5kKAinkJSb4su/
	ubAyryv4zi29fYk2TIhEPdphKtb5H7NmSDXbXLIffCZsfoMMLOofQNPPovgmtqwmwCDFRtPixR2
	W0EMdmCKHQNKLb9Tdj1VH9qajCXSGBmcai7mlxdjJGl83M4sd6c4YrG0XJdbm1GKQe1wVVcVv/Z
	PuYZAaWkMHRdLWH/vl2CuZGHjVa2JBQQe+PNvbVp7zD8Sv8ZxIT5/eIa0jZlcqpF3NCy3gqZ5tY
	R7/TdUPC+Sm94RzWAV0JkDq1wVkxI8Fo=
X-Received: by 2002:a05:6a00:2388:b0:84e:52d0:69cb with SMTP id d2e1a72fcca58-84ebc446e5emr2058294b3a.75.1785408388143;
        Thu, 30 Jul 2026 03:46:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:2388:b0:84e:52d0:69cb with SMTP id d2e1a72fcca58-84ebc446e5emr2058252b3a.75.1785408387575;
        Thu, 30 Jul 2026 03:46:27 -0700 (PDT)
Received: from [10.218.33.235] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03ca2c0sm2831254b3a.60.2026.07.30.03.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 03:46:27 -0700 (PDT)
Message-ID: <d62dfb6a-ea99-499f-b7f4-933dc257aad9@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 16:16:18 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Subject: Re: [PATCH v11 0/7] Introduction of PSCR Framework and Related
 Components
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org,
        =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        chrome-platform@lists.linux.dev, avaneesh.dwivedi@oss.qualcomm.com,
        umang.chheda@oss.qualcomm.com, faiyaz.mohammed@oss.qualcomm.com
References: <20250618120255.3141862-1-o.rempel@pengutronix.de>
 <3309e88e-e189-42ea-b74e-346aec1b4b5f@oss.qualcomm.com>
 <729b0e26-bdbc-42f9-8245-79b2942272c2@oss.qualcomm.com>
 <akJaAesz35Ml3iW4@pengutronix.de>
 <4b5321e8-05c8-4f3f-bc22-d3776e008151@oss.qualcomm.com>
 <akXnLLl_nq2G8EGI@pengutronix.de>
 <f1400208-0c47-4dc0-8b69-d3ca2b054bb4@oss.qualcomm.com>
 <e78ac252-1631-4f8c-a0e7-e48c66c20d9c@oss.qualcomm.com>
 <amZoTd1w6okw0Rw6@pengutronix.de>
Content-Language: en-US
In-Reply-To: <amZoTd1w6okw0Rw6@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: R6jmc5F-cI4j0ExfQLc8fdEpufqQUBCz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfX7GKHvPTK2j2x
 ETSAtwCtujtFhPOWq1xZ05V8AeE6MYYuuWeUjM9ZY8Id8lNPIheZLtbE/a/V0TX/rwF8Xlt4wGR
 EcjrVhljcUY5T16TsInFQUxhEjdsu50Xho3onpsGB7pxGrm2YLnXXAjMmmE5VgcGAJS4HcbeekH
 MOwCMpzqZ6LBsa1XEpTUG9U8/EkXiNMByV1kLIClzSvqMBOdyUBc89lhRAfp8xSOffr1q4PFVIU
 PtopsHwSWn28XIKU4Xy7xpKqNQmlIziZh7M0l7qPjpsbSAIFoOLARDxYKOPxm5d1NKly2yxInAA
 tzWrmU2EzLwdMqX0kiSRHiRydU2L6KCg32auHLAmlPVbTeZNLw0AOlQklmWx/LEJZIaXRPSifrr
 H+sHtv4p49D7/8V9zHO8wcehFQEc4k2wNA+9NnJoCMyNOqBPmtTor6PnEmhkicg/c5HMWEpXYBF
 w9XKZ2jR6SCdozNiTsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfXyG7Cjafe38S3
 qVms+yKYGqsWoTLwlo0qU/WigERqYfMseG+FKrGRUgkWLoB5QyZAPtUVaN9tAgNP7bwqZtmUdCt
 N/ugcY9ZpobllH/5goRI4RPRDASAWTY=
X-Proofpoint-GUID: R6jmc5F-cI4j0ExfQLc8fdEpufqQUBCz
X-Authority-Analysis: v=2.4 cv=K/QS2SWI c=1 sm=1 tr=0 ts=6a6b2b84 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=HbpdUXfEe2KejOgVjCkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300080


Hi Oleksij,

On 27-Jul-26 1:34 AM, Oleksij Rempel wrote:
> Hi Faruque,
> 
> On Fri, Jul 24, 2026 at 01:17:40PM +0530, Faruque Ansari wrote:
>> Hi Oleksij,
>>>>> On representating nvmem cell to the framework  - if not DT what
>>>>> is your plan
>>>>> to represent it ?
>>>>>
>>>>> How would framework discover the nvmem cell if its not DT based ?
>>>>
>>>> I'll need to re-spin it and send a new version.
>>>>
>>>> Are you on linux plumbers conference this year?
>>>>
>>>> Best Regards,
>>>> Oleksij
>>>
>>
>> Just checking in - Do you have a rough timeline for the re-spin and posting
>> the next revision?
> 
> Hier is updated version,
> 
> I did some framework refactoring to address some of comments. There are
> sysfs interface changes:
> 
> https://github.com/olerem/linux-2.6/commits/v7.2/topic/pscr/
> 
> My plan is to send first 6 patches without drivers (if acceptable to reduce
> review overhead). Can you please test the new interfaces and give me
> some feedback.

I have validated [1] shared by you on Qualcomm monaco-evk 
platform - and it works as expected.
When is your plan to submit this new version to the mailing list?

[1] https://github.com/olerem/linux-2.6/commits/v7.2/topic/pscr/

> 
> May be, if you have some time pressure for this functionality, you can
> take over the up streaming. Otherwise i'll continue..

Once you post V12 patch series, if you are occupied with other 
activities or have limited time to spend on this framework, I can 
help drive the patch series forward - addressing the comments on 
v12 and afterwards - with your Signed-off-by and Co-developed-by 
acknowledgments. If any blockers or challenges arise, We can 
co-work and collaborate to take this framework forward.

Thanks,
Faruque
