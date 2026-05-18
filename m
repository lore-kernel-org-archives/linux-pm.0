Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316863F5BD2
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779103802; cv=none; b=Zit+qyF4J5doEcGAx4fN8nqcKXhh0njfHRvWfqO7HMQSK5yO7heO+PfgytVEIvLV0iI1OF0FZA5DmBt4nNygqdWMRFdqr37tqc1RAH8/oas3z/E53/8q/i5eh3kSDCUkAM3JPHzthiSH8htWZwWI967+QY8+017kFzxNep9ejss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779103802; c=relaxed/simple;
	bh=D+JxwENoOUj3iS9Ow5TGib5JfpQ4/E5yu6fQWqjUhSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5skRXqac2w3YvzI+4uKbJHFrHI4Fuq0xXC4hys2xHEKzP8rd5DJHXD9JDdQ+VtPhEGUMyAzMZhQW4Ist0Puque7jIsB1PHX2kylF+ohNnOBNQpfOmAkP4cPbTLoOhD9pcnYINuIciWBZMrac6h6XLZ5yhv+InQmSxm5f7AmUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ymdn0rOC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gkFAnv5J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ymdn0rOC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gkFAnv5J"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I6bBSf559349
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 11:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=G6hjDl458fg1vZmi1jXkcPSC
	R1vUSBiQ5TtnFePeUdc=; b=Ymdn0rOCHG7oKgKuxMp8IZLFMqXGmaMdnTNt9X1l
	MSlEyPIUBdbmL22N1kRTDc1HHWhpBLGSnvVtUr3Gik63yH5Ti3gbtbQTlSuCgZoe
	l473jJhjcM0ZUPvDG3rsLBOpQuP2eRNrHqsNdvd5air7ONkUfy5swWiXsdjjWLnk
	1yrkFGJ0+kA6+Wnj3N+J72qROiX8vtMGsWdA5zhtwh9UK70YmcZS0OSpqGl8EZM+
	pwc27rUbzsJz2cHmcjzYn6bWic2+8qR/ggb7sfyntLuHS7wvUeH+giRqBJiIntTZ
	SyAVV/Cw+75xTgKX/tP/ZK7R/WqsOjNIvLz3G6aJOCy0UQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6h0qe898-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 11:29:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b9b8137828so25060265ad.0
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 04:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779103796; x=1779708596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G6hjDl458fg1vZmi1jXkcPSCR1vUSBiQ5TtnFePeUdc=;
        b=gkFAnv5JihYfb+qTRAoPKBhOEshRsCCY4oYYIwhpE+F9B1uoyX2yDwk0J2TMHA1BYt
         dTpURmQjHd74R4OgOp24ZRKUKEwo205Pq9tGku0jJMqdNrmH3uYl7fXaRIBt+Xa5DP56
         pclO8yNF/sxV3MGbLM4l3EPvtWPc4Hmcealpmmv5QxN7nVDptSQJcFXH13k3h43UMv3F
         KKkluCI3fb1DfpNvJkHLDJfXgoq/fccTPwqszK+bCVCkQO3d4T7u4YNCegK/Pk8MpeVj
         X//B5wtni1z3v9SZef4B6Oqa9pBYulv0vLUQZN8fR7vOf9TFJPTb0hI4U/L4UezKIWTO
         D2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779103796; x=1779708596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6hjDl458fg1vZmi1jXkcPSCR1vUSBiQ5TtnFePeUdc=;
        b=P+krr47ZKsmd4dTdNp0a0qgKZczRR8LXjThh//Lv8+90alKFEyKiWaVjum+GIp2vn2
         DKQCynOj/2BsTCjUpPaJ9gPTfRvDvSaqdnOFAP4UGJp6HTchThfmbXAuLfWr4G26YsK7
         94YigsYCo0vQHuqFf+F8bgVqTfyMFk1HnabqLFUutkbB6Q9nenq1cc5nNB4wGnUubYcC
         NxdzrgNfX9yBLjbvgFL2UIhylGe5mtVMzRNRLfM7Jgw9RqrSRwRlEqDINIdbcQkEnj39
         QB5HgEpQfSZjhMYRsL/Hvf+wQ5ZrwNG9sgN0MAWv+eW/ZiPMEdGTaz8YP/+tDeTxmhb7
         561g==
X-Forwarded-Encrypted: i=1; AFNElJ/adQ7AamxZCCGzFCybUshKLtJA4ji8UEByw7oBlZYaSaKep+sxC1ipYMs1K10s0Dybya7aX00k/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgeJj0Qgq2xw3m7igGDTIk0m6ku3mABxNRoAa9cs6UGHn3OK/j
	jzpDC+i2SFJ1O6sT1bz9YW8dZiJQM0ikbprOcGtLx4SE+INoXUospeQRE9OlSjiiRAWR3aSBqmr
	npTSs/NqBy1cQOgnIz2QDdcIXMuD1zQSZG1jCyy/ZGomN/+dTxn/LBLr3nLu/eg==
