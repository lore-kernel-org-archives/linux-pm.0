Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93419400DF6
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583921; cv=none; b=IO7MKY1aqi2wg4Lz4RU/X2dkYRM50j7wMshGxliyxtmvB0xyOfz0EfnZMucs1RvE9AV0BYynorRoFumu5zJuVFB1A6mbh/FPmVErtP6Jpsi5QgLE6hcn/nNbgGhjWWsreVFBPrawsywJ/MFu12/KBp3aiLsV5tYNl1EyHKqxHU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583921; c=relaxed/simple;
	bh=sMTiCyj5+9y1S8LPjELQzmaV6VdDm+PrnVA/OmtExmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/cJjotHoaaV66Pkl2wSYZvjOfnhJJsNEM5WFVGmaIjekjftFZsQAnj37zKjtf/m9Nt7vVZg2HbqpUw6Mo9p7WA02LUGNWdK2q30XBjmyYlFRk5fmjd4ozwdbhrFc1YjAvdDOi8JIFrYJGy3kCHsBHpO+uU/Ob8QwpCdSqs4LOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WQo5YLjb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IfB4L9HW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WQo5YLjb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IfB4L9HW"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCv2nc3402773
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 15:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fl6brSJe0+fFv2NIJ5+xIBCq87sP/RzIUmJGMjRks6w=; b=WQo5YLjbSEP3ewIO
	FMnI97R9N6YJk9la5QGqIYT9UtMW9cG3IztThXugYL8syL/mcdWFi3KFxSgCdjaF
	NkLRTtHpkTxdPxOVsJ6wRh5KWnwmV8Q6tYx9g7hU9iun2AHu9FUuupGaxrAofXXD
	/GF/hUsroSWgFe52OL4A3mT1UaQBcXzXWZxSNqkhyeWWVs7uPu7xcEcl1LB8fmc3
	4aiQt2ecuNu7nv0L8n+kJeQy9fyY6CtXUbB90tBVyXtBFiVvCaaMguqrYa1tZWHj
	EQ7BwG5HtkJkWBkauqMQhxQWuQQ64OzDKqN/1j4IC0f8XWyHBhC2WhixoOCUVi28
	DS81vA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hjgsxd6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 15:05:19 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-977c5e92ec6so49000241.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787583918; x=1788188718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fl6brSJe0+fFv2NIJ5+xIBCq87sP/RzIUmJGMjRks6w=;
        b=IfB4L9HWwMv/V/L+/FlRBHAYMlPZcGzjcNOvsgiHEviJbi78jhm1g1KOPZol3ZIh9y
         zzVgJE0hP4ezzDLYUWaIObL+dHv7xw162NZYrMM0K0i2Qmaey3SoncuHdlmaUJV8rtee
         25+8NYoR6JHqfPpeSk/sBJAyX6JuLtO5sPmG1AnhdmBHivsVLUo3G2GQE/3WzbEhGI3r
         Gv3O49hJVZQum/IYeqayaREicbK8C+XL6A4c0lKiFAUzxF8NFqrHDqTSMj3leJ+wsuiX
         VlFk67J9G6F1TAtWypP46D72/1MY7b0LuKbpFqFs8jfyrfo7Phkr8pczOdeR06h563cf
         jGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583918; x=1788188718;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fl6brSJe0+fFv2NIJ5+xIBCq87sP/RzIUmJGMjRks6w=;
        b=loTDa9NV1/RzMwvoIiK5sfJbp6iVws1zI4MyJQWkMXqh39H3CIsjYk6lvFS81InapB
         K2AjxVMUQliOqQv5q72TMW6wAIqHOmgllCDPnWBj49Dz2tFl+f+bqLpOPMS9xQyk9/Dk
         6QlrAuizld00n4NKK2RiLh5mSkZlq/Gr+6fkKFhUsYRkwiukXTcHSWAvVvXxQsI8Ykcw
         6SE8uNSbk4Zk5lQSQIS2gagIGS9fHbJZFTnUdUVnKyhdJv9TfAtDDPlcN35XjQvX8Bh5
         WahulBbi2mksHR+YdckLEltXg+EVdiBQiCx+wcHrEMnJF2As/VxajTbqDWDTVBooGMPD
         adYQ==
X-Forwarded-Encrypted: i=1; AHgh+RqfBrWLJXg9UfhMkyhHzMGQsudtcN6uGoBPaAjktrS7IBPdBPrClDJvvLkvOqXig8kNcMF3tJXQoA==@vger.kernel.org
X-Gm-Message-State: AFuF++moBYgBdl/C6mTzQ+0nAuBA+LecKds17MKygHl3svuUMm1bDYoQ
	G43mwPHkVvPDDYM+JDSIu+b+9VwT1oIvIwrHofrEbrdE50OpLkw+8PdEF0sCyEV5SHkt232ZeCD
	TxEn0pA90MREsKDzL7VxO+coJ3wKsBzmgEJ872tfSrlRtNV0/s1+vykN/g67eZA==
