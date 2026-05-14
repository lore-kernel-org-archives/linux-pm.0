Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B27224AF7
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 09:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750626; cv=none; b=W/z0BuBNLyaTYDnamXSkJdGkHMPAE3QnxL8cko49OXiRZxKSZLaK0zol19+iFnOqWN2yX2BUw3+DCWF2SGWY8Vq1NNE3rekqL7q3Tb3cNN6oa8NPqax6TIP5FSlifV1gvj+20nv3NgaVkR30PQCwXWyTWf+WmxS7LXOIK5nGf/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750626; c=relaxed/simple;
	bh=D+0UR+tuvuV+iGfThn6DdO0atxo4c51hBLb9B9cq4+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rY/lh69L5Ds4DNMFq7w5VOmcumFMe6nF7ZeuGMRqXncqzriXc1ygBOANDGLOSNhnt4IFc5cn+lLGmvISJCgrxj2o3dTqOK4do+IZ3atBPxfiNrzJfgsPoLmr+zuQrYIzD8EWU3GZginPEvIZS2tpFrla8EwJG2crSeNdfBo6pZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dIDd61Vs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dz4MRTcm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dIDd61Vs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dz4MRTcm"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E9IaTS1095445
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 09:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B7mfb7Vpn1k0Bgb4UZHW0W0XQiV5frm6lZKL/dZelLY=; b=dIDd61VsmW15KdXy
	ruWqI5i4785aTYCsObwOPIZnr4VeMUPMgh2qD+fOvSuNKhW22+fyI93n1xS8oT3j
	hljoajyDUhFIJ69GIjsBa7GvYGgiEgxTgZh5fJRZWDzEipLnkclLtR9iUimhIFlH
	qn5HTK56s3S2jyWl4ystX8fYrSeUgeyJirpM1+iIHOhr+nstiFIx+vo4YJqDnrPS
	/wVKDgz6Q06Mq6JSCyXmrW4TXErseNTpNbkMBivkh8rXXVj1XdhR28NyUN7gJEiy
	sZPMP4HTlfd4ROl85FjJ4up8Egao757BPo0Gq4fYz1+ag+wMQsuWQ8+NDIA3dwkc
	/kWPmw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e563hh7u3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 09:23:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-90f6e66879eso56446885a.1
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 02:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778750623; x=1779355423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7mfb7Vpn1k0Bgb4UZHW0W0XQiV5frm6lZKL/dZelLY=;
        b=dz4MRTcmyWq6urB0W3bJ6TomXomCdp7EB7Gninsk48Q7ZuseTnlCqUt1NUuCWAIJSr
         XmjSg3e/gbiAzIiABdOF9a/TQZpOcLPut+GTK9lqIZHk6E9f77JdozgBXUSxO9JFx2WI
         wDHTdtxOuDGo3nzdIyJ6NCpNWMA2SLxJtkOrGNpuEKKvCvjZRHxE6fc8wmt0+mOmp2Kf
         f9m7Yr7P3E1xihCVyEWDF2RPP1MEkjoF0LukjVuM3Lkf1aM4ZZAnu9LhCE/LDjDreQOM
         aOTIpFY1DG2uGNsTzk1s2XfYpWBb02Apuh/X02OSjjK3oKiLw1OAwxGmbAM3bSU642dZ
         twnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778750623; x=1779355423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7mfb7Vpn1k0Bgb4UZHW0W0XQiV5frm6lZKL/dZelLY=;
        b=FkPZCcdy0bzJZZ0dqmQJQPDrmxKkmNs52F6zanv7+ZEvYZkG4JCp9sOdoulUt+CVWJ
         La9ygbSXhXc2Kyip4cm6QjOGgTUG0vNTyZgfR303cgmmWU8/POkH34d4OEjlutA2Ff/8
         g6cODxu4m1+YEzkiToP5Dxi5C5AVKz3MOJuCqGLzcDxmViiky6BkGQs5xlw5aAE7By/U
         f0P5OhUaHVQLd9X7WT1i1K8UuCtiRqokf0XZaSnWl5S+N+QUu9E3O3Id6v7S7GuMjE+c
         8B7fAZcKprnZCw/dJins0dPtCKmbf4meIfcEVAWNi45Y5lmaGw6GwGDvmBoVymPXBdjR
         HD/w==
