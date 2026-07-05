Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7711A35E1AD
	for <linux-pm@vger.kernel.org>; Sun,  5 Jul 2026 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783244285; cv=none; b=FW+SCbfHA3CWChmjcof0EpuELVhXKC6iEvxIDf/IhyePedi+ob9HfRS0QuabLxFUNpfp97v8LG7YbRATH1qoRR98etjDRMLf1e2Xnghz0GOwilpKe9vnQwqyLopHGt/aaw+9hpayFgQe7zZF/EUVm1SM9inC23EWXrAh3QpA394=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783244285; c=relaxed/simple;
	bh=gCbBXooVnN3k41/0JDtYVjFn6KqbQrAPWx/Q5waJ1NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ab1rD2e77mIGPtkfw/Ss8ZeFcwbBO8kgPmRtc/JU6yJfKgGzwJ4XJjCNL8mA373IBodvwyHNxOuHejeDQ3ebAlcq+dwevTkqjACSdXo1cdNjS8aYNPV9pFgRyAYF8xMNLsh/xvEu3L/SjNwp+0UnvygEwwrcOX5fhu19SKT6Jlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lVLjp1BE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iqhx9puu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lVLjp1BE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iqhx9puu"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 664Napvc146751
	for <linux-pm@vger.kernel.org>; Sun, 5 Jul 2026 09:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ewd3mk0qig3FuHi3oe799MF8ljVGpGl35xYn8JqcSgA=; b=lVLjp1BEh5/02w4q
	EmCL1gltyDlNxJjOL0M16QnFFxBD3NsMcu0ZYncgBlXVZeAGair0/47ULXzurMdb
	34NQBTDy5jBD/vTZ40Uk6KRwTnuEF0jT0oS7utFUQeDoT9UXrVzKrPKRKRIEFqV7
	Yr+euYYz5QMud1uMoMcPdDbImgwJEbg335DNFJIK2zavhxzqRyFpPlvfJwzT99u/
	pJyN+vQvUFBToa55bM3jJNaZy6BNRl8BhDq5IzoDOaf4L7y3mw1NhNe69QdTolVs
	AzX3T2SZ2+sc8mcK7LzJXqVKgN9sUZkKa9NuH1VH4G3anxbRNVe4L4zdtbrPMcMq
	Aqpc8g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6td3aej4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 09:38:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38108fb9d83so1211443a91.2
        for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 02:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783244282; x=1783849082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ewd3mk0qig3FuHi3oe799MF8ljVGpGl35xYn8JqcSgA=;
        b=iqhx9puun1p4NJTMqSi6OvwY+ovXKiwSEQzfCwW7dH27bZbvhQM8FcVMvd4l1OMI3X
         6u/oKOhsiuu5dA09crCZvB4M6uDAMDNMzAFomIVgf4fRF84BF4hwe04NKhj/4qOcmzm6
         JHGYbyepyG7BUwpBvC5V01bM38i7S4G3q1XyAS3EZQQZZG+ADLNmhoPFcdWs/F3MF8/Y
         CSBVi3Zq5dKtSc51atJZLiSgIwqK1xpzQs0lg/PxfHklT7OOuc1uNDmji0N/8q/7N8c/
         cN9tQ3mzf9d81U3MAzQMgUxTOXIbihE++iU95enp7GZ2FTsU2fOeVywWYZOGg8x5jpmw
         3ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783244282; x=1783849082;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ewd3mk0qig3FuHi3oe799MF8ljVGpGl35xYn8JqcSgA=;
        b=I6bVbT/FQyhXhpGBpqzQA0/cbGkDPnoG13CR9dZDp42weCWmtEvOXS8r3Mo54Ifn4Q
         1l7Vp3lX20wgcJkeMqMSwwQdPYISiVNFQBFmF/upb1i4Qpo2v2IWhagCJF+bRsRDOwVy
         YZjdvGokC1XYRTKuBIr2pkXJ/qANHu+5eciUXLGxwvsWMj/PoV64isRQEOoIblRiPxDC
         aczNxZRpRxFWOMGniJM0Aoca/UV0YiinOh36C8Vz2Ddx0JhjV7gsGeVMZd3HoDwcPUKI
         4QPz2ZHO3aBb0rpYOhriATGn3yWbnts18n5omJWCctkTo7455Pi4TurCCKh4t+ugtpqP
         djeg==
X-Forwarded-Encrypted: i=1; AHgh+RoLZo2I7Dyueak0eLT36r5+wWEGQui64tIcnKc+u+3hccjutH823D3C82YDmJbsYXaSHaz54ekURg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBWIczIj94GvpFO8kF04uc8MCxdojt3cw0n5ok1o2tRBffTyv+
	n57MJyEBYRGTmqSIEPFbOapZM3h8DEOO0+Xpm2b10sNbnT11bQWsPaI3YgB1iTLD8tzvEo4griC
	GqAZbS76d9F8uHoiJeThYzQCOAdPTChZ9V3q8XjmaULSrJ9LUVY+V6Kam72C3cQ==
