Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5113E92B5
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775043089; cv=none; b=ufAUNQFGQx7OX6WjGY5l+jnCGk87OXhuYU0IhnztcbJV1cJL8IclGBpPQ8L47bGbsFlV0bDhxznFwJtketByFcLhhpDF38itscEQ/KgCsC+XJ+7vpL6MVDkldqT0K/EyIX/wv1urgHbAENtdALF/Pc1AwP5tUBik0qnILO51TE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775043089; c=relaxed/simple;
	bh=bH6OQWW033078M+pZnkDl3K24EuiMHMTgn97RT/t8+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZD4UN3Hages8y5eokR1slfQd5eaUgfE6eG4YWNAD/9crtLF8xsQnKWNMI1JnCZUCMfYaZGXyj8nd2nGA8H2C1w1WxlO/eKB/pO8CVIpdvp/BgcB8n0N92zFsd0U38C+WDrPctSmGeDJyIw9K8Gr0Uf6cJ/A+UF82uZDTBYm2jts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SZVe+tEl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iiIueIrE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SZVe+tEl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iiIueIrE"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6317ErFW4106751
	for <linux-pm@vger.kernel.org>; Wed, 1 Apr 2026 11:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=r9608+SJx12/aq/uDZkF0WxK
	S1uDQHU8MsIx6PAq+Qw=; b=SZVe+tElXLPC6t6CEdiHx0F3EtRADm7qBjzCA5Gp
	W5+k65g/kH4SrNUeQel2hjCIma3vAV8nroVIdlIJBOLPKGwhlXt9ECgkkjmes/Ch
	MmeonhaI85mNJVPgyd85Q56SPyYC6AHNXRXW1LgE26cwy1E/bDHwphwOzxc2ifWs
	Q28tnDAy+OA7ccOO02uX+6WK8pvw4VEMEeIsUtz7j5kCOYu5UPvLUOtOCTkD21kO
	LFoDrTK2s/JZ1LSx4ma/f+1fKYU3wc+KGUrU+ojGQk7LgzXDoZn/NxLEV9X1O3/1
	fDkGnCzhGbC72osDKAwvdbLvTpGVtF9dAPoMUhZWacYLkg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8xt911cp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 11:31:26 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56d817b03a8so1067664e0c.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 04:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775043085; x=1775647885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9608+SJx12/aq/uDZkF0WxKS1uDQHU8MsIx6PAq+Qw=;
        b=iiIueIrEbmStqfJ1vFHHSup9Q0WZlNG37nVYwFKJgvDeL5ErX7E8+EoijfT4ZD3KXJ
         9S/qCJsiSJf8Ywx41zkfdU7JwpHR1JYOoqUvxPyDyMHqFc3twRD8HCuksUYUFNhmPD4+
         /SGa81CmRlp2oZbcAb16oViVCPw96oYUlgE1RWHZrvmw4yAhwrcbpjLTGvPYeW1rnblb
         MwZi3qv8/aOWdhidI5hOyDoECS3uCvDZkB6jmEjENwFU65hR8u3cUkyQjRDf1wJVwVjK
         u8eR3wG8212xDU1zWIhUimNtbyrhwxT88fOXJxqLv8dxbKSmx+6Q6ygQfdhh0BqzLfJV
         tYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775043085; x=1775647885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9608+SJx12/aq/uDZkF0WxKS1uDQHU8MsIx6PAq+Qw=;
        b=UDq7wHUSNikehpt1gvEeQVgkJqd5x+7cJifuEWgfkgNH9qeWhlzq/lUDE+mXx0KQuW
         hPFKZREYUa1iCK1pD5pj/MlNDXa+qwxotbCsecs0T0BCu6DHxIHvTuPAqUAAGKrp3iXe
         UWIISdaKSYT6FfdtMb3rkvO39TSZdTS0qmhBjh4bSPhsIsG+eORxKy8DCSLHyhx8G5KN
         IJmEevIeOzlJLuf1Ak1FDsuL8ypA2RyqNeP5mGJskiNxr4cXEyhxIILL9m++mIoOAbki
         t+ZrrFlxT2QorKEar9XA7CAIcGktppmIJxbmW3FyeubKBqj/KdFrDr20Ax1DEizNlWUX
         a/tg==
X-Forwarded-Encrypted: i=1; AJvYcCUM8m/6OiRPYlNNGWcYPTv7Wk6P5nkJGS4IljcCwX/2XJnw4lhXv77Y9RVYziiiNkhZG1rvQd2Xpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWk75o+6rfgHHacHZpgNla6FiZA0fRK3gMwS9jlA0upBW17nDX
	xKvsNMAnpq0H3GkmvwpeXZ9vTaf/BKorbiZgIvnpWaFJV2fr5a/lvpE0lhpx6UDU0QS/xaf/y1y
	hobrSj0QVKjqQEiErKZc6fnATtnQzuvfvCWisGTBBJvkA/Tb9do2tLEowwQdy8w==
