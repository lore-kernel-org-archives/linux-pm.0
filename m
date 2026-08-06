Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2A33A5438
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786042996; cv=none; b=jmnKzcIVY/izTqB6765Qp7xT4jQUrl/IkenlUNNPKmYaIMbJnH1ImMid0/iUnU3I0puKzmC61wVMBzwPE7yMaXHPC9f8rFLciBP7HqnD1775j7F39DU/ZQ4FFjq2Hr4ulWTGGcTjeohaHXLo851hMv2Zm6J8+Ra3UnpSFdGDXy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786042996; c=relaxed/simple;
	bh=xB8N6cUDJDuyXxiLPqDkOEBEypAeNb//J3zNTvLIe3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMjNT6Vlbqz2T6BaK0OtknrDWaSJexuLvyCS5j7zavcAgHITRsmh3YsBcd9FuGDbwQmhSu7jpwVoLy1l1ah0Y4OOft99Ljzf0PO8Mc8iinTg/ieq2l3iPKhOvoZ7KammSdgzjmxzOFby7e3bpzxThK39H3Kwk7aXifCwffBQRkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y3zxAs9v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DIFL7N9M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y3zxAs9v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DIFL7N9M"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IHdJt3051102
	for <linux-pm@vger.kernel.org>; Thu, 6 Aug 2026 19:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IQkVjA9pmubbxZYV7B9I/KJHuyXRTQBwNfT5h9lHEBI=; b=Y3zxAs9vLnWKtiP5
	sZDxc94coZH9/v6VsPJmHViUv9PdcFAyMBVsCttQKUnyP9IzSmpFr2NPG6s79vul
	fr31d2hZjFof3B838lt1jcaEXiDgBvT+6oeE6eoC+v5h1+5MEGlF9dJ3mdMdc4cW
	3AWAGkuaz1ZCmWpjqfUC4jN/ZGrjuLE/PAs0Y9VolSdVn1o2FnxldO1oHKVoRF9q
	ExVzZxrTODBNPPDs9i3/GL5yo8K43VRtaU1Pw73Wkoam7AEs0ZDf1Ai1J5IyA+kz
	0BfKmB7C/pKfYMUSWtANtSsMVfddGdrzCA8QlCREHZbjo/X8jYfOvqlT8WIuqUEE
	MFM2QA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6grabp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 19:03:14 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c860544c077so5218466a12.3
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 12:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786042993; x=1786647793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IQkVjA9pmubbxZYV7B9I/KJHuyXRTQBwNfT5h9lHEBI=;
        b=DIFL7N9M9L4DqXAo3jvxo/1EoKCZJge3bviT7ldzwz4vsuoajdwc4lmo4E3TRlHayf
         4r7OeWP8uNZPGj/8o+hNGQqRHJpXPLIwr/hWP6mt/4KSukPnTdK6eNmE7tk9bwyaLNi9
         skklVyl0m25JxEt0grQEVNC1uteQH9w7YDstpU7+oBOmxRh9sfVLtbj5RZM0H5znMfIF
         NUvt2d74H5jazGrmMnojpS69B8Dm2LDLXV/K1FoKPY+3twLLPD+lwEsgxVZZ6WUgJuA9
         9IdHbolzjIeMKX67PrUJ9cADGFb9lT2LGONOfcBm639gkOzBb4piJG2YdbIcqUiI/oo2
         A5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786042993; x=1786647793;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IQkVjA9pmubbxZYV7B9I/KJHuyXRTQBwNfT5h9lHEBI=;
        b=et+eOd8qG2FzwALZaJBUJO9Usj+kbZgtHTlx6EpJpKKSr2FjPjsC1p4KdJ2rQZREdE
         mVIXzOLkMb59IN2/7GrUgayutwLm4/7dEqfOc1yIJytKicoqmpIUwMF6kFDxHCJup4w9
         EBgrjQLzFHn3r3UN0iXiM2TUYADkvOb41fDdtuN+PclOePDdChJSlAkk4FYp/4q9JGs9
         ahXR3PR9lFR+Qmra0p1YXMH1+3o9SWAxA+UDy3YjCH1t4GxbVggqWi/riCDcl3sjU9+D
         9PwxYWFvcFc0pqe0EALghbGbwp/uKfPEytFkSGGBarG4rhtbeJJHUgqhjs34WH7V8ASA
         4ZWw==