X-Gm-Gg: Acq92OFo4ZJcWiKDsSc8JmfLGOiKzNJTyF9Bi8xYJUgQqSrVz/YvMSoiYtvJ0jdbBlq
	P/vZx/3Qi6oVX9/CoDZL7F+s9T2XEQezmqbLI/Y0hfiXZz6MmxVF5a1eyCJNjMaY2fFSDAUHdDu
	TzGzAfZVTvYUJZ7gjLaKfnAxxRbBYJxUWppL3pdx3MBofYfLbVpJ1f56kQtWaAy911ss/u2svbr
	aV19IGr4MCQR6p4SY/YY3a0uBV3Mi0Oq9TDeOG9Zowfeku6qOQViijSwdQqepBjLJ02EX6aj0QO
	1N6/aaBreV8SQCOe6wKNntUzAcS0xBBCHXQUZcfUXnX1j3Nb+vkoax/HmvaiPpbEP2AauXgXyXt
	1CD+yzN+K9VEitwNhMQ8WpJYmRI2eTk61dCNW4abws3+3lXQa
X-Received: by 2002:a17:902:d512:b0:2b4:5f96:184d with SMTP id d9443c01a7336-2bd7e86c6a4mr167038065ad.5.1779103795505;
        Mon, 18 May 2026 04:29:55 -0700 (PDT)
X-Received: by 2002:a17:902:d512:b0:2b4:5f96:184d with SMTP id d9443c01a7336-2bd7e86c6a4mr167037715ad.5.1779103794907;
        Mon, 18 May 2026 04:29:54 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0fc2bdsm187835475ad.63.2026.05.18.04.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:29:54 -0700 (PDT)
Date: Mon, 18 May 2026 16:59:49 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: Add Hawi
 cpu-bwmon compatible
Message-ID: <20260518112949.ui2gfxvkjdmgc6ks@hu-mojha-hyd.qualcomm.com>
References: <20260427182255.3649922-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427182255.3649922-1-mukesh.ojha@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: kOSOH1ul_dhyhrR022fT_d4aXsURaewh
X-Proofpoint-GUID: kOSOH1ul_dhyhrR022fT_d4aXsURaewh
X-Authority-Analysis: v=2.4 cv=fIMJG5ae c=1 sm=1 tr=0 ts=6a0af834 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=O7OvwgOkGeDt5fK5py0A:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDExMSBTYWx0ZWRfX+mYiuQrf4/z2
 WZbtPVh+g2w9mqaQ/N7yvjqXtWFrU8TmVVADsgUox3ahIk9Ho8huiFzYyTuuWCx8enxGegL8Vdd
 cc2ftI1YDVASYPbfYELDP5wRK5cyfgRnT+2Lcaqj5nSsEvZbqOFaKK6OjBALJDxGNqHDXMRatEX
 VatpipBZ5iMgnWFadUFelq5cDQ/ha7skzC5+r5LRDI+emzkuqfjMSHCOskstZBJLybxaoavSEeF
 TUdZDLBQsAgX3CI0qYMJBdO2C8QvJ9G+LDn1bZYXyfNu488gMFzsrs8xlk9/Db/0WCEdPTZgmnB
 UWA7VQN7DIMJxg9HSKAfdhM/SM99clDrvwiUuILlXHqCXT2T0W6Cu8dAhBPReViSZilfxRoGcFH
 yB8Kl5gP9oxoE7UgQAbZl/9DJvxbJdUfbOr4Ot2bnscFlp7wt2WR4vUiPvPWHk4gZMFa2D9WSrw
 XDXv+sA3EnZ/s3oC2qw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180111

Hi Georgi,

On Mon, Apr 27, 2026 at 11:52:55PM +0530, Mukesh Ojha wrote:
> Add the Qualcomm Hawi SoC compatible string for the CPU bandwidth
> monitor and there is single instance present globally to monitor
> the traffic from CPU to LLCC.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> index ce79521bb1ef..82b1d94d3010 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> @@ -26,6 +26,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,glymur-cpu-bwmon
> +              - qcom,hawi-cpu-bwmon
>                - qcom,kaanapali-cpu-bwmon
>                - qcom,qcm2290-cpu-bwmon
>                - qcom,qcs615-cpu-bwmon
> -- 
> 2.53.0
> 

I am hoping, you would be picking this., let me know.

-- 
-Mukesh Ojha
