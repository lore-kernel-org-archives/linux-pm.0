Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293703F9260
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002084; cv=none; b=LJ6HKilu6Gq++8EDbKmS+8pODqtRaqV+UXrWir5h2TEmCls0UH57SB08l2iUEIMhFH8ZU0RMQuqCqw58OCpsKiqAPkIijcVvxJv4kVctDlQ5aiv7BMKArhXk+N5uCKf/tZtKvTD+xKpygOIT6cdQ7b71LdnWZnxTQDKEAQYDw8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002084; c=relaxed/simple;
	bh=/fmIzCVQFlRc9hqGthcJ8jz++uNYfhPm1KVVgsySGU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOjxHzOInIu/wDKbTN++l9R0SgJJT9LbyXfWy0EZCFRfuUxyVWmXdRylHtaZvhNJBtFCtZfNABtlZpGkpWFkZsGtn5J8i8OK/NZMAzNE8So06BBl+/NtFV5Mzs9jB5fli78qVCHbq0c9el39Xona9DzuF01osIB/LWoiGO8Hoe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eKbtvGn6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F2jdDNEF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eKbtvGn6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F2jdDNEF"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6599xBwe2312336
	for <linux-pm@vger.kernel.org>; Tue, 9 Jun 2026 10:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UuGTO67RmC+ivHQmIuRBVduc
	tswyL1nN6TdGwGzdo4M=; b=eKbtvGn6qNyrvxqiCmTZMXlJ+rFa7CuUFK0NL4os
	78YNrHKvvop++uK7mOW3XHHZpMa/QMvAgHccTGcbXACwFieFvq9bVgxEYcoVe9tb
	V9TCroc3Z30CN+o255C5/iGmPvFK96F7GbMydqxRTqwISA2+XMCPHM2GZ+8auQjc
	KqM8ngDELKAm453BtdgGmpQFfb38EMJkuXf+QfkQ2Ae9FefmkwghFwIJzmUesyM2
	yiTWI7GVfFE2QUHwCLvlcw/PcWT1/b618aeSlmTwPH/PlvsZ2n1CYILKLKyQJy0a
	69hHna6jnxsMDJ+iFbs8hOpxSq++Pdqid1EfOxjyqFoNQg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3v0aff-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 10:48:02 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-963b4e8cf8cso7381160241.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 03:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781002081; x=1781606881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UuGTO67RmC+ivHQmIuRBVductswyL1nN6TdGwGzdo4M=;
        b=F2jdDNEFOwz+c0lelpAlFXXoaL/yMReJ+gnKYw0IgO9sIH0MJY3kY4yQi1/qsLvfQK
         bkJljo4xKAJP4eBjU/5FQyxyvPtQ9DS/lWZsZdCvUcWVff3Wo3hTt4/uw+rTmsTEgsLE
         8+uI768vXUDj0IID64IeMq/vCp6BSWVisAiG51N347oN0iEzIXgtg+B7BqgDKi1WD3D9
         P1CgOxHyXQVrMAYaSJyDnfpHVP4xzHjMQU/On065vHj4kmgL2mEcsBnGH3lCm9sApSs4
         UJWs5ezkCo1Mj/i/uuexA/8tC25PEqF6T9U76iYP9oaGq0aCt3NmkoH+n4OIVLH0gcku
         397Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002081; x=1781606881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UuGTO67RmC+ivHQmIuRBVductswyL1nN6TdGwGzdo4M=;
        b=OML1tYIsl7G14PZVSuWrXxmHQ7h1yLV9dDeqQdyhhY/5RNzjH/oBhLDCxtpgPOEOZC
         7fU7jgQemR4K9gFqclWVtypQhKWVYpDWI435tDQINEKE/2r1Pujup7tUenXyUqgLgS7W
         xbs6ySkJ9iCZoOCyl/DbCPMYU0hUtu2LTrLhlunckzjUaD1qmrgmLOWDLf6/8rAJwZsa
         4+66y/Mx8lRRBkDvxs6jHkKcb0Q2g9nzJ/KJn0l1MItYOMqRsIwgYvtsgTBqSoAF+IY3
         9J44TL+1jnKoFJJIGD3LpOJ3C1y8yACguKJoKgqHCCAbDhHHlg+OlQzCeeIoMDBCTKU6
         5g3g==
X-Forwarded-Encrypted: i=1; AFNElJ8Xzaw21Bp0dmrNDb2ICuwjpATSVrUPveJzavRzTHvlYOetxlKXwBft5QRdcnm7bsS2nriqcqtFhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YznJxn3foZgd7jxSCHYJ6qaJjfCsNaN1J1S2hF8CFKDKbLn1mvP
	NLDD3OA7qWQ6YzBmSWzCAksyL8K3lwTSi7JzFzokJE1aObiQcwMHRus55fRJKOJ7GWUNihuRrKS
	zfkpyHzpHfSYhp6zw5OybVU/8as0U5xF1ny/N0k3r6e6siWEW8nrOEaQ/x75akpPypzkaUVy7
