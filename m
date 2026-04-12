Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFBC223DFB
	for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2026 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775986541; cv=none; b=q83uXx+n+pQBESvqeZ2axBZ1smvYqr5dFLtzZLLEkdK/BLX4rVNWkB6oeY8JlpD1xpsVQTEBtBwgPaT5QMn2w3mLmEMcV+Unfi+F0K+Ldr50hlyapYc/YMwhLKq12JVEFAfESyi1/mSs4EIZTel6qzfZT97Hf17LVI9Ps0XBke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775986541; c=relaxed/simple;
	bh=5KcLbBnpUP526jc6HeKCPLsUm6VqSn6+Giqky6YBi2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNeZzL09gAH7c5Upsx4HfIIru0JT16C2TLKNgKkzKhW7XvUM81yVhbN6Z1R91pkKla8HXntLrbI8ep2ReZIZg0tywBBbwZWVzHRbhbFuBb61gaj8emAWwesRm7AGr5NOYYAB4jl7ByM4um6c1uT9khZRCxwrT8ZFOlIgJfWOMm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gHaRacsI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TIfiFSkX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gHaRacsI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TIfiFSkX"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63C4twjG2204933
	for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2026 09:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ntDR8NBqpIqaw9Ou8YQiyz9oJYsTv5hhvLULdDquyzs=; b=gHaRacsIHQ3rhQBO
	10CmLBKSZaS9YhpTdxeU5anrIQfP2dDbLH2GcpvxkZX9hu6rZyO71XFHtuu0NrxT
	kvHXNgKtvAugWtIrMedoZDS1dPzMkbsH2l2r8XZImLI/vcLYVGZ1FKcpFNbfo/p4
	nXqatTDvmi0e0EvDrGTYFECibheFChe7KLcrBd6ONdpa48ulBHy9K8NSJRHCzXSx
	dKQYNDeYpP3qPSuVQk251hlI0jGasdWGzqyHPkhsxkpwhctQCeNcsdNu7fs93apF
	lW0oHuW/ALgEg9JXQ/3I52LKAGCi0uvWQWq9Z/OpBQItx0Da38ph37eGtXRzQpuI
	FxbPiQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfewkt3wg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2026 09:35:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d890580e1so65318271cf.3
        for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2026 02:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775986537; x=1776591337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ntDR8NBqpIqaw9Ou8YQiyz9oJYsTv5hhvLULdDquyzs=;
        b=TIfiFSkXAK4+HAiSMOk1aWoiooiYqtWhY2QzE6sDg9gnwL3hjAtGxUVT7WtvgCUIak
         OFYTA1PTlc4jWpDsDL9wO2QGFPQFccIlFfGEPowSuftFPTuW7rv87mtXfNahZ/D4mxzW
         wp9DjWpKeLyC+/Nmqtmtl0SyOBVgI09wJny1NOjie1aZgxnKyvGlBDxAA7S8mFO8NSAi
         ckV2fZyNLb91YAlWitH9BSiM55PbPGdbwe2u1DWeFf+dukEe6x6en6mShlZE0H16gpoY
         F21i/VgJc0GZJS0nwyRao5iwPrjda964j1DpkMA31NmZmbvPKN2Y/gmc0B3dvGCB0PMq
         6Log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775986537; x=1776591337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntDR8NBqpIqaw9Ou8YQiyz9oJYsTv5hhvLULdDquyzs=;
        b=WwHKJWOao3r+3xfTGevFahnJIkI8g+ndzMq5dWzlsEqxIKdl2U8cWofDo2IkrS3S0k
         5HKQ5+qu5+7UQvnti/QO6PKMYPFV2xBHvilM7HZXqVkW+RW+aFuGSBpeXDW7d98RbzWI
         Mbo4iHWh8bR+3NsDKvwwaO+E/ua/KdkPafEIQJIpR3fBD2n93HhNWFnEeWqKcfR3wp2z
         IpfnoVbH0R3Y1NMvJw3zo/t5APS/b/FA8hC1y4QOJlXeWIO5ljNX5f2gA3YCDS00Rbci
         Pwct70tAc2/l0xvV/Bl+aYtl4cEWjGOdCJV4iRpC0GO/laAuVWpfyxwLL0P9HOMw+wC3
         Wjag==
X-Forwarded-Encrypted: i=1; AJvYcCU7DDVgrQn6uQ6ZITa4dh6uKiHwljPrnO7ypi1jxwVD5jrorLAHmvlM7PT8nbvWjjThzvWVCbD4ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YztGIhIxh4pZ4bjlY7nf1FlZ47ibAOoU4Cf4b5r19CjqCP0gq+V
	ZdGf6RETMUwal6XGbGtAAFjE6APnH/kSEAzvRDT8nDwuWrWxBbF2yBBYbeDbhyrDnXphHeugWHe
	zRM7RZ0yAHMNFfZc/XOqKyx9Ysr4lLHIPmTe9A5ZzuK/UCp7qCHOMjb26AARGMw==