X-Gm-Gg: ATEYQzxfgujS6EnIJEORt1BqT3uJi7j7PV2xEQyAtRaLbDZD1dBGmRuygaNpApn3Nat
	q3fQT2ho3GMicZXVsX8JhcvTAKJ6CKsKDf4Lh8zH84ONKZsUBI1VD04jMM2skRC+1pUogls3QEr
	ltXIoN/gcb1Q2n5WqyuDvT5VN01OH22VnX7xxpmmiDZreMAbazFeoRW11HZC5yoQSYuWehmp8Oo
	sHsNZWJFMVColv6fWpoTZ+UuSB6sdR/SfyBXe+jS/qxkM6+YMehkl3cOsGoDV5DuzTASu5HB9Oa
	7RZirv95WxrW82vv4B1RzGuBImy8Q6gm9U75w7JMsWa/jWQmXUTnMoHZjt8yn4B4z/AelRCi7J5
	SsTSiawtTUYLMd7FKOL2Ah18V+11xaO0RCzpRGfSwTaSZ3a/viIhpcIChQdtRsK7ZSJWC317ZUU
	prvr/Y8+yueMETJFr/EDoaGXZwW70ZBBlX0o4=
X-Received: by 2002:a05:6102:c13:b0:605:6650:465c with SMTP id ada2fe7eead31-60567e07604mr941875137.13.1775043085469;
        Wed, 01 Apr 2026 04:31:25 -0700 (PDT)
X-Received: by 2002:a05:6102:c13:b0:605:6650:465c with SMTP id ada2fe7eead31-60567e07604mr941849137.13.1775043085052;
        Wed, 01 Apr 2026 04:31:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38c836d4381sm29415461fa.2.2026.04.01.04.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 04:31:23 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:31:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@oss.qualcomm.com
Subject: Re: [PATCH 3/3] pmdomain: qcom: rpmhpd: Add power domains for Hawi
 SoC
Message-ID: <ht2vvduvxvz3s36cn5m54hv3zon7qelrgat3tnykfvqi7f56fd@t24kmaliap5l>
References: <20260401-haw-rpmhpd-v1-0-c830c79ed8f9@oss.qualcomm.com>
 <20260401-haw-rpmhpd-v1-3-c830c79ed8f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-haw-rpmhpd-v1-3-c830c79ed8f9@oss.qualcomm.com>
X-Proofpoint-GUID: 9Uv98_HYmy_r6QzUvj_k9uYQ-daTH4Ii
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEwNiBTYWx0ZWRfX8Z/ZGTiDqNHn
 hfnzoFYeZ2Hrxtf+zPrgqkZcabp6W/ggyFSLAsKuR/EpdCaURT+RtyBViKgkJtIiOJMBJpdC0O5
 tM6floms/iKYy+UVXXB0GfVw3CA2ZqTD0KL0FN1Vx+zwAicrTH0n4955tf2e3UXHnYfT0WjTpBz
 +2f0aEuCR+6HlW7tjNiQuSP7isSwIPJcQLnF+dfwRVkdccDA/t0+QuQ+B6Z4iLjcVQRqg6G5Fnu
 Ed40XKDyiQXfxwKLW1B0rBS2oG7vrb6MPdWa+uPknXWAtMF7k0DaxR26T13L2DrTlvCbJSosvci
 oJzUM5qTxZZYjYolCqeeZgcBpVZclfLGZqLCGwEDFljLtEzjH91P8amfWJpSUGYOduM1z+stXbX
 ECPjGZVJdZYunOSmi0ofgcM2t3HBIh8Q2DGsjce7VHAQnXiGI/sR778eZcKqzT5F/cCYoyl3Kgr
 e5vCComaYQlxp7c9RZQ==
X-Proofpoint-ORIG-GUID: 9Uv98_HYmy_r6QzUvj_k9uYQ-daTH4Ii
X-Authority-Analysis: v=2.4 cv=PoGergM3 c=1 sm=1 tr=0 ts=69cd020e cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=bf-_WMFNrYAB6uAn52kA:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010106

On Wed, Apr 01, 2026 at 02:15:31AM -0700, Fenglin Wu wrote:
> Add the RPMh power domains required for the Hawi SoC. This includes
> new definitions for domains supplying specific hardware components:
> - DCX: supplies VDD_DISP
> - GBX: supplies VDD_GFX_BX
> 
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> +	[RPMHPD_LCX] = &lcx,
> +	[RPMHPD_LMX] = &lmx,
> +	[RPMHPD_MMCX] = &mmcx,
> +	[RPMHPD_MMCX_AO] = &mmcx_ao,

So, should it be just mmcx or mmcx_w_cx_parent ?

> +	[RPMHPD_MX] = &mx,
> +	[RPMHPD_MX_AO] = &mx_ao,

-- 
With best wishes
Dmitry
