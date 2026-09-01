Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D747ECDD
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281337; cv=none; b=MG6IOtDE6N99ccvdKTNJksCzFrI1QRykx9l1XyuZxQS0SSvJXl58qyCRxCFfrtg3wS4L4N15Kwh7RW1+n8B1INSb1SCJuPfqWgi19jZcojongzDqqObMuGfRlkfbVALXNV24R8zQMZaAvamKEMvz546CwcxmcURHFy55lZYEfL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281337; c=relaxed/simple;
	bh=CfzWqf5o+3N92HLjtir92933+kWR07XnaDw5BK9jsWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0Pb38I2G7TrZJO6QbxGQRTaprbSmc6iJ8oItRcDHb9hNgTB0SvvLQR18b3mHjyByjM/ORGq8A9qOopttmUdoNEpJ/dQjLufRwWNlCd9Hsu4bDkW9AuAOE1MQ5QJ6w+Cq7s3naNWggDLDrrZPR8xV8ZBSfYuP93JGmBo/EwqG6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gLNqsggg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hI+IV1JF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gLNqsggg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hI+IV1JF"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EA3r02219466
	for <linux-pm@vger.kernel.org>; Tue, 1 Sep 2026 16:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b62TM3b+R7LBBBMdiFoxJotUo5iPVNG6UJ+rLi3xZbw=; b=gLNqsgggpn1u3v7B
	ihUObr1bhMSg+9eNo6gGT6JwdQ7VCl51Iw1tDlfT4vRHHDM0zHCPu7D0NAMXY0zW
	AAwHroDHKm4owfTqo/eS9u+jDHHeLbm3JKcUK52z+XGnbU9RvFqJ+1KwRR2L6qJk
	JVLFPl1EYWSvB0Ua4ajiC5qSdyS0Qg1A3IHBC2SWo8BSj87hAUb7ZPFrDWH/qiP3
	OCjG5jrZyzgig4exr5ZLAcflW30O/0utbZfTJY3ql5AOlbKCGyvJQ+X+aeyedqW2
	IulmWho7SXtAee0CvZgQClTNGFS6P8W7Q6rG9pVLPhmpYQp1fQj5rLHqH7AmI4kd
	rX2J3Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdndxbt9t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 16:48:54 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398dc3d8f0fso1431297a91.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788281333; x=1788886133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b62TM3b+R7LBBBMdiFoxJotUo5iPVNG6UJ+rLi3xZbw=;
        b=hI+IV1JFvx2lYKZoDbus3DhNXE0sLMcx/UCUUFDRUWewDOIWaXI7vsMNt2CvH5OyQG
         dBOLa7aNImfryyC6I/Y2Acy/HZzMBKx+x633xuo+ZTdPTnjexp4i1c/N0w9krP5x65+I
         YJH5M0R//cQkfQHy9GH+uuwwdIi0D98FD8/FVIqdW3lFnlm9274YYBojKXRQCdkBQ2cj
         EMXUAkFfW5DFcEcA872tGJYEH5ldLwFfgo9O8bJe6U4rIcBlVIxtJwtoObft0oK6IYYi
         KwxgdcIo/FS1CInRv9J5RbeZYbKyWo0kl9vwoLqhNsqwczjebAiUK6DsvOeno/pKs65N
         BBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788281333; x=1788886133;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b62TM3b+R7LBBBMdiFoxJotUo5iPVNG6UJ+rLi3xZbw=;
        b=AARgYuUbmYjAR4al1Zmmm3rljP5NDgUukRbxZNisLMIgaMzrJXjU5waPDeJi2OxHtJ
         nvR6wiTKcy61I2peiknIJwp2pXIGE5/EzsDjeVpTMTr4sxcvdWxjJ7kL+X/rqLysLhA0
         PBgy26XD1XZ09A71ncenhXUxWsrfeVrXShIZCxIzxkTy297OFN+EWOsjQmYZgQF0U0Cl
         4HZYnUTepSPTVU2uz2kg8IZYEyv2SQMZF+xtNhh9UeAYzlsvgXk+IDGLPii4dTMTQa44
         eywCb8sEM0WY6SmEwLBvmZk4lOWoU7FWBRb/Tjhq2wtuf8Qe2sFVbdALlrglkvnvjoOL
         2zdA==
X-Forwarded-Encrypted: i=1; AKwUvBwl4Sm5cTavE5wj6xyeGb1v2c91ErlUVgOeIiIHrLV2DamIsO3gvzvVQZQAuPuygl3e9UPo4t6NmQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nQsqGPvEeJXpZDb0ZM/NAiwgFr8sQNmmD8caInqSTd2CvBO/hQ
	GPNPpOMlYJ2CZUSjLMDyc30TQrNDbwlnN4YHjikovOMQnLhWtrNHkHf5x3j0W2lqFxXThtRYfyd
	QgzEm7CaiNdl1uObbD+ZWYekAHIqJx7XmW3DTwghAccbm8cInfo+3VvaHhytygQ==
