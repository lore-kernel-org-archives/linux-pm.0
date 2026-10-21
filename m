Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581923;
	b=gie0Rt9OCOCtblrEeZs1eHkJtpzsok5blSSDK+dAh/CLelAzQ4mbRPVAdWcTATAAWUBE
	 5pDTaq9ZUiEHgUfxOj+GgxeIUXAiE3CT1GErzzKu8glhfvT4CnfSGLbNAZEXixk1t3FXf
	 fN6jZWwxaXwW9w0argN8f5TwLAqPZ2GVUiy7+N7tVwuckKtlaQ3RKHXPH6SOy/hBc74JY
	 HgdMbQvtGAbxogGJuUSC7mt/x3FUgUwI4CY2nStmmOamsW1E9Cj1CPHTFO9DfzvV62Xwh
	 aX9ymQsOhbeR32xCd3n6EaBkf1oZ6ECt7ME+wpSIKoVuKJU8XLIgOhHIyMo1wbRUjYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581923;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XsKx229A2cLUh6PDcfG9nagyZ9GT3vCswf9ByNtPLGE=;
	b=lSAuHNp1aFKz4pJvWZWE8qVl7dQi8r6vViP+XpOHeR5gX+JcGBWBKI7hPXqNjx/h2bFk
	 YRvYplk4A28ly0G+akz3AzKeunmCEt4GgppsDXHSoJfqxn6LryO6/kO41NZi7ce8zhL/j
	 lPX+stXCbWtUoEB7+6JmnP6XiWjmYGcNw+uA4kgeDOI6jhUU/CB9euE2QbBqH5ye+JIzX
	 pZVUejzKQOO/HuCQnDOhY9HhHQcYwHjGzYDjwc5tbu3ZGwwRAQYuSapmDqiwERMi9NV2l
	 ft3424VqwDmT7rO9sr/DFggW86T9ZFKnurnzJQNI7ppEOul1+RZSsEUI3y2GvRNIlYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fyeI7m3X;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K84mtt7n;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A990C60A260D
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 11:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A990C60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fyeI7m3X;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K84mtt7n
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LAJYxZ1422191
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 11:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XsKx229A2cLUh6PDcfG9nagy
	Z9GT3vCswf9ByNtPLGE=; b=fyeI7m3XgCeXBBvm9Lc3tglUxyJyVwiC7LoydVcw
	BS/sYlty0A5J/hpXS9Zhq+t3ANy9qZsX1/oo/59O1+hl600qqeZqEjHvk9G3T473
	oIfN9pqorFLiqhUJlPdNaoyDxWkl4qFsVi+6QfG0rdV9nExf3fzwy9M2I2wn47lZ
	eghG5SlbcTirlgglFlRPk2JKratyZdI5rGSFyKva8cpJ8SLwpZXEPzAy5epq4v08
	YMrOJRK0Cgak84GxM1NLWCeO9EkRrjLSIqby7ssUzqzAppklyXKSokwLiW6ORLF+
	7MD+Ktq78D6VmY9UxgYiPd2+E+8iZsPzDFWQ0euMDbw57w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heuhug6wn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 11:25:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f26dd2165so205537885a.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 04:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792581921; x=1793186721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XsKx229A2cLUh6PDcfG9nagyZ9GT3vCswf9ByNtPLGE=;
        b=K84mtt7nTb7DG28B8oVlzyRIV0sOS/IiycisUgFogstOU4OpVjdydEJqTKNP8qGZ5s
         lkjRfXrnT4OyN7YY8m1wqwy3WzUG/f8s52EHAyUpvNe0Y8wt7uIofEB4EQ3lUZDDURjr
         pxsuytQF23Idp4C1i0LfcUwouvSiOSlZos6T+kejJCBQpigZ+29i6HwJKKcCCViHoAw8
         CvwftBt2hMbmJJ1LOoix/HnaO+h6DTdk1a9BASMAKecLJ0FEarPubE/7Ip3OzJLevGyG
         ixdZ6D/oTc0bAIn5DSSVmoUGk4wh5oHvRvR3irFBm8Q8RF99OYCClSacP6yZpf08cp1c
         lE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792581921; x=1793186721;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XsKx229A2cLUh6PDcfG9nagyZ9GT3vCswf9ByNtPLGE=;
        b=RYucrxj54JQQOqpAPT9aqkPjJHG1JK3IfXXVI2Y4nPqkccb4U5Mxvf7OAUtRHjfFJ9
         BZMOnsqJSi5QNdbK42u+Ygru2LCxFN2qwpSytCirp/x3Z11vXn+mrRynuDxs5Mosc5lF
         jvk5b+jNwkIgFFV/RPIc/VMqKQwUsO5U5UJOdXptZ1joVaJBEol5z/imbrPOG5kXP9SD
         cSPoqt1Jf7lLWjt4B3pc9hD5XOFKkUeh5ygHFEy0YmgE95sq/5yIk5YZWL0KhU4rSYTR
         A+REmG1Vq50Dfz2Gf+CTWrp4ugIt665k8bBs9BsuDshvbuVFrV4P6Ql9PZQC4QeKrwPJ
         WS5A==
