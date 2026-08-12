Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BB43321A7
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549688; cv=none; b=fAhZHIi0GS0j2yWu0ZmRIHBmXUR19cE9TRib/jDaiJT9B3gnAUZQyyaIzX99d5mcV20n1yGq2gKSya1jYSwDqoGzzhYmPP5qAyxhdA3OmW6wwbHVsTapSoGynuhpCcsuTtuMzngfkDM0/KqhYyboPAH3P9zoktkX6h4S76N/t44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549688; c=relaxed/simple;
	bh=zI3TNPPe6L8M7xlS1nDQbUrr8AfIzmyJ+pWobJL8pkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJbzCGcAbMfxWSBreOirsm0Cm9Q2v/i4Yo/wbOfrhEU7BGCNDbPQzgnKMishY4aCx7x/9/bVFTiPGaFlQxd35fIItVo6M3WqyPWOziPBSer/Mm5bBIZ+xYMvnWtUulP44/I+bUQ0yTYwag+CzCLfviDBzKJbWk2fSP2CgK9fFRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VAbBZY4E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VuZt0ZQt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VAbBZY4E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VuZt0ZQt"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CDbbbr3995473
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 15:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6eI30N4Qm5PW71y0No3cx03eQ8pMDtF1rEz5kRS8Gxc=; b=VAbBZY4E/j0w6E0j
	hjKUn8qJcZscS7lWuAx9OCuhh/GqXF3hXB6ImbrsomP5Nu3TIHqTYoHkhLarllxg
	PuaeZta3NKvvYqxqq9SpvjhfjQoD0+Nu7OwnwXimUeoJFpg3acv+y6ux5e2pbmJD
	4OdkazOg0ekTcpYgepq5O/82gqpGt2kgwKiQupJLvOl3CSR9IlG6aY+nJEKjGgaL
	KCJSb/kE2Ibi8B5YqkCYpRnWwA3RJBjCBWpz/eSed6mTCq8IL9nsqVafACcfs7nx
	S8mdXMD+tmXbRSkTIGu5YyjZeFZj5qmFEHg/E8KSNBdMUriNyiIWJWPlmVgsmdd8
	ATkLIA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0m6rj4v6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 15:48:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce8a76df2dso18392135ad.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 08:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786549685; x=1787154485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6eI30N4Qm5PW71y0No3cx03eQ8pMDtF1rEz5kRS8Gxc=;
        b=VuZt0ZQtC86h5OE7CmuwN/oO8Hb0/jUaS9Xb+zu3ALM0vehl3cD4g7/UJ/uwJniGzQ
         Dny0ETvnn/T/nZbvNxduNYpzP68qrUDOQFceD/+k/sF0HjpHMQAO/ZFXlAilCWyRHDQT
         8Q+VLGzpggXV+zL8/QU3Wg72v/uIgTLEeg6cVGI4zt1mhgVaPas+NinQ9JC9+GuyeiSQ
         0h17pEy0+UK0O3kOQITCNMwwNIDhuVMUSgg26ViheOPksk3nyNMpYn2wNLwpbI0C2r3L
         LTZPzhEPQJEGJHsvuOw0EKmqeAZMQ1ob2KzLWXIjK/8nawKns5DdYx2dC+YmiOo909BK
         PNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786549685; x=1787154485;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6eI30N4Qm5PW71y0No3cx03eQ8pMDtF1rEz5kRS8Gxc=;
        b=DtiAYpJDckPYsDPBEmMfCdSp9KPUv64hKfL5xsIT8BrMAPcNhof+OEXM334ueSLeXT
         tu7fhgGeHujKWEi+10uiCNaQ98ruMZ35IdX4zBOPCO5zB4wXXCwbI6IEixsqF/AQbxl2
         Tl+JXT8cjT73ljaozwovJLYMtdfkJ9//vrqefgWYj2Annug7T0Ai2jIjZNEBYzYWkZnY
         i6FLs2m9hXyyyzMxnxWCcZ6RgCrdYnizhNOhPKh8+wTFJhyW1FWOHm8FYvzjz07NVLor
         5iupcsEgy105+vbL2iE7yWtstEB6vaNx8iUyMMWCdZ7hyqiy0+tKbLwUH9+Eegh6jKZv
         0SMg==
X-Forwarded-Encrypted: i=1; AHgh+RpCGR+lS/cAsHQmYW89/j2k8APwh8FQJoBSYJA3SVc8fCUzdctHjUh3biAd0j6YCdrRpIcOE7ygCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDAeoCm2adjNWq4pp4w8OaBVUm+IkG4iFXjuzlvh8Ut539erVX
	Dh6ka6nL+GElZyKX0SPEFe3QeKwh1k7JFoeTLYAg2HyY3xp2NE3rHrd7uOYrKf+ZOENde6JFGBg
	kSKLx26PiH+8ANwXAcIw+kclBDTn0P/bvCBkR6jaYRL0UilcaW0hr1TZTqugMWA==
