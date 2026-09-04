Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66A33E6DCF
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512410; cv=none; b=bsjzAC1JKMBtvWeZE16N+I7lMvBSIfjSn7eK1WF6nJnUqFVJlD3uzFuAl1TaSww1GVa/QC3xLf6xJWNe3KGitTWD+xJUvBewQmeZ5g76yhIPwNEMEAgAins7WmSTnwU8DmKtXcYOjP+A7SxPDyhNstorDTAB5ZmfcRgmZ8KfVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512410; c=relaxed/simple;
	bh=TwdMkfkku+7xLhkQkYda0UxtIy+OV/r23+7AedMhDfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VoRXPGNADg/bWt7eEZZ533j4jNDzMIWNcnTFS2/NCeKL2725UoqjmWwWNO4y3fH1mtP1O2DmRK09C86c2p9VItfZpv2ZZXpl3YMWNWJeixUVWE6eaNOy+td17k7TRI8v7U3vTtQG5u/JEY/wyE7F+ouHg0EkEd/ogSilsQ271y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RgwQcusi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G/Hdw7uz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RgwQcusi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G/Hdw7uz"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mmLM3234630
	for <linux-pm@vger.kernel.org>; Fri, 4 Sep 2026 09:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hPrFnyRkQ5lya7hdY6VenELDRNtS6j9fb64j+zDHYFs=; b=RgwQcusiD+sBqz0F
	jF2XOTgx2pvLO5qTcCp/KU57VdohSxr1FqohE1cUY2tk70/TPuqmFfLaMLktqg5G
	p4MqrQnqlWaHEFJUah4LmnpDevNJ2eLS/gnd0y1pFcnONHPfRtNjZQIVvRymxVSY
	v4R5GIk+wNf0LXbGizShkEWD5YmrmXmp0Xbd1PHNjPXeDphndDl8Ddm1kU8w8OZB
	/YZ6QQtzCG95q1v9KMPEviI16gYbWaZVyfLdO+kisFMjX9kKo1Ks5eGMfFdUZiSs
	rUPqZPmbNa63fw8kXGxpLCAHsjUTGkR52R5Qo/+UoO25SToQqlmkMr/Y2+Ue1T1w
	ifDMYw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp0r0yur-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 09:00:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93494b1e35cso14410785a.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 02:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788512407; x=1789117207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hPrFnyRkQ5lya7hdY6VenELDRNtS6j9fb64j+zDHYFs=;
        b=G/Hdw7uzC9kSxjTUpKvoU1GE4jK/dz2XRkpC78NI5vjF3hhQlTy2ZTG3xPq8smfCa2
         LrWRf+IGlXm6a1tAzfz+Zd1Tw7SXd1S0A54gB3vUChiPRnqpvrJRiOynY93pO8VdjjLf
         IzEEJ29csUX2/cqsiciEgyIsl1xqKLcdMbybvACo/G0DROHxBuY/LUWrC4kmcJafjEHD
         NiOm+7wAYTIa/wLjNyUQ6O4fv+kVOZeoXeW0VtfH9rKH8Q9D6UtJQyvYmeYfZF7W4vMV
         VHBj9m1H4AM4UtkNpZ/nckOtgOyDqyrjjLwroLvfNxzMdmHtU9zt8huLFAmsek3Q62nz
         4OsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512407; x=1789117207;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hPrFnyRkQ5lya7hdY6VenELDRNtS6j9fb64j+zDHYFs=;
        b=GEnYjyjA5x+8Hfi4FwMdfGta9FOJf7QOekElxl9fUqByAmDyVEGGI3gshK/OmtKE0X
         eg23lqvp7As8lB4ICXBHR2bk60jX36nq5YX68yiffOlaKmd98miZoTthJR2uIQIbOc0y
         VgqhJLTV9f/GQSw3Q1ZN0i1Dj393CDbKky86MvAlsByvUCStVJmbh7fbxkFdqTvfm8n8
         77ZaxyeBLGRRz8XFXnVKV1TFCYlVzI3TN/XzaoBXV2N1jgAORTD5/i9xlOSuPIeP6d76
         5a4tv+y9zZRfDflonjey64kYULZhe7a4DS/nlqes0IoY6xpwoKmxCOfYAScRot4MNK1r
         ne4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxTjDaHQceACWIu5tkOUHfhFkxGBy9EnRORpxcHwatlSmJU+E4/JuOT0DBthiXRKrLPg8rBYrTBlA==@vger.kernel.org
X-Gm-Message-State: AFuF++n+y0isN5sqZKTQt43jNVpr/cwFQLep1C/y1h+KyAEswU3roj5S
	Me/bpdV+XvyuyXim8IMsUA3tgkuWF5Bv4DAIrXZU6wD0KjYlmujx2U5PI/IYLIE5ljGI1KfQ2Y3
	C4gCmQ9ev61Aq4KRwYbjhM9aoODPgfdsVX/1nv2ESS3/Jjrw31HqV6yevLOj2Lg==
