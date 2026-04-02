Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC73346AC4
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775150669; cv=none; b=H3i955LwlH3kpZdSLZjx5e5/1nXVT4XoPWXz2t3zDePbchsq0f7FysoQX6s8BBgn2ciC3fetdTIZ1s2W/lCI881fSAK+du0pRwNoS+6wel5odf/1JTT4dgQD3KF+46OaDRrtct9/AR9M9IwOhPk6TES4ayRoHsIah5SMzSxIYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775150669; c=relaxed/simple;
	bh=+1RuN0VTy2uM92MXmgm5hMB7Ix4d2SVZ9OTrxr0RZp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMi7DF5DXLdHooGe8o+oaD3hLWPQogNs2bNqxqPqSOoioyPycNvHOuSbTamL49y4zPRl1fnA7ukxBSr6UAXhhGBze3lAzJgn0VN7xX2oBBDD0iURsENBFb16zL3jmSFmBjkFAQh0w7WAN3dt4s+ynp92f7LEV7j0mXgKK3xVkVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mFC0AVfu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W2gYZ7q/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mFC0AVfu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W2gYZ7q/"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632G4Z4E2922141
	for <linux-pm@vger.kernel.org>; Thu, 2 Apr 2026 17:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tq7FG4Q/QQKaF2KEXQXUS/wC9EocSmykX6qtekYg6N8=; b=mFC0AVfuix9ruhKO
	2rGfv66jE8X9lHZzyBOFBYXnnbdWbHnaX3BjpilwYpaa7SL5mXjYSGO8f/jFogFr
	qP9crl788a84vPk3NAr+vD44RImcctGCHK4BXFT1tCtBYEc+xcbucdoBdvk0Wox2
	4G+68fXHdj9LcIorXfL4RPn3PnJR0qATNcdazH/G+3ggI538DvGX/BfRe7/0rzjE
	yK8jLAgyDk7ng+/sS9YOpNVQjcvckiifMh+LGbSL6j/Myt41yQtBYLMaTVgGa7E1
	drZq/ZAz2L8N39yhj5vbRpW5qWaV2uUvkIxsbKOTl/zxS22G2YGhUN+0EH1Wtb0m
	NA+sXg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9qw09cef-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2026 17:24:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b6f869676so25347801cf.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2026 10:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775150666; x=1775755466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tq7FG4Q/QQKaF2KEXQXUS/wC9EocSmykX6qtekYg6N8=;
        b=W2gYZ7q/ZZr0M2RslZ07pMo/r3pErnNm1EbzpAbd0OLqrgRWUeqNL3RUMp0t6VaYBU
         wR8wQnMgH36dig/RA0rnalSjHO45t/fL9CNibVoD85R2UyBe3uU/lGfaUOuHWkABlbyI
         uPYvbHrnAAOAyEYPJx7/yMrTyMcVTNw7u1HAD5T8aYTIeCY2FAk7FIE8D1C8XSaxCF8e
         UdAcsMhk8ONPhMbCKGjfSGn4GoAoGfCNm3Rx8VqxHXC8kJh1BJOh8N/GHLA++Jg3lLmM
         0RCmGGE8gHvb+Sqkpb74eo8w+SeMk1OmllZJu1yCnhbHE8hywbRpB8WNPSw8JeNBru4H
         5oIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775150666; x=1775755466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tq7FG4Q/QQKaF2KEXQXUS/wC9EocSmykX6qtekYg6N8=;
        b=UyFDtPHVBxvdkBN/3XzPoaSujv0WWR0FOUu1rFtulRGK1prbdzhqpnqcI1choqtFGv
         xDJO2H9lFZ6Z8f2U5cjZL2SrgedECrtvPO6NTE73x3pgORNZGYnyOGS6NudOBhtb7tMw
         MYZ54IFIY1xBFUY9ldm6Yd2VK9gDOdYTQeAxX5CCJBYZDJMkFXHSCDmvFpyJO/+qKZti
         rk7teTaeUbRFNn+TCp8/NILF4q3mSm0X3SOwV0AphmCjuVahkkd27lPom7BCJmGBQETK
         prnHfdGlkvy68zF8qEJdimE4dEBVIXJEB+E3Y1atWJ9NjjjMmjrO/2qSdNhb5e8ZqAXe
         TRtw==