X-Gm-Gg: Acq92OF+tXM7NhAZ1TBmsnhQhynXD8RftYU2BFbmG6PYjWhY3/j9qz7w3koalFZqBtD
	n9n54b1w/YEJMt1YaPd3TT6K6fkaWu8moOMpzkaK/zcZtBPvMmNzYjnQFU3TDPWnr9idxOpJds7
	5YT/879kwdkS6VLIFv8fG6PBCdG2WKcIYyovzTjrkWO/FrYib0+7DIPYXWdfELCyx623otpc3J9
	H8OAUzEkFCZu4qcX6kssDP/5cHqHIGBGI4EgceMYmzIJytfS3HDNRf9/85WvJCtXU3yJkFGEnsy
	KyRgW534vN+hgFCY+TmdpgFhP7pyCxroPG9sCBIAiNa0wAlLsWL68qBksljZUHwJOEuNfzaOV60
	xavYQ699N5Xi39eR6NG0qzjw0IzyaNlKW9ncYXqvuW2qKvtPeGo4PyhZQPGbTNZPtlSnRSL/LJl
	ubskwxd6h+izjCKbNXS1Lq3Mpciu/kSGvCDnQnxjtBWAbxyw==
X-Received: by 2002:a67:eb47:0:b0:6cc:8a90:9f88 with SMTP id ada2fe7eead31-70037cb32b6mr5316813137.16.1781002081423;
        Tue, 09 Jun 2026 03:48:01 -0700 (PDT)
X-Received: by 2002:a67:eb47:0:b0:6cc:8a90:9f88 with SMTP id ada2fe7eead31-70037cb32b6mr5316797137.16.1781002080993;
        Tue, 09 Jun 2026 03:48:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b99c11csm4466142e87.78.2026.06.09.03.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:47:59 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:47:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: qcom,pas: add thermal
 mitigation properties
Message-ID: <ujf53zya6hes3hkddhsmgu4wyabodnyg3zdwarxmcsoy6p5h3c@ild34ppiyvre>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-1-291a2ff4c634@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-qmi-tmd-v3-1-291a2ff4c634@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=St6gLvO0 c=1 sm=1 tr=0 ts=6a27ef62 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=3uhaW4yOT-U-B5mjbOMA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: 3s0OWzwL5vUq6JzsE056bA8KEi8Oshyf
X-Proofpoint-GUID: 3s0OWzwL5vUq6JzsE056bA8KEi8Oshyf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEwMSBTYWx0ZWRfX/KzR3/vCg3lC
 YLC9zKx5fabplvoio0+Y316GPE11XqY/r0N1/IqCsqGJHW+EJS98PjBo+EK8G7fVygsco348z0S
 sd9DTgTbFFkGYC6aG36Gvx+8RcZ1qMHzFmBfDfXf356pRCySp6TiDHaKFbJeSn4P6arC5GLlMYo
 qSHB8Mr+aGOumCwmk+Ym3yjnN/pqN2rPqdSC/2QpQQOzoLmA6UpzRlenfJck8W3AWlyAAe+yNTX
 2reeO3neYt9o0VerkSyVhOWiqA8pFKfMspCbbOJJi5VKAx5NAX4F0dao9CW6/vK9M4YP/thJ5J9
 dK0AJL42zwH2jABtvW1ltVr9Agjk5d0GbQqn+0Ari2ng2CZXai4YOhW4/6pkY/gcTAJqMAzAtoQ
 8FZsgnCaNxI+P8kW5W5oyBBmj24ETViMRhEGF8KE2lFWvKP9nfgYOp/y/LLVOAmos1nVYa4I1Vf
 9WOh1Yb2u6KJ/q/PE4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090101

On Tue, Jun 09, 2026 at 03:52:56PM +0530, Gaurav Kohli wrote:
> Document Qualcomm PAS remoteproc thermal mitigation properties used for
> QMI-based throttling.
> 
> Add:
> - #cooling-cells (2 or 3)
> - tmd-names (thermal mitigation device names)

Describe _why_ you are performing these changes. For example. why do we
need to handle two different cases for the #cooling-cells?

> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/remoteproc/qcom,pas-common.yaml    | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> index 4607b459131b..0d07a0750762 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> @@ -79,6 +79,20 @@ properties:
>        channels and devices related to the ADSP.
>      unevaluatedProperties: false
>  
> +  '#cooling-cells':
> +    description:
> +      Number of cooling cells; 2 for min/max cooling state and 3 when
> +      selecting a thermal mitigation device index.
> +    enum: [2, 3]
> +
> +  tmd-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description:
> +      Names of the thermal mitigation devices available in remote processor
> +      subsystem.
> +    minItems: 1
> +    maxItems: 5

Missing example with these properties.

> +
>    glink-edge:
>      $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
>      description:
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
