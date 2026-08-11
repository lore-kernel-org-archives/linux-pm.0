Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB53C25F7B9
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 03:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786420041; cv=none; b=B36F5qQSwbMr9h2rQHAp1GyCHUMpaKbmlMQflgTtjZLpQorGmXLe64CXQ//bzdcnHQHCT4hdDKbZLWWjH0QuxV2f7nRHuJ2CeE/YTMSyC8NGEigQXTs8tJQDair46a76FFw5YFjf7LIaQ6UvS3iylkwe9anBXGuug3pbHROBR3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786420041; c=relaxed/simple;
	bh=edvAPZUlqdPxQvGt0zVokuNjkmj+7OzVo9zvdPz8oCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHgzInq8LQj+Dd/LTo6jZ4OBNcU4cyWR0Dj+5O4VQq71718mrkx7e5emx0853zfmbAwXmwe99wm8vYhV2jFjBXh5kCHPJv5eZONDeXMeBDsUuy77h8L4kIqsD7rcuJ84NxZqxhnqvwCmR0BCGlNjv9QijfPqphu1XmvOiMNGm8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cp44ynqJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NwDwVWV0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cp44ynqJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NwDwVWV0"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AMpqjr3047684
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 03:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ud9uue+eAmgOeli/UJM+eu9+5MxvNkXUbo2Xuvjg13k=; b=cp44ynqJNje5/9PP
	bOmw6YPW4iucixdbehwe3FMkrXR4aR/l3fhbCBdfmrv8FgkvuyuNna8YsfNqhYjN
	cevx8JgxvauDFNbLv7B3iy9xMBMJQsCvGZYK+iG+WGWV5cIbR3YR6B7KnGhLpI8Z
	nlCeQSg8uv5x93AoCUMFZ7m3oFb0HkXHo+y/0s0+KJIqrR2OEAhNWFkW0H3IRlKf
	7gFLRcJn+4K2GsUm9iP6/PxgfaTtC+3yKlKQ8VIuehKT13tI2zYtvbqIVWBiI4Zb
	kii4d5vWqdSyi7wilPTVNrscCHjDnbw7QLOBWgEaml/rzHiRNTfKGVDFVZheo4YW
	tfDWgg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk228mb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 03:47:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cacd6d37edso41470775ad.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 20:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786420038; x=1787024838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ud9uue+eAmgOeli/UJM+eu9+5MxvNkXUbo2Xuvjg13k=;
        b=NwDwVWV07wJtxG0B44pINNZ4Uvuk06AGEPuBL0ey2C1WNdXi2QAAzuqAcO7TDi58WT
         IqCBQzR69Q7Zya/40h7aL5TI8LXBP4SGpEpMHlVn9Q9a8bOFHw9/tcqUV5DWNgCNsC2h
         ezCIb+cQgFoAXdGdlqK+M7fXcjljiWgBWDjGJ1GiZB1JlrAq3LediHlfHA3hi1lqnMna
         /CHGZDvNe/CmmEC9R+Jw5Y3gZ73LRwXm3IXGxlLwGvUyTbSjr7q4yLZpuay0oFaoEsWJ
         nri6dLo8hFifwQMnYOuZTQZ9qmU8x0nkAZrn3YwnJhwM8MB49ORzVzwxG2qKU+in2h4+
         GCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786420038; x=1787024838;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ud9uue+eAmgOeli/UJM+eu9+5MxvNkXUbo2Xuvjg13k=;
        b=XIdujLl/nJkbhe8rpJLg1w+jcD0XY6GCeeXA8kI+UaxubdbQZ6wNy68Pe+Z3LE5MBK
         a+mxCEZzvFlNPOmlywzlOH1SzAjKnjT+Lgj4hUWLr9ErfEtrzJyUqVl22q+bOmkIIghk
         ixeunrTfpo/k/xw3L2ip6jXWV+Inhcn+/HdVcf33BlAnZjoJ4ygLU/0+4o1YJUmlevWx
         iAtY0GgQpKOBuRvolHnz8vvHGKuozyt2gIihEKM4lKG0uiPdXxLssNQ9QVqufrs4I2KK
         SniRZc2vHkwteU1oOdv/wHVhsX3v1J9yAs7FN+W5OxbgPjQJ3z6N74VxTNmy8kgNvxx8
         SSRg==
X-Forwarded-Encrypted: i=1; AHgh+Rrac0zjbTj/ftB6nDkRQbA5rsSmjjmv8K86eHwFDyXqBS4w/hJ576yvfbc7tkcrfG7Vp/s4DXS23A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzR1hwXz8Nj1yVYZo49MnIbxJowHdthZ89pndNPF4J8/8RXM0MO
	Bqt5sz3ohnUIp9JYyTAAdSR9wOp756K0iKBizsXzIlYIwQOFbXW8wvWgkXwzOCA5wmdmxD9IMAU
	TzZuR2Kwl94GhYmEsa/a394uD6lVA1xZz9iSNRTgEMTKM3Kak3zXPPR8GjyskJA==