X-Forwarded-Encrypted: i=1; AFNElJ8Win9lG4MLRI4cdAiFZ3S1RJEmtWbPVKtBz5qCXEJTrtzVIQEZveb945fnORlKr+SZ4pMGhFza5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/yP2y9FTDJuardXjEaCZsLqpwlW3XQrSX7x5IkrNV7z5shMcw
	EiFDiPfTb328wlrhVW1+YjwYEreMTmkvi8MIMSpTEsGVsP1tJQdIqUiMYtl8yShUx66syI75Est
	bJ/qk9RKZm+hRnYnsw47bJG4tkTHur9sDa5opW/ncEqtYq1ANbIDE5Q632fssxg==
X-Gm-Gg: Acq92OHiRjONxxH/wP1Kb/so+OgNnY0yf6AtfvowuvM9cwB2qO/TR1o+RWbVq+vkO3C
	mS44ME0tPdLDvEBNSWYpLEWL/1wqyZShVVt8eKV7cQliQT84HY9nCfQds5CdRyyefuVy+ZT61Ef
	pRBKgCAERfaNKmw2vTNo8T2Fup4wcn0Uk9dvwHg7XgfXpJn1modrkHsRz6uto1ucVI3bgX2sWpE
	RD6N9LCGAZHFRTqhnFsxG1IvXzIInecqFZmqEAPH4YuwMK71unCxgGMj/jKssy9QsE+7SoQz/dJ
	LSWSlMeHx8JA0QYI/oluz4UD1bPZm7yLAK/x7TVxWyXzHa/Y4Ttu/101jeKVebjTklimtBN//d0
	Rw+SeA5i1aAmtOk/LJ6kez2N6Xdoo4qZWzpzx2FoF9H5hFE+Mg3D8ANWRCntrNACj0iAigRLUiK
	IQIAo=
X-Received: by 2002:a05:620a:4043:b0:8cf:d953:b4ec with SMTP id af79cd13be357-90f8a634f71mr758713285a.3.1778750623305;
        Thu, 14 May 2026 02:23:43 -0700 (PDT)
X-Received: by 2002:a05:620a:4043:b0:8cf:d953:b4ec with SMTP id af79cd13be357-90f8a634f71mr758710285a.3.1778750622815;
        Thu, 14 May 2026 02:23:42 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68311660f76sm513638a12.19.2026.05.14.02.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 02:23:41 -0700 (PDT)
Message-ID: <d2025522-ac5c-4e45-8274-1cbb49b7b348@oss.qualcomm.com>
Date: Thu, 14 May 2026 11:23:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soc: qcom: rpmpd: Add Shikra RPM Power Domains
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kamal.wadhwa@oss.qualcomm.com, jishnu.prakash@oss.qualcomm.com
References: <20260429-add_rpmpd_shikra-v1-0-fdba28564380@oss.qualcomm.com>
 <20260429-add_rpmpd_shikra-v1-2-fdba28564380@oss.qualcomm.com>
 <e032c072-57b3-44b4-84a7-5aff062b9c00@oss.qualcomm.com>
 <20260514084512.q5pzh226zdkuw53f@hu-kotarake-hyd.qualcomm.com>
 <ezpigr442rjnodqcg5fqsyaik3tkp4yyw3cbu6j75ra2vidnnj@7svqkcz45sdi>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ezpigr442rjnodqcg5fqsyaik3tkp4yyw3cbu6j75ra2vidnnj@7svqkcz45sdi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UMH--e2KF1YIvtqVCWMcftRkwrF3QdWz
