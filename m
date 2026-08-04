Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF113F0A9F
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864826; cv=none; b=E5qsTnPv20DBPD2kbBMcmrn5ai7UF0h6gKc99cq1rOq8+9PR8BmCVBSh1lNcx+8lQouOo0Dk0fGtvI7x2qD9J8U4AVl2bl4wUaci3lKN/d2q7gqCjwiNO+ekdZlmahtDkHVPFmGFQfNYy/pQii4++pfpFCvIPerqwl0+X1axDGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864826; c=relaxed/simple;
	bh=s5GrUbO/K7GURFg+P5CxA0Qxa0DU2VYDxIT+ut6Whsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mb40m5m6oDsSDBuBs5bHhujNb3dPOysN0WDwI97Y4u6iFfks1xPoJ2QPFVz6lSG+K387PlG9feWvnVHYgX/lL8eqIMtHeMt1dhwN7MnCckmepINdC1PZs1LE87V/Togj/w+bOM7pVwlEgCndS6Xk8g0e2ekexvJl9UPsbwxBaBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WSFpLY38; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CjBPgeHy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WSFpLY38";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CjBPgeHy"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674H3XvF063345
	for <linux-pm@vger.kernel.org>; Tue, 4 Aug 2026 17:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wyItnuYAoSw/iX3WQl8cdPxSiwleyAQ9qgrs/f/zFks=; b=WSFpLY38+80fqZZO
	T0ca8XTtSMvaGsVT8TlKB8IYPBbmrVMphHdIBXmQNPQVDdldguwuneFbwyTW4Hym
	K2PuC12/0ohwXc1ftdZdY2J/OxT/hromVjhdprIjPPDxouVh9GX5o8jqZiCR76hl
	tEyxTFN+cqt9fYQBW2TOrpd9MTTQJc7X5kRYyHSOcMw4H74NpnSxFZ37SDOFKuYM
	woz1mR4iktjID03UP0IqqvJHCqqsF53ZPU7S8qVHMNuxlfQpug0qETs2sZNxkBfy
	SuatTR5Io7hgvD0r3EUS9q8ud5j8LKR07YLLEexUOxtS1FiShrk48h9UaL0k4ZzD
	6z0Klw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fum56876s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 17:33:43 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8487eb67173so73430b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 10:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785864823; x=1786469623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wyItnuYAoSw/iX3WQl8cdPxSiwleyAQ9qgrs/f/zFks=;
        b=CjBPgeHyDk1+kB4y/JFdJD3vIPVF8KkZZ+OFHfQWTiFZqFE12Lo48CB/EEgm0O3iP7
         pnu1wo1B1RKd64apUu3LUioOYc6iBXACqmrIuRk2nLTswld0B8ipoc2zrI1LdzEV/o6R
         p03wfP2SfIqTdIX8JKvSGEKvRQe0gHMFl1XYc8480YuCtGOBiJ8fMkpjuqhqNiob9UfS
         WqAZqKw5lEDkTuwJwgJ/K46R8yxBHYtzhOFo6yk1BrtgtPmeOEEV8YIxeUA/XBv4jFJQ
         DA/bUsNo8Gl9s3i0Rh7M+nFvNP6cZfar9yrfslq2EWmmGYIdhwNS/5GXe88tDbW5QpoO
         GXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785864823; x=1786469623;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wyItnuYAoSw/iX3WQl8cdPxSiwleyAQ9qgrs/f/zFks=;
        b=ZI4rGh+L1MU0Fh8Qlx4wSADFK7qi9r5srR1Gh4K1ydMvn7Kx32iVYj+outLDWkymTT
         M1tcoKvOiJ4N6KcpBnzwY00AufTOYv2XtDC8iBEUL/3dwFdNqzgyHWNH1OtOpLzyEsBF
         fzDjK4WfM2M1mGTQif2mI3cy5rSNuy2ZvsoGxeREcAQbTZ8AcfI369sT8ZJVkIrd3T96
         R1s8oSRxXzPf80bn8QRhhWjzRpM5UfiI7YuUycAzvOE3dRrQpXCC8OUw63zgJdra2zjc
         N0rw7niI21AXNpY908UkxMtQGUjJMB70WDn8917nBBc9SjdD8ZVoq90OfA6CpcqR8wZ6
         JT7A==
X-Forwarded-Encrypted: i=1; AHgh+Rpz/ibjZKawBOqaCCPaYbWI1rvBAAca81h0w1cTDbQT6YYYPiKV/HYNRvUGX/YjN0DlY8/5sxROeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YztrFS6M0c2dT2uh+dA2x0ZF93BcrKCBV11PqbCpkdQeI2Lnftl
	nFH3VmHt4iQ0joFWEx/Ebmc0bP8HOM2BXZ6UKE7wbeQKuiL03lGBtDSfVLeV56Megfbn++WPFwP
	6c/QdIeEgFTfogkjYZY6SIhl7Pd5+cjjQC/mEX3YvDTxraF/RQ/FAMuoWjlBaJQ==
