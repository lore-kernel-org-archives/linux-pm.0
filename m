Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5B53C9EE5
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776881829; cv=none; b=N17ZiG0d4BJ57Hue0NUN0QxL/rewCcMkJqCuuXo2RyCPOvKCEEOv/jwA7kAVs9MbxwkFw9X/YhqsSq1c5cta7y8/+UrXbbchTrMTzVz0CM+kOo7b+OQjvYOsq7Mi3LrXPV1Lwgtef46TULNqyRdxgqQuTvEvdINyD+7Ds9i/jrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776881829; c=relaxed/simple;
	bh=QyxMpCXkdpo86Mw+3CM5Tn7kWJdhDyrON+s2e71h77s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pv//l9713Kf5Hhbefmw+IOZCR49G3vWM4ZP+kTG/pqNKzUek/mJpP10Yx2L8FX7P6zu+69E5VzdZep9kshvcCfZKb7MhrB+qBUDAKkWdABT9AMryyfvoJjs/qpTsKz4c1SHT7qGoSmemUREEAtMEYtZv1ktQJjKO8woSTRs48Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VRPn90qy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ms//ljRj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VRPn90qy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ms//ljRj"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MG6UQb872657
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 18:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3YNyozOmqbEWs49NxHPxfWO/
	ujoEQ7C37uXS00Jnihw=; b=VRPn90qytWGlVt/ltNShAODhvWuMMc6rebbTc+/T
	213b1Jj66nBkjNuGs1RRre26wsGSO5BKyTjoGKv0+SHJlR+ZEl971rD35F8xl5j6
	ppbg7QFNWmmEPLY8KQHRqzfIpMSmwXDnRSl2yslXlks4sOSaStpRSTKMW94htIDT
	W96igmX3GHpKRYxpnyiPy46dnJ6hWXJVPSnPRo9Y/NT3RjNv7yv/aFB3Ytm+r0od
	MLNJH/Q/wjdHLx2aOjqRJolgsin34NDFCXVAXg8vl5pOvt26nUcREux2bKJKBY2i
	nfl28ABWPjVnLdzsj5hprWg0BVmmo0mmrJRGYfuJu2J7fw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1jh0fac-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 18:17:07 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6101726c594so2701012137.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 11:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776881827; x=1777486627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3YNyozOmqbEWs49NxHPxfWO/ujoEQ7C37uXS00Jnihw=;
        b=Ms//ljRj0x2kWiqNFWeZfJMRuHokAizED/0QQUs/jUFfdALossGjMBpTdRXyhEc1ur
         BuqV4jsETs2ibie2KOUNE5NHlAZT5p45m6YMb+4dHHsAR0Rcbbcl8RF7zlMxKTl/87II
         OmWV34iS89+1S23cXKiQ65y0q5ZNJ3Wl6uA7RSu4qGshp4Fi9VxwTi/srRSz5woF8fyp
         IBa2iPkeauaRYNivtHJwcFuuyieUA38BMruHrhGUAg2zE09Y3pjkFLWEA7JPo8zJiv16
         KSzX0poCRteAEs/9Vgpm+3G7aodgRLl/A5O+ZaB3G5PI4XTOZOTBdABQmGMbG9j6iaUO
         QDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776881827; x=1777486627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YNyozOmqbEWs49NxHPxfWO/ujoEQ7C37uXS00Jnihw=;
        b=J9o+N8OGF/FwS8Z/tuYv0ifPzVlrw/s/cTtIAlV0VboF/19YRV8kbkRkrRUP1lA5Wy
         xTGwUdBv7jQ0icN1pyCsh9G9JXJxuyCbOBcMhBtN+51i21Apyq6Xab/MiZy58Dr48h0V
         1aIkIbqH1jRoliGQwrRhknlIAQ15dBqyapr7H5sylYKU4W6PpXJyvwxssdXcoII/NVEY
         SW44uEU4m0xc73Qsirzqi9lIaglbe1OCOx6wWLr/xx7N7ILfyTCZbNLiGwGlLFN2iRR3
         aYZM2SHToEONKXg8dbBSPE3cyh092A7wDkVfVQ0sNgry/rPe9st36Ne/qg8EdgutiOey
         CPdA==
X-Forwarded-Encrypted: i=1; AFNElJ/0eY0FmOkheUpMN0wmO2n9mqKJRI3DeN9LTVwL3KBWjrkuE8HPF8VPPRRC7ndddZFBwK0zpJZJnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkL6521DXXub7HSexJkbePBGOJyF1CmW9ne6U6xCL+uTUjFhze
	1yk0v2X6N83tJvV6s+EHm3F6pKwnP/cb/P9sz7Zo0DZHHT4np/5iPoz6rATxlfyJ5KyK6tN6ksU
	L1Le8xiEM9TRKnMdpMrDE+r3LgEmvDl5aOVO8zH3tOCN29JfBEhm/JqsUJzwdeQ==
