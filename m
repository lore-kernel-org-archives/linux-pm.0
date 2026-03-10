Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FEB36F406
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138004; cv=none; b=LRMpw/CH21/1/zfFqiHXHWH6cmdxJ8ZzTpNx1ecWTT1h6LcZ0QN1vry5FKyMOxr4bzz+vLl/SQCzuhrDQR+wGRtMl46FjZRqvsf1aBrBpVn+khzgDLTDhjWy9pOyNR7CHuQC1VDJY6FUVqyfrPovJBgYfG+ptOuX0r12xM2KjFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138004; c=relaxed/simple;
	bh=lxucRPLGFP2tL95+5ul03k27TMgtuEPJHmZZz0al1dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7fVLct5siV2xRoKqV8GddfwfCUijYS3aD/wyfhG3MYyCHWNXbH8ixFlAMU1soJ2baZkN1G9kJ7P36c7S+ZCABUp2P+17j4ZArytrcwKvsJQd4OppRInvfIFt5LBix6e/eqjLzJiuWo5ZJMhnjCSNwDnBa/M2CQprTdordrhhDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jK3TxLBq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hJbxCyWZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jK3TxLBq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hJbxCyWZ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A98juk3754559
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 10:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xK7UBllLwsfyVBP7rppLjdLPdGs5UskxvKVTbdCf2Dw=; b=jK3TxLBqNiVnhojq
	BYI4lXL+fDKJ+eSbOgxpC/4BE3pXldjTCxwIZRSilZnDyb/+oaYyuuoVZF/M4sJh
	RTN+eWzmSTC73QEcWkcULkx3ldhLciG82+ZnV9yK0xZRXNYRcxY604aKBIKYdahu
	tC2bq+MvLgjG7tKXNBxrx/ZAFXtMoAOfbyzXNCQ0TqKsWgTkz1h1155Zlh7TCCMU
	PqarthxWOmwcM4GtnNGKC1fA4jbeS8O8pIG/oLbF69fyYEgpMRaO2A0Vt+mB1lxn
	s/hyZus/zYTfo7NcJTCtEjlinmpNoEqfpwvh7Q1r+5/IkQC2LIm4EJYNJOQUoEW0
	n9fSVQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct477jnjf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 10:20:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd7fc27cf7so1384174685a.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 03:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773138002; x=1773742802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xK7UBllLwsfyVBP7rppLjdLPdGs5UskxvKVTbdCf2Dw=;
        b=hJbxCyWZICa2M2JKkg1zokWupRXPwl/ooNyTLZolEXRLpX+aVDWZSrlHsTeCeKe7SC
         Ioqkqd2gYZOUYcY8pPnnnpVG0HVfat3cr0yMyxO3LJIgLexm22c+r3yD+l2cUm6HUcot
         iY2TF8hzRcaytR8JgglzekXxqxREKy+QKIYjps6W55EyXTkzRrM52cWoKccfFALnuagL
         YDyOC2tKSzKYIg0NIfgTkycOb5W5P74ipx0DqLA6IytyXL7B+L6Rem/6kmYsG82Ms8x2
         ew62FjR3yQAZvlTaHKEJLlUZmKudBNeW0oqkvmkEVdJae7uyehIR6cMXfh6byuNWCyLy
         TxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773138002; x=1773742802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xK7UBllLwsfyVBP7rppLjdLPdGs5UskxvKVTbdCf2Dw=;
        b=m3UN7gbGHuqatEHys6lkm5IVy+38ibdbG8Sxzkp0maNWWdie2oonWBhdfcXnmZjuC4
         CWhqT+Sm9WKMFwGSXxNkdqinsIt/IiKrmCohQGNiJnPAu5KXQaMk01Kp9BXjx65XfrM0
         nqWSfY7QuE3V7Bc7KosowhXp3yN6lubB/7njVtsv7uSBdf/wrtZTrbho4dOVP398MqQW
         DYibRkpwQYWwE0uFsrP1o//N3s1TiQXu5bd+qEqdr+sogzB7/CBcaFjrQtGKjfFw7mot
         9lTOd1o8ekhiuU30kVTJNSZnWFtkNCLV8BkpBv9pKwd6gPK5vSY5G19WX5dXyn9luNnw
         /qRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFLiElkPh+BGNo6Sg/qp/90OCpA0fc2lts9ZGfHM9YJ9bFOje/stZXcHBL6SgN7p3x3jG6DE4h/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIfjiwACEeRvJWKih3QImx39A0po3aAC4Dyx6IScgeZTZj4Cca
	XaedR2YhShGJgzGbCRu+WV/pTn07qKlpn9ZX22y0wkemAzTrRYd+nzPNP+9ivuP7HP18eqVOgF4
	VDcOYpBbBonNT6NNrSsnCRJsXlghtEa+grBL5zhbiHOxcSDcFZP1BMXfuakWamw==
