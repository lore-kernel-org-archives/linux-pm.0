Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5589128CF6F
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989986; cv=none; b=EOTU13415vC2t71DJDrgM58K/52toHmvPnUUa3BGaDD04guYr7fEKJTBgYzry8VvQK8ido7LWKbtWZX/iR1qQ04C1CAajVQmbuU+gn74R+u3rRfqaDAErVZrRzYAHv7sNK7hLNzUkSdQtA4BPP4SaLJjIWVybOl43tw3ozqIxYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989986; c=relaxed/simple;
	bh=VyTdXY+0+wvH6hvhv1k6KwriSQSnFo9Ih756l2s+Zfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4/xn7EtbSVoVsmUA23V+JKvxs2xQB9QaCXZoSpj+BvFNou6/7xo3AmQp+TCYAzQ5nb9XqZwcf7+6KmPJiAtKImsHjnx/7aOP2DoyBwv7WayDWzoZb+gP7yt2giBvR9PlwVAvsyvgGAIpaaSj1cNrbed3WK7P6ljinXywGcEyXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gZaEZfuL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dSPoTcVi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gZaEZfuL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dSPoTcVi"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6628sTa34172791
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 10:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T8l303crY05X0SOko3/98TvkP+K410TeNXuDoKahb7U=; b=gZaEZfuLBvPGVhEJ
	IW/rB2RpgDRswRjdoN26w+mpsSW3GAaL6dR521F9K4XwGtVMMRwE5lXPHlz6nBaT
	oN9YIPvYYxrkBoO3mmqcAM+octSyx4ehBOwZhiUsdyJHFpjOnop3JaBFis8mYGcc
	hteKyzXGrkuzjR4qU3zQqdN8oHBh5VyUq3HS0Tvw8iugeGsdkldzGSEO2FfxtA+5
	PhTT5zfTGKTiIUpDxWwBffTfO28fdG1PO9AR5TXixz2LRX2l/3AZO8S7S/hbyD7a
	ljC/wOdy48nMUW6uFC32oseN9mnfVNlxBwb/8lMBRJ4lA/4r+HEZ8as0tfMcaiT+
	WH9qeg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5mvwrfc8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 10:59:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c21be5bb4so8372681cf.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782989984; x=1783594784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T8l303crY05X0SOko3/98TvkP+K410TeNXuDoKahb7U=;
        b=dSPoTcViJJE91Q4C6VrV7ujzJH10P0/enhNGjfTEAYs4LE4m/d4B8grexpAy7AOkqo
         rnZr0KMY4o5BJIG0fG7IRi1GJYzKcEAJCrl4UFv/yU9Qqp70y8z5dFbGEMeBgWFlylLZ
         5rpNvShp3zd0E5RjvLwbSDfNyo5hfvjzfEqE6m0HZxs+4hLZQj/wr3O0gA2+PStgfcyy
         ziTVqgTZIbcx4jyfSlQFuXpxPMmgpL1daN6ElPAQuvAyO2JHk0ra6sFpki8rYRxztgWx
         etlGkEOthe8utfjxqd2xhgMCQ936LK5h8UDPStbY9EHdaYpm2E1xrzzoWn8WTe2qD8mk
         OT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989984; x=1783594784;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T8l303crY05X0SOko3/98TvkP+K410TeNXuDoKahb7U=;
        b=AK5OVbpbQ5eMXCAD1sHuv08T5UkdFtzKllPCXG44Kydc4lZW/smfRVuODHavdOdDmi
         vn2zdBj5W5fM66GQAvWOcPJo7yEMW45Tw0GchsYHawm19zhGqN+p8YRcL4s6ouPxJhqS
         DuqWbzCC4HJPLSKq8lmgSMf7BbqoLF+zW5HOfzY8IPBohRCJSfn3+Z04RlXt5Or4aAmX
         +4FIUKDUT4QIcPYf3L5xnuc6PjFJbeSq9z4I6gqSBsC+qCs+uK7KfKBrtSPe1W7+Ha0f
         r/7DERggkzePhZctu9z/SygmhnV+t9HN+SwvjLbALCHKsxaOwl/dLaGcCckbr1SbcRjQ
         YU/g==
X-Forwarded-Encrypted: i=1; AFNElJ81ZsriJLZMF5KoCKd9tA3iPreDk2mR6W410Q/v6Simb+/SvpMVcGlZNOa3Y5ppUHmrTs840fKjVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwayaBbcqXYRtDCnhjK8I17Zx1Zp/CGl8dcpbskM3kQxxVFWsxd
	iKXbLUobCiKPuEbI+25g4edwXzC65xdmqbk/2HfLet+u8xY9Y3BI1dE9KbUr5QL8tfqvsTaW/PN
	Cy4LqLh54lBRU3JDMrsP7qMcW8N0EFDMSYcqCx9KLRw+gOLW8c/x5ASyE1qhS1A==
