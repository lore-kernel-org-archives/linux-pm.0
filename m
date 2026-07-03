Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E4A370D52
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065203; cv=none; b=XoJd3mrj3eTKLR221/Ig8FtQszSg4jxvcpFKTOZjdxzMvlpr0nMX5w3wtmukwe8DpkUCxfAhnuqZ4aO1GMqwercQiGL/OJCp8Ld4MKnVuWlO7w4o4sOOQwIyKMv0hYhepiXkbW1GfO6zEj0mr5xgPE3RDK20kXrKMuY1IRYacrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065203; c=relaxed/simple;
	bh=4GDXcUWg0RJJB35LWW58Z24XSFPlDFhzDi0gE68NIGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izAtm87VdgZwDwNNmaUfF47G4UpJ8BKcLgEV8wOGKqg2BAXrCSyY0F0vdMy1WWBuc+3coy0u+7A3xIgT4NtJSuEWdVSGIWTPFqWAwPVRJXfDcZeHMpep746/YEoP70sPRNWAa+dk+M4sKVn38IDBjd8TweQX6m1toQl/ZhM5Et0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WOOADg8B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DowyvV+u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WOOADg8B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DowyvV+u"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6637ZgNg3410056
	for <linux-pm@vger.kernel.org>; Fri, 3 Jul 2026 07:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	my5LxqpeZJrLYDspU5PJadi/aHSgKZJwjD5QvHa1qxA=; b=WOOADg8B0zZOnxbe
	/L1k1s5BKYj8MsloinIr+OYMOpUNny3YPAg4pcqsGtJOLByl7w5qntAdsEImCmqv
	ftrsCMwrw9JCLEwOZcDvkWAr1ifbAReYE3vJJ1UDric3+S6UcXl41DOAmMFZ6EKa
	6tj3mOuhvphKimTBpx6BSnt3XseGprUK6h7E9R8KfV7TXKpe/xRbDzWClg46gIFP
	CAAMbITW2YRqqrCdAzUwFJU7gw3rIln5iCn8CobHLXYv8Yo4rvdawmrjr2Lm6aY4
	dtEDKzMCTlF7wvKUTmF11mtt8oTTYrZ+26NuLFA27ve5P2JfEDzwISkgHUCCzYgB
	/bY1JQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68u3024y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 07:53:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e6cb57d25so9065085a.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 00:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783065200; x=1783670000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=my5LxqpeZJrLYDspU5PJadi/aHSgKZJwjD5QvHa1qxA=;
        b=DowyvV+ufcJaK8iKAN6GxzmOUobiePUdySL00jQ99EJzEMjJmNS20qELILKdEt4k5c
         ltVOtP4NtfeI0YI+NfWirhDdgV2UB1Q9qEGB0pSiqkQbuoJo9+WphEerb31onTVh5czx
         zo0HolRQ3sl4b7tD/V8XLl2T79R7JYOOmJGhzvxlh3wp/PoIEwytUUFWaHV63fL9LKEm
         TsGARkcJLYiWH3oHdNbSNS1a9k+DIj1+kNFi6FyR5Z6cuBnjnmCobFcnZaF2sWdFMGKR
         sO9RtM0UGvISfznfAUo7MSl+Qn6/mj1oTgeuntB+9PkTG9zqbEuIpBPWnnHK7b7KZncs
         tDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783065200; x=1783670000;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=my5LxqpeZJrLYDspU5PJadi/aHSgKZJwjD5QvHa1qxA=;
        b=Ld1q02yRUyDFqGIAFbRBBi5FyiGP3CGHS2bKtU6L1o8YqYEBJeYkbuxNAHw1RCmCoU
         KLKXBubzgQY4Y9lAh6u263Xh9eY9R7sRp6IEexMS+Rd+Tft3jyEkZ1I9hCdQk3o3VrBd
         HaWbt5YgroAllAe8aV2+mjmmFaK31suRp8OLkURLId572BwIYk7rCkQ6jw/i3Iu8GbD5
         t/GCOgxqr5y+V7LxBXxW8xn1MYQ8oTZ2qF1WalcUqaGSDHJm33RoZBuNqMuQiR25UbBQ
         nGZhCr9C9wX/lThhvtZumHTrWT14H94Bcl/q7qAFuLvrngnNB45xvz5aQTUGH73mmLoW
         xK3Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Xh1Ec87Z4Fcy+NG0ISEfs+5a4+rQUAHC0px5IdJZcED9qhOOl4Lh0+Sc0jR0kIoBhiSN/Q0jZNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV/tnxxKpmocBBmpRKDl5MqHe+UYnk+vFvaYiXIiqbxTi3eSAf
	ACmQYJNROLXRgJ4Iyh9NzMXDYDXbP7IVJg44P6cwLZmyYLA2h2vsDb7bu7yZpY6hj3Hq07bDxxW
	LFnnnGSpQdjSTcWZYeIo0bp/xrXmu2Ab3Bd+NdvsNfjWFiq7tauwhbqHz/UuSCw==
X-Gm-Gg: AfdE7clCRfYHox6qlPm6OXp/91PdctqgIku7MDi6l9rnz618XVyPgqk+HaIhg8vIkE4
	vTVdN5NTEk+09ZBdKk+0Ii3Una2edjiZmOmZwVDeK1j0eTH/TlZSIkJaQmTCWKvfi3/CIm3wHs4
	6yZdQOICIh5RsC8dPnpEfUZxuXz42bYxnzt/3iCTLUFQbQqjFNpZEsVvW0oAc0Z0dUQ9ae1dzSm
	hPC9/rBE7hckcQjMXOM4IxXuefHCdjIqo4ryGDteKO3Af4XnXf0frj2HAsyNWCWJRlhLmg3VMva
	R+k0Iwz7yf9f3n5cLIhRZKIi8ZlbxI26xOR6Y53U0MoqEKDb58XsaPA39pjkUhL7Qp5NTkzjTe4
	CgAMlhEGdT7PPOmNL9iJPOVkeAi2mJpLWqmc=