X-Gm-Gg: AfdE7cl3c4nsZ6yYnKZ3zt3PsGr1fuQ5F8Ymyqoy9o/PbOjC2ud1UBm0ryqiQB7rP6J
	3UuuOQwEToU+KjGoIU3ZtYLwgsN7GvGbR4j+XVTple4xxN1uFhFb0nlURhwU9N6zYxAa4uZ5+0j
	78JE91tEUbA8epECYPEkjWkK1Ez4lX/d5N5PIQkKqPhVum/lmtoTCPOeN0QsLaEZhn01hU2pD1h
	MihhhOOcN7NzEbxZLlsd2VEot+RLliiZZtebdxan040nFPqqR5Bnpoh2kfyWbvPfpIKpJYGCiOl
	9DSOK+56EutmTt/gcoosqw4JVVYdifjshcvkTHFmNKMrSf4ATax0zlDpjA80HPIEnqRODWkM2iQ
	Xz3rivay3OrfnIBSL3XFLOIy07s/963tgUyWQR16APA==
X-Received: by 2002:a17:90a:d00b:b0:381:28e0:6259 with SMTP id 98e67ed59e1d1-382808ae0aamr5393733a91.9.1783244281811;
        Sun, 05 Jul 2026 02:38:01 -0700 (PDT)
X-Received: by 2002:a17:90a:d00b:b0:381:28e0:6259 with SMTP id 98e67ed59e1d1-382808ae0aamr5393704a91.9.1783244281232;
        Sun, 05 Jul 2026 02:38:01 -0700 (PDT)
