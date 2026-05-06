Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00623DA5BC
	for <linux-pm@vger.kernel.org>; Wed,  6 May 2026 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060281; cv=none; b=iRMzOY6Zm+dEtS8skbAaAGrZypIltVufPFvhfOaw9xdJcA7yD9JBlzyxPhRgdu0cqAV974x+dIxEy2KZZQflYB2ZdNxWBscKLpVHd8GTDPoSTA6BZ3AKPmtZUREenTzJSFSp89LjhIsNOm//NNN9Ph0ZGfSzAbkYf6Sh1M259FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060281; c=relaxed/simple;
	bh=qr0ZiLB9ps2AVAiHqe6DE5oXw1vLc5bxId3xZMuHxWQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=H2CYD8lCu5ppfhlhyuTJxNvohtl22U8oU2aWpXAyhh4TnAVAo3B4CSp66xPfnGKbEkdqlZoiHbthkFx0t/ZBgqvWSr/5WvtLDoKAbg38RmEZLUuOTLvTiKQQZ6M4rHcuVK74wN1BfnEgFNLcc4ZXv8v/G+fk+aa/sQwY1mwJ7g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aCGHThI8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LvDJqWuV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aCGHThI8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LvDJqWuV"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6465cffx3501529
	for <linux-pm@vger.kernel.org>; Wed, 6 May 2026 09:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7s+0qxdlCAN7+C0UZ4qVMPuFKE1Jpl403dvIhapVC3o=; b=aCGHThI8+xqnNP47
	1V5hQbi2vxrSnRHadLez/6ke9qHEC+15f0ZL3nvu6rGaLMM1w8FO2lJsXARR9J/N
	J07NrjEedeTtwb6QWNLpRtTJRGi14GiAPFI7gs4oRf5V+ZFTxOseb1wkvHB9aqMT
	nHgf6Ey3UaFOOcBkrgEc/DzEYBYaDqZ4UV+myKREUzDWaSTPwwwk+J5udSh+XCA+
	Klksst+wugFxivHwO21f9FaPVSSc++PqDYWKpjbC0jxeRKD12EsbO4C/bm08yQ6p
	jWX1X21bR3kqUb3HTBvhU3KHUobaT1OjeYkJ3knps1587ggzoBnHbnsbPksJjZYW
	Bg9IAw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyhqfc70s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 09:37:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d890580e1so108595741cf.3
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 02:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778060279; x=1778665079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7s+0qxdlCAN7+C0UZ4qVMPuFKE1Jpl403dvIhapVC3o=;
        b=LvDJqWuVNRaMWTBA1dQQmd74DsC0QdWz4ua7bkoWC7SLrLIO5LwIYy2PjxLZStqLJZ
         T62BHVVvvfQe6EeSoHFu9/2nafJIN0d8BVeUtqE/0/5Y/ab+qEq78Y9dHaNfgb6lme9f
         dMf85PhgSHGypli8NrEpnC+7N+JVZi7NVvX4q8ymnGl6b4qI34VcVtyfSppClvc9REah
         67fDnFl/S6/ELrscjjgFPQeB6B40wvN44k17/Ii09qY1cpxqnjY7feZ7RFSJLrG8AbIo
         IL4aawLgVHHGNuUABSKdr/XDQ1eDUgiu+ORMkVmwcuOCXeIIoQlx1GhW1YLx/VysoJM4
         j2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778060279; x=1778665079;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7s+0qxdlCAN7+C0UZ4qVMPuFKE1Jpl403dvIhapVC3o=;
        b=AkEKgExOOvbAphaeFR+YfrmcMaRw+Q96Q63ehTfLKWOr0I4eSXLYFrl4+/Ie3H69H3
         CmubI8TV4tqYNHn0s3wgirnL+LwcFwZf4Zwynhln4dKLt19nSKrU6JIG5LRGcAA/VDhk
         pYcwNcWO+9u2X8qNZuHXlk1nzNg/M8WuNKS/bk3e1bKJcwi5gxTRIuCKItVynHJ8eC3q
         MoKOu6fNVJroDw+Vu7VYlgMJAsLrJQlx2vy8L44LQE/k91bwhTYxGwGR9hXRvyl30R9Z
         N2VwdzhKnxiLyuvPueSLF+6jNYI/V8Vg9Z9AFG6peYk6OL8C53Uaq9IHS3jsAx90mQSE
         y33w==
X-Forwarded-Encrypted: i=1; AFNElJ+idE9u9WzlJGzwIE9Vra7aKbraZLSq+gA2LCSOFB6bkgmObhtjb/m7ovlAHYbVQdzOE3SnPSQPEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YymBsTU3yqJxUdkk5S9FgQ2HhLIrEYOI6/M6Dm4E2JXGpmf2YnX
	+6L3l3ojEP3wmU9EKICQFVJreUUEHQVegIIY0x9U8pAcVp2tRoe2pESci4TlYuPJcdBeRSfosc/
	o+5I7aI+S4WSS2OGhfms4D5LxcTAwtqG/8CTwS0YtTD5lUBZ8zLjNVxgdiHIF2w==