X-Gm-Gg: AR+sD12YwxBtGd7B1sEUzZr9wyiRWLg2gRgEJG2XRd2B9fEij4OLzeF06LRaxRtVeZF
	r79nUuWQzK4QMmjsyBBqO9T3C4Fy3Dk+9ncWPDNvwyTVKuyDsgu9hmc5qMTnvra0uZl0s251Tui
	9Hjo7LhhS78nIUcHPOoOatJ8Gw4Gjig53rLCXuEIUQ+ZcoSYYQJ8i7OO7D8tYdt0/UJdSSii50q
	YfEyqR0MsSYCBbCcS4/NvffIVxNWSpz4Yi8PuXvDTKMX8RBtk7P7mTE9V4BwVSMAV1HPf9ff32g
	Pij4wtfOYBnyaqJpqUVwAAVKP1bKJ7A9cW1960+t2Z0eJkuiWmIA0eLEwedo6LTCFdwSCPPrMaq
	5DI72VuO15aInxRQeUiVlodWv11SpEBrCgQ==
X-Received: by 2002:a05:6a21:6b0f:b0:398:9379:d04d with SMTP id adf61e73a8af0-3cb85e6c922mr471745637.24.1785864822734;
        Tue, 04 Aug 2026 10:33:42 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b0f:b0:398:9379:d04d with SMTP id adf61e73a8af0-3cb85e6c922mr471711637.24.1785864822315;
        Tue, 04 Aug 2026 10:33:42 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.234.41])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673be99sm12590660eec.15.2026.08.04.10.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 10:33:41 -0700 (PDT)
Message-ID: <ed403582-d3a9-4d64-98a6-5bc8537f0f54@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 23:03:36 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 03/14] i3c: master: Do not treat master device as a
 duplicate target
To: Adrian Hunter <adrian.hunter@intel.com>, alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com, akhilrajeev@nvidia.com, rafael@kernel.org,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-4-adrian.hunter@intel.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260804133810.184905-4-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0MiBTYWx0ZWRfXyy5W958odb1c
 5snF+bhwy3bGH9tWmU5x/ViUGOMir1h8iBStkpWw3MDd1O7EtRxnpCnSYbyNJjkInJkx+BfXC4u
 TNLc/OIaK3TolxF46rGrDBjYNYoCQy0ooxFQ9QtbkXPM1IxQUClKTGewpqr9e1TRSSXpClaYJxA
 Nk8vkAf6H/731yjcGq65V2kRuLUGMODqd6298cSFtCH9IGJ72CVvt61QOvNou3Vx31G7dyXMj4V
 mifrSIAhmXC9S6QLmDtJxib9BgNCGEwSlP4jvnpuz5pthTdVGvhDnnMPyoQ9vRY2DEYUCplSBxW
 OB1u6yk4lVIWb5LrtcLzTb3RGZ49lKukZacMhJeom+sFYHpTXFa99XJm6g+o/oi0eIE5VYHBf4L
 Vfqli1Vn4AUsqYhCqbEuwErHl0sTcdDnrMQlKmRaRc5xRpKNTedD7C0W+jFChoUxCJVpxQvoVph
 8Rr5NoccHDaS4Z7NtCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0MiBTYWx0ZWRfX3RVjqlDE5N19
 SHGwwSjQOZO9RB7n6OYqT4MKIVxcEXajhF89++hZrRsQKRNu20lDIiQAu/i91vWUvk17X2GbvOt
 ze5ld9O+s59ZpuT4f9RRYsDB1FQ6K80=
X-Proofpoint-GUID: 0qlYF93zA2iHA-9OA8f_Tc2y-Z8f-qvn
X-Proofpoint-ORIG-GUID: 0qlYF93zA2iHA-9OA8f_Tc2y-Z8f-qvn
X-Authority-Analysis: v=2.4 cv=GL441ONK c=1 sm=1 tr=0 ts=6a722277 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=/lQgZcjXNA7ZrIsIl4Cfeg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=RtcsEO40LIKQJCypwjwA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040142



On 8/4/2026 7:07 PM, Adrian Hunter wrote:
> i3c_master_search_i3c_dev_duplicate() searches the bus for another I3C
> device with the same PID as the reference device.  The search can match
> master->this, causing the controller itself to be returned as a
> duplicate.
> 
> Since the controller is not a target device, it cannot be a duplicate of
> one.  Exclude master->this from matching so that the function only
> returns real duplicate target devices.
> 
> Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> 
> 
> Changes in V3:
> 
> 	New patch
> 
> 
>   drivers/i3c/master.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