Received: from [192.168.1.13] ([106.222.231.34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b4c5577sm45642249eec.0.2026.07.05.02.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 02:38:00 -0700 (PDT)
Message-ID: <4e9c4810-5ee8-433c-884a-90bd0d29aa62@oss.qualcomm.com>
Date: Sun, 5 Jul 2026 15:07:52 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] soc: qcom: Add QMI TMD support for remote
 thermal mitigation
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Casey Connolly <casey.connolly@linaro.org>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-3-3882189c1f83@oss.qualcomm.com>
 <20260703-overjoyed-laughing-panda-ee7ecb@quoll>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <20260703-overjoyed-laughing-panda-ee7ecb@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA5OSBTYWx0ZWRfX/FDVx86FS6GM
 YA0jz6JF9uX64rGHDVYIk3z+WJIWhmszw8pdtxJjZSW7mdMVh9Y5+/2Hwu11aIp2dEFg7eeHnm6
 vhQnqCry8DIvyjhj318krsNKqlzFjgQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA5OSBTYWx0ZWRfX45+7Z0S4+sRU
 zc+v3aJVANMrU2joaURtZR+zLxsKLMI4xEm6O49RzPRaxbncbAV/fp6q7rOWO2kikQRrcpOOqoo
 GT2rp4/RnoFc1YTmjfNElxYSIdJo7xGKONK3dRAB9SEucFedRjWLVy0951pxoSjbvVlC48fG26X
 hYHkKtnxvvvwvrbEoYcwxN9HbxsV/SwxUXMNxvCdQ2IYfba61cB9FV/tO49lZ3Z11B0mj3s2Ieb
 iD9o2Xmzgx7HDQnZq3IupFTubdWN1ZjfMM16QljvwpF4wKgYMy2kO+h4iWD4K6/AHyYdHxcGghy
 SQ80sTGS+vhkHDRveLRlDTjFQLXmTg1HSlCI6g0VkGu+m2Ckun1HQWCwmfYXqxdz3Ypu5iYow/3
 UIriGLPsjdLyIHSjXCtCY0tVtBRRFCza37GuOtPADJb3VOoDXozc6WSw/tlS2LIg21opMSqLhQh
 q845UOI9i7soXN0Qmrg==
X-Proofpoint-GUID: Gy7fIQkPVvLm-EQbVGtRJiHqRo_ZUWSr
X-Proofpoint-ORIG-GUID: Gy7fIQkPVvLm-EQbVGtRJiHqRo_ZUWSr
X-Authority-Analysis: v=2.4 cv=b9GCJNGx c=1 sm=1 tr=0 ts=6a4a25fa cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JaHktJlP2QtFIg7UHuVw+g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=oNAn0p0IznoDnlf92NwA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050099



On 7/3/2026 1:33 PM, Krzysztof Kozlowski wrote:
> On Fri, Jul 03, 2026 at 10:33:06AM +0530, Gaurav Kohli wrote:
>> From: Casey Connolly <casey.connolly@linaro.org>
>>
>> Add support for Qualcomm Messaging Interface (QMI) based Thermal Mitigation
>> Device (TMD) cooling devices provided by remote subsystems.
>>
>> On Qualcomm platforms where remote processors expose mitigation controls
>> through the TMD QMI service, client drivers need support to discover the
>> service, register cooling devices for available mitigation endpoints,
>> and forward cooling state updates to remote subsystems.
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> Co-developed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>> Co-developed-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   MAINTAINERS                      |   6 +
>>   drivers/soc/qcom/Kconfig         |  10 +
>>   drivers/soc/qcom/Makefile        |   1 +
>>   drivers/soc/qcom/qmi_tmd.c       | 581 +++++++++++++++++++++++++++++++++++++++
>>   include/linux/soc/qcom/qmi.h     |   1 +
>>   include/linux/soc/qcom/qmi_tmd.h |  23 ++
>>   6 files changed, 622 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ffd85fd1dd80..251b1f583913 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -22287,6 +22287,12 @@ F:	Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
>>   F:	Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst
>>   F:	drivers/net/ethernet/qualcomm/ppe/
>>   
>> +QUALCOMM QMI (REMOTEPROC THERMAL MITIGATION) TMD
>> +M:	Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> +L:	linux-arm-msm@vger.kernel.org
>> +L:	linux-pm@vger.kernel.org
>> +F:	drivers/soc/qcom/qmi_tmd.c
>> +
>>   QUALCOMM QSEECOM DRIVER
>>   M:	Maximilian Luz <luzmaximilian@gmail.com>
>>   L:	linux-arm-msm@vger.kernel.org
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 2caadbbcf830..44c2b533b494 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -128,6 +128,16 @@ config QCOM_QMI_HELPERS
>>   	tristate
>>   	depends on NET
>>   
>> +config QCOM_QMI_TMD
>> +	bool "Qualcomm remote subsystem TMD" if COMPILE_TEST
>> +	depends on ARCH_QCOM
>> +	select QCOM_QMI_HELPERS
>> +	help
>> +	  This enables Qualcomm Messaging Interface (QMI) based Thermal Mitigation
>> +	  Device (TMD) support for Qualcomm remote subsystems. It manages
>> +	  TMD messaging and handles QMI communication with remote processors
>> +	  to exchange mitigation state and apply thermal mitigation requests.
>> +
>>   config QCOM_RAMP_CTRL
>>   	tristate "Qualcomm Ramp Controller driver"
>>   	depends on ARCH_QCOM || COMPILE_TEST
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index b7f1d2a57367..4544e61c74e7 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -14,6 +14,7 @@ obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink.o
>>   obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink_altmode.o
>>   obj-$(CONFIG_QCOM_PMIC_PDCHARGER_ULOG)	+= pmic_pdcharger_ulog.o
>>   CFLAGS_pmic_pdcharger_ulog.o	:=  -I$(src)
>> +obj-$(CONFIG_QCOM_QMI_TMD) += qmi_tmd.o
>>   obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
>>   qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
>>   obj-$(CONFIG_QCOM_RAMP_CTRL)	+= ramp_controller.o
>> diff --git a/drivers/soc/qcom/qmi_tmd.c b/drivers/soc/qcom/qmi_tmd.c
>> new file mode 100644
>> index 000000000000..d82500415f8e
>> --- /dev/null
>> +++ b/drivers/soc/qcom/qmi_tmd.c
>> @@ -0,0 +1,581 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2025, Linaro Limited
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + * QMI Thermal Mitigation Device (TMD).
>> + * Provides cooling device support for remote subsystems
>> + * running the TMD service via QMI.
>> + */
>> +#include <linux/cleanup.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/module.h>
>> +#include <linux/net.h>
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>> +#include <linux/soc/qcom/qmi.h>
>> +#include <linux/soc/qcom/qmi_tmd.h>
>> +#include <linux/thermal.h>
>> +
>> +#define QMI_TMD_SERVICE_VERS_V01 0x01
>> +
>> +#define QMI_TMD_SET_LEVEL_REQ 0x0021
>> +#define QMI_TMD_GET_DEV_LIST_REQ 0x0020
>> +
>> +#define QMI_TMD_DEV_ID_LEN_MAX 32
>> +#define QMI_TMD_DEV_LIST_MAX 32
>> +#define QMI_TMD_RESP_TIMEOUT	msecs_to_jiffies(100)
>> +#define TMD_GET_LEVEL_REQ_MAX_LEN 36
>> +#define TMD_SET_LEVEL_REQ_MAX_LEN 40
>> +
>> +#define TMD_GET_DEV_LIST_REQ_MAX_LEN 0
>> +#define TMD_GET_DEV_LIST_RESP_MAX_LEN 1099
>> +
>> +struct tmd_dev_id {
>> +	char mitigation_dev_id[QMI_TMD_DEV_ID_LEN_MAX + 1];
>> +};
>> +
>> +static const struct qmi_elem_info tmd_dev_id_ei[] = {
>> +	{
>> +		.data_type = QMI_STRING,
>> +		.elem_len = QMI_TMD_DEV_ID_LEN_MAX + 1,
>> +		.elem_size = sizeof(char),
>> +		.array_type = NO_ARRAY,
>> +		.tlv_type = 0,
>> +		.offset = offsetof(struct tmd_dev_id,
>> +				   mitigation_dev_id),
>> +	},
>> +	{
>> +		.data_type = QMI_EOTI,
>> +		.array_type = NO_ARRAY,
>> +		.tlv_type = QMI_COMMON_TLV_TYPE,
>> +	},
>> +};
>> +
>> +struct tmd_dev_list {
>> +	struct tmd_dev_id mitigation_dev_id;
>> +	u8 max_mitigation_level;
>> +};
>> +
>> +static const struct qmi_elem_info tmd_dev_list_ei[] = {
>> +	{
>> +		.data_type = QMI_STRUCT,
>> +		.elem_len = 1,
>> +		.elem_size = sizeof(struct tmd_dev_id),
>> +		.array_type = NO_ARRAY,
>> +		.tlv_type = 0,
>> +		.offset = offsetof(struct tmd_dev_list,
>> +				   mitigation_dev_id),
>> +		.ei_array = tmd_dev_id_ei,
>> +	},
>> +	{
>> +		.data_type = QMI_UNSIGNED_1_BYTE,
>> +		.elem_len = 1,
>> +		.elem_size = sizeof(uint8_t),
>> +		.array_type = NO_ARRAY,
>> +		.tlv_type = 0,
>> +		.offset = offsetof(struct tmd_dev_list,
>> +				   max_mitigation_level),
>> +	},
>> +	{
>> +		.data_type = QMI_EOTI,
>> +		.array_type = NO_ARRAY,
>> +		.tlv_type = QMI_COMMON_TLV_TYPE,
>> +	},
>> +};
>> +
>> +struct tmd_get_dev_list_req {
>> +	char placeholder;
>> +};
>> +
>> +static const struct qmi_elem_info tmd_get_dev_list_req_ei[] = {
>> +	{
>> +		.data_type = QMI_EOTI,
>> +		.array_type = NO_ARRAY,
>> +		.tlv_type = QMI_COMMON_TLV_TYPE,
>> +	},
>> +};
>> +
>> +struct tmd_get_dev_list_resp {
>> +	struct qmi_response_type_v01 resp;
>> +	u8 mitigation_device_list_valid;
>> +	u32 mitigation_device_list_len;
>> +	struct tmd_dev_list
>> +		mitigation_device_list[QMI_TMD_DEV_LIST_MAX];
>> +};
>> +
>> +static const struct qmi_elem_info tmd_get_dev_list_resp_ei[] = {
>> +	{
>> +		.data_type = QMI_STRUCT,
>> +		.elem_len = 1,
>> +		.elem_size = sizeof(struct qmi_response_type_v01),
>> +		.array_type = NO_ARRAY,
>> +		.tlv_type = 0x02,
>> +		.offset = offsetof(struct tmd_get_dev_list_resp,
>> +				   resp),
>> +		.ei_array = qmi_response_type_v01_ei,
>> +	},
>> +	{
>> +		.data_type = QMI_OPT_FLAG,
>> +		.elem_len = 1,
>> +		.elem_size = sizeof(uint8_t),
>> +		.array_type = NO_ARRAY,
>> +		.tlv_type = 0x10,
>> +		.offset = offsetof(struct tmd_get_dev_list_resp,
>> +				   mitigation_device_list_valid),
>> +	},
>> +	{
>> +		.data_type = QMI_DATA_LEN,
>> +		.elem_len = 1,
>> +		.elem_size = sizeof(uint8_t),
>> +		.array_type = NO_ARRAY,
>> +		.tlv_type = 0x10,
>> +		.offset = offsetof(struct tmd_get_dev_list_resp,
>> +				   mitigation_device_list_len),
>> +	},
>> +	{
>> +		.data_type = QMI_STRUCT,
>> +		.elem_len = QMI_TMD_DEV_LIST_MAX,
>> +		.elem_size = sizeof(struct tmd_dev_list),
>> +		.array_type = VAR_LEN_ARRAY,
>> +		.tlv_type = 0x10,
>> +		.offset = offsetof(struct tmd_get_dev_list_resp,
>> +				   mitigation_device_list),
>> +		.ei_array = tmd_dev_list_ei,
>> +	},
>> +	{
>> +		.data_type = QMI_EOTI,
>> +		.array_type = NO_ARRAY,
>> +		.tlv_type = QMI_COMMON_TLV_TYPE,
>> +	},
>> +};
>> +
>> +struct tmd_set_level_req {
>> +	struct tmd_dev_id mitigation_dev_id;
>> +	u8 mitigation_level;
>> +};
>> +
>> +static const struct qmi_elem_info tmd_set_level_req_ei[] = {
>> +	{
>> +		.data_type = QMI_STRUCT,
>> +		.elem_len = 1,
>> +		.elem_size = sizeof(struct tmd_dev_id),
>> +		.array_type = NO_ARRAY,
>> +		.tlv_type = 0x01,
>> +		.offset = offsetof(struct tmd_set_level_req,
>> +				   mitigation_dev_id),
>> +		.ei_array = tmd_dev_id_ei,
>> +	},
>> +	{
>> +		.data_type = QMI_UNSIGNED_1_BYTE,
>> +		.elem_len = 1,
>> +		.elem_size = sizeof(uint8_t),
>> +		.array_type = NO_ARRAY,
>> +		.tlv_type = 0x02,
>> +		.offset = offsetof(struct tmd_set_level_req,
>> +				   mitigation_level),
>> +	},
>> +	{
>> +		.data_type = QMI_EOTI,
>> +		.array_type = NO_ARRAY,
>> +		.tlv_type = QMI_COMMON_TLV_TYPE,
>> +	},
>> +};
>> +
>> +struct tmd_set_level_resp {
>> +	struct qmi_response_type_v01 resp;
>> +};
>> +
>> +static const struct qmi_elem_info tmd_set_level_resp_ei[] = {
>> +	{
>> +		.data_type = QMI_STRUCT,
>> +		.elem_len = 1,
>> +		.elem_size = sizeof(struct qmi_response_type_v01),
>> +		.array_type = NO_ARRAY,
>> +		.tlv_type = 0x02,
>> +		.offset = offsetof(struct tmd_set_level_resp, resp),
>> +		.ei_array = qmi_response_type_v01_ei,
>> +	},
>> +	{
>> +		.data_type = QMI_EOTI,
>> +		.array_type = NO_ARRAY,
>> +		.tlv_type = QMI_COMMON_TLV_TYPE,
>> +	},
>> +};
>> +
>> +/**
>> + * struct qmi_tmd - A TMD cooling device
>> + * @name:	The name of this tmd shared by the remote subsystem
>> + * @cdev:	Thermal cooling device handle
>> + * @cur_state:	The current mitigation state
>> + * @max_state:	The maximum state
>> + * @qmi_tmd_cli:	Parent QMI TMD client
>> + */
>> +struct qmi_tmd {
>> +	const char *name;
>> +	struct thermal_cooling_device *cdev;
>> +	unsigned int cur_state;
>> +	unsigned int max_state;
>> +	struct qmi_tmd_client *qmi_tmd_cli;
>> +};
>> +
>> +/**
>> + * struct qmi_tmd_client - QMI TMD client state
>> + * @dev:		Device associated with this instance
>> + * @handle:		QMI connection handle
>> + * @mutex:		Serializes QMI request/response sequences (qmi_txn_init,
>> + *			qmi_send_request) during DSP subsystem restart and
>> + *			protects @connection_active flag
>> + * @connection_active:	Whether or not we're connected to the QMI TMD service
>> + * @svc_arrive_work:	Work item for initialising when the TMD service starts
>> + * @num_tmds:		Number of tmds described in the device tree
>> + * @tmds:		An array of tmd structures
>> + */
>> +struct qmi_tmd_client {
>> +	struct device *dev;
>> +	struct qmi_handle handle;
>> +	/* protects QMI transactions and connection_active */
>> +	struct mutex mutex;
>> +	bool connection_active;
>> +	struct work_struct svc_arrive_work;
>> +	int num_tmds;
>> +	struct qmi_tmd tmds[] __counted_by(num_tmds);
>> +};
>> +
>> +/* Notify the remote subsystem of the requested cooling state */
>> +static int qmi_tmd_send_state_request(struct qmi_tmd *tmd, int state)
>> +{
>> +	struct tmd_set_level_resp resp = { 0 };
>> +	struct tmd_set_level_req req = { 0 };
>> +	struct qmi_tmd_client *qmi_tmd_cli = tmd->qmi_tmd_cli;
>> +	struct qmi_txn txn;
>> +	int ret = 0;
>> +
>> +	guard(mutex)(&qmi_tmd_cli->mutex);
>> +
>> +	if (!qmi_tmd_cli->connection_active)
>> +		return 0;
>> +
>> +	strscpy(req.mitigation_dev_id.mitigation_dev_id, tmd->name,
>> +		QMI_TMD_DEV_ID_LEN_MAX + 1);
>> +	req.mitigation_level = state;
>> +
>> +	ret = qmi_txn_init(&qmi_tmd_cli->handle, &txn,
>> +			   tmd_set_level_resp_ei, &resp);
>> +	if (ret < 0) {
>> +		dev_err(qmi_tmd_cli->dev, "qmi set state %d txn init failed for %s ret %d\n",
>> +			state, tmd->name, ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = qmi_send_request(&qmi_tmd_cli->handle, NULL, &txn,
>> +			       QMI_TMD_SET_LEVEL_REQ,
>> +			       TMD_SET_LEVEL_REQ_MAX_LEN,
>> +			       tmd_set_level_req_ei, &req);
>> +	if (ret < 0) {
>> +		dev_err(qmi_tmd_cli->dev, "qmi set state %d txn send failed for %s ret %d\n",
>> +			state, tmd->name, ret);
>> +		qmi_txn_cancel(&txn);
>> +		return ret;
>> +	}
>> +
>> +	ret = qmi_txn_wait(&txn, QMI_TMD_RESP_TIMEOUT);
>> +	if (ret < 0) {
>> +		dev_err(qmi_tmd_cli->dev, "qmi set state %d txn wait failed for %s ret %d\n",
>> +			state, tmd->name, ret);
>> +		return ret;
>> +	}
>> +
>> +	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
>> +		dev_err(qmi_tmd_cli->dev,
>> +			"qmi set state %d failed for %s result %#x error %#x\n",
>> +			state, tmd->name,
>> +			resp.resp.result, resp.resp.error);
>> +		return -EREMOTEIO;
>> +	}
>> +
>> +	dev_dbg(qmi_tmd_cli->dev, "Requested state %d/%d for %s\n", state,
>> +		tmd->max_state, tmd->name);
>> +
>> +	return 0;
>> +}
>> +
>> +static int qmi_tmd_get_max_state(struct thermal_cooling_device *cdev,
>> +				 unsigned long *state)
>> +{
>> +	struct qmi_tmd *tmd = cdev->devdata;
>> +
>> +	*state = tmd->max_state;
>> +
>> +	return 0;
>> +}
>> +
>> +static int qmi_tmd_get_cur_state(struct thermal_cooling_device *cdev,
>> +				 unsigned long *state)
>> +{
>> +	struct qmi_tmd *tmd = cdev->devdata;
>> +
>> +	/* cur_state is protected by thermal core's cdev->lock */
>> +	*state = tmd->cur_state;
>> +
>> +	return 0;
>> +}
>> +
>> +static int qmi_tmd_set_cur_state(struct thermal_cooling_device *cdev,
>> +				 unsigned long state)
>> +{
>> +	struct qmi_tmd *tmd = cdev->devdata;
>> +	int ret;
>> +
>> +	if (state > tmd->max_state)
>> +		return -EINVAL;
>> +
>> +	/* cur_state is protected by thermal core's cdev->lock */
>> +	if (tmd->cur_state == state)
>> +		return 0;
>> +
>> +	ret = qmi_tmd_send_state_request(tmd, state);
>> +	if (!ret)
>> +		tmd->cur_state = state;
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct thermal_cooling_device_ops qmi_tmd_cooling_ops = {
>> +	.get_max_state = qmi_tmd_get_max_state,
>> +	.get_cur_state = qmi_tmd_get_cur_state,
>> +	.set_cur_state = qmi_tmd_set_cur_state,
>> +};
>> +
>> +static int qmi_tmd_register(struct qmi_tmd_client *qmi_tmd_cli,
>> +			    const char *label, u8 max_state)
>> +{
>> +	struct device *dev = qmi_tmd_cli->dev;
>> +	struct qmi_tmd *tmd;
>> +	int index;
>> +
>> +	for (index = 0; index < qmi_tmd_cli->num_tmds; index++) {
>> +		tmd = &qmi_tmd_cli->tmds[index];
>> +
>> +		if (!strncasecmp(tmd->name, label,
>> +				 QMI_TMD_DEV_ID_LEN_MAX + 1))
>> +			goto found;
>> +	}
>> +
>> +	dev_dbg(qmi_tmd_cli->dev,
>> +		"TMD '%s' available in firmware but not specified in DT\n",
>> +		label);
>> +	return 0;
>> +
>> +found:
>> +	tmd->max_state = max_state;
>> +
>> +	/*
>> +	 * If the cooling device already exists then the QMI service went away and
>> +	 * came back. So just make sure the current cooling device state is
>> +	 * reflected on the remote side and then return.
>> +	 */
>> +	if (tmd->cdev)
>> +		return qmi_tmd_send_state_request(tmd, tmd->cur_state);
>> +
>> +	tmd->cdev = thermal_of_cooling_device_register(dev->of_node, index,
>> +						       label, tmd, &qmi_tmd_cooling_ops);
>> +	if (IS_ERR(tmd->cdev))
>> +		return PTR_ERR(tmd->cdev);
>> +
>> +	return 0;
>> +}
>> +
>> +static void qmi_tmd_unregister(struct qmi_tmd_client *qmi_tmd_cli)
>> +{
>> +	struct qmi_tmd *tmd;
>> +	int index;
>> +
>> +	for (index = 0; index < qmi_tmd_cli->num_tmds; index++) {
>> +		tmd = &qmi_tmd_cli->tmds[index];
>> +
>> +		if (!tmd->cdev)
>> +			continue;
>> +
>> +		thermal_cooling_device_unregister(tmd->cdev);
>> +		tmd->cdev = NULL;
>> +	}
>> +}
>> +
>> +static void qmi_tmd_svc_arrive(struct work_struct *work)
>> +{
>> +	struct qmi_tmd_client *qmi_tmd_cli =
>> +		container_of(work, struct qmi_tmd_client, svc_arrive_work);
>> +
>> +	struct tmd_get_dev_list_req req = { 0 };
>> +	struct tmd_get_dev_list_resp *resp __free(kfree) = NULL;
>> +	int ret, i;
>> +	struct qmi_txn txn;
>> +
>> +	resp = kzalloc_obj(*resp, GFP_KERNEL);
>> +	if (!resp) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	scoped_guard(mutex, &qmi_tmd_cli->mutex) {
>> +		ret = qmi_txn_init(&qmi_tmd_cli->handle, &txn,
>> +				   tmd_get_dev_list_resp_ei, resp);
>> +		if (ret < 0)
>> +			goto out;
>> +
>> +		ret = qmi_send_request(&qmi_tmd_cli->handle, NULL, &txn,
>> +				       QMI_TMD_GET_DEV_LIST_REQ,
>> +				TMD_GET_DEV_LIST_REQ_MAX_LEN,
>> +				tmd_get_dev_list_req_ei, &req);
>> +		if (ret < 0) {
>> +			qmi_txn_cancel(&txn);
>> +			goto out;
>> +		}
>> +
>> +		ret = qmi_txn_wait(&txn, QMI_TMD_RESP_TIMEOUT);
>> +		if (ret < 0)
>> +			goto out;
>> +
>> +		if (resp->resp.result != QMI_RESULT_SUCCESS_V01) {
>> +			ret = -EPROTO;
>> +			goto out;
>> +		}
>> +
>> +		qmi_tmd_cli->connection_active = true;
>> +	}
>> +
>> +	for (i = 0; i < resp->mitigation_device_list_len; i++) {
>> +		struct tmd_dev_list *device =
>> +			&resp->mitigation_device_list[i];
>> +
>> +		ret = qmi_tmd_register(qmi_tmd_cli,
>> +				       device->mitigation_dev_id.mitigation_dev_id,
>> +				       device->max_mitigation_level);
>> +		if (ret)
>> +			break;
>> +	}
>> +
>> +out:
>> +	if (ret)
>> +		dev_err(qmi_tmd_cli->dev, "Failed to initialize TMD service: %d\n", ret);
>> +}
>> +
>> +static void qmi_tmd_del_server(struct qmi_handle *qmi, struct qmi_service *service)
>> +{
>> +	struct qmi_tmd_client *qmi_tmd_cli =
>> +		container_of(qmi, struct qmi_tmd_client, handle);
>> +
>> +	scoped_guard(mutex, &qmi_tmd_cli->mutex) {
>> +		qmi_tmd_cli->connection_active = false;
>> +	}
>> +}
>> +
>> +static int qmi_tmd_new_server(struct qmi_handle *qmi, struct qmi_service *service)
>> +{
>> +	struct sockaddr_qrtr sq = { AF_QIPCRTR, service->node, service->port };
>> +	struct qmi_tmd_client *qmi_tmd_cli;
>> +	int ret;
>> +
>> +	qmi_tmd_cli = container_of(qmi, struct qmi_tmd_client, handle);
>> +
>> +	scoped_guard(mutex, &qmi_tmd_cli->mutex) {
>> +		ret = kernel_connect(qmi->sock, (struct sockaddr_unsized *)&sq,
>> +				     sizeof(sq), 0);
>> +	}
>> +
>> +	if (ret < 0) {
>> +		dev_err(qmi_tmd_cli->dev, "QMI connect failed for node %u port %u: %d\n",
>> +			service->node, service->port, ret);
>> +		return ret;
>> +	}
>> +
>> +	queue_work(system_highpri_wq, &qmi_tmd_cli->svc_arrive_work);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct qmi_ops qmi_tmd_ops = {
>> +	.new_server = qmi_tmd_new_server,
>> +	.del_server = qmi_tmd_del_server,
>> +};
>> +
>> +/**
>> + * qmi_tmd_init() - Initialize QMI TMD instance
>> + * @dev: Device pointer
>> + * @instance_id: QMI service instance ID for the remote subsystem
>> + * @tmd_names: Array of TMD names
>> + * @num_tmds: Number of TMD names
>> + *
>> + * Return: Pointer to qmi_tmd_client on success, ERR_PTR on failure
>> + */
>> +struct qmi_tmd_client *qmi_tmd_init(struct device *dev,
>> +				    unsigned int instance_id,
>> +				    const char * const *tmd_names,
>> +				    int num_tmds)
>> +{
>> +	struct qmi_tmd_client *qmi_tmd_cli;
>> +	int ret, i;
>> +
>> +	if (!dev || !tmd_names || num_tmds <= 0)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	qmi_tmd_cli = devm_kzalloc(dev, struct_size(qmi_tmd_cli, tmds, num_tmds), GFP_KERNEL);
> 
> Either this is dedicated to probe path or can be called from any context
> (probe or not probe). If the first, above is correct, but then:
> 1. kerneldoc is incomplete or function should be renamed to have _probe suffix,
> 2. why aren't you using dev_err_probe()?
> 

Thanks for review, this is probe-path only.
Will update the comment for context and dev_err_probe as well.

> If the latter, then above code is not correct because you do not have
> cleanup in qmi_tmd_exit() part, which leads to unspecific/unorganized
> way of cleaning devm resources during cleanup calls. Plus actual cleanup
> does not happen when consumer/user calls exit() but when remove() is
> called, leading to possible huge memory usage (not leak technically but
> same effect).
> 
>> +	if (!qmi_tmd_cli)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	qmi_tmd_cli->dev = dev;
>> +	qmi_tmd_cli->num_tmds = num_tmds;
>> +	mutex_init(&qmi_tmd_cli->mutex);
>> +	INIT_WORK(&qmi_tmd_cli->svc_arrive_work, qmi_tmd_svc_arrive);
>> +
>> +	for (i = 0; i < num_tmds; i++) {
>> +		qmi_tmd_cli->tmds[i].name = tmd_names[i];
>> +		qmi_tmd_cli->tmds[i].qmi_tmd_cli = qmi_tmd_cli;
>> +	}
>> +
>> +	ret = qmi_handle_init(&qmi_tmd_cli->handle,
>> +			      TMD_GET_DEV_LIST_RESP_MAX_LEN,
>> +			      &qmi_tmd_ops, NULL);
>> +	if (ret < 0) {
>> +		dev_err(dev, "QMI handle init failed: %d\n", ret);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	ret = qmi_add_lookup(&qmi_tmd_cli->handle, QMI_SERVICE_ID_TMD,
>> +			     QMI_TMD_SERVICE_VERS_V01, instance_id);
>> +	if (ret < 0) {
>> +		dev_err(dev, "QMI add lookup failed: %d\n", ret);
>> +		goto err_release_handle;
>> +	}
>> +
>> +	return qmi_tmd_cli;
>> +
>> +err_release_handle:
>> +	qmi_handle_release(&qmi_tmd_cli->handle);
>> +
>> +	return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(qmi_tmd_init);
>> +
>> +/**
>> + * qmi_tmd_exit() - Deinitialize QMI TMD instance
>> + * @qmi_tmd_cli: QMI TMD client to deinitialize
>> + */
>> +void qmi_tmd_exit(struct qmi_tmd_client *qmi_tmd_cli)
>> +{
>> +	if (!qmi_tmd_cli)
>> +		return;
>> +
>> +	cancel_work_sync(&qmi_tmd_cli->svc_arrive_work);
> 
> And what if work is re-queued now?

Thanks for catching this, qmi_handle_release should come before cancel 
of work item. Releasing the handle closes the socket which prevents any 
further callbacks. Will update this.
> 
>> +	qmi_handle_release(&qmi_tmd_cli->handle);
>> +	qmi_tmd_unregister(qmi_tmd_cli);
>> +
>> +	scoped_guard(mutex, &qmi_tmd_cli->mutex)
>> +		qmi_tmd_cli->connection_active = false;
>> +}
>> +EXPORT_SYMBOL_GPL(qmi_tmd_exit);
> 
> Best regards,
> Krzysztof
> 