X-Gm-Gg: AeBDieujOxOZ60jKSSj5ge0M2px9p70i5qXtLhApoNkwnhdh5FEsQvrBoiedpcZmZQE
	ucgkCB33VKQn1h9zool6Ycm3+xZ9TIRsOPNuwOJUvyV3s1ufvj/76yzerUPDTZKSAA8tGdNaewm
	QJV255fMgCU6VCt0JzSYNvdPA9YEK/PHxxmtDK6pv+8hFcYLgNLQrtsF0hiDrBzSTo5Y4ZRAKqP
	XbobTo0ytSQLKYGOjiK3/g0aExarsLd62wEgHKdH7NG56oDEo1pzi+Jsg9nkqzYZ2Ysi3wOZKKF
	3ZxsGrNut1toCTlk54Aq9GPSmmX0K3awwyZN7DyXMAHptwLSSpLKIEir3H70CuO+KIt0H1ZuI3M
	uOGxEYZjHbdN7gTKznIjhJq7xw1XPHABxlZXRE1/U16/Ldu+MoklTA8ghKf16ms3Xl71NTmqmGN
	UkHjcfV8z8z+kRRHDLyL8=
X-Received: by 2002:a05:622a:6096:b0:50b:4337:179a with SMTP id d75a77b69052e-51461bdb369mr34218791cf.3.1778060279165;
        Wed, 06 May 2026 02:37:59 -0700 (PDT)
X-Received: by 2002:a05:622a:6096:b0:50b:4337:179a with SMTP id d75a77b69052e-51461bdb369mr34218481cf.3.1778060278755;
        Wed, 06 May 2026 02:37:58 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:41ef:7b80:b3e8:2c1a? ([2a05:6e02:1041:c10:41ef:7b80:b3e8:2c1a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a547bsm38519455e9.5.2026.05.06.02.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 02:37:58 -0700 (PDT)
Message-ID: <d60b7b44-37e4-47ae-9af4-0c8d24b6c599@oss.qualcomm.com>
Date: Wed, 6 May 2026 11:37:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers/thermal/tegra/soctherm: Use
 devm_add_action_or_reset() for clock disable
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20260424160019.41710-1-daniel.lezcano@oss.qualcomm.com>
 <3075fe5c-e8c3-4439-be5c-0f6eb2fb6e48@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3075fe5c-e8c3-4439-be5c-0f6eb2fb6e48@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA5MyBTYWx0ZWRfX7OzEnSFbBw0e
 iiUF4xc8MyLbsqu6l/X10ksJt3lmYWKXhA3VBV3i/FDCl4gHA8CiPAr8Sa9934mOh2IYdHa0Nfw
 Xtx59/36k1MyE4A23NMlr2ADXz6PXKU3bu3O33o4rviHerjncY4A3JkJFwzUBh86MSve4/OrblJ
 wjrCzE1x0RowNK2AE2Sk8zNTGq0Wd17Y3fq7c+DEwu26D4uB66spGTlxH7fvjbrpGgxV7EZ8R3X
 Z3TS56CiDrVIaLsgGHwwbzFdv2qCbSt8UaAD9i7CbBCU9aFyetBRlbFp+z8S3Xbb1sVjtUxsnHt
 YJqOdwxibFniQRsOyVruCIebOmKNXXBnrYfzimqc/FUuNSMHZsXXDtCayS6g/Q5SU21JsO10HaE
 VXNhd/FYjNk8wuNnotENKpfMCAKVr8s/niNwtRNQFBYVzhCUim5k0tVogE3l38lgUwpaYKy6SEY
 DBtv4rvPlWWpCYIJs/A==
X-Proofpoint-ORIG-GUID: _kfAfY-olri-YCwBpuMA242TdFEumBKJ
X-Proofpoint-GUID: _kfAfY-olri-YCwBpuMA242TdFEumBKJ
X-Authority-Analysis: v=2.4 cv=NPvlPU6g c=1 sm=1 tr=0 ts=69fb0bf7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=dtrGPWWTKDy4za8dmv8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060093

On 5/5/26 14:10, Daniel Lezcano wrote:
> On 4/24/26 18:00, Daniel Lezcano wrote:
>> Replace the manual error handling paths disabling the clocks with
>> devm_add_action_or_reset(). This ensures the clocks are properly
>> disabled on probe failure and driver removal, while simplifying the
>> code by removing the explicit error paths.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>> ---
> 
> If nobody is against these two changes, I'll apply them
> 
> Thanks
> 
>    -- Daniel
> 

Applied, thanks