X-Gm-Gg: AYBFou0utKM7Ks5J5S+drclsADFyfVD4gj7Ub7Fyce6DuWQ7HMY+M1rG4xE/FzTg+sj
	QI162Gq9PYMwp6PM66sVJhVe1pRJXlffsF4jNxpFYe/8OwhBhD55I4K2+AGQQx79iTEMFtA1FCU
	vFYj9UbLvQED7Ok81BevLLxfcQQBSU+B06NOhKTPaw/GU30BHydWeO8I0A10esxhD5kUgC14/NS
	u7UUVPlOg6KDxyAd+dSWMeBAuLYqBlZY19wr8euU04JIJjlQwicgmfoSqXvRB7ioELz6+cZM6SP
	nTHtGD5uijttQeyDCL7A1oFPNAX41DFM9btqDxCaRCi0p+/cYSeDdOpxk4JCmADPgtTlCmt3Jiy
	yX8SnT/tWaW6CVVoQZmZ3el3/TRj1c1KR
X-Received: by 2002:a17:90b:2247:b0:37f:a913:1554 with SMTP id 98e67ed59e1d1-3990f890861mr6902042a91.16.1788281333010;
        Tue, 01 Sep 2026 09:48:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2247:b0:37f:a913:1554 with SMTP id 98e67ed59e1d1-3990f890861mr6901973a91.16.1788281332349;
        Tue, 01 Sep 2026 09:48:52 -0700 (PDT)
