Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7EB43F08C
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 08:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757118; cv=none; b=cZtbowvLabqSyem+yXuHSdITBF40c46aZtR2TstFlUa+BBqMaO3+V/QgD23mWnoEu2MMu8a35qEUI91YQub/FN4Z63EvOIt+Ja0rBWsFt/8bAgmmpc0v2ouf3eXL1md0Bwh/w9+EX09kp3fjxgUdLsKDGnaOdR4Vu5HkDorAKfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757118; c=relaxed/simple;
	bh=Opt4VNuc2KPpgMuc2/rksZqDzapRigDwXQ8lJQZDPAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzN0ciHyJwll3HGAJFZB2b2XyNjb8sISuaLKd88LBZF9qTs0HSozbk/6MIpPiAZqYcoE7hErNjq01y3pnlCo0Hn64tS9++A4BU2SWLZAj0SCKTlmEn68FSutjM43xxK+ogu8DxIqPxJVOtUNl0xNwj3wmRMnsLJOdleDPutffhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O/Lntel+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cufaX+39; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O/Lntel+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cufaX+39"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U7dRKX1556144
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 08:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y+H1wvxx0wJT8GWVnuJAvDW4MyRHAxC/g56qNfnbS2o=; b=O/Lntel+xwdwmmqN
	6iphkvMp7V3/0IM04VrEMobR8ZcLReKQEcHV+3bQZA+Y0rrupu86f0ke6pVf971+
	zu4Ow+lAEOcF9nYT3CAKX3ZHvdRwgraLIj01p51AxENIYVh7KaXxRCMjQXrA3SIM
	WvFqwyOGG0MleINB91JyN7RiZjnWCx5aWb97Nw3lZUxrsyHXFlsIEe0ZUwO7wNLK
	RIj3uCMDkT3c2h6m6ZXEFTsTP9jUGx5VhyWK2Wp7uTKbjIMV5QbUJGvbkxsGMB1n
	TiMqs3A6V4Gm4hViVJcN7to7Hks/DZh7dO2avulCaBIkqMu05N/lDtePC9Y4Ozo6
	tI4/TA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0x1c09ds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 08:31:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a01d1d1b6so915046085a.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790757108; x=1791361908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y+H1wvxx0wJT8GWVnuJAvDW4MyRHAxC/g56qNfnbS2o=;
        b=cufaX+39rejGHOmCigQaj0sPGb4V1+lzAN2AFAloP31SQfUM8wm/4qCTDkHfll1KXQ
         9BJrSMJkw8r1IrgmXR19TfWyBwWYNq9RqrEk2fKSiAWHbDJtZmxsYn5kD0P0MKqZiCfg
         IC5iu0lknNzLlYQhoVj3Ttjipss8QHh8xm4h3ctgRmyHm6sdh135RVCWYQMF9L5dJd9K
         AQ2ddb5YxhDi1I+1Ab9zrinnV3vM64wkOHTqaY51iamPKwd39sO63CunEWibhYiZs8ni
         xkUa9a3+S0YpYxAgr2lSAUqAtkw8bSdtqfMMHP5dvI6F6/JaqnUggqOX3WlmaV5ZFRVe
         Ymnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790757108; x=1791361908;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y+H1wvxx0wJT8GWVnuJAvDW4MyRHAxC/g56qNfnbS2o=;
        b=v96z7cbH0PuEdYXcZ/lw28qMu8UzrEHUELOV8r7YEKSJPl5Xy0JyXeggpMMAtYSbww
         rv1zT2ORg7rLIZt0lRHiCEea0/sKpq4oqclfQM+7HoFqzFecgEV1BxiQV6H0pMz9A2ec
         8BmMnudFyTxeBUpOMH+J6GYTapHSg2OL+YfWH9mPSBAzPNJGnuy2Nfi2WRrPd2daR7M6
         L2jXgda6w3yidSqU0zFgVm7XPXBmTS0J5VSu2s+9Uwmc1JoY/yg4mP4cOTVYuVIIbI+9
         9BpD7u0QZvfA7sg4XAhJNZc5UINLjp/qJlVBM/PFOEuaaL3+S2fQXhXLQM+tyrD5bijF
         v6yg==
