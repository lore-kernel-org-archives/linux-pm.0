Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F3D472793
	for <linux-pm@vger.kernel.org>; Wed,  6 May 2026 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084261; cv=none; b=Bm88ouuaexutMX0IflzhkihSSpEtpytZ2bYMwSlLhTBfcgMt7Wrrdt9oVkc06oPZehw54u2kOgsKlDFdaIK3DcCsH9IoLwhD0aswCLIzUsaWxds10uNaAVoSJUC5vNSxGQl+NuB6ObPrh+KLaKdQehZdzuGfcpkjpvEhh/oESbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084261; c=relaxed/simple;
	bh=k8mdGwOI45VMWhAk3cO2z+9fxW9u1DI+6A8LfvpUqic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ut2Td5ntO+v4wqpzqTThBIcRDiARxKANyyZDp6xYCtRF+loO8ZmQsYWWMgenR4c2yBp3Yts+48uIXaBx+AtTsGuWYemldlGZw8wZShGEClJ+cNYfq42hZ3l/hPAeSI7Ztz47iN9JITyh5uya0LtRuH679XdAt82awi/NbSMBtCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f4hebraP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Quz7Exwz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f4hebraP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Quz7Exwz"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646DvJ4B529759
	for <linux-pm@vger.kernel.org>; Wed, 6 May 2026 16:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vl6gtDEwP/WGqP4XGKgcHTsYq0tg7ZJDq6KWRqpyQPY=; b=f4hebraPSXWso2xB
	ZVPODWHYJbqc3TcCB42zbDmh25VHSdrAzg8ksAJxrehsSfknt8AJiTyZlX2fQc2I
	RrIWQz+LLUrdBF/iEkdFr1oas3qykbOLqYaYEqFEOGxofcMzbDduREJH9y8gkmhb
	EFj2lNsg1jiKixua3ZCuwkin7hPgn89sbV1uMqspGI1Kr+RliKkx8eYOuGTOisbA
	Re2F/bnXgehXejg1JUoKj8DrOxLdVjotiBCBnLG+/7cTVo5nh6GVdZaEAz0nzNMO
	+oYBELy/9yLHek0rBE/FVICz1PsvlXge5e+KYvwb4d22kiAQacqe0mC3Za8j8RmA
	H62Dsg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e015xa5eh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 16:17:38 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-56f69a1a9f5so3466198e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778084258; x=1778689058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vl6gtDEwP/WGqP4XGKgcHTsYq0tg7ZJDq6KWRqpyQPY=;
        b=Quz7ExwzkvOvcZPHEWDUWcUY3e/ovnFsMxzgjMZIcM572EgLQ2I2Y342ATT0nbdlH8
         ItR+g7CA41mzv6zZRAfMqsdSSturJ8Aw4C+nJ8D7/fcnQC+tr5I8C6vfhFaP7w0QYKtL
         +x+B+DAL120YGjLowhyW8yJWH3aOJzakEtMKP1bBkiQL6YKPLQoaTEpk3+sx7oMFHsqq
         ukV+gyF9cYvNkMGwT1cltC/lAISLfG67wYDaXeERTDTocN3PM7N2NbWKYuKtQtI+rFb+
         FqhDuJa80G/cqFj/OgsFYJ9I1CVre0TjBqeEl5Y/COZIy6ubvkc7wWmm0ZDkaiIrt+DZ
         KmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778084258; x=1778689058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vl6gtDEwP/WGqP4XGKgcHTsYq0tg7ZJDq6KWRqpyQPY=;
        b=CMnYR4GBGXu+r1YklZMk7cprfrgqh6rAh76bEWjRweZw+lxu0N0kQKRjBC0Y+x23ma
         EfSbkewHKCQbG8ek6JpDqYJsNtzrGZl69b9n3hJbv/IfKn7zKlJYXhb8my3j/XCWNf3/
         DMdc62O7BHd7wBWqdruRzlJYZDfQMC8cnfn2z8OIGMdGpySW4/f7XbXC5MyWAwx9WOr1
         XOJV9KQV4RI4Ogp48D9vfz1Bjm4buQTpwLkXkheNcgqQTPeo5ryXMzV7zYuF0n9pk5uz
         61Ur/+q7P/56jCyEZ0Opd0OgCXLi6kAV9iz0Bf3k4U9OviUB3CImiufgzzkNITYlY8rB
         HDIA==
X-Gm-Message-State: AOJu0YymzQUnQNesPlQFBkS2w/jMuBAtBvJRIESR1rAwqloIUDJOIqHf
	DVTb18tipNqwbkATSmursNdOQSdZDiOBss8v2F1lTOBYquZqYkOZj6JhIrMivioVFowXVriMQgx
	bHAHencGSO4FVsHG6oqegDFbDUi0eOecHeUeHroc3v6Wrg7ehIYlP5uL2B5R42g==
