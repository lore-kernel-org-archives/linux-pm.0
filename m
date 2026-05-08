Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555A6377EAC
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263832; cv=none; b=PbuIbumi6wHAbTKGjeFZRqwdHjHTNTbR1Eaj8DvYUnfEJ3RAQLdveFLlnkECuBFTQFwRUUGPShxXW0h0+pVJXRfOrebPcYH25/7JEVUXJPZLTF0wEEowZWF6jr3fjDoCqf/E35JA2bJwp8E1ZWVKqgR4+N7jw/W0mn7A+PN2LSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263832; c=relaxed/simple;
	bh=rDOq0L6/M5sP8BXonAMiVzQUSqGp8PFm06N9pip70kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjrGKqV4+KvfarnqjIbqb5xrdtvRv/Xm8b/a+Rghiu2hRgCAG0VOUcDMCD65Km+cvOMkNZh41Hxj3QgdSkkKIExxazNzdGD280P1OiEl5c/b5dzfTruvZ5Uqw9nEJ6lqYQ9Ptva86/A5KgH/ZMKHf1xT8DPOBVS8c5B+q1tdmSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BMUxxJ1J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g36lBb90; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BMUxxJ1J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g36lBb90"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648HU2tM2515295
	for <linux-pm@vger.kernel.org>; Fri, 8 May 2026 18:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FKDB7NkSZ+mEr+2vdzq3XP98X54E/DRWyAMpZqMFsXw=; b=BMUxxJ1JhY9EGzQx
	CgSBzzgbY5dgQ6qNdSMecHT1hgVdIMS332pgZP2018Js1sW6Kysf8rI/rnWCeySP
	faLfT4Pt27zDdmAL97nETKhVKLSLzx5DqJFxUZWTnHk/wzuia35kIxCXlM5HJYpV
	llRII8D1ItjsgVe8JYw7fbt/zc4T8/fSjAgh+GhPShxPVyjPbCYY7xQkfr1j84ia
	5+tL+jS6PiItIh/hf5U2iexxLAu42YZkK5mUWnI++QExx5YboIME0oTsZObB84T5
	PZv7YypPTW9EEtoO1MYMOzahXWzmQViw9yzJkm49jUDnjlgoIjAsay+7B4FuZZUE
	z884Fw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1m9nr506-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 18:10:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5102a9671c8so52827171cf.1
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 11:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778263827; x=1778868627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKDB7NkSZ+mEr+2vdzq3XP98X54E/DRWyAMpZqMFsXw=;
        b=g36lBb904IXaPXgKSVkQdmmlvlbUXukkKnXtArvv+iMCTT3+ev9cTYDJ9boTslVcaE
         ORc7mi8aHd8iZfBtlFDOWch8vK0GRH45CySSyYSJrwuoHq+INJo8cnUgLmMfjld6hTxx
         rSU+ZAgWr1kF9vZ65AAUVmbdJrVeGRldr+O3hneybkOwfy6mc+vFZUg/gqGj7SReoIRf
         UrV6L4t48/SqahXs18uPyuYPVb/kWvPt5FsU3/74ddaks7r5w7EPOO2NEZVqnA5uBPTO
         jiJh4TSuglrYKNNQ9U3Nuhj5u+PqlHjZVvYE9SLxGXQCS0EVqtPxXV0J/NfG3ZNGwDQY
         JNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778263827; x=1778868627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FKDB7NkSZ+mEr+2vdzq3XP98X54E/DRWyAMpZqMFsXw=;
        b=hrcAD3wbU8Fqk6KQPI2hGb71KIq8AcrV9qPqQTYs2toaOQB/fScYwFCN2WoDJEW3Pd
         iMgNDyP27ct09ox+4EnViJNUeCwAbPUjpUEi4kcEX2ooscHtTSFny81vhrQeSkF2hV5A
         BfTyaA5Vq05Jy/0SGvE0zR0Ai511s+q5zfRoe7fZLRGEojSF2ComIp5mvmv7pypuycA/
         YvrmJI8DWPIk8UfjfvwX+mSzqg+yawd4f4oxzZHTWOPXMg8ChUFFvbAXGLJqHm0Kkc8l
         NQtdsIz5AJ0fCfJoKQ+vGN0ZdmQSwq729qqYpa0D09aPiz1FwzWDv/wlc+B6gikdN653
         hnaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/C2WZ8s5buBzI47pDi784s1KTpw2sjz+PM+LPP1mWHc+14/kGxJ1udU13b0Ut+rsl8sJ2neTQTWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7tzQa3KPoOFJ1EbyXf8Uz0rsNgIHQm8BwMI7iuhNaw3ZReQqz
	9kTfwZkM5r30zzat+kmQr2uHTJidWf8rle8sHy3HWxbcifcezfZTVsaf1FIg8vIOPrJ1ckgcUGA
	OEOM19rWThAAxZp3cBbsGk+MD1l/ZP/vclHSbnyhogLzXHrH868ay5KLhc7rkEA==
