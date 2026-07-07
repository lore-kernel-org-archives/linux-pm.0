Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BC1379C2F
	for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2026 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442177; cv=none; b=d+JHs3lKLJQ6DuJijiOjpzSS7RJrQZ70NryIMIWinJPDFA8BuAO8TomYauxqPhPdJofvWtyNmHk9XmbCUPTDE6N/GuS9NFrNQnSTD57WlTcmYwOZKB7xfd5M+L3FnAaqmitCrYVeWaVqAaD6893xyED0wObX9zmYzkZhETMsK1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442177; c=relaxed/simple;
	bh=jD7vMq40BtjbLgY2tK+JEwoLI6ZCP6ExRZNtAmmlxYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WltDjWWXDa3wioOr9ninle36k6H8XFQkTT6V5IlIPdmLcB7/YFI7Mc9lR85KU96fNb11PwJvryReU+6cc8/YCtsRYu8VfT7l9lpDCrzVtvVTDNo6A+q4dzyDRHQV8Sv2b1TVG/AVO09gHL4RibjX/GGTrOC04XsJxQqcDhiNdgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V83Lk7Ef; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=it3/nVzL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V83Lk7Ef";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="it3/nVzL"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667FTHQX002538
	for <linux-pm@vger.kernel.org>; Tue, 7 Jul 2026 16:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rOfu/YSWSoVJ9+8gOLnE9/D8lneB3OTBsZ8QT6Zknbs=; b=V83Lk7EfjAfcIHfd
	bkLPBHZ7XgqzFQ9jyOKPYHyMkGKzP7+6Qr/7y1Y10nxHQOmGEnfiYcdrtZj8vJVe
	huf+LH3EXGxlwQ5Zc6gyIpLVJkcFUXPxNu1Lub0lZrhHU5Incyp/bl7LulZNGj3T
	1adSCkhBFLXP5OqmCWI4hBid86sdntPa/eAK3cAbrPHA5OuiOjKkVbwzloPyitAD
	Br7JeOHWzbXFwR+BUvgbDap8qMW3pwVx4gZLZ9Y3ERe/oNl2kWYD8GydLMJK/bfb
	TTLhMaPXC5iX7SptJ/yL4LOhOzXFNvsXketDXDOrDheXo5ZHJij0XomcMZ3TOSuH
	XJlWpA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8ye0hm04-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2026 16:36:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c7f385887bso69583425ad.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2026 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783442175; x=1784046975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rOfu/YSWSoVJ9+8gOLnE9/D8lneB3OTBsZ8QT6Zknbs=;
        b=it3/nVzLgTn7meAL4hKBePYlyf3uMuQ2kcPTcGhnG+dDXnW/Fytad9gAktFX2+Ytyt
         XDRY4/ML4lenkUtZoAkFIjNQo8BU3kXgaexAMkEKmFhQuuaQQnt2gF+f3K8TjvP28q5C
         edOYOPXgzbzR/Q1mTRCAcddCbN6Y8miiSGJyLUty5s1XUGttUJRs1xwGlr2yTW8UZQyZ
         Yp2CIRFp7McBKP0haup9V1EezznQaPPCigamUK7imirFcKmLaNcK/g6PrptQP43tPyW4
         NjjlKDlGqIkQfWoHlrx2VQVPvF3EeK+cVGTQot7VWXeVVgWvjc3eHUzdzPy6b0A1MHku
         d3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783442175; x=1784046975;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rOfu/YSWSoVJ9+8gOLnE9/D8lneB3OTBsZ8QT6Zknbs=;
        b=oQzDQu5rZ9acbGQKesPp+50oFB0TRDN2ThBqjfJZyINEajjDIyFfLpBtIv4bR2tl57
         AOtzjVjIAqI5jZF8TZo97dHypfghxFv7NEXXfE52zJGxSbTpfRgEnH3MSvERyoOD+LpV
         2sT1hZhgAlNSHhFx86qodNxzyqjTbTSA9C0f/aFlucXyiBksdlf8ldq1RxnIGNU+Zitl
         NK5tFw9DZZ5+0Y300iawpzL+eXySA5+yMDBFaLqpBlPhDdUFsrN2nTedeQ6aZ1PSSEDZ
         fVSi53FlA4K2Gag+uWiVVzGgLvE3Mb7osqa6tdYAnBp3RVlRUT+cwm6F23GCW0nP3TMb
         PGxw==
X-Forwarded-Encrypted: i=1; AHgh+RrAXzlm1ZjvtSK2Q/607uWUAq8RY0RVVfH8X0D64qE5duERegpAb9EgnrkezuYYfudjkh3i6Gqwtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpeAWZkJ5jO0cKQDLH9ivMUlF+EUt9RpoRkPat12bCGwDExCOl
	tOadhp+dm90X8pjTm4XRoHoAgJ/t+znXV9rkjtC0GHpq9b/jA8AsQjP335MWZvwbcAOyj2dqwJu
	BtZjY2gG5iZzXNdRl59pJvo19PicWUfzpIm+zkhHX9luCf+E8Ay1LIcxi/Zs41w==