X-Gm-Gg: AR+sD10BBmxC3DQGwONA/WcFurtlTFSkNIgeaPf4Vrv2DSpL1Qh/5URx6nOpBQrOfvE
	rhfb0WPvHNYwCQwbzmMBHexJSvkZUxYdrNb6/1rFDXilQmsWabY3ZyXvouSyLaMljkGQhkAPcgP
	m0XxxDlBNAzJ401IahU6iWs+zU/xotuMVUjqB+IjLbrSgh763iz7AB8oVGgD/kOUe2BHAI9V/Tt
	Pg+3SchL/qB5mMxAlcLCD0v9KhqHoozL+jgGAp+FI2ZaGssVK86h52kEYIILCXN8hfwEPPDvOLG
	EKAIxRLwcLi+SkbSZe5e4acF2Z0qj1u3InKhdETgd9iaMu+W/16UKHh0FEnwe602rPPkTvnGE+T
	FkurOa/vMqey4culQblcSFXkbY+tp
X-Received: by 2002:a17:902:fc4d:b0:2c0:db23:4c4 with SMTP id d9443c01a7336-2d34567e628mr70678245ad.16.1786549685450;
        Wed, 12 Aug 2026 08:48:05 -0700 (PDT)
X-Received: by 2002:a17:902:fc4d:b0:2c0:db23:4c4 with SMTP id d9443c01a7336-2d34567e628mr70677715ad.16.1786549684965;
        Wed, 12 Aug 2026 08:48:04 -0700 (PDT)
Received: from [192.168.29.179] ([49.43.225.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf6d7a3c7sm18740573eec.29.2026.08.12.08.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 08:48:04 -0700 (PDT)
Message-ID: <71b867fb-f7fc-4d82-a02b-3d0e7874a6e3@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 21:17:56 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: qcm2290: Hook up MPM
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20231215-topic-mpm_dt-v1-0-c6636fc75ce3@linaro.org>
 <CGME20260709114143eucas1p18463122323bdeae8e63b1d13cd626b55@eucas1p1.samsung.com>
 <20231215-topic-mpm_dt-v1-3-c6636fc75ce3@linaro.org>
 <dadff7a9-bf04-49fb-8c55-5605e99be7fc@samsung.com>
 <CAPx+jO9d1qH12mxg-n1rkbp6Xd__sdrSMeoc7CPELE+jgxRYHA@mail.gmail.com>
 <e83dffd9-e54f-45a8-b997-e84b5beead71@oss.qualcomm.com>
 <b434e198-2778-4dd6-8896-f7f54bc9b8e2@samsung.com>
 <ff6f8e27-5489-4d63-afeb-a38881d717d0@oss.qualcomm.com>
 <869727ae-e4b9-419a-98e2-798c1aec5223@samsung.com>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
In-Reply-To: <869727ae-e4b9-419a-98e2-798c1aec5223@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfXzmy5igFBdOKk
 65yj21nzc3w09Zw3NuiQ5cZ/Z7sCJUrLwufbLXKekSJ/1JNZjK0I6pjGEM7vN9EXVwRbLNm1/dX
 RN3cJzL9PMshEn8g1B6HV65Y3Dk+C2HQInoGQ62Zzr/ZV6ZqUmL3293vfYk8aYWv111XGozP1jo
 LBmMiQJj3nf2qys6sgdWcnWccfPkP3cnNSEI7o0V7AHt31xzu0K6LK7WuhrdiJ1CJLSsmvbpZO4
 Emo7zRY9SnPTt5ClIkLL7Vob9N7VjDx+OWP+9fqQR7bI0i0eX8Pbv8VWFN8aea2iyCZrDCpTCTc
 3X9hXfYkvITmFX0QEgg3+++Yh3j/OGCV7uOHlcy4DC56pGV/QeeDDmyEqPKlAw8LGgUGLnlzYcC
 gT3oT/HmhF6G77eBFcj4TQGCs2VVgIrIf9xOYbm72YZ3ScscVPaNPfpl0EnxPNkWwRNSilqS79W
 IOTxTMvkTFYBtY9N2Vw==
X-Authority-Analysis: v=2.4 cv=Wb08rUhX c=1 sm=1 tr=0 ts=6a7c95b6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ltT/yu60HBk4Fd3MSdKqqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=eRr2Iam4zZPITqxNHqkA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: YdAM_qcENU79KCfQ2LPn1DqZ87-F-aSG
X-Proofpoint-ORIG-GUID: YdAM_qcENU79KCfQ2LPn1DqZ87-F-aSG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX01ADNd3F9COe
 /P3woXTkVWlZ3QJAvhlJ96asZph4Dwh11zrPJTpiyfIT2uJ0niRf0imOIOocD7kDToO0TRphGlh
 O8Ma+UyX3X98VkItqFUsHYfQSlXJPWQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120128



On 7/16/2026 2:06 PM, Marek Szyprowski wrote:
> On 15.07.2026 14:37, Maulik Shah (mkshah) wrote:
>> On 7/15/2026 11:44 AM, Marek Szyprowski wrote:
>>> On 14.07.2026 15:29, Maulik Shah (mkshah) wrote:

[...]

>>
>> Agatti device tree change in the series [2] only removed power-domain-cells# but did not add power-domains = <&cluster_pd>;
>> with the reason that qrb2210-rb1.dts had deleted "cluster_pd" however qrb2210-arduino-imola.dts still have it.
>>
>> so below change on top of [1] series would avoid the BUG from mpm_cpu_pm_callback().
> 
> This change moves the 'invalid wait context' warning from boot time to system suspend/resume path (although the system suspend/resume is and was broken on UnoQ at least with current next with and without the patchset from this thread):

I am working on this to fix this warning for system suspend/resume path as well as regular cpu/cluster idle path, will update soon.

Thanks,
Maulik