X-Forwarded-Encrypted: i=1; AKwUvBw6PIskG/SKHmVggV0ZJ8T+ol/KoQ67HgOuSBpQJMfl0mwm1GgXv7yaUsThvD22UGB8Uu9FF4L7kg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKJs8R6oUBS6UYcniy0JrUdl6NgBEMVykYNVjgZGfjwNtriPFSL
	YWfLWODT4hkmZg+M8KSsw6cTDuP1nFkNPWNcodUQugJW4uPbwEt68GuNFgSjTo+nB6O+Bc3SQ26
	5DnvKRobngdNXuQYiXlN5fuV9fLPJQdA78MGVljMqb8zzSLW5t8aKHhe3GHSVCg==
X-Gm-Gg: AYBFou2RmHxLh9zdzGDUnVxBDk7oY9TZhWEdF6lsXMVCT+N+At0IZohqVOnzQBT6qEa
	cOcPZvo2i2IGx495L9NCck9NJmWIcRlRwe0LU21jwAUe3BMBn+5DGwPIIXmJAXTein3uZJyeSA8
	OpxoD+NDl9QPVb3jIiUxBC9opQ3O6Gb+gKjUS7k5y6QMKu4sqfGhfNMV6P+lOJD50LKfCPoO3sy
	lxKAkB+6RKYYBb5l0lxU6bbR4bv3kSvJaFFhhoeoiwFldQZZMKdjQzByNAbE7xbKG0zD7Pozg1R
	ZJrmYltrpcuqIXGSiG6DDH58ha8SzdpQMhaNSqvWoDYgMR59s5y/IgMw6JwkZT1IPwpUEZmA9oM
	/8cQSkWbUiLVxiT7TE51H4fhUilU/nmFrjmbfLJBSa6bptd6Lw6gcyQ==
X-Received: by 2002:a05:620a:649b:b0:937:27fb:96f8 with SMTP id af79cd13be357-93f57f580cemr334951085a.41.1792581918789;
        Wed, 21 Oct 2026 04:25:18 -0700 (PDT)
X-Received: by 2002:a05:620a:649b:b0:937:27fb:96f8 with SMTP id af79cd13be357-93f57f580cemr334946285a.41.1792581918255;
        Wed, 21 Oct 2026 04:25:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac437d6d7esm5338761fa.30.2026.10.21.04.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 04:25:16 -0700 (PDT)
Date: Wed, 21 Oct 2026 14:25:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andy Gross <agross@codeaurora.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] arm64: dts: qcom: msm8998: wire up interconnect paths
Message-ID: <iijtxya7fr2xvo6kaaiydda5eqb6eicqpwkwrldc6fmd22ub5u@dbty5tsl6jyy>
References: <20261019-msm8998-icc-v1-0-c2da3934b6c8@oss.qualcomm.com>
 <20261019-msm8998-icc-v1-8-c2da3934b6c8@oss.qualcomm.com>
 <aee928e2-909a-456a-8ab4-66d8b5aaeaf5@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aee928e2-909a-456a-8ab4-66d8b5aaeaf5@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=d4JgWhjE c=1 sm=1 tr=0 ts=6ad8a121 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=Q16rnCddB8cEJ5J-xv0A:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0NSBTYWx0ZWRfXyGRaI/FSmtwa
 JzQHhol6lKcj0F9WT3K7g/wjeAcM6bCWyNeNYtgOaqSx5A6MG5bH1gJ+l0sFbCqDu++qG98rMOA
 coEt1EVDgC6owuowuaWX0toQxOWtHhA=