X-Gm-Gg: AfdE7cl2oNQ3LgFO9eSpY2QRrRFtE3IvRbCOcH12jPsOL24VIZ8m+DhmVwmgaLZO0D+
	HXX2G7Gs03Pj8OLEugBYctDPH/WfxHjvhki4ZyZsxgYlY5j8tWYL1fWM1B3cSNJkrfmNjLamlqU
	rnsUCOqODByWSfNF2XxEg1I3vGLSBaIszflPjXq74mntsAkMygdGDnD43FziPkKeVqxavPtGtMf
	314x7ql6w4IYLE7o91gjU6EPAClAtf0tXXchjKcYv53z1DZobW42/uHM27sZQEZ9cNACYzxKXG8
	gifBTaE0t/ZWz5fsOglExUqNInyaUAwOMYZ/EYuyxImKy9xByXSYz76dEO0dq2QuvlUejiJShI/
	1CcY0BsM8PqHCv8hn7pYiRvoqZQ7aaHfmCmE=
X-Received: by 2002:a05:622a:3d4:b0:51b:ff1a:3d80 with SMTP id d75a77b69052e-51c26b07996mr51310271cf.7.1782989983704;
        Thu, 02 Jul 2026 03:59:43 -0700 (PDT)
X-Received: by 2002:a05:622a:3d4:b0:51b:ff1a:3d80 with SMTP id d75a77b69052e-51c26b07996mr51310141cf.7.1782989983368;
        Thu, 02 Jul 2026 03:59:43 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6290972sm112872666b.41.2026.07.02.03.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 03:59:41 -0700 (PDT)
Message-ID: <0ac50f09-8a62-4735-99e3-b8e632621ed5@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 12:59:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
 <20260702-shikra-dt-m1-v5-10-f911ac92720c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260702-shikra-dt-m1-v5-10-f911ac92720c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0XtJn7YQ9eiIQMxyTwnRYlxnQtl4Cz1Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExNCBTYWx0ZWRfX1UZuPdXS2c1u
 PSut75LVQIchooYIfe91wH688vw30CjuY33ym+jdqVcDdl0xZlJOoW1L4I7FPlaPKcttlzqIXVj
 Yo+CQZPZwQxBQMJ69zsxgSvExLwrvGqYdtQJQHpRL5m5gY/UUushOsWZrO4+Bhdq3K39Scu5sQp
 4WbMWkkyyKEnshw73X/XKz4rklb8hGLvBI1CKlizpRIu27O2nuALHmpQJuefEHHw+ezX2dcwZjn
 coZw5mHVu+Jr5tfX7ryPoW7wbr+MJEc82kMdFzJJL/plipwVObNAF62m7RnBrPLq1HSzzdCu7XQ
 DqUdu1JaBRzRtPntEE9G+7TIamjpOj91cefESdfPDEA+s0f4//aA2f/g7j375bOVbBIGk4Sfyf7
 bYXTAwwy0i73Arkuvtl1XHGFEEmR+Vel7rQvqr+hCRzRbZjr4/0HkgSMpQqn97fGRjrafZEGM1I
 CFCCDOUQ5+a6B5VE5kQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExNCBTYWx0ZWRfXwQbXMXFBI6KT
 LL7MB6n1FokuWpRsKSc2FNSlm7efedQT+srWlGYwyGFAaJonFflX+eFHlWZcG+4BpWbLgomjO3x
 AR8VUvcHt28f5baYj7qrArVOn0xZ4N0=
X-Authority-Analysis: v=2.4 cv=N+UZ0W9B c=1 sm=1 tr=0 ts=6a4644a0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pm3H3U3sixV8GkyNLbAA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 0XtJn7YQ9eiIQMxyTwnRYlxnQtl4Cz1Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020114

On 7/2/26 11:50 AM, Komal Bajaj wrote:
> Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
> EVK boards using the WCN3988 combo chip.
> 
> For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
> board-specific regulator supplies across CQM, CQS and IQS Shikra
> EVK boards.
> 
> For WiFi, enable per-board with the appropriate PMIC supply
> connections and calibration variant selection.

[...]

> +	wcn3988-pmu {

Override by label, this works but it's super fragile.

[...]

> +&uart8 {
> +	status = "okay";
> +};
> +
> +&wifi {
> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
> +
> +	status = "okay";
> +};

Since the module is on the EVK board itself, push the enablement of
these nodes there too

Konrad