X-Forwarded-Encrypted: i=1; AKwUvBzL+GndNhm59lWPoE2UU6cO11sR3D/kl6OPmp5sGWS8i8NUZUOhlK4cBYTiDEtWwl7Zpb3FmsmuPA==@vger.kernel.org
X-Gm-Message-State: AFuF++nPvv8j9iTui1+SjqF6oK09YMz51osJNmZ9Mx+fmS1JMPNz3U9s
	4UOfnCXj7cyrna7yANtpxRAQHm3VbIRNNzba4AF3nvsCD3xV2+VpOELfpaUcbwpd/TywC7G87Wq
	sK0kzoUM1P2vXFMNR1TKY5es53N0wUbzNaPHoPLDnCEm4PEkkbndlZQpw0AYIwQ==
X-Gm-Gg: AYBFou0JFaLImUf5zE2luB/ELZUvUEmaAO3MS4LrB6hLq/01it/j+tUk3R8E57OHcUU
	3pCQo42UZRC0oKmoLiZm3xUeyaD8QiTXhWjmeKEb3LVaZ0cNlnZ0YK/xTAHcKfCkJE7swKmMaXr
	SQPMPr/sjHauWEDjGflFJTWoMqdK6DiFpA2dAjZ3aqi0T4ty3AyRTU8HT8qeCesjbY0jf6r2J+d
	9KNNOYOoyj1DQu+wCxaSKRZrH/MuumFT/xfR1+DTfPJWgS0YnOJfvj0MjDtQdJQ9Qc+bvT0mV7Y
	p48WHFaLzRnAaeSew+blhPiFBDtpfOT8JEaiMYM1eCsH0buLqhhEToVSpiyWwrw0kas6DfmQXl3
	rNfkIfuUlpylqnoSD6eSoXMUHAU9KGEVuFa2x/0/O
X-Received: by 2002:a05:620a:4398:b0:93c:8d49:ee4c with SMTP id af79cd13be357-93ca96b42b4mr84396785a.27.1790757107633;
        Wed, 30 Sep 2026 01:31:47 -0700 (PDT)
X-Received: by 2002:a05:620a:4398:b0:93c:8d49:ee4c with SMTP id af79cd13be357-93ca96b42b4mr84392585a.27.1790757107064;
        Wed, 30 Sep 2026 01:31:47 -0700 (PDT)