X-Gm-Gg: AfdE7cka9vFHjv3IuvAJD1bkkVURkNvNf91fLRI2cCQKTgeZCx7jlufk4L54hH2n/xm
	i2L/6VMKa7iEGdeOThYtMTJVJ8FMG68nv/gktsFOX8HUlPXwIZ48EJwRQMEHjZA07aqVo0pHJBa
	Q0TOEViHhwK5EtaqMinP2sLie2rLb5WEmGaOray8bzr3VTFuaak8zBqRWlqipxfiXSdwmdV3IRf
	s0yw5NlWVpVEKJLAsSEu0Eod777xM4sS94SBQYnm1xXKqdlzCBBD2qjrw5TSRvpktJxsWsRjeIY
	B0LYRWrki0t51iXRKrbao+BuhHVvr6kedeq+b4+BUy2OWdnbV26PEMQpNzCpSs/nWoaGAicInc8
	oF1htm1LlYpipZROOzBmFOocB7cDVOet8/MEOSz8p+w==
X-Received: by 2002:a17:90b:4ec5:b0:37e:1609:b304 with SMTP id 98e67ed59e1d1-38756801500mr5684133a91.1.1783442174787;
        Tue, 07 Jul 2026 09:36:14 -0700 (PDT)
X-Received: by 2002:a17:90b:4ec5:b0:37e:1609:b304 with SMTP id 98e67ed59e1d1-38756801500mr5684047a91.1.1783442173406;
        Tue, 07 Jul 2026 09:36:13 -0700 (PDT)
Received: from [192.168.29.166] ([49.43.234.127])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118389d9bcsm2524489eec.20.2026.07.07.09.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 09:36:12 -0700 (PDT)
Message-ID: <97b205e8-5ab7-4205-b1dc-cbcb0497987d@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 22:06:05 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/11] arm64: dts: qcom: shikra: Add
 gpio-reserved-ranges to tlmm
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Anurag Pateriya <apateriy@qti.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
 <20260702-shikra-dt-m1-v5-11-f911ac92720c@oss.qualcomm.com>
 <9c1aab59-14b2-4811-b778-8e96645bd65b@oss.qualcomm.com>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <9c1aab59-14b2-4811-b778-8e96645bd65b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: O9Y4UJn2YTyY6DcXu6dlPEWXUDoVPvbP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2MiBTYWx0ZWRfX/2pn+koV8DE+
 1HqPCBBen5LhzRb6HWRMI85EeVW44b4o5oWlyv9JmLWxhTlHgOxCmQI+/wAv7OtN+aqg23H0dAX
 nl9oGVQBS/cKyC2xhOIzt9i6dbSnSKo=
X-Authority-Analysis: v=2.4 cv=SZfHsPRu c=1 sm=1 tr=0 ts=6a4d2aff cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fIivk1FRtaL8gRNK6azaIA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=TqdALn-mf9RdMn6JgEsA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: O9Y4UJn2YTyY6DcXu6dlPEWXUDoVPvbP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2MiBTYWx0ZWRfX43/hV/AIwjfs
 A96EEhwHMPf0AEkDvfQkQTpA9w6M5QUxPHWV/MkgSPLAmXXb3TOL5unME4KdAtE6jKt7LTfWo8L
 A3ZxM9i+Y0iF+b8eMULmjEDI5XekHnSsMJ2XWC+ntWDRgCh+Ly876L06xnce1AGdXQdlBFXQOjE
 upI/UrjFESQb3BrrQNV0EJx9c/zn63gjMXXiudFBeMwnQT+f7+FcV2LFspPmRLA82REIEfXpKyj
 3g0EDeu9+hlvcpQpjGDdnX4XDicmJmxwNn8kmpmEX8Q5xkA2eusHVRnTFqQgBt7M8sJrN/cxfju
 aR3YMzO+NDHsifxBMpFtbp6abR3TGwHtOARS29uA7gHMQtYIRiK7OJLeXVQgRy8HMfS8XWOQank
 fnowUkYsS4Idz9KsADFBMt/tuZmQXvUssyVAchL2/X5Zts08idOhaHYN0UWvQUBTNtyGcbntWOI
 sUVEcDu3tBvSHMbGGdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070162

On 7/2/2026 4:25 PM, Konrad Dybcio wrote:
> On 7/2/26 11:50 AM, Komal Bajaj wrote:
>> Add gpio-reserved-ranges property to the tlmm node for all three
>> Shikra EVK variants (CQM, CQS, IQS) to mark GPIOs used by the
>> SoC internally and not available for general use.
> These are generally added to prevent non-secure access upon TLMM
> probe, i.e. the board won't boot if some of them are not protected.
>
> I assume the proposed set contains both ones that are _absolutely
> forbidden_ for Linux to touch, but also ones that are dedicated to
> some specific purpose that Linux _shouldn't_ touch.

Yes, some GPIOs are reserved for secure-world use and are therefore not 
accessible from the non-secure world.
I will update the commit message accordingly.

>
> Please add comments, like in glymur-crd.dtsi:
>
>          gpio-reserved-ranges = <4 4>, /* EC TZ Secure I3C */
>                                 <10 2>, /* OOB UART */
>                                 <44 4>; /* Security SPI (TPM) */
>
> explaining what these pins are.

Sure, will add this info.

Thanks
Komal

>
> If any of them are boot-critical, squash this into the introductory
> change
>
> Konrad