X-Gm-Gg: AR+sD13Mqzpjf//yU380pRT+UU3COPyoYXbfdKzmIc8twmZhHt1T33McoSxY/N5FPjh
	L+YleRz3eFnWCNFhrgBUDufExNGVXLJxmNt9Wbq1nP7VwW3RVITt15do4kReuZEg57CC36oTC2m
	bHytXWeJslmpsOAozle7pNivE/8VrpaguBBNigtGaCwk8PUcaxc0p1rryzKCPXJKVQhYKf3aWhn
	q5MRrmKz5IqrfUguSYUe8t4Mf5FC9p4cUab8hkiPyxR+taQt1rflXbUVbJ+C5yGygMyEUY2oibg
	6wsNsRBICtfr0C8rRTh+zlyZDyHshngh+7taG+KxOISluvxPg7dJoFhVsI1sIQ4wMeL67DKnq1c
	sxgyCmLklAg9eBihjd9Lo7UCh
X-Received: by 2002:a05:6122:849:b0:5c3:b339:7b19 with SMTP id 71dfb90a1353d-5c5ff3f5682mr2692110e0c.1.1787583913404;
        Mon, 24 Aug 2026 08:05:13 -0700 (PDT)
X-Received: by 2002:a05:6122:849:b0:5c3:b339:7b19 with SMTP id 71dfb90a1353d-5c5ff3f5682mr2692045e0c.1.1787583912801;
        Mon, 24 Aug 2026 08:05:12 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249685ab3csm1349197666b.49.2026.08.24.08.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 08:05:12 -0700 (PDT)
Message-ID: <4e0d636a-7975-4711-8070-6f71957b754e@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 17:05:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] serial: qcom-geni: Use geni_se_set_rate() for source
 clock configuration
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-4-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-4-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfX/KnA8smIz7Tw
 Krk7BhNPWrghv6VxaalbS1xXRqEP7SyY6QsockXTvWIrGOfQsQso2MgFWs+Qe2k29tFPSOsLNiF
 /aI7FfH1JsSqO4YigfzUCppkidAgCyk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfXz/rLjvlMNlNV
 ih1U7vhJiG7O28zdzSCMB1opHl7jg/h9FnxP4VpyIBHJtPHoSLZndaxWpgl+cteRdRZHAzEVQcN
 TxWuz17/s0U5Bz/Jc7ckBO82NtHmINTYuD4413tFSJMGMxP7yRGGveghNQTLXQG7WzZUV7GCNhp
 askxo7EmJooL30qlw8bDh8Gwh0RmSBOOB4+MvYIu5RUyfSpa6v5YrCnMAs5JlTzMGUvmZZkQ3tc
 eWlnKM5guV5nu1rxkw4VDy+CaCiRBqNm1C5pW6RCfmKsG2AhCifgh/1wlBmwi4JFSsLYMsBHXNM
 IVkLTRClj2swAu1Q7sYSrpveVkVInTbO5j2OIIuSG3uWZKWAfYRvtQF9zYoE9ibxdRhOfu6+zZ3
 j++lsyBNZ7O293NswJ8qXKSmE4I/+fhNC7Lz5p0mQa8u14nBxjYbAaaZ7Tl/nDg+1lXWcvzkOT2
 bVFY3+ZfI00sbo2bwxg==
X-Proofpoint-ORIG-GUID: CB6xc4WJ3PSc9tCUZstvG6qcRfgco1qV
X-Authority-Analysis: v=2.4 cv=CoCPtH4D c=1 sm=1 tr=0 ts=6a8c5daf cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=LofuKaiTYX8IWbRp0b0A:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: CB6xc4WJ3PSc9tCUZstvG6qcRfgco1qV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240126

On 8/4/26 9:57 PM, Praveen Talari wrote:
> The driver calls dev_pm_opp_set_rate() directly on uport->dev to apply
> the computed source clock frequency, and dispatches baud rate handling
> through a per-variant dev_data->set_rate() callback that either
> recalculates the clock divider (Linux clock managed path) or selects
> a performance level via geni_se_set_perf_level() (SA8255P firmware
> managed path).

[...]

> +	geni_se_set_rate(&port->se, 0);

This ends up calling dev_pm_opp_set_rate(0) [i see this is an existing
bug in geni_se_resources_deactivate()], which removes the power vote,
but does nothing to the clock (neither set_rate nor disable_unprepare),
which will crash the platform

Both of these calls (new and existing) should be removed. Clocks will
be disabled by geni_se_clks_off() in geni_se_resources_deactivate().

Then, we should do dev_pm_set_opp(se->dev, NULL) *after* they are off
to remove any trailing OPP resources (i.e. icc votes defined in the OPP
table in our case)

Konrad