X-Gm-Message-State: AOJu0YyaH7Ds1dTkFm4l75n8vNoSvQhVJVNL2az7M7mZHmOmAqjV+wc9
	lwx0+RGDBKd7H8N7FZ60CuHEjXOkFuw/zoBIcwQLIGiqngFYXN9SdFd6gIJM4WBfp5QyM31w6Fc
	2GVgSf2DJvhq+S5UptOcT0jEgqHHxzLLSEm78Oq3cu85e5ziSa4Yynba8BhWN5IdiBYXsrw==
X-Gm-Gg: ATEYQzzbYo1OBsECdV29+zFW1lnPLAJTHA1PRTDZF8zW6948bLR7I/S7UUNBVLuCLqG
	FP6Bh8IUxtJRT3NKTVezfzSDREPsS91x+z0QjW7qJjxeS+JYp+Gi/p4euECQ0hJ0iDT5/zqlMms
	muSeV2SczuS51lQtNpyukQGmELqHrUucKG6KdWkf/T4F8RDlpbR6qdXbDu4YEiw8hc4T+hMfwX6
	MhU+q7Xj/h0Nv2SPpgzBssSIfxa9Jecr6EbxApkN3y9S1pPAlTYrpS5y1G6tOPmBzaPeMzLOlfN
	VVOi1sBnc3/C4YYYaxJHu8bM9vFzWJQFrTjwrTeAbrs5vEXYOEJn5iMTAwkELyBb0KMWBZyWHa9
	HPA6zv8BlmdfirOco6JZ6x7offTZfuYWEVuqV9gDIGo/S1s3YcwyidoWFUhYwcm7+htCAPM1Vl3
	bHVAeZ1zBm
X-Received: by 2002:a05:622a:5810:b0:50b:4b2f:1606 with SMTP id d75a77b69052e-50d62750dbbmr3336241cf.15.1775150666313;
        Thu, 02 Apr 2026 10:24:26 -0700 (PDT)
X-Received: by 2002:a05:622a:5810:b0:50b:4b2f:1606 with SMTP id d75a77b69052e-50d62750dbbmr3335801cf.15.1775150665896;
        Thu, 02 Apr 2026 10:24:25 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d58e5sm11345379f8f.23.2026.04.02.10.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 10:24:25 -0700 (PDT)
Message-ID: <471ec056-3b67-4ed0-bd8a-9c4644eb8672@oss.qualcomm.com>
Date: Thu, 2 Apr 2026 19:24:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] thermal/drivers/brcmstb_thermal: Use max to
 simplify brcmstb_get_temp
To: Thorsten Blum <thorsten.blum@linux.dev>,
        Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260402165616.895305-3-thorsten.blum@linux.dev>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260402165616.895305-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE1NSBTYWx0ZWRfX3OHv+NNQ/yj8
 q/yh7kJbXrX1GYoxw+kHjgPUmcMBzYks/ooArb7XX8QElH08ryyHsZu3F+rDnOpvRPpR7O8wNlq
 igshsIMHvYd3QvfHOPf1ufwsKfPl+veRV+Jy5VxGxLdHuVFvRs8ryjflFb1fsmsrgfpwVq5UQkB
 esY+pbU7D6h+brDxIIG8XmLOeqbl9zA8TqHBPFF0Z3ibx67JMbjqkwUYd9NUssZc4tvyy6+hYws
 /9ANmbUS+X0NM836Tp93GiC117gWENFqaxFHs7xV1iQOW6dyVqLVTWfpoKVLSBAKmVbxbyalTC+
 tLFDAkPO728RjrdpStmKvY7mEoJGpe6C8TCTpgsP/HuNcZO4p/vfDojjOlFwwp9leJnuMQ+C+ch
 b8peCP0aQzIOodbouCVG0duaQfFP79X7DX56wYGMS+8p37gVImmbdf1yauVYsTVdtPM4HQ8Ku3Z
 onhg5IPLD5ilX/DBfQg==
X-Authority-Analysis: v=2.4 cv=PNICOPqC c=1 sm=1 tr=0 ts=69cea64b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=Q-fNiiVtAAAA:8
 a=z1V0bBGJbCNoM0m4n84A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: C1peCdTrmzzWMPArOa4BafPf0dSjgrGM
X-Proofpoint-ORIG-GUID: C1peCdTrmzzWMPArOa4BafPf0dSjgrGM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020155

On 4/2/26 18:56, Thorsten Blum wrote:
> Use max() to simplify brcmstb_get_temp() and improve its readability.
> Since avs_tmon_code_to_temp() returns an int, change the data type of
> the local variable 't' from long to int.  No functional changes.
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---

Applied, thanks