X-Received: by 2002:a05:620a:19a9:b0:92a:d10e:bde3 with SMTP id af79cd13be357-92e782a7a3dmr728598585a.3.1783065200380;
        Fri, 03 Jul 2026 00:53:20 -0700 (PDT)
X-Received: by 2002:a05:620a:19a9:b0:92a:d10e:bde3 with SMTP id af79cd13be357-92e782a7a3dmr728596785a.3.1783065199915;
        Fri, 03 Jul 2026 00:53:19 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b60575c4sm244853566b.9.2026.07.03.00.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 00:53:19 -0700 (PDT)
Message-ID: <977711ef-c1fb-4735-b82a-4ca2f4797f51@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 09:53:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: firmware: qcom: tmd: add TMD device
 type constants
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-1-3882189c1f83@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260703-qmi-tmd-v4-1-3882189c1f83@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9A958YU3ud7MqAPLqfYAhhk6oUX2F0Kd
X-Proofpoint-ORIG-GUID: 9A958YU3ud7MqAPLqfYAhhk6oUX2F0Kd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3NCBTYWx0ZWRfX/nOlJQm3rAYy
 tRl0NS8cBID0PTqaOZElQwBLjke+A5d1OB4/3juCHqSpobSwKrHRKB1KwIMBnugPPOarh6T+nzS
 539wV87o3aSI+mdkTQs/Q6EgE8nH7kU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3NCBTYWx0ZWRfXwhGVHdIymI69
 9B8IGD3Z9xB9jyM87rWwCVZ1K3WtOdNFObrwmd/dYQNbP2OmELUkI/CdLfKA8pK+Dwbb3B9aCEC
 oiFgfoInBcDge6PAL8q+ZpVdYoAsAi/2h0Sc0FiECOJ6IDaCRx/oyl6PFWifDcsI5FucrUdK+mT
 nDVD9+kJpwvpmb/rnSKmuRmatbyAzMGozvlep7ciUQTOusBXkLBxdGA+i9hvGf0EegMQ2roGqYr
 0WD5VKeeXxYeknCkuIRNWVT+LZDDas1l9bzDscLSi+cH2g0fMU4WHeih7hTjcrJ0V8YIcpjXdla
 jKTIH/X9NtSIx3fGjX9po1TAzWyhqrDg665nkXlYgX8bxcMfZPh1opmMOhkugPEMpfJzrtlGWC9
 MLHo1uD34+k7xnlJ2KfagW+zjx6L6zPCe3p+V6QAbNW6ImboVMotkDxXJ4DHis/Lt37dAEOdO3A
 9RkWUVdWHiNfFo1l4vQ==
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a476a71 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7t_v5s2nVLkGmMFP55oA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030074

On 7/3/26 7:03 AM, Gaurav Kohli wrote:
> Add Device Tree binding constants for Qualcomm Thermal Mitigation
> Device (TMD) types used by remoteproc-backed thermal cooling devices.
> 
> Qualcomm remote processors expose thermal mitigation endpoints
> through QMI. These endpoints can be registered with the thermal
> framework via the `#cooling-cells` property on the remoteproc node.
> 
> The QMI TMD protocol identifies devices using string names (for example,
> "pa", "modem", and "cdsp_sw"), while the DT cooling-device binding with
> `#cooling-cells = <3>` requires numeric device id in the form:
> 
>   <&phandle device_id min_state max_state>
> 
> Define common TMD device index constants shared across currently
> supported platforms. If a future target requires a different mapping,
> additional target-specific constants can be introduced while preserving
> existing DT ABI.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  MAINTAINERS                                 |  1 +
>  include/dt-bindings/firmware/qcom,qmi-tmd.h | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57656ec0e9d5..ffd85fd1dd80 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3410,6 +3410,7 @@ F:	drivers/firmware/qcom/
>  F:	drivers/soc/qcom/
>  F:	drivers/watchdog/gunyah_wdt.c
>  F:	include/dt-bindings/arm/qcom,ids.h
> +F:	include/dt-bindings/firmware/qcom,qmi-tmd.h
>  F:	include/dt-bindings/firmware/qcom,scm.h
>  F:	include/dt-bindings/soc/qcom*
>  F:	include/linux/firmware/qcom
> diff --git a/include/dt-bindings/firmware/qcom,qmi-tmd.h b/include/dt-bindings/firmware/qcom,qmi-tmd.h
> new file mode 100644
> index 000000000000..73efecef0f3c
> --- /dev/null
> +++ b/include/dt-bindings/firmware/qcom,qmi-tmd.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +/*
> + * Qualcomm QMI TMD (Thermal Mitigation Device) cooling device indices
> + *
> + * These indices are used in device tree cooling-maps to reference
> + * specific TMD devices provided by remote processors via QMI.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +#ifndef _DT_BINDINGS_FIRMWARE_QCOM_QMI_TMD_H
> +#define _DT_BINDINGS_FIRMWARE_QCOM_QMI_TMD_H
> +
> +/* CDSP thermal mitigation device id */
> +#define QCOM_CDSP_TMD_CDSP_SW	0
> +
> +/* Modem thermal mitigation device id */
> +#define QCOM_MODEM_TMD_PA	0
> +#define QCOM_MODEM_TMD_MODEM	1

What about the dozens other ones that Dmitry's laptop reports?

https://lore.kernel.org/linux-arm-msm/4gs664zboaqgpok33x7bgorfmhh3f2fahjkt4jjl6fbzpwixnm@hxzz2xeogd4k/

Konrad
