Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C608446849
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457347; cv=none; b=keQYit+y0TrWQCEE2hW33ikJUEQ9rn5+33gMvz1OLxFKxMjLkUhzmHQIOgoUx+ryMGUU/06qbgkzyrMcBFPLV3Yk87muRE7bLG+F2xZwjb8RPZNddiXPhGZfXuIGW7Ov5dtvNzshaX4Ja0smHuGQ6ncLtcHBxTSABdT4WGbWFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457347; c=relaxed/simple;
	bh=+Tkm6xyqPIAM94Y9fls4QttSRxVs1kEohQrzLAOcU/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuSS29BUQIRiB2ap88w5YJFVHfLLTfvIwIlqTMYahOvGP8dFeNftfmyI99WNRDdrGxQBrVqh5oG0CQ9sWClbjqpKdMGI/QIRrLdX0/S61IcmDuVnVhVkfXXKX/1Ay7O9LtCtmKBNq7CgeCv0UYndFFDCmCK0mhN7P5n16ffz0Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tl8k4JKt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kUC9zoOw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tl8k4JKt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kUC9zoOw"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWvFb766895
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YQ5sLUtEGdSUDuIMVQFtA5aC
	Da2Hzsxmztm/DUAhaGc=; b=Tl8k4JKtb0UJkTWKujhivPelS+34TUXdz4mI7IZK
	nIW/0uZW4IfkMfnDEsb4BGuNDGzNVtKoC83kzgggO/kvr90VFWDk5ZeIBlrHrHij
	yVnwlRFQb+p5Hg68HWUThEG4lyEdYzfIJZHnCmd4j3jmbX2Nd3aFC5v7+rCz4rbn
	lozy69sgXVOepJ/y2C0gLTNc5hXwuWmSE8UxqsUco33XQEG1++kqmY33T/Z2F5m5
	J2zaPqo0vgCXzEqY3Jjyf+QhUqCKn5vh/2N1jzpG60grHLxOlY0ynJAkJvbqXe94
	xt5gXNUrN5nV9tjv78ua0Caq6a6LXi+t6shlIU/l7uwSUQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g01q10ug5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:09:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0408254aso14065961cf.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786457345; x=1787062145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YQ5sLUtEGdSUDuIMVQFtA5aCDa2Hzsxmztm/DUAhaGc=;
        b=kUC9zoOwgsLPioSorQ+GlYad7mE6NgqWsHQu7ISoFMcVRsrdW5N6A50slxlmlUblIY
         8TuhsclqDWkI/pWg+Y1/z4C1wzYzQ7eUOwur3wK2TO2/btg/KgCWC8Ldc08rGZNpC6QI
         iHHjb1fwmp+6Yfd3MLnTL/w7VBMynIOVXco8a/U3Ak6nryq867/YVRGEJODJnDXhmynC
         eI+jcI+Jsg3VHEZj7tUAU6jSAQgkr3hRj8WsaL+FPuTfnQpfkrw/1To+6osOZSBuoN85
         E8FRoo6myDPqZ0vARBbMH/RV7o/ThAuIRZg/kWhbLol/0TPvxQG1XcdzbW4ibdkKgpCC
         pgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786457345; x=1787062145;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YQ5sLUtEGdSUDuIMVQFtA5aCDa2Hzsxmztm/DUAhaGc=;
        b=GUlLpA4E8R+ObgL/td5tu0rUF8hhcowIaz6BSZL6nmgDDCLVNhUpyrHAZH0NoJsQRz
         nwN35/A6K0Xj8k9LY3rC30WIEK9bdNg00dP15tmDqrvMPqVJreUujve+sJM9apbWTfpi
         XAU+y02CUA0bWQEr/JVHkWF1e1qOrvBSzL+SdnIXWoTxwtP6GLH+7k3+Pr75aKOLqjxF
         o9zUlpoHmDSF7J15qnrdT/muNz9Ku87ZdNop017Z7da/H2cofbSX/F7y0lM4JQBo+EU/
         nPD1v2k/Niws4zAuifjFA93UtjO0171vCYz5vtIkxP7LHmLWV+YiWFNKVNL5pQFIltQN
         dhyg==
X-Forwarded-Encrypted: i=1; AHgh+Rq39CCemavYMQXl0EjSvM2vwNwMuS+YtmRpWh/ONe9NlpID2NY7FTYAqUmnNAp70KmOfYbSXiAKMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiAKjdSj3bJGJzsTn0UgGSTi5xronvKs+Z6EaA9LRmeoxdIAEO
	s+igmlbxy8boV/2rX3Ac8tEFTcPX+SZIz85e8HWQK8pHBeY9xUzdt0sEKCW0HP+XtCd2VQKSOZX
	+vCQx4aAFi/H071E5DsEQEWI9nnSIdX3QzmTxHRazsZOxHJfSiWoK6VR/9QQAtw==
