Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A8D3CF68E
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840776; cv=none; b=ofoG0PFgDJSfOw2w8tbvxNEqmVNMAD1hM79yOdU6zsyNohjtNgWSXXWYiUfhkf1DaOF8A6guzzvOV0s1M5G3A9agz7UT5KJj+/J254dcajAXAvmpvlUcPRi2wP//MZBAIGq4P/IxS8fqkyoqVOzhezfpuKiEBk7jLW/Yv8DRo7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840776; c=relaxed/simple;
	bh=QFtzC7b/1f6NP3+QfIo5lhUSru9B+PbuhuuSV9Omoys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mU1rBAdzFUEyTa6AdQlTWnp+CSa9UzJ4UNUKbOBEBurPqOBxqfkdjo2UDpHzVswSHmtNzmM4uJhbVuq+6FpA4glpNK2TOR1fm59/n25TtevJQldbQLooscC0E0nyOjjSjQOIJxaBU1PWfKb0Oa74lN9SxNi+ijc7VnOTg7oapHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XG6uQAbT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P+4DRbff; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XG6uQAbT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P+4DRbff"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F55nkS4020975
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vk7VBeUZzwHE3tZsc8Y1s7QJ
	tuqy7pziC/VqL2N4MPg=; b=XG6uQAbTVNoUkjFp6sKqxJxlFxx5Ias4ao5X2tNQ
	VEX/vAcUJvsaYeHaKQhPfyowDr6ITxsGlrs7AAhM4bRsuWZcDNh9ATdyGphdsw7v
	5SbXFzoU6oUHVQLcIFMd3X4GbLE6/TcbTAV1IIzJEQVEGOF95o1PiZQcr/W/kSBx
	V6xuOnxQln5n/lgrzUSW29XRkWWuQ9o6wRTFuVttpk1kVZwu/nThqcJlhKGkqHM8
	qDQQO+Bkh20Dsm+wUVQN3lAbwP/RopWb44zq8roDoPCEDwJlVkQX2MkZPp5zQ91c
	mAXuc4O1kqla2PmuMfIUGNJQfhQYi5LsyzqnsUu8U2oT7g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1rtubt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:26:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-514ae0e3ad6so19661241cf.0
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 03:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778840773; x=1779445573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vk7VBeUZzwHE3tZsc8Y1s7QJtuqy7pziC/VqL2N4MPg=;
        b=P+4DRbffnN7Za4pDKYbJSAgFFTVO7IL7CPHgABe0hDGM01kOtDQmPk8l2UAFhPjNbR
         T48OY5q2WSV1Yit4QZ77/GO9n1BahuGTw+EHqm+r93B8CFxf36AEAOL/wO2sEi7KfNAX
         35qTVCdKodvJewjTUIqmxX9kW5MD5ZpBTX2Pmhkpokp1v2Qx3R8RKer5oeNu9wY74jXy
         OW/0K0f20zml6m06Lqpal+mvSgF31wnyIOY8vZLGv8pKieZn9cL9iN1TFiCoH3gE4q/2
         KfpT+orc8cILgKGrHQnnPknbeTVN++nUKTK862diJZb6VjZORWbVviqM7BIe238UKiVn
         uBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778840773; x=1779445573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vk7VBeUZzwHE3tZsc8Y1s7QJtuqy7pziC/VqL2N4MPg=;
        b=M6KoCyXpBsPOvURkYTr9asR2Yp+Ze+dDojuNJJRBojn5CX4IhFBGD3yG1ibyVtyeiX
         QY0/padc6N3JJrcpPMWphJaLmAe9NNuPcIyxwnlupE/1W6b4dWC3YKn3almKeGvyKT0A
         UCkKfK9tWHl843opj+8PxaCBCqAwtZWjLYHPU8EFke/iYv0DjBxexP96X/lov2shN6NL
         5O/B3Jj2VG9j6O89NSr0cuQc0OPNBiIUIT41KPzK5Fjtjo4Q1+75fsDUaWatWlp2Bszi
         X/FXZaxXaGSl4pM+eH0b9DzGEJaQm2RiXQECNDaiuR3qOTVnYzsgtywIdof2fC5p+SA2
         n70w==
X-Forwarded-Encrypted: i=1; AFNElJ/89BpSY81XQhD8mE8K9tnm+E2KQcWbc5Fp6W71cyjaBYkbJM1FyZIPWVyuAQY816NYnXJupTCg/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVmMVOB/aWeTqeyTlHqYhLMWJrKbXHMmXKNzsnL7Y7cdY51Kkp
	IuMJQXxOKoknuejAMvMNu/C1GkHX3Ko/aY2YqzAr43HxNDyWaSCcxNF/yifBnCHM0JnRff3X2nQ
	gXQR7LYun81nO1VOKsHO3auVnoK8gRKp85SFNHv3gJnD09jlC6nvr9n81yOnZyA==