X-Gm-Gg: AR+sD11tULnxvBwEWvJZjy9pD4S9/RHd0WTXyHpECflKMADWetHFuDLAMGcPMQtEzui
	oF8yj2VT/KsbzwACzaETRDhEq+Dg5/fg3YHip36FDOeiO+ohmIhKZqOEdq//KBxAkOdT+DxsmUy
	7jVFEWiIRbslht/f+/uQAEgOS5JpG6sga1sEhgPFGj6/iaPAmUaYHxPBQuckU4jhtwbTPXo6IML
	kg/O6ItJSs9qHkQEC8rwNn8auhoP1qFC+jtVgribwVdjoYyv3keYU2TcKcJWJpXFVAL/8a9+aX7
	BZbF1KHr0P9QUb/GfoQUt/4GR5XosKhkMChl633xaC8+GxrrHBOzlRuwFvZTK/NrhcabUB8Q7hp
	KRvBGT3cmyaAlZInQcUG5VTyfWOBJJ/s0v6a07U4jHVzSKT548WUn3mVymeY9FZHhSWbLEuI/oh
	3B4CWQQyBu6T9UKNgH+SY=
X-Received: by 2002:a17:903:2c0e:b0:2ce:f9db:a9e0 with SMTP id d9443c01a7336-2d3178f4e77mr6309795ad.16.1786420038256;
        Mon, 10 Aug 2026 20:47:18 -0700 (PDT)
X-Received: by 2002:a17:903:2c0e:b0:2ce:f9db:a9e0 with SMTP id d9443c01a7336-2d3178f4e77mr6309465ad.16.1786420037844;
        Mon, 10 Aug 2026 20:47:17 -0700 (PDT)
Received: from [10.79.117.20] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb8844fsm50674040eec.16.2026.08.10.20.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 20:47:17 -0700 (PDT)
Message-ID: <f7a76790-0e7f-4c4c-bb33-36134a0f3e29@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 09:17:08 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] interconnect: qcom: Add Kuno interconnect provider
 driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-7-5e0ede4a0c72@oss.qualcomm.com>
 <xmj3xhnvdixooy3l6wro5f7eeehlrlrq44y2mwojzzeb3yjdjf@e3eo2772qctz>
Content-Language: en-US
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
In-Reply-To: <xmj3xhnvdixooy3l6wro5f7eeehlrlrq44y2mwojzzeb3yjdjf@e3eo2772qctz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDAyOSBTYWx0ZWRfX8SxpmyIIIA1t
 mXeNtgmFYc8zCkQDorjTpEigGszcQAopjX26KGU0exNSCKslKLMK1qgd9dRhKMTWoDRh2qEFJP9
 BDNem3PdIzBhJvpl6QlPd0jj8cQjJ0w=
X-Proofpoint-GUID: kRcGZxmcLe2Yrz-hLmmPUMJA6TVrFT-P
X-Proofpoint-ORIG-GUID: kRcGZxmcLe2Yrz-hLmmPUMJA6TVrFT-P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDAyOSBTYWx0ZWRfXxRg+yVn8RLTY
 1hNZ6tri53ORomzM9BjsoPfPcPhhjBhV+0OUJuXqEkQeb9Ei0QKUtXwuckHIvpUnaYxBiIC99aN
 P9L3/vLDgam+INaCs39vlbHZl1ImsGoxv6LGeRHP61kfLweIfKayIKe7XbomeY6RHql+Sry3Jz4
 4IkfvAZrepjFvlGZtKRN+qz4SjLHN1zFm2OxtumoHNNCdiH2rkXQ8qZ03iI2OHFPodXZetLrWKj
 xleU7jq9FwIeAEkcw6fGKCGreynUu9wdWRhitDmh6TWb+oci0uv5jKjM00aYMZOokjHZq83x9vo
 ZPE0fZBwpYz/Ljiqj6/oKu2Xyn6oHr0G+b6kBhAy8ZvFcvaDZfSMMC1TwIs9V0cZKZehPUgi8tz
 +B3nsb9SbO8xGwfdQesrJvsaRdcq9LmbrHiIZ7fsk66ujnpieh3qVBRU+F1/TJKVEwqncHOhsOG
 VVNBS6EyDPcc5AMksow==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=6a7a9b46 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=58NiY7KAgNsMs7qA__gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110029


On 8/11/2026 6:30 AM, Dmitry Baryshkov wrote:
> On Sun, Aug 09, 2026 at 12:57:06PM +0530, Hardeep Sharma wrote:
>> Add the interconnect provider driver for the Qualcomm Kuno SoC to
>> enable bus bandwidth voting on the platform. This includes the
>> aggre-noc and cnoc-main NoC instances with their associated BCM
>> nodes.
>>
>> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
>> ---
>>   drivers/interconnect/qcom/Kconfig  |  13 +
>>   drivers/interconnect/qcom/Makefile |   2 +
>>   drivers/interconnect/qcom/kuno.c   | 978 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 993 insertions(+)
> Please add QoS settings.
>
Thanks for review.

Kuno's NoC QoS is provisioned by RPMh/boot firmware, the same as its 
SDX75 baseline.

The upstream sdx75 interconnect driver programs no AP-side QoS and only 
issues BCM bandwidth votes; Kuno follows that precedent.

Hence no qcom_icc_qosbox settings and no QoS clocks in the binding — 
matching qcom,sdx75-*.