X-Gm-Gg: ATEYQzzCQ9ktocV0B/z9BZD9mD4J3sGbytQvWiQDBSvyJoGRrfGOjfHQxAAUK7DZLZO
	0XvlfdyFtv/WbOyoTKrem1NOjaGlowoRA7gMLSMoltoBjDnmzF/9OSgkqEjuPY8UBut9R8JpolP
	VfkO1vyi8+VzA4vYtGzHWhQJIRpqORzip/lW1OtKC+Az4l0yUg17GSYWHDKrdx1cqHbR/FIZ28c
	wNUlycoVzEntToHGmTOu3zvSsB4UZ8bfPC9n7BeBlOu7iOqv2U8N6oP0ERJ9DsTRd4mH3Q3egTv
	MK7VhjYWiZg3ACU5dR2WvmJCBimmaNkPd4CcVRi034N+nsGGNI1cNdmkubdcNeKko6nMUKmdxvs
	Tsk7VxiM5/6iUzc1Ptnx0IFmDmTKoHbHTA05S6EJJPBHYrEF8ov4tB92XDxKGfdCcAJWZ6rAq67
	MyMaDwhlvL
X-Received: by 2002:a05:620a:480c:b0:8cb:3288:6777 with SMTP id af79cd13be357-8cd6d389730mr1713762385a.28.1773138002338;
        Tue, 10 Mar 2026 03:20:02 -0700 (PDT)
X-Received: by 2002:a05:620a:480c:b0:8cb:3288:6777 with SMTP id af79cd13be357-8cd6d389730mr1713759585a.28.1773138001935;
        Tue, 10 Mar 2026 03:20:01 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad977f8sm34581699f8f.9.2026.03.10.03.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 03:20:01 -0700 (PDT)
Message-ID: <1e64069f-e677-436c-ad62-0f3f26f01cc6@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 11:20:00 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/2] thermal: sprd: Fix temperature clamping in
 sprd_thm_temp_to_rawdata
To: Thorsten Blum <thorsten.blum@linux.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Freeman Liu <freeman.liu@unisoc.com>
Cc: stable@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260307102422.306055-1-thorsten.blum@linux.dev>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260307102422.306055-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA4OCBTYWx0ZWRfX8GYCSrqep89A
 K78vPCCe3hC7JsEnuTg907VlfGqK+BBhmgV79ypb3C8ZXENrAyy9ZiBmOsRzwBY9ko1A+Ve+ozj
 Y/LU+Z4nVdig35xZ/zwiY0bNx9Ose3x5Lvg0cGvqRLDbYQyyP3ywMlOm65yCDp3v1SPRTTeeCve
 P6yHJJH/yScEst2QafV87pgRW9P3YC5vkJ8QcofGegwEEmWG74wfHjEKlQA7zj/7JeO024I9WSb
 p75Zf32QgW74T6RZolQOO9Qazj/Zsty6eGcnEUP/+gd+hGXLh3q9D+Hxv1+HQwL2e2H6Nivm5NY
 sUkcFhv9JZzafqO3e5Hkufk8leWh8dnjTyeEv2CbUtEPfVf7Mer/d+CcZ1G+ELH6qkUOZPg3+M8
 v4QBkD3g+bCWsNodGezhDNGuXjUv3P4Pi9VhVrhpPlGgr+0U6X3CIk2wuPdtdRpxUtTwx4/cF4b
 icM6lMYdO/FA7TEV2XQ==
X-Proofpoint-GUID: VNl018LEUoi50IN3Cci_paChcBGqY-cg
X-Authority-Analysis: v=2.4 cv=KLxXzVFo c=1 sm=1 tr=0 ts=69aff052 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=SRrdq9N9AAAA:8 a=l4XDqvM-JdByRFu37KQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: VNl018LEUoi50IN3Cci_paChcBGqY-cg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100088

On 3/7/26 11:24, Thorsten Blum wrote:
> The temperature was never clamped to SPRD_THM_TEMP_LOW or
> SPRD_THM_TEMP_HIGH because the return value of clamp() was not used. Fix
> this by assigning the clamped value to 'temp'.
> 
> Casting SPRD_THM_TEMP_LOW and SPRD_THM_TEMP_HIGH to int is also
> redundant and can be removed.
> 
> Fixes: 554fdbaf19b1 ("thermal: sprd: Add Spreadtrum thermal driver support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---

Applied, thanks !