Received: from [192.168.0.5] ([49.204.111.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b944bsm41662284eec.27.2026.09.01.09.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 09:48:51 -0700 (PDT)
Message-ID: <177884a8-902f-49be-8fcb-b2bec3ec7d6c@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 22:18:44 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] soc: qcom: geni: Derive SE clock configuration
 from OPP table on SA8255P
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, mukesh.savaliya@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <CAPx+jO9fcvBsxe9yx9oK=0EXmpNwub5ba0a-TGk1WRFaRGsqpA@mail.gmail.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <CAPx+jO9fcvBsxe9yx9oK=0EXmpNwub5ba0a-TGk1WRFaRGsqpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eceLsDxb0bitycRRy5HbTwX_P0MtjWqM
X-Proofpoint-ORIG-GUID: eceLsDxb0bitycRRy5HbTwX_P0MtjWqM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE0OCBTYWx0ZWRfX5Bq/EJ8e2WBt
 Vi9mx1cOgbrzdeb7ca6y+pdt84SamAEVeHBXuFqgdUv+k0qAYmbQ1vmqhH8XPubF57Hmnr6oSB3
 Q6Yjt358QunvGk464n6iHA4yfz0JBg0=
X-Authority-Analysis: v=2.4 cv=U8eiy+ru c=1 sm=1 tr=0 ts=6a9701f6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Z/g59IqO3Gki/5UUpFMnLg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=1OWG-U-0pMjJ1F8qq_YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE0OCBTYWx0ZWRfX2xffwxxUjDZ8
 yof6k/5yYx7mNj0SZteu1HtW0ww8BT8tP0SAalUdi0D32sEManq3A4tKwuiOa4GkSoJ9zyoEZ+H
 Yi6plrZgEQlYGzyiaCXXZ5CaB/hVDKE5n+dLybRorZKOgs8KCqNAmgv25J6ZrsByJ0dM0WqUjC+
 XZfRXvJfGIuAl2BsIMynEmL2qX5vIRlsupZdueQo/EyYKgQXuDMoofXXk69a7Qur/Wv3xOsPHXR
 ilb3j6K4+VhfAaKNG2THw8deIXhLnlSfuONqw645uqAHZkSmiHGNkr5RS9s1pXXiP5tGoq4Y+ps
 2Cs9UcqbKunqoHlVyDNEr5mnXTfRTEznrEcQ42+MZPzpwpjpcngtGzBiR6AXnFbtFbgibOKBhoP
 SawRrGXE+v8ECWovQtnn6MZWXBpDj/Od76g8tIpFIQRYjh1cRrVQHPz09pSVxQkD2GfOcEflQx8
 JAvLmg6DrGogr3BwBNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010148

Hi Ulf,

On 01-09-2026 20:22, Ulf Hansson wrote:
> On Thu, Aug 27, 2026 at 7:59 PM Praveen Talari
> <praveen.talari@oss.qualcomm.com> wrote:
>> On firmware-managed platforms such as SA8255P, there is no Linux clock
>> handler available to determine the appropriate SE source clock, source
>> clock index, and divider values for a requested protocol frequency.
>> However, these parameters are required when programming GSI TREs, where
>> the hardware expects an explicit clock source selection and divider
>> configuration for the serial engine.
>>
>> In contrast, platforms using Linux-managed clocks derive these
>> parameters through geni_se_clk_freq_match() using the source clock
>> information stored in clk_perf_tbl. Since the firmware-managed path
>> lacks equivalent clock information, protocol drivers cannot reuse the
>> existing frequency matching logic and instead rely on a direct mapping
>> between protocol-requested frequencies and performance levels. This
>> creates a separate clock configuration flow and prevents
>> firmware-managed platforms from deriving the actual SE clock parameters
>> required for GSI TRE programming.
> Hmm, this sounds like moving backwards when it comes to keeping
> drivers as portable as possible.
>
> I understand geni_se_clk_freq_match() has been around for a while, but
> fortunately its use seems limited to only a few qcom specific drivers.
>
> Rather than continue down this path, would it not be possible to find
> a more generic solution for "geni_se_clk_freq_match()"? Can we replace
> it with a common clock/OPP API? In this way, we would not need to
> sprinkle drivers with calls to platform specific  code.
I agree that protocol drivers should not need to know whether GENI resources
are managed through the clock framework or a firmware-provided 
performance domain.

The intent of this series is actually to move in that direction rather than
introduce a separate flow. Today firmware-managed platforms cannot use
geni_se_clk_freq_match() because clk_perf_tbl is only populated when a 
Linux clock
is present. This series derives the same clock-performance 
information(clk_perf_tbl) from the OPP
table and populates clk_perf_tbl during geni_se_domain_attach(), 
allowing both
resource-management models to reuse the existing 
geni_se_clk_freq_match() infrastructure.

Likewise, geni_se_set_rate() hides whether the underlying implementation 
uses
dev_pm_opp_set_rate() on a perf-domain device or a regular clock-backed 
device,
so protocol drivers no longer need platform-specific callbacks. The goal 
is to
converge both paths behind common GENI helpers rather than maintain separate
clock-selection mechanisms.
>
>> To address this limitation, the performance-domain OPP table is treated
>> as the representation of SE-supported source clock frequencies. During
>> geni_se_domain_attach(), the OPP entries are used to populate
>> clk_perf_tbl and related clock performance data, allowing
>> firmware-managed platforms to leverage the same clock frequency matching
>> infrastructure used by Linux-managed platforms.
>>
>> With this change, protocol drivers can use geni_se_clk_freq_match() to
>> select the closest supported source clock frequency for a requested
>> protocol rate, derive the corresponding source clock index and divider
>> values required for GSI TRE programming, and apply the matched clock
>> through the OPP framework. This removes the dependency on direct
>> protocol-frequency-to-performance-level mappings and provides a common
>> clock selection and configuration mechanism across both firmware-managed
>> and Linux-managed GENI deployments.
> Rather than adding yet another platform specific method, would it be
> possible to extend the generic OPP library with the pieces that are
> missing to make this work in a generic way?
I agree with the goal of using generic infrastructure. However, 
geni_se_clk_freq_match()
derives GENI-specific parameters such as the source clock, clock index, 
and divider values
required for GSI TRE programming, which are not represented by the 
generic OPP interface today.

This series does not introduce a new clock selection path; it reuses the 
existing
geni_se_clk_freq_match() flow on firmware-managed platforms by populating
clk_perf_tbl from OPP data.
>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> Kind regards
> Uffe
>
>> ---
>> Changes in v2:
>> - Add new patch to remove OPP rate reset from resource deactivation
>> - Add new patch to vote source frequency via OPP for I2C
>> - Compress the SPI, I2C and serial commit messages per review feedback
>> - Drop a stray blank line before trace_geni_i2c_bus_setup() in the
>>    I2C resource-initialization helper commit.
>> - Link to v1: https://patch.msgid.link/20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com
>>
>> ---
>> Praveen Talari (9):
>>        pmdomain: arm: Fix -EINVAL from scmi_pd_set_perf_state() on state 0
>>        soc: qcom: geni-se: Populate clk_perf_tbl with SE source clock frequencies from perf OPP table
>>        soc: qcom: geni-se: Add helper to set SE clock rate via OPP
>>        soc: qcom: geni-se: Remove OPP rate reset from resource deactivation
>>        serial: qcom-geni: Use geni_se_set_rate() for source clock configuration
>>        spi: qcom-geni: Use geni_se_set_rate() for setting source clock frequency
>>        i2c: qcom-geni: Vote for SE clock rate using OPP
>>        i2c: qcom-geni: Use common GENI resource initialization helper
>>        i2c: qcom-geni: Use geni_se_set_rate() for setting source clock frequency
>>
>>   drivers/i2c/busses/i2c-qcom-geni.c      | 72 +++++++++++++++++----------------
>>   drivers/pmdomain/arm/scmi_perf_domain.c |  2 +-
>>   drivers/soc/qcom/qcom-geni-se.c         | 62 +++++++++++++++++++++++++---
>>   drivers/spi/spi-geni-qcom.c             | 24 +++++------
>>   drivers/tty/serial/qcom_geni_serial.c   | 26 ++++++------
>>   include/linux/soc/qcom/geni-se.h        |  2 +
>>   6 files changed, 122 insertions(+), 66 deletions(-)
>> ---
>> base-commit: 0f6da28aab51b16762ed82e8fdeaa5042da45b08
>> change-id: 20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-2f29ad32226a
>>
>> Best regards,
>> --
>> Praveen Talari <praveen.talari@oss.qualcomm.com>
>>