X-Gm-Gg: Acq92OGzxmcjxv9UxEMV1OUlqzIlCYv247Ec4f/41HF01aJYysVRCrRycJ0rEUYsdf3
	4vCdzHRfeY/JAbIOJORuRDkdHZe4rd2uwllkqReYnSvKlxLO8p5V/mrHhssa6Jmjnhsq/3J/wfe
	NwWYyrcXSm78e55UUvWHX34z6JRkwX9qHW5O1im5+yLqkyZ22jpQ4j4Mvnn2RBfdEt+d4Z9jggW
	LBNPERSS4jZIjn9XPpDE3wTlMTtIPqmQ/GtNg8zhMUjGNbT7qlz7g8uSA4tvxcV8CgW8i624XSS
	9hygWOuZgBJN9d35gVlZYWp79momoIssj9MIpeAiEBsWcnsVo4wE8BxwsxvkvnkN3tUFPjuZyD5
	C6xteYxVR+9OWNuKbNNJxw5BehNs5v5VErs6heEmXUenKmQNim88OMrhtiEveDMqG/K56LiX1/s
	qT6kfCpd6+/cvLOeb1lMHPV9VQcpropnTmNSw=
X-Received: by 2002:ac8:5e4e:0:b0:50f:ba60:2dd4 with SMTP id d75a77b69052e-516419629f0mr95751521cf.40.1778840773597;
        Fri, 15 May 2026 03:26:13 -0700 (PDT)
X-Received: by 2002:ac8:5e4e:0:b0:50f:ba60:2dd4 with SMTP id d75a77b69052e-516419629f0mr95751181cf.40.1778840773127;
        Fri, 15 May 2026 03:26:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3945c8dc7afsm14595861fa.14.2026.05.15.03.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 03:26:12 -0700 (PDT)
Date: Fri, 15 May 2026 13:26:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc8280xp: Add reg and clocks for
 QoS configuration
Message-ID: <r3r37hdua62lpt4xiahuhun5hgz6gtirmvwqo2ze5qaluw4kzo@7ikdv6kj3wxt>
References: <20260507-sc8280xp-qos-v1-0-15135858cd98@radxa.com>
 <20260507-sc8280xp-qos-v1-3-15135858cd98@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507-sc8280xp-qos-v1-3-15135858cd98@radxa.com>
X-Proofpoint-GUID: kBreP12DCDMDwGWorkPBUCr0FFOEXe-d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEwNSBTYWx0ZWRfXwQI1Dt8xNHd2
 2tKfm/ISMXCeW1v5rRvyOqC/lGibzJQi45HKFzfOIeQ9SQBvvN+BdQnJbS4XQobry8aH2JxW13m
 ACDk6ehcG8VUHb0tuhpPL0suGgF+bbZDBiEdCv9NBSA06jmk6UTPDCZAV9AL2gvrCDdbEW3kxa8
 UqMRNVzkVaso/sdVMXjQ+3eBi/oyhXLYMcXNV9rj7dQn3i5H3so5u5JI5hFouHJ2HDCaE4GD55O
 diiWjQX98natKEG3//oTWdDJdG44MJXJhS/bQGWKvhLr7EYHYVkOg4/od/tHftB5qNePBg+JEHo
 W2Udl1SNZax4/XxXDjUL7dg+YIVYlXiac1+HFqa9oWDK8iIFHe+Ma6+Tj0hSmtw3jwTI/lyu6nn
 4ERJWPEthPwmifjiusT4IRpS/zoGUXECRMo1je8YzM9f90umaqaao3RJ5op3b59a68pxi4D5U0p
 5IVHG/DG6EV/NXvs9lw==
X-Proofpoint-ORIG-GUID: kBreP12DCDMDwGWorkPBUCr0FFOEXe-d
X-Authority-Analysis: v=2.4 cv=JPELdcKb c=1 sm=1 tr=0 ts=6a06f4c6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=ksxQWNrZAAAA:8
 a=EUspDBNiAAAA:8 a=7vROA1eCcShV3ZceFmgA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150105

On Thu, May 07, 2026 at 10:25:14PM +0800, Xilin Wu wrote:
> Add register ranges for the SC8280XP interconnect providers so the driver
> can program the NoC QoS registers.
> 
> Move the real NoC providers under soc@0, keep clk_virt and mc_virt as
> virtual top-level providers, and add the clocks required for QoS
> programming on aggre1_noc and aggre2_noc.
> 
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 157 ++++++++++++++++++++-------------
>  1 file changed, 97 insertions(+), 60 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
