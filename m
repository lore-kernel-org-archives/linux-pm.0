Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37FD38C41C
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261961; cv=none; b=mTsmU97gqpkjQwwyRD9UwiyyOCzoRm7fbftUMF+lbGrfrVpwcqt7OFwucKPycts21Is5ubYfVXZh7MatrwxX4yGvbmmen7o+Jccqlm/a3qm+g9eztax29/B5lLorxPh6XzLjo78lvss1jlhfHYU2n7AQMZhWjxciEYCE1bWQcFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261961; c=relaxed/simple;
	bh=M9TJbC20ZbjsQ2ZRYaguu9GU4i3XzOcSMPck1zZ4W4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVVWHVos+Af9qbKNFYDHQwf0hAJ9DB35fxP3RvneBKLEPljYZ4oqxhNEMKoz8FOkaJGvJqS1sTGvKjjoiRGdh51lqq1mFowI6GnEdoXMuXqTolf7g4+VbFGqstacBOxn1xP9dTLjyN+Gu9WMgV9me8jdQsUNKhyPZ3mlLBCnyoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HywpP8bt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H13sx/of; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HywpP8bt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H13sx/of"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NA1uQB1750375
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M9TJbC20ZbjsQ2ZRYaguu9GU4i3XzOcSMPck1zZ4W4g=; b=HywpP8btK/xv9IMp
	e13zKGeSbBSNZ7EZni+TmkdOK3B3T5zR1r2y03vLSejCIlW6Qy2ME7xX7muy2xZy
	chA+b0H54TV/znQ7CvWGkQFoXj1R23YnUFR6fDZ1MsK77cOYYuGynCI9OZRdHkGs
	4SSm9r0A1Q7GAMX7fMkKAoGd6YQfmuteBBLQakEfXtTIbRfeAnADKERcNU3CkRvn
	xYx7/a8SpQ9tPe4XW8QU3sRNENWtRy6ilUYtFubSG79w386V/JmZuGSZlG3Z625z
	7bJFgi7H05uIfGRV+Fb2/UELSMv5IraYkj0WjTfxt5dGzvW9Z/bz5Akb17xUvtHT
	J1zt9A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jng4ycf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:32:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5073ed1ec6fso40624451cf.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 03:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774261957; x=1774866757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M9TJbC20ZbjsQ2ZRYaguu9GU4i3XzOcSMPck1zZ4W4g=;
        b=H13sx/of/oe60SSqXsXGRFQiNuJqjPMK4s6A7wRmsUXX5BaNpZfxCdkcIa+xnw0FOc
         mLfIA264II3sOToDIjexKOQOVVPYYqw7zN4gJ8onjSuCdf0p/IZe/WFSXOuMJRqATcB4
         JItM7AMXtOVwe75kB44ZkPBP8ZOWgGTFSVhessnP9gPR1wAJj0hUJdNp+ajAfoP1x0u0
         ajVtK4HuchVJ4fTUuODg6bGFWW+gp+Iwj9u5IJDIrB3ll71CS8jbi6JgSdBODzCOdmXr
         WJQoY01mrj64ceCkrBSJlnhpP6FMLtI1Ijv47T64frXGHr+X/lEztukhgNK6mu4Shxrc
         UIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774261957; x=1774866757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9TJbC20ZbjsQ2ZRYaguu9GU4i3XzOcSMPck1zZ4W4g=;
        b=ZGC5V8Idy3dqwkgu3zNxqXWIvZvtFeuIlh8bVH6THjQ+z3imVuZp44KFkziAh30VJY
         MWiADknIjsXTOAJErKIYhN+YkgnPoOPN1kumgScczKhPBUUY+iCButiTf6gboIf8X2Uw
         YmioRlNhmdJqIOhP5sNePAEv+JC2nxzp7OzajmuV9Tl/pOMn9yps+jZS3duQO6WERiuq
         jMWzQltSh0juyO07W7yfIcZ+H+l9SwY7JXJJqaZro2JPhREjlieNjGlsL8a77FlH7Mmb
         83G8yg31GYusV/FiN8RKQCdsT7BPFmNyxr0KUPc/I5fEXOl4T8m+Y4mSlaJkJMyFAPVC
         /DzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTBEwjBnPTmshAYXvWxMjqVIZv+F3LUbTGwNXWvIqf/vupLgO/3EW/gWGYJJ5mkmKTiaT5vqlDVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1QhIryNm9SN4MmXc+8tMXgsmddBLfRqI1wL1llX0Q6bv3BgnO
	V4dDNMmYzUwCBIoCFxL6SpUXzleg8Xr58+acWKvuPcZKW4Yc+hI1i29dWKkzd7kaV1im2ztCFFx
	1DQF1U8AEE8W1QXox13ASLGAooOPQAwoZx4qfs0O2O7MAvYVKvZXeJk/kIGBuCTfmYGRukQ==