X-Proofpoint-ORIG-GUID: UMH--e2KF1YIvtqVCWMcftRkwrF3QdWz
X-Authority-Analysis: v=2.4 cv=DewnbPtW c=1 sm=1 tr=0 ts=6a0594a0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=tdAlGey_Py1J2zJlv2AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA5MiBTYWx0ZWRfX8EXjXrW3mwcI
 teFRwu3K6yuPz5Um/2aMC1aTFGD2lPhI6N8RWHduBJreF77Yz4VILAtCMKakV/Xp1YolFvY728d
 7glXAxBSCYCX3QCGOiVPORYYXHeXLbEQl0qGoOfezzD5U/kuhvkierGngQNrSAkrVcbz38GJrz3
 nir6+H6oyQjxeLN4MdaoIRXndBn0FGvAg0j5DTTIgHjMWwM+gzRIlqJwIQCCOmmh/RcAvMNXYyF
 JKG8cPai/0i/N+r/g2Or4XtkFTgwFKorWIBDM8nk9iwhhouu2GsAJA9MOl+EwZ6DAhih7LmCeX9
 e8sW9rJRDenDH3N2PpHlPv3U90CknGab5sqBl6/GorSRdPa5+2REnj9TK1TmAWMFGQYzDjdNtcc
 MNb0XIIiVmjPE+nXnurpDjk5RyVaileN2xX2tXPBCvrR8qKFfyfKg2RPMNcwDL7Ikdmy+r67SDB
 xSbo5NZzQqoNN3QDssA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140092

On 5/14/26 11:16 AM, Dmitry Baryshkov wrote:
> On Thu, May 14, 2026 at 02:15:12PM +0530, Rakesh Kota wrote:
>> On Tue, May 12, 2026 at 02:16:07PM +0200, Konrad Dybcio wrote:
>>> On 4/29/26 4:09 PM, Rakesh Kota wrote:
>>>> Add RPM Power Domains support for the Shikra platform.
>>>>
>>>> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
>>>> ---
>>>>  drivers/pmdomain/qcom/rpmpd.c | 16 ++++++++++++++++
>>>>  1 file changed, 16 insertions(+)
>>>>
>>>> diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
>>>> index 15a11ff282c3f86b1e86c6604d165e297620f6cf..6f751ee5a7833912d54d2bcfd5d85837ab7a97d3 100644
>>>> --- a/drivers/pmdomain/qcom/rpmpd.c
>>>> +++ b/drivers/pmdomain/qcom/rpmpd.c
>>>> @@ -863,6 +863,21 @@ static const struct rpmpd_desc sdm660_desc = {
>>>>  	.max_state = RPM_SMD_LEVEL_TURBO,
>>>>  };
>>>>  
>>>> +static struct rpmpd *shikra_rpmpds[] = {
>>>> +	[RPMPD_VDDCX] =		&cx_rwcx0_lvl,
>>>> +	[RPMPD_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
>>>> +	[RPMPD_VDDCX_VFL] =	&cx_rwcx0_vfl,
>>>> +	[RPMPD_VDDMX] =		&mx_rwmx0_lvl,
>>>> +	[RPMPD_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
>>>> +	[RPMPD_VDDMX_VFL] =	&mx_rwmx0_vfl,
>>>> +};
>>>
>>> This is identical to sm6125_rpmpds. If you're sure the list is correct
>>> and complete (no LPI domains etc.), you can drop this patch, and proceed
>>> with just this change:
>>>
>> There is one difference — the max_state for Shikra is
>> RPM_SMD_LEVEL_TURBO_NO_CPR, whereas sm6125 uses RPM_SMD_LEVEL_BINNING. 
> 
> It's handled in the DT. As such, programming model and the domain list
> looks the same and compatible.

Yes/no, this is an upper bound

one improvement we could still make to this patch is not to define
shikra_rpmpds[], but refer to the existing sm6125 one

Konrad