X-Gm-Gg: AYBFou2fgATFSqrwbTXOse3ocI+X+iNFTxQwa001xjFq+IfxxrWYY/lBnkyly7CyATs
	BI7gAJhBa886/W8RKlTMn/tQqAMY3aQPKSakmbYKVgY3aVF8OFfHVx0I7wzV+/iZcGoorW7BA10
	uiVzeqzF62/ZK2dVEvKbZxkAKXwC/XX1DlHsVxrriz+QiP1cFMGJiPjC/bFcIW2lfn61hMCNmS9
	prhBruSuMXttvOEITklsOVVlmr2vQbiuyUxCgAI0/rc3Y/N/5qy1eq6gVravEZyk73u5jwb7DKg
	MQ4JNWYH4FmlhfDZMsYs78baZrczKDEnipO6gQ1fwqwu87syoeqNtt4JqBhnyx0CiCoD+kdTO6t
	rP2u54kpaCHBeW9cGySVISQ==
X-Received: by 2002:a05:620a:178d:b0:939:4a24:4de4 with SMTP id af79cd13be357-93980c5c987mr285928785a.5.1788512406263;
        Fri, 04 Sep 2026 02:00:06 -0700 (PDT)
X-Received: by 2002:a05:620a:178d:b0:939:4a24:4de4 with SMTP id af79cd13be357-93980c5c987mr285923885a.5.1788512405649;
        Fri, 04 Sep 2026 02:00:05 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6c20c0fsm895767a12.30.2026.09.04.02.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 02:00:03 -0700 (PDT)
Message-ID: <0f5494c7-c3c1-4668-a09f-d8c43d1c58b9@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:00:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] soc: qcom: geni: Derive SE clock configuration
 from OPP table on SA8255P
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, mukesh.savaliya@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <CAPx+jO9fcvBsxe9yx9oK=0EXmpNwub5ba0a-TGk1WRFaRGsqpA@mail.gmail.com>
 <177884a8-902f-49be-8fcb-b2bec3ec7d6c@oss.qualcomm.com>
 <CAPx+jO8bXn2F3cWz87Ozjrh00E+a_UWBrHeUViTEkTL87JHW9Q@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAPx+jO8bXn2F3cWz87Ozjrh00E+a_UWBrHeUViTEkTL87JHW9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MSBTYWx0ZWRfX+twMOe8M607E
 eKAxDXozZVbUUCyXM/+Kux41g+r+LEN4kUVg4ljRRCOvOafexAMd5Lk6VjetgG8n1EfDFDh7khh
 Kb7sXzRZrhgcuBhIUQJBL429fNZx5pA=
X-Proofpoint-ORIG-GUID: u9oU7v-l2zTe3HbYBAizWSZFr28b6d2f
X-Proofpoint-GUID: u9oU7v-l2zTe3HbYBAizWSZFr28b6d2f
X-Authority-Analysis: v=2.4 cv=T/S8ifKQ c=1 sm=1 tr=0 ts=6a9a8897 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=tfn4aQiUfrmVOWBwnpMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MSBTYWx0ZWRfX+hwhrFmwY2NP
 KtETeRkLFBiw+2O3TpoI2h+Hg+1gNdq5O7o5PjnryOVF37plRiHM9xdxt0IrhpJrHNyDks/36NO
 TCaXzQFSP28iGSEHOmi/boiQ+GMDgsRC8STiuRtkW4udxwX1AAfD4zz7RHvRhpY97Izbo2z2wYW
 S/MwCcxaIq9qBWEut+MJ2WsJeBdQNmjU85Pb/jIYgW384GamQH8aNSmSQR6eupEHWBuDTi0hdfc
 IvI0Nd9jvleoZ1fB7i6UI1a4/k9GJacMIw49q6nYEXgDxrO+Lnz3YPaxAKf1KXFvcDqGE/4Cyn+
 IQKCuAsktcfbp0JVUJRjgCf/Ig1uOwajeTwOGkxf76q+hpp5Y1u+gxu5mnmLcRMx6bh9ai3rKv0
 wWYi9xxHQDh+eizD+pMfiFAGL+Td2GtbmOOpOhkIyIL7sSTEdsqf50jI3skP9YqaZeZNwxFZAPa
 ct2LhmNKCapV5RBWvHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040081

On 9/4/26 9:56 AM, Ulf Hansson wrote:
> On Tue, Sep 1, 2026 at 6:48 PM Praveen Talari
> <praveen.talari@oss.qualcomm.com> wrote:

[...]

> So geni_se_clk_freq_match() is used by two consumer drivers today,
> drivers/spi/spi-geni-qcom.c and drivers/tty/serial/qcom_geni_serial.c.
> 
> Beyond the $subject series, there will be even more consumer drivers
> that call these platform specific functions. As I said above, I don't
> think this is moving things in the right direction.
> 
> If this can't be solved with generic frameworks (clocks and OPP),
> please clarify why so we can figure out a better way forward.

The way I read it, isn't geni_se_clk_freq_match() more or less
dev_pm_opp_find_freq_exact() called in a loop with an increasing
divider?

Konrad