X-Proofpoint-GUID: jHG5PcRsEaQ92HUOCTMRtY41ZF0_594w
X-Proofpoint-ORIG-GUID: jHG5PcRsEaQ92HUOCTMRtY41ZF0_594w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0NSBTYWx0ZWRfX337hBjwL5+Ek
 ovxyunwuskEVd3NNmxqQtNWJnzsr1vIUAgZRPIGvyzs1xAUZQTug88RpCcPxoLykywejS+KEPxC
 9hazQfYoJxZr8f8O5/x2QjFk5Ii2QrnyyunhTOc9FkExeAoKGr5GtMNEcGPH/m2a8OQ6KZiASG3
 TPWcu2peBsK+GSJaCRJdtSKWhx5kEO2MNedSNcNF/mtkiLUTQ+RMt/MDFhdC1UJF/97Pwq/Ma0P
 4EmNTuVS1pvUPprM/NwgQMnV99i24TOenDfVPnFaZuXbsy1mGgVeOPEaJRkQ7PhaRzl+LsbWOOF
 ZQ3qCrg8QxRR2WdBmyom2i/aDzSpHKjvQ2U7YzkZvWTVmJ9Gqq2XF2FlCErkfWaD06cm+wJeLQR
 FJnjNERjIUcizAyWOG6wag8STgasd6yFyC0yMyzX3z+nXL2QjXV5Bpcnt8xDkuYNgsH1y4Y2wNX
 02rmfsq3Ac2H0XjZkSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210045

On Tue, Oct 20, 2026 at 09:16:15AM +0200, Konrad Dybcio wrote:
> On 10/19/26 4:12 PM, Dmitry Baryshkov wrote:
> > With the NoC providers described but no consumer referencing them, the
> > NoC bus clocks stay at their boot rates: nothing votes for DDR or
> > config bandwidth, so masters such as MDSS or UFS run on whatever the
> > bootloader left behind.
> > 
> > Add the interconnect paths for the GPU, MDSS, Venus, UFS, USB and SDHC2.
> > PCIe is deliberately left out: MSM8998 has no route from the CPU to the
> > PCIe config slave, and requesting one only makes the PCIe driver fail
> > to probe.
> 
> On upstream, sm8450 is the first one to have one wired up in DT
> (intriguing), sdm845 is the first one to have one in the icc driver
> 
> Downstream, 8450 and earlier do not have a path defined on the PCIe
> node but clearly that relies on lucky ordering
> 
> I threw the LLM at msm8998-bus.dtsi and it said:
> 
> The only edges into slv_pcie_0 come from three masters:
> - mas_bimc_snoc_1 (line 669), reachable only from slv_bimc_snoc_1,
>   which is fed by mas_oxili and mas_mnoc_bimc. Neither is reachable from
>   the apps master.
> - mas_a1noc_snoc (line 679), reachable only from slv_a1noc_snoc, which
>   is fed by PCIe, USB3, UFS, and BLSP2 masters.
> - mas_a2noc_snoc (line 692), reachable only from slv_a2noc_snoc, which
>   is fed by mas_cnoc_a2noc, IPA, SDCC2/4, TSIF, BLSP1, and
>   mas_cr_virt_a2noc. The last two come from slv_cnoc_a2noc (fed only by
>   mas_qdss_dap) and slv_cr_virt_a2noc (fed only by mas_crypto_c0). Neither
>   of those is reachable from the apps master.
> 
> But I wonder if it's some sort of an oversight. Can we try to
> regenerate the paths internally?

I've only seen a tool to generate RPMh drivers. But it looks like your
intuition was correct and there is a missing path.

-- 
With best wishes
Dmitry