X-Gm-Gg: AeBDievkkqxqYcbN4USzy4kTgLT0JATGTr5JH0imGIM+4/Vyw5b1A9jL6r2Ld9UAbKH
	MDpAOYiH+aPMnAMFzIujl0k+4dQWDH1L1hVit0Y0E6NzMHoW4xouhtR4jlzR8ysco1LWcpB/7vx
	hktQBUG06pC6EAtrOUBtjpo2xD1thSMfX/gsAthVTlXJng6JwROBPDkrWLMitX8W11FY6ECCJBR
	fNp1pcLKJfoLsp45oZ0N5erHcljluqQhLc5+ULkgwbQp/+9ms3FJpSOBiZVY7zPONa1kVHKAR5i
	w4PhO//VXMXzmnovWhe8Nn32kXrHcCehNJ5GJ2WPfV7tAzuBdOqccslOHzm8acu4ZIURKTzvB4W
	L7m5hgtE/y0ITW+PwZZN3x1b4xJUIXRuwGJ4EVUQi+tchWgthQBENKzp05/3v1YTytzyCYcuQpR
	ribZT/Dtfc
X-Received: by 2002:a05:622a:8a04:b0:50d:855a:8909 with SMTP id d75a77b69052e-50dd5b7cca7mr107850981cf.32.1775986537188;
        Sun, 12 Apr 2026 02:35:37 -0700 (PDT)
X-Received: by 2002:a05:622a:8a04:b0:50d:855a:8909 with SMTP id d75a77b69052e-50dd5b7cca7mr107850761cf.32.1775986536700;
        Sun, 12 Apr 2026 02:35:36 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ccc9:82ca:cc1b:b64c? ([2a05:6e02:1041:c10:ccc9:82ca:cc1b:b64c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5df2062sm69408705e9.12.2026.04.12.02.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 02:35:36 -0700 (PDT)
Message-ID: <e13badf0-def6-4fa0-8009-f9fecf6a5c88@oss.qualcomm.com>
Date: Sun, 12 Apr 2026 11:35:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal/drivers/imx: Fix thermal zone leak on probe
 error path
To: Frank Li <Frank.li@nxp.com>, Felix Gu <ustc.gu@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Oleksij Rempel
 <o.rempel@pengutronix.de>, linux-pm@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260412-imx-v1-0-cc3b45d63811@gmail.com>
 <20260412-imx-v1-1-cc3b45d63811@gmail.com>
 <adruT5fgNSZ_VOLr@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <adruT5fgNSZ_VOLr@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bcFbluPB c=1 sm=1 tr=0 ts=69db6769 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EhLqWX2mNhMJiQ7EdO4A:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDA5MSBTYWx0ZWRfX7+3j4wtj3lqD
 n+cbFtjFsHbOzaMIZcxOLklHGYy7NtbagqWKCv5lLE1vGUDzTZpZcSO8aD/u1Qznqu5VfCfyJS/
 6/4zBCG6Ngxgr7H50IxqwXeibldpD6PkyhT3sBZwCaA6rAaDtlUuUuRwClePKwmLqMJ1F/pzWT3
 eW+9wPBIlaPLrdnhLv6Nlk5OgBchsizKhkrGFris70ZfusSrua2tv4LgX4eXoPg/vqkZ9awW4I3
 vRXhtgsk/8bDysFlfbkMSJYwg298DmTR3cz1Or7AKosu9DSwT/o3Q1AkCybImpE8ub7ml+76Au0
 2GxKAbBhSgjUv7dXP8sEpZYw+RzmSqN9/dJoFu5QDW1/9BhM9lXv+zU28SZV5vwyiOZg0+laq9I
 SqHxOnjSZANIClYya/ZiCW8uSAdpCagiGafjhmaLWwptwXyX0bJExujxZ7Hym6UC4b/vsurlXwQ
 7h0ujjqqpjonF2NOAFw==
X-Proofpoint-ORIG-GUID: PBFuHbanFz-D-SewLUZdL6ra_HyPXiaB
X-Proofpoint-GUID: PBFuHbanFz-D-SewLUZdL6ra_HyPXiaB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-12_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604120091

On 4/12/26 02:58, Frank Li wrote:
> On Sun, Apr 12, 2026 at 03:03:03AM +0800, Felix Gu wrote:
>> If pm_runtime_resume_and_get() fails after the thermal zone has been
>> registered, the probe error path cleans up runtime PM but skips
>> thermal_zone_device_unregister(), leaking the thermal zone device.
>>
>> Move thermal_zone_device_unregister() into disable_runtime_pm so all
> 
> Use devm_thermal_of_zone_register() to fix this problem

+1