X-Forwarded-Encrypted: i=1; AHgh+RoqSRQfuUWUuvcY9B1s2WKMYt40V0NklSEianNiEPPKK4Gc08qDX0e269AT5l7cH5+A2fW64d7N9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YysmEs2wG877T5vIc0GaS2BQ1fOCzxV3HjlHzF1XoxpIfm1M+TY
	6GwhQhn4uaYXf9P0R3c49tvLtBGG1f/iOo2MCtnkC5NUoEJYBAK8wXpYCUit2XyR9RNS2XVKufx
	zC+4yCCXQegq9Lgxp1g9R4yRcFFaLNwK6EtScGnnRqFNKuoAAKFaCeEP4eotYyA==
X-Gm-Gg: AR+sD127n1z7iEQMiUtvH6NSI0xRw9cN8c+eQ5b9QLuEqzZl0tcMDSQWJlI9nEk8nHE
	D0xFneSAfFrmhiAHNpVb6QlXzO1H2NPtdIB7/jr39iy9JMkBzDwOLm38HY5apij/+oOUtmuJtSG
	CFZqM92UQTrl25yX2O7HIwQtnDwnFyo+6NniQG2DQfZzX/H0GzX993gf1OKt/1RmG33e4WaQ2tx
	tuVPGWts38vYwK+6iJpw4pEpJx5O3EqJNtCegsdu+FtsMk3W1200FqDFeycwyzgNch3EkehaMaK
	6wIX/5r6tLrCACA2AypC4lyqGsy/wn1SDIz669gOaORfXFm5KLYCRXPtVwRnU5HrYk0IL3B5CS4
	RUvTyKJqI5hxFdCw/zGP1piJh85TUVifJGw==
X-Received: by 2002:a05:6a20:244d:b0:3b2:a809:ffe with SMTP id adf61e73a8af0-3cb85dcafaamr19832904637.14.1786042993251;
        Thu, 06 Aug 2026 12:03:13 -0700 (PDT)
X-Received: by 2002:a05:6a20:244d:b0:3b2:a809:ffe with SMTP id adf61e73a8af0-3cb85dcafaamr19832835637.14.1786042992725;
        Thu, 06 Aug 2026 12:03:12 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.231.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158678ec37sm30465262eec.23.2026.08.06.12.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 12:03:12 -0700 (PDT)
Message-ID: <336f3945-75bb-4cba-8565-063384020672@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 00:33:07 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 10/14] i3c: master: Add helper to query bus wakeup
 requirements
To: Adrian Hunter <adrian.hunter@intel.com>, alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com, akhilrajeev@nvidia.com, rafael@kernel.org,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-11-adrian.hunter@intel.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260806131857.119830-11-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=frDsol4f c=1 sm=1 tr=0 ts=6a74da72 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=uB10XSru4U0CyR2DWkO06w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=ir2BDiqAYjbXK5kd3AEA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: 2MmGFRfsY1acNq-V-7Q-bv_ttf5f1NDH
X-Proofpoint-ORIG-GUID: 2MmGFRfsY1acNq-V-7Q-bv_ttf5f1NDH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0OSBTYWx0ZWRfX7MCQb9AaQGbs
 Oa/vQYwc2dXQ60MOEWk3kItORmH1k9HMdd2W1HAS+II3rJY+gGkYw8fNkaWPGA/7/DRhTX8QWFs
 f3aRFCl9ir2Qgsq+Mxx9D8yh9j/8FXw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0OSBTYWx0ZWRfX4fdac6UMuk8k
 xkSRTABmkAUQLdNXNVEyDkaKS05IpaNZ2qXu56te56EDCSUGeUw8p427mmZRCmCnJg0uV9Iy0MF
 SOFqnUTuK+gq4U+KBjjJhatxpLNu/43QJWF3xfakAdihUbo2bRaZ3fHLmKZ2UxtwDvrKJceJVEy
 JV+lxn7dOcKJiqJwP5S7PcyJMCUfp/LpcduEtmwUSNnON84UEhgHAwL4uBQy1aDcPqYwx/HHaoY
 P6VJw66hyE2DUnIh2yK3/uIEKKg8qT2cnSL+AYYGumTLnWb3OqUpQSXJp+wIaWNysQrXu5NPWNU
 9ErQ0QAIUD7sX8kjEif/N0MlNXGPVUgi0SIu9+QVHcRYZa68OXYsmBuzJiE+8Wdm8mpolGVI8o2
 uDDmxRG8rGo29CkllxQA5L/XXisgxiP0FlfKxCVhorDtC2RX2pSoBA7FzG58VbiDvowANtlQRHH
 TnoadzZTiV4Ax5RdkuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060149



On 8/6/2026 6:48 PM, Adrian Hunter wrote:
> Add i3c_master_has_wakeup_enabled_devs(), which iterates over the devices
> on an I3C bus and reports whether any of them are enabled for system
> wakeup and have IBI enabled.
> 
> Controller drivers can use this helper to determine whether wakeup
> support must remain available while the system is suspended.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Acked-by : Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