X-Gm-Gg: AeBDievblS2TJ0IFHEeIi8rrgtKfZR46tkDVlDNmdgDVckXK6BG0faYGQhmHhxVi6iX
	UoXlVVLJtAUk/Lw6ABK9LGMGEDn124wMdiASzYjy61VhoByd2mNh96kcOY9ot5gzwX232952fS9
	b9UJ9g+jJzf9ns8lFNzwpDIlyh9WxrFOs/fD4plbLCVcPjHl/2OgkNlKY7Z22mFarJvSnx1k0B9
	otZMdvGF5robLYIa2UAwggp4Fco7oLWHyDh34YAY+D1HRnubx18qjOma0bCSmK32+qzCBxuiIrq
	cFkUXkDeYUYC5Yabo4zfAJhLvjsxIS5JIMdQYd1sllMQWHNIOI3lCTV+OlaQpJDOu11Z6Evd+f2
	TOjXhuMzRk42ELziicv2vMXpTKCaI9niEUEqNIhgBIk09FUySsvgnDND0azuXVotgu/03UObuXf
	WoXDNu2RSedHfd1M7ArWw=
X-Received: by 2002:a05:6122:8106:b0:56f:b831:909c with SMTP id 71dfb90a1353d-57544474e1emr3810514e0c.1.1778084257943;
        Wed, 06 May 2026 09:17:37 -0700 (PDT)
X-Received: by 2002:a05:6122:8106:b0:56f:b831:909c with SMTP id 71dfb90a1353d-57544474e1emr3810491e0c.1.1778084257512;
        Wed, 06 May 2026 09:17:37 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:41ef:7b80:b3e8:2c1a? ([2a05:6e02:1041:c10:41ef:7b80:b3e8:2c1a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53891d62sm95223275e9.1.2026.05.06.09.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 09:17:36 -0700 (PDT)
Message-ID: <2e9dd9fc-a42b-40ea-8393-3bf66955c4f2@oss.qualcomm.com>
Date: Wed, 6 May 2026 18:17:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] thermal: qoriq: add i.MX93 tmu support
To: Jacky Bai <ping.bai@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Li <Frank.Li@nxp.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, Alice Guo <alice.guo@nxp.com>
References: <20260430-imx93_tmu-v6-0-485459d7b54f@nxp.com>
 <20260430-imx93_tmu-v6-2-485459d7b54f@nxp.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260430-imx93_tmu-v6-2-485459d7b54f@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Os1/DS/t c=1 sm=1 tr=0 ts=69fb69a2 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=8AirrxEcAAAA:8
 a=_0vOcDHEFh9t5MRidCsA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: p1oejwJ8fQqKf3xP76ZoSHOW3vQzsDTq
X-Proofpoint-ORIG-GUID: p1oejwJ8fQqKf3xP76ZoSHOW3vQzsDTq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE1OSBTYWx0ZWRfX/AaVVG4WPvze
 qI2RWLBHm3/kUMtl7O4HH3rXk0/NPCwnQgFM8uHaC/6zwgduHh/AWsHc348kHXKTP/phRxwe0G/
 BWQYxFTk03j72sZ/LNQ9tXjB0CClxdCwXjP+vCamDeqk5oLnSqUnZjeWWHGqkkSIW5g5Ey8c8gO
 cFzhotYQkSnQW7v2n1H1/ZOcO1iYZKexXTnJfJ7TJ1J7O+r9Lj0LwYJQHcrUDdwHDD8HWRvHK9w
 IYJZhSvoQPrKCKDNKbLbdxgqq/4Agjec/Fg+Z/4LDU52lBf+ZZY7Av0p2b/3kD/zYf19pun6T92
 jqrJe2ZK/IEXVYZCm5uoGwr8bNUWuCLGalJG/qsscQ3U4MipiDMj2JBojwgjRsC0qTbqEXg0TLM
 NbCJjXNhm+AoOkZDPSN6dZG+EE+vSIpJO9M7bO6cA8GtaUAJyrNU7iJM24CfdiC1p8RVo5+41mb
 WrYNHNLZxm7r8uUfuVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060159

On 4/30/26 04:53, Jacky Bai wrote:
> For Thermal monitor unit(TMU) used on i.MX93, the HW revision info read
> from the ID register is the same the one used on some of the QorIQ
> platform, but the config has some slight differance. Add i.MX93 compatible
> string and corresponding code for it.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> ---

[ ... ]

> +	data->drvdata = of_device_get_match_data(&pdev->dev);
> +	if (!data->drvdata)
> +		return dev_err_probe(dev, -EINVAL, "Failed to get match data\n");

I'm not sure testing the return value is something very accurate because 
it is like the code is testing itself as everything is self-encapsulated 
in the driver.

> +

[ ... ]

>   static const struct of_device_id qoriq_tmu_match[] = {
> -	{ .compatible = "fsl,qoriq-tmu", },
> -	{ .compatible = "fsl,imx8mq-tmu", },
> +	{ .compatible = "fsl,qoriq-tmu", .data = &qoriq_tmu_data },
> +	{ .compatible = "fsl,imx8mq-tmu", .data = &imx8mq_tmu_data },
> +	{ .compatible = "fsl,imx93-tmu", .data = &imx93_data },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, qoriq_tmu_match);