X-Gm-Gg: AeBDieuQcAQ5f/68Pw4w36zYSeM8CEXWfijcUKnX13CobcBp5bOJ+npzo3xPvUOj9n5
	7tpQbl+kwlmdj+rDn1D+YxdV4cXZWQC7PXZxeuCJ5UbJ5jaHBhw2uThruY4GM/hFNISacHGaFT3
	PnCF2IYpBCP86Xek/4EORB5izXmhoapMKvfTYEVoppQeWhBtOonPXNzbWRyUKqYs7NpNf3fUFf0
	q/O0HkwAQrYc67GwxkBTVeaLgVf+yUOieTf58AvWFX2P0NtE4Muzvqm/B7lRPNfJZXSelBb5TIv
	wU1hiQSLunmgceulmUPjsJsrejOhvrKvniqxKpZivtQdyhn4G0jp6r43YAXi7wIi9HHVI10Ppqt
	RUIO7xHpFS2HXJPAQ//Yim/CC9TgFjbiPhDC4wfCNib9fEJnEI+av60wkStfmyUpVg/Ad9Ebkuu
	UXa7BFj1mljiYHYSTVqbMB3vx1FdlBB1zf2mPEVKMj7qXfsg==
X-Received: by 2002:a05:6102:3a11:b0:608:94e3:bd89 with SMTP id ada2fe7eead31-616f5eb9cd4mr10922051137.1.1776881826210;
        Wed, 22 Apr 2026 11:17:06 -0700 (PDT)
X-Received: by 2002:a05:6102:3a11:b0:608:94e3:bd89 with SMTP id ada2fe7eead31-616f5eb9cd4mr10921842137.1.1776881824146;
        Wed, 22 Apr 2026 11:17:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb4f51a7sm37631051fa.7.2026.04.22.11.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 11:17:03 -0700 (PDT)
Date: Wed, 22 Apr 2026 21:17:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 11/12] Bluetooth: hci_qca: Check whether the M.2 UART
 interface is fixed or not
Message-ID: <e4h36co4ein4mqvqempmrvjhfbgx6cxwjvdcsfhkz73qnkw75j@dceeamd65gl5>
References: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com>
 <20260422-pwrseq-m2-bt-v1-11-720d02545a64@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-pwrseq-m2-bt-v1-11-720d02545a64@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE3NyBTYWx0ZWRfX/wszQ6ytd1aj
 grQbSEl0+Ny3mIWpki6IIDsREpmwqCQPq/vV1nvDwTfzWFy66oRAWx9r99UZ6hlPH9fm0j1xsdq
 2yzWBR7baJF1kC4XeqnKQ056KUN/uXzo+5jS7m/c+/I+fRo87yPf3j7QmZ+DkR1HCpio2KTKDD2
 DmSd2YvAA87QTCC83kOH+Kfke1mjsHqoqxhq/sqmsFI1bYamXD5uP1ffxZecFPZMeuOCkWlS9je
 5x3xCSPboiO83SqPxGJrqzz44wAgFe8rl6PGhnxbeeL46Rqfuu2uglredwsfjkpPUf2neoLapjx
 L05zdPmDz2aEbX8SaIMTF7RlcyEOt65Mp1B4aBlRoT7zUh5B16GHZFaTZXBZR45mjvL2YfFDDRc
 6DH0z4hHDQPx2yMwnNNjAh1rXykFape8Dr3ihiKi6FWd2x8hBs9yMIPL3NeiBEmqOKAsA8wq6Jt
 uuwGAy/YGZwTUntFicQ==
X-Authority-Analysis: v=2.4 cv=OeyoyBTY c=1 sm=1 tr=0 ts=69e910a3 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=rMrwSXHligAysd2ZAJkA:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: 209rqeC1SuV-bbbiDE2GTBLV02vPuN_S
X-Proofpoint-ORIG-GUID: 209rqeC1SuV-bbbiDE2GTBLV02vPuN_S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220177

On Wed, Apr 22, 2026 at 04:54:52PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> In the M.2 connector, the UART interface is controlled through the
> W_DISABLE2# signal. But the BT driver cannot know directly whether this
> signal is available or not.
> 
> Hence, use the new pwrseq API 'pwrseq_is_fixed()' to check whether the UART
> interface on the M.2 connector is fixed or controllable and set the
> 'bt_en_available' flag accordingly.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