X-Gm-Gg: AeBDieuXd9zyG1buoE1Kia5GhYuqUY27oEU0JfXSVeSofs98Dtrn+BBarDc2iC3iGxM
	wz3NVY6n2LaqMmJK/id1sElGCg2RtMWQNU7lYli5t0H2k08r01BOmLUAvFOdglSkpGGIR7z2CF+
	pGE6aNrYZ49yxp1ojAtM2fgJcvkyCy6q+1qJrPdi3MO1HdxXzsgeSvm8HYh/xr3scpGtxHalbrp
	5XnADvFNuL5PkZ+Pl+T9R2DRVAJMEqjUA/l8iqG5oXsVPn8bBsvul/CEl4qkNfKhm4/Xc7fxMQR
	+NjUNS05oMXhrDJkSV38EhhFFyKOSrht6DYbtjJ5kpHocY1hY59w2ZfosBwbW0iztIsbP9FhSQd
	Qqot3SJpVKdxdx0KTMF1bwBaVdAlj6IXwIE08LpFZzvlCrNFxhoedZVxSMS7iKB1To2bMgOGGP8
	iK3yesFG+G
X-Received: by 2002:a05:622a:5c7:b0:50f:b790:96ae with SMTP id d75a77b69052e-5148e871055mr49993291cf.22.1778263827235;
        Fri, 08 May 2026 11:10:27 -0700 (PDT)
X-Received: by 2002:a05:622a:5c7:b0:50f:b790:96ae with SMTP id d75a77b69052e-5148e871055mr49992651cf.22.1778263826673;
        Fri, 08 May 2026 11:10:26 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:cda6:5a1c:b564:d3ee? ([2a05:6e02:1041:c10:cda6:5a1c:b564:d3ee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db09943sm4881635e9.19.2026.05.08.11.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 11:10:25 -0700 (PDT)
Message-ID: <ce06dddf-3f47-4492-ab30-d3fde92e3b2a@oss.qualcomm.com>
Date: Fri, 8 May 2026 20:10:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] thermal/core: Decouple release paths for tz and cdev
To: lukasz.luba@arm.com, rafael@kernel.org
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260508180511.1306659-1-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260508180511.1306659-1-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DaEnbPtW c=1 sm=1 tr=0 ts=69fe2714 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=lUpQ5I083-l-Vf84Yc8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 3sUm-_uQB0bGSaSInpqxpe3J4jRN_9C0
X-Proofpoint-ORIG-GUID: 3sUm-_uQB0bGSaSInpqxpe3J4jRN_9C0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE4MSBTYWx0ZWRfX2PrLiHqRipKw
 cD26F7pqb+L9B2tAAdf0v0q5cxFurxTqg9Oug+/otF/GzSJVhtwpfisKlJz6Wbuv4WHDivwEZJ7
 GoH1AOTRG4Tojev43nZCkxbmVlGGcz23bMrYoLrwPAQX+1aLBfP/X/a520vvT2tNahiE9ojtDi3
 Nlrb/kYJgpb6i4wT/YSesl0RI05Si5YPSii0npqGxU9innWyei2rNhzWRLvmS8OI2Jf5VL2fpoy
 YJlTQBc79Gxd1x081z5snp08g6BriPBWrMITZSbPeuETADawauApGwPB02eOKc5KP3xujCqCAPL
 DbenLkjiaENgYs9ydhqQYl1WUCpuu796Ow4++Icdou78Zs7X5UmNLCZnuYF1TUmL6UGAiMjrJbE
 ELDAMAFdw5KFGX7pBUvnt/+e/2eTPD2ZurlgKa6NN8qKroycrEjy2czsEaiAUIk4pBz4VvcaafG
 8+IVSmowar5QxAYQPRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080181

On 5/8/26 20:05, Daniel Lezcano wrote:
> This series cleans up the lifetime handling of thermal devices.
> 
> Currently, the thermal class release callback handles both thermal
> zones and cooling devices by checking the device name prefix. This
> approach is fragile and mixes responsibilities across different object
> types.
> 
> The first two patches introduce dedicated struct device release
> callbacks for thermal zones and cooling devices. This removes the need
> to rely on device names and keeps the lifetime management local to
> each object.
> 
> The last two patches convert the thermal class to a dynamically
> allocated object and simplify the initialization logic by using the
> class pointer itself as a guard instead of a separate boolean flag.
> 
> Overall, this results in a clearer separation of responsibilities and
> more robust lifetime management aligned with the device model.
> 
> No functional change intended.
Unless I’m mistaken, the patch sent to split the cooling device 
registration is correct with this cleanup.