X-Gm-Gg: ATEYQzzOl1L0YFNrv/ea/WLkMC+A+AP/QUtaEtLl1AmUBcHffYqaU57owC1PubujOfw
	eSogluup6HOqCnokrBufWSIJg+vn0fU+Jeva+qZAVCaDlWIejWdyvvsa8EdCzQ5CDdQpbGfAjE0
	xd5YeCjc27NXSiZVVIhDtKxlwfzkfOJ9PhvYcENk/yDHTLa5mReSmiicOQJWDoR6sFur5Wjoo8G
	P0vzfXCF29XNeADOfFq4lQnB5oih3bqKDbpYHkJ0WW0B+nILSCvBwaIVgcea0jRM4fxcMX4k9Q9
	xmND9cJ5ErCK4dKuOyfYOAL5OXk3Li59sPPprNzbZ7O4k4+fyhTEoNteLlth3CvQG50Zh9T4RQX
	qIky0+kMSB40C6fpopFqdEotnqAFWk7AwB5aWp0B4sDVmWseGNdywBaNZiET0zYr+8etZjk59gr
	7JsLo=
X-Received: by 2002:ac8:7fcc:0:b0:509:9d9:e19c with SMTP id d75a77b69052e-50b3739034cmr137127701cf.1.1774261956738;
        Mon, 23 Mar 2026 03:32:36 -0700 (PDT)
X-Received: by 2002:ac8:7fcc:0:b0:509:9d9:e19c with SMTP id d75a77b69052e-50b3739034cmr137127491cf.1.1774261956354;
        Mon, 23 Mar 2026 03:32:36 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f8ef74sm467617766b.25.2026.03.23.03.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 03:32:35 -0700 (PDT)
Message-ID: <abb14718-3d94-426a-a0f0-d101470951ad@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 11:32:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] interconnect: qcom: icc-rpm: allow overwriting get_bw
 callback
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss
 <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
 <20260323-msm8974-icc-v1-4-7892b8d5f2ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260323-msm8974-icc-v1-4-7892b8d5f2ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: --tCo22vO--MWx1eiNJ-1lEyiRg-wQ4g
X-Authority-Analysis: v=2.4 cv=Q63fIo2a c=1 sm=1 tr=0 ts=69c116c5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=0-7ZaTWUpwkl6A8NQQIA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: --tCo22vO--MWx1eiNJ-1lEyiRg-wQ4g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MSBTYWx0ZWRfXzWjJZkMBPVvH
 D6Y+TmspKB3wHe2nIFi2YH10KVsC4W+IkIskFGTA973PBQjoWvn9f4mHiwKp+TwfVf0uXqQpkV+
 kg5edrITVGgDHTEbPTcoKsBRwfUbzxb5bHa5V8Er4dIYLAptB699dmWV6swjjDNmQna8jnDfL81
 Vxl3Rr6JwEBxm7U9WfOIzdtSSpFbRaY/4a//BofIBF3uIFQJX6XtcgaVIpxbUBO+ECs6dxqBkE6
 0w9BrEEgJJxrUx02avk6F7nJmyIi5MPTyanHHRgEKfP2xVfnEEi2iGJShVPgsbkB/UtsFI/p83c
 GasjbvS7l0fFOHFQ7CEdCBdbmKD85QFILM/JzqG2YSg2Q8iv+lKGkimhhAri1fhTLsfQrUEgOBe
 uwdigSCwR2lVWl+o4gU1n+V4T6Dp6VSxRXffcVHSuDqe4qK1edBiUBdgMTmLusm0W558PP9VTg2
 TJMdHofSZFTcHXjVYHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230081

On 3/23/26 2:17 AM, Dmitry Baryshkov wrote:
> MSM8974 requires a separate get_bw callback, since on that platform
> increasing the clock rate for some of the NoCs during boot may lead to
> hangs. For the details see commit 9caf2d956cfa ("interconnect: qcom:
> msm8974: Don't boost the NoC rate during boot").

Is there a single specific bus where this causes an issue, or is
setting *any* resource to INT_MAX problematic?

Konrad