X-Gm-Gg: AR+sD11u1LLv9E69XFHSafuZM/Bf2/lhO6IYHzTkrCFcTA9x7S3zxTVJt3D3cV9iCEZ
	FOodkrd+kDPUPX2FlvN8pe/vrYVWuXfuwXcR/7GW8QWFxTqW90C7XoL13q1ke5+6Y7mRg9FwguJ
	R9dOmjvXwdMszjboL3QDLNZZres6R07YyCGGkt4b8lN/m5gzS25D5tbDiK7ZNpJcLHekIz7F2mm
	UF/L2T1x7xi/u7AITOnZ9fukdW7y+SQLL1Z9MlNvKmBkgBsO/HS7R9cfDFo7sRr7j65BMdK5hWI
	AjgA28j7/iH8TQAtGlFkim52a6bCNXr+UPv1CwluWd9+JTK4llfRKuvdpm8xo6dqY7xk3PyYrpp
	1pHIH2MxsGqqI6LEla5NqNg99TRHglYff3p2SaIp2Npx4GM3EYINA1tPLWzCPuBd8x9gaqSndjg
	oCmFk1YKki6cXMqg==
X-Received: by 2002:ac8:7f0b:0:b0:527:7756:3ee9 with SMTP id d75a77b69052e-52d60051c2dmr5617591cf.0.1786457344493;
        Tue, 11 Aug 2026 07:09:04 -0700 (PDT)
X-Received: by 2002:ac8:7f0b:0:b0:527:7756:3ee9 with SMTP id d75a77b69052e-52d60051c2dmr5616501cf.0.1786457343967;
        Tue, 11 Aug 2026 07:09:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a0fa6e0cb9sm3037801fa.39.2026.08.11.07.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:09:02 -0700 (PDT)
Date: Tue, 11 Aug 2026 17:09:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Taniya Das <taniya.das@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wangao Wang <wangao.wang@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: Add missing MXC and MMCX power
 domains for Eliza
Message-ID: <wcmnmidvbgfr2zmkb7vs7rhrwrxutca3lbfd2xb4llzfqqv7w6@bzddrstbb2xd>
References: <20260810-pmdomain-add-missing-mxc-mmcx-on-eliza-v1-1-5e10fad1e456@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-pmdomain-add-missing-mxc-mmcx-on-eliza-v1-1-5e10fad1e456@oss.qualcomm.com>
X-Proofpoint-GUID: 2_5KcGbjAR1jkGdeBhqR8l0aqJWzEIJq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExOCBTYWx0ZWRfX7eas5+O73b9a
 JMPvoHALXKSz4cbBdbjGwYINbOQ1ho/ZvZdvGsUmlwE48eaj3nfBuLBH50u73Nxsm5SLJKk/tv9
 qjo3tzTIcQLesuVKlE1B5+BJvbio2bK9K0F7jSsSS6QvAPVqnmH+t4+o754gjszsytWy4G4LxjY
 BSXvoLBzeqOtUNRQKzG3Hnrc44XVfbldofky6F36aimFB+CFC/y9wLEebcJv1EeA6TcjsWcmyd+
 kBlbmYsbHZ5Gt1ghL988tWDGwJJRBl4pOtyOTljXpJg6l8ZlWfq5iXIPIFwShN6qWje5lu6zFZ8
 Y17/nKw5tB70c2QNorFyeV27tESqSlSENE3d3URCXDJ+3AJKOjjtNFkpUwjvj2mFMZORh5IeOp7
 tY3B4DCl3eYvxXw6hZwrVfH+aQytiZh8RbgSZp4p5N+Tmu0LTS+IZUIvSzJMgKPOGM4rneOZ5q6
 09D6S7a7sjk79o0cwWQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExOCBTYWx0ZWRfXyjJ0lkhjkLJI
 8YBLrHGLNCOGpwc89pPotxSe8ta4Y35+HTccDX8ab7aBcw3jXPt+JJ74PFRotT4JJJYKfAf6ZQx
 BOkGGkgY4mC1usEOh9HD8e383/DtgqI=
X-Proofpoint-ORIG-GUID: 2_5KcGbjAR1jkGdeBhqR8l0aqJWzEIJq
X-Authority-Analysis: v=2.4 cv=brt8wkai c=1 sm=1 tr=0 ts=6a7b2d01 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=ZBvaiP2Ty9m7IjM8UroA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110118

On Mon, Aug 10, 2026 at 02:10:38PM +0300, Abel Vesa wrote:
> MXC and MMCX were initially omitted as they were believed to have no
> consumers, and they were not present downstream either.
> 
> The Iris video codec requires these power domains, so add MXC and MMCX
> along with the MXC_AO and MMCX_AO.

Is the display completely sitting in the MX domain?

> 
> Fixes: f387ecdd492f ("pmdomain: qcom: rpmhpd: Add Eliza RPMh Power Domains")
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 4 ++++
>  1 file changed, 4 insertions(+)

-- 
With best wishes
Dmitry