Received: from [192.168.25.64] ([94.155.124.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a017520e1bsm29919385e9.6.2026.09.30.01.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 01:31:46 -0700 (PDT)
Message-ID: <9394c0d0-1d40-4237-8481-3f7cbebf9980@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 11:31:44 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] interconnect: qcom: Add CAMNOC interconnect
 provider driver
To: Bryan O'Donoghue <bod@kernel.org>,
        Atanas Filipov <atanas.filipov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260819093211.1436275-1-atanas.filipov@oss.qualcomm.com>
 <BL_JgUju90yJ83WelqJjGySbDZXaF6FONsvtmnFfm9fSkHcYKfQOQnCXainWwse1bgfCXlxKOhWSNLNPg2uXuQ==@protonmail.internalid>
 <20260819093211.1436275-3-atanas.filipov@oss.qualcomm.com>
 <ea7958f2-44bb-477e-b06a-44153489f396@kernel.org>
Content-Language: en-US
From: "Gjorgji Rosikopulos (Consultant)"
 <gjorgji.rosikopulos@oss.qualcomm.com>
In-Reply-To: <ea7958f2-44bb-477e-b06a-44153489f396@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzMyBTYWx0ZWRfX33q83GMfhJPs
 SkaygP0eRt0RzdE9czPVgEmTOxqnRHXG+1elZD0I3aELGNFhAnWIfiaMDpnJZ41r7v4ArkLIsY3
 DFknMNKNrvKYtqpjt31mGsUZjSuUVZE=
X-Proofpoint-ORIG-GUID: lDnZVHigItGkE6ABWd-BAmvKX8UlOtKo
X-Authority-Analysis: v=2.4 cv=VrC2kO2n c=1 sm=1 tr=0 ts=6abcc8f4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=eGCDHFSXubCXFTSSGhjuOA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=lZvclhIxJYcy508GXbEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: lDnZVHigItGkE6ABWd-BAmvKX8UlOtKo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzMyBTYWx0ZWRfX3vzKbAX6RXOR
 1k8DJJeanadMDQxUUESSqiLzAz853CLUSW16ssS/GWO3bo92yWZVyUoSmNs65Dl0CYTGLBkZErz
 u7Gl0F4WU5jTVGTOdJSpg8B5nZZTW6EIx83M7bzkKjAXjbFlZW3zG/LjZwf68KxGzB6TH5k7y28
 IpTu+mhDoA5ni73Qo0C4sXk/UjDhLOxj2jFk5vbB7yO1OcqFAIdDLnuExg4Ho7BGxvxcuXgJhug
 NAI0geCxoHIMutcVl3yCcAcG97KzQ4BcOa5I2PMnLNC3Mnhi3UG7BsCFu4/vhShkGjdft2DpFhh
 ggw95+GwONl5zoE6LWbGKcBqFC+th//coDr5kMhtF/o+SxH9HnS4/5O+jY02WxKAgl1GZI4yofd
 VshkfM/hLIdhqJNXFVVDyi1mj0uXwMeQso+zV6L2NsGqhPPSfdtCbEhThYb7C62BOo2n41fmYAi
 n21549qeJYRAxlHUNsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300033

Hi Bryan,

On 9/29/2026 11:36 AM, Bryan O'Donoghue wrote:
> On 19/08/2026 10:32, Atanas Filipov wrote:
>> Add an ICC provider for the Qualcomm Camera NOC (CAMNOC). Multiple
>> camera sub-devices share CAM_CC_CAMNOC_AXI_CLK; direct clk_set_rate()
>> calls from each consumer cause a last-writer-wins race.
>>
>> Each consumer obtains an ICC path to SLAVE_CAMNOC_AXI and votes via
>> icc_set_bw(). The ICC core aggregates votes (max peak_bw) and the
>> set() callback converts the result to clk_set_rate(). Consumers
>> encode the required frequency as peak_bw in kBps.
>>
>> Signed-off-by: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
>> ---
>>   drivers/interconnect/qcom/Kconfig       |  10 +
>>   drivers/interconnect/qcom/Makefile      |   2 +
>>   drivers/interconnect/qcom/qcom-camnoc.c | 279 ++++++++++++++++++++++++
>>   3 files changed, 291 insertions(+)
>>   create mode 100644 drivers/interconnect/qcom/qcom-camnoc.c
>>
>> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
>> index 5b8a094ca4ed..9d9d238019a0 100644
>> --- a/drivers/interconnect/qcom/Kconfig
>> +++ b/drivers/interconnect/qcom/Kconfig
>> @@ -135,6 +135,16 @@ config INTERCONNECT_QCOM_NORD
>>   	  the RPMh hardware and communicates via Bus Clock Manager (BCM)
>>   	  through the Resource State Coordinator (RSC).
>>
>> +config INTERCONNECT_QCOM_CAMNOC
>> +	tristate "Qualcomm CAMNOC interconnect driver"
>> +	depends on INTERCONNECT_QCOM || COMPILE_TEST
>> +	depends on ARM64 || COMPILE_TEST
>> +	help
>> +	  Say y here to support the Camera Network-on-Chip (CAMNOC)
>> +	  interconnect driver for Qualcomm SoCs. It aggregates bandwidth
>> +	  requests from camera sub-devices (IFE, JPEG, BPS, etc.) and
>> +	  scales CAM_CC_CAMNOC_AXI_CLK accordingly.
>> +
>>   config INTERCONNECT_QCOM_OSM_L3
>>   	tristate "Qualcomm OSM L3 interconnect driver"
>>   	depends on INTERCONNECT_QCOM || COMPILE_TEST
>> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
>> index 1c7d410b40cc..52a5998ae6a8 100644
>> --- a/drivers/interconnect/qcom/Makefile
>> +++ b/drivers/interconnect/qcom/Makefile
>> @@ -18,6 +18,7 @@ qnoc-msm8974-objs			:= msm8974.o
>>   qnoc-msm8976-objs			:= msm8976.o
>>   qnoc-msm8996-objs			:= msm8996.o
>>   qnoc-nord-objs				:= nord.o
>> +icc-camnoc-objs				:= qcom-camnoc.o
>>   icc-osm-l3-objs				:= osm-l3.o
>>   qnoc-qcm2290-objs			:= qcm2290.o
>>   qnoc-qcs404-objs			:= qcs404.o
>> @@ -66,6 +67,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) += qnoc-msm8974.o
>>   obj-$(CONFIG_INTERCONNECT_QCOM_MSM8976) += qnoc-msm8976.o
>>   obj-$(CONFIG_INTERCONNECT_QCOM_MSM8996) += qnoc-msm8996.o
>>   obj-$(CONFIG_INTERCONNECT_QCOM_NORD) += qnoc-nord.o
>> +obj-$(CONFIG_INTERCONNECT_QCOM_CAMNOC) += icc-camnoc.o
>>   obj-$(CONFIG_INTERCONNECT_QCOM_OSM_L3) += icc-osm-l3.o
>>   obj-$(CONFIG_INTERCONNECT_QCOM_QCM2290) += qnoc-qcm2290.o
>>   obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
>> diff --git a/drivers/interconnect/qcom/qcom-camnoc.c b/drivers/interconnect/qcom/qcom-camnoc.c
>> new file mode 100644
>> index 000000000000..9a703b052b2d
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/qcom-camnoc.c
>> @@ -0,0 +1,279 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + * Qualcomm Camera NOC (CAMNOC) interconnect provider.
>> + *
>> + * CAMNOC is the internal AXI interconnect within the Qualcomm camera
>> + * subsystem. Multiple camera sub-devices (IFE, JPEG, BPS, etc.) share
>> + * CAM_CC_CAMNOC_AXI_CLK. This driver acts as an ICC provider so that
>> + * each sub-device can independently vote for bandwidth; the ICC core
>> + * aggregates the votes (max of peak_bw across all consumers) and this
>> + * driver translates the result into a clk_set_rate() call, avoiding
>> + * the last-writer-wins race that occurs with direct clk_set_rate().
>> + *
>> + * Consumers express their required clock rate directly as peak_bw in
>> + * kBps (e.g. 400000 for 400 MHz).  The driver converts kBps → Hz:
>> + *   rate_hz = peak_bw_kBps * 1000
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/interconnect-provider.h>
>> +#include <linux/interconnect.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <dt-bindings/interconnect/qcom,camnoc.h>
>> +
>> +#define to_camnoc_provider(_p) \
>> +	container_of(_p, struct qcom_camnoc_icc_provider, provider)
>> +
>> +struct qcom_camnoc_icc_provider {
>> +	struct clk *clk;
>> +	struct icc_provider provider;
>> +};
>> +
>> +struct qcom_camnoc_node {
>> +	const char *name;
>> +	u16 buswidth;
>> +};
>> +
>> +/* IFE */
>> +static const struct qcom_camnoc_node camnoc_master_ife_0 = {
>> +	.name = "master-camnoc-ife-0", .buswidth = 16
>> +};
>> +
>> +static const struct qcom_camnoc_node camnoc_master_ife_0_rdi = {
>> +	.name = "master-camnoc-ife-0-rdi", .buswidth = 16
>> +};
>> +
>> +static const struct qcom_camnoc_node camnoc_master_ife_1 = {
>> +	.name = "master-camnoc-ife-1", .buswidth = 16
>> +};
>> +
>> +static const struct qcom_camnoc_node camnoc_master_ife_1_rdi = {
>> +	.name = "master-camnoc-ife-1-rdi", .buswidth = 16
>> +};
>> +
>> +static const struct qcom_camnoc_node camnoc_master_ife_lite_0 = {
>> +	.name = "master-camnoc-ife-lite-0", .buswidth = 8
>> +};
>> +
>> +static const struct qcom_camnoc_node camnoc_master_ife_lite_1 = {
>> +	.name = "master-camnoc-ife-lite-1", .buswidth = 8
>> +};
>> +
>> +static const struct qcom_camnoc_node camnoc_master_ife_lite_2 = {
>> +	.name = "master-camnoc-ife-lite-2", .buswidth = 8
>> +};
>> +
>> +static const struct qcom_camnoc_node camnoc_master_ife_lite_3 = {
>> +	.name = "master-camnoc-ife-lite-3", .buswidth = 8
>> +};
>> +
>> +static const struct qcom_camnoc_node camnoc_master_ife_lite_4 = {
>> +	.name = "master-camnoc-ife-lite-4", .buswidth = 8
>> +};
>> +
>> +/* BPS */
>> +static const struct qcom_camnoc_node camnoc_master_bps = {
>> +	.name = "master-camnoc-bps", .buswidth = 16
>> +};
>> +
>> +/* IPE */
>> +static const struct qcom_camnoc_node camnoc_master_ipe_0 = {
>> +	.name = "master-camnoc-ipe-0", .buswidth = 16
>> +};
>> +
>> +static const struct qcom_camnoc_node camnoc_master_ipe_1 = {
>> +	.name = "master-camnoc-ipe-1", .buswidth = 16
>> +};
>> +
>> +/* JPEG */
>> +static const struct qcom_camnoc_node camnoc_master_jpeg = {
>> +	.name = "master-camnoc-jpeg", .buswidth = 16
>> +};
>> +
>> +static const struct qcom_camnoc_node camnoc_master_jpeg_dma = {
>> +	.name = "master-camnoc-jpeg-dma", .buswidth = 16
>> +};
>> +
>> +/* CDM */
>> +static const struct qcom_camnoc_node camnoc_master_cdm = {
>> +	.name = "master-camnoc-cdm", .buswidth = 4
>> +};
>> +
>> +/* FD */
>> +static const struct qcom_camnoc_node camnoc_master_fd = {
>> +	.name = "master-camnoc-fd", .buswidth = 16
>> +};
>> +
>> +/* SBI */
>> +static const struct qcom_camnoc_node camnoc_master_sbi = {
>> +	.name = "master-camnoc-sbi", .buswidth = 16
>> +};
>> +
>> +/* ICP */
>> +static const struct qcom_camnoc_node camnoc_master_icp = {
>> +	.name = "master-camnoc-icp", .buswidth = 8
>> +};
>> +
>> +/* Slave */
>> +static const struct qcom_camnoc_node camnoc_slave_axi = {
>> +	.name = "slave-camnoc-axi", .buswidth = 32
>> +};
>> +
>> +static const struct qcom_camnoc_node * const camnoc_nodes[] = {
>> +	[MASTER_CAMNOC_IFE_0]      = &camnoc_master_ife_0,
>> +	[MASTER_CAMNOC_IFE_0_RDI]  = &camnoc_master_ife_0_rdi,
>> +	[MASTER_CAMNOC_IFE_1]      = &camnoc_master_ife_1,
>> +	[MASTER_CAMNOC_IFE_1_RDI]  = &camnoc_master_ife_1_rdi,
>> +	[MASTER_CAMNOC_IFE_LITE_0] = &camnoc_master_ife_lite_0,
>> +	[MASTER_CAMNOC_IFE_LITE_1] = &camnoc_master_ife_lite_1,
>> +	[MASTER_CAMNOC_IFE_LITE_2] = &camnoc_master_ife_lite_2,
>> +	[MASTER_CAMNOC_IFE_LITE_3] = &camnoc_master_ife_lite_3,
>> +	[MASTER_CAMNOC_IFE_LITE_4] = &camnoc_master_ife_lite_4,
>> +	[MASTER_CAMNOC_BPS]        = &camnoc_master_bps,
>> +	[MASTER_CAMNOC_IPE_0]      = &camnoc_master_ipe_0,
>> +	[MASTER_CAMNOC_IPE_1]      = &camnoc_master_ipe_1,
>> +	[MASTER_CAMNOC_JPEG]       = &camnoc_master_jpeg,
>> +	[MASTER_CAMNOC_JPEG_DMA]   = &camnoc_master_jpeg_dma,
>> +	[MASTER_CAMNOC_CDM]        = &camnoc_master_cdm,
>> +	[MASTER_CAMNOC_FD]         = &camnoc_master_fd,
>> +	[MASTER_CAMNOC_SBI]        = &camnoc_master_sbi,
>> +	[MASTER_CAMNOC_ICP]        = &camnoc_master_icp,
>> +	[SLAVE_CAMNOC_AXI]         = &camnoc_slave_axi,
>> +};
> 
> This will fill up quickly given the number of entries. This should be 
> moved to a separate file.

Yes that make sense. BTW we plan to move to icc-clk helper so we are evaluating
how the things will look like.

> 
>> +
>> +#define CAMNOC_NUM_NODES	ARRAY_SIZE(camnoc_nodes)
>> +
>> +static int qcom_camnoc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
>> +{
>> +	*avg = 0;
>> +	*peak = 0;
>> +
>> +	return 0;
>> +}
> 
> What's going on here ? This sets everything to zero always ?

Yes that should be fixed maybe as part of using icc-clk helper.

~Gjorgji
