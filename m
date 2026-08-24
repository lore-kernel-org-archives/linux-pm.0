Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8844052D6
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571641; cv=none; b=hUpNUFKxznqgjCskiXmG4QpW+HZt6ufH6syvqSLAakEuDcTn22qHh9hqjjLWhqhSzy5eGVLw5BYQlY+J9iqgLdB/EjwKi8mYJ/OHFEdlmQTdNgWF230fl9nQkNnoGEozlMFa0xAoPaPgbKmt6SOrApZpjY0jKtcNWRx/uut92LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571641; c=relaxed/simple;
	bh=ckB25BnMw7XB3ZZL+1QBBFAP7gwZc1IxYgqGinjpLjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnFzYZ9Cl4BSYQsdQsInjU0T0C7X+RO1wE98UCLo1Mu6ZBuume+o3PUE9sUCAxJywgXp7AvCrpVeswf5zkkyfPkiYMoKfHa9BhVxxMCrmZmvpDJDh0ccE1BXSjfDIjehK8ttWvLn/nP/PMjCSX9MCs7lBk4QNhEBeIUJqWR85rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UiL9HoP7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K2AyDRzV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UiL9HoP7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K2AyDRzV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OBMUek2647973
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 11:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dDK2q8jEQBsx6u42K6XSBrp2/fHnP/dHMqcLRjUxZpE=; b=UiL9HoP7JETaWO9z
	e3x7AoLwcfNEXuvmrFHr1Ou5cX2s+rI0wEizv/+AhhMcRizfBM3ADmbtZCadAwWN
	Y4D5AGkCYlieTuu6TWI2SslAl4WYCu+5g5jQrVSOWkAeuHwKtyXfdFNw6J6QygKG
	R7BZ+GRcDhFJV7F2ad44ZMOMutZO52Col7FVrsflYKCPGYybDNICli3UAKe3PFUi
	mbaI4v0eRMj4idoLkBHHXjfYwf03SqeLMyFaM164aCTf24uSTzIHAd0MLnkZ5j3T
	9e9/M5y+H8S03lqspb6085u305g61F5NIMrW01PEjKXrL8YStGt6O1GGybq9zsnZ
	xbAekw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gqn98pr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 11:40:39 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84eee2147ffso4217861b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 04:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787571638; x=1788176438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dDK2q8jEQBsx6u42K6XSBrp2/fHnP/dHMqcLRjUxZpE=;
        b=K2AyDRzV83uiLR6IfKcmWF426uAX1ZH9fQ2PniQyE1mnmgeFsV+iukMP1e14xmKXRC
         6F+FOa/86NmPttOtKLq92fppP3TzXYN7MpFTNYUsutdsGA4StT2KyAXPtYhA3g/PARpB
         WSMSEQ2m1g6YrX64m9k/Ys+ZErQahkXW7ENzavyGC0Gy/ZXB1+4+qrbNcskLA0Zg6XuD
         Wu9Bbcc4GWlf0+cupljYK0Pq93fvXYmCVIYc40qNA+/th7gStFNt+wKQ6cr99LLjODfy
         AwFxXaqktar/Al9JuFCG/ukk8bwWvB0LfGxa97lnbj8RUBWEGAAMGWjcBCtYfSPPUrNL
         ji0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571638; x=1788176438;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dDK2q8jEQBsx6u42K6XSBrp2/fHnP/dHMqcLRjUxZpE=;
        b=MiSyGviQ4HXSQYScXuctciThJaKdZORfqDM0WqJe7ARC3sAJEKQnYNV+Q5fDgm7Jdx
         YtzzDlpjUONAYZn3kNsDVxXGPuzY4x8zVp2xc/xJ1Q++oz4Uzd5HbC3rrhiSVn3RJaza
         vywxiAFHutPWqNE4z+19De0YFGP/SnCDpJmw3ypg3sk3nWho8jUaa0ZwaqIrP0Nb6ftf
         NfTPfdVM67R5duHm1iWxLEKd4fiLTQHb1HG/5jfxMeIW7x0+Yy6cwgyuwH/cc2o8ke4t
         EPx8ggbgZSiSeMMZ4Pju1Pt00dp5HOzdAimjjXEGhgp6Rg1SAAY0FcXeYvMKAAtowoa4
         IR9Q==
X-Forwarded-Encrypted: i=1; AHgh+RoDminb94hjh3TY1NgDOXbhJZI5l9IkiGRthqUFkR/HzU7uKTZ1DFst2agOIZqdj24TmOCW85boMw==@vger.kernel.org
X-Gm-Message-State: AFuF++mN48/l+KvdYD9X3JvpJ5HoKQZ2Ac5eHvgA/qLhbJXK3kr/+R1x
	6bsViUf8wJisW5EQwkfqwmnBbaQGpD855nm1gJ3S/RXsQkXLf8o2ZmSbtpqDsP5ZnFxJZcEFwln
	1pwyPZedJKufYJ8kzx9b2A3rp4LDJGR8AyQDb3f1MTMQQJrGrUcVNKAIjOyTx5g==
X-Gm-Gg: AR+sD13LImislkqvhV4ecBkFoTP3GTJc8XTv8tgvrZ639dw5A0MGnYZtTqMQC00bWsV
	blim9A55zoPchoHey3OMygLAcu030q9aUPNTD13Marhw0/fGddP5vL7eTjbIVEhujMoqATt0JGd
	reqcqhk1dCXhXJK892OVEWVFIAp+tVFYW2GpbKcczvxU5yNDD0vLPCWN+jYU/+ktkC9sJVcKxnI
	Zh4EMod68aubzQWeSe4Q/4hS+pae457ocpY6zRr6N/my/ubHBUGvG5dQi8hG0r6apJS3OAgYG5y
	ETtHk9XPZJkFgxFCdmi95g9aNL+pW2bT1JRvD77U1K0cB4bSaFdj2SnlNH/pT1qjaC5uD3ErTbF
	1l4/IBYVQXtK+pftttsLG43WsVd1lDEnDhmc=
X-Received: by 2002:a05:6a00:194b:b0:852:d5:d0ca with SMTP id d2e1a72fcca58-8520be70013mr25620820b3a.9.1787571638305;
        Mon, 24 Aug 2026 04:40:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:194b:b0:852:d5:d0ca with SMTP id d2e1a72fcca58-8520be70013mr25620717b3a.9.1787571637790;
        Mon, 24 Aug 2026 04:40:37 -0700 (PDT)
Received: from [10.217.218.158] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f14a418sm1883825b3a.47.2026.08.24.04.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 04:40:37 -0700 (PDT)
Message-ID: <e8856a22-0060-4720-9d8f-ee3b7498f46b@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 17:10:29 +0530
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
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-4-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-4-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NyBTYWx0ZWRfXziFB+RkvjyNo
 pmzNdqIxgXDL2AhrZQrP/UlIP3tVFXtXaffifL2/okrGpzMEcE6lOJJzNuTpzxze1ThV22sNRR0
 Yu6xpNBPiHaSv2bgr/ivQD1iuw1c6yQ=
X-Proofpoint-GUID: T7mq4qF8z-NR043IjsYxiTS7oVV-Dtaj
X-Authority-Analysis: v=2.4 cv=fqXsol4f c=1 sm=1 tr=0 ts=6a8c2db7 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=2-yugF7U08GihXn5wV8A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NyBTYWx0ZWRfX3DwaYyELj6yA
 Rdt9l+VQ69wNrohSvKNaf4/QE5JLUQJrykQ15UZizUDTNqTv9aDFP13JG70iVJpyjHTEVx8KD5j
 cnwxn/ao385WfTs1yUhnzA0auZxIVA5wX4OiWxXhuAPLanbFME/p/zdjI+DumuilzDqDcM5bepD
 1Z+s8D0EIVa51f1THo+s2yyvuZagN885rPXa1GSQnJZPKwa6HAgsOC1d1hFQOvPhR5OY3n5ZS/d
 ipsukHmF6E8hDNJD7DhkTn7TTGYL1KrR29moKrN9/Fnthl0VKHzNuiL+v3jfB6GU+GAZj/hBidF
 MywPwaENA8HM0wdGqQLLqKXmyysn9qyTqFSIqQ6qU93sHvLlwXHBKBu5vBd+6BGObGLzVnyawEl
 HKhO4XKiPCVrQxhTnkR+Rmfq/0TjC7eogKY5LVQm2nMh9vGk0tR36Ih/Kt4zLnAkFQ/Qt9gBzyK
 Us4in3kyGkVE5RUUCww==
X-Proofpoint-ORIG-GUID: T7mq4qF8z-NR043IjsYxiTS7oVV-Dtaj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240097


On 8/5/2026 1:27 AM, Praveen Talari wrote:
> The driver calls dev_pm_opp_set_rate() directly on uport->dev to apply
> the computed source clock frequency, and dispatches baud rate handling
> through a per-variant dev_data->set_rate() callback that either
> recalculates the clock divider (Linux clock managed path) or selects
> a performance level via geni_se_set_perf_level() (SA8255P firmware
> managed path).
> 
> Now that geni_se_domain_attach() populates se->clk_perf_tbl from the
> perf domain's OPP table, geni_se_clk_freq_match() can resolve a source
> clock frequency and divider on the SA8255P path the same way it
> already does for the Linux clock managed path. This removes the need
> for a separate perf-level based set_rate implementation, so
> geni_serial_set_rate() can be called unconditionally and
> dev_data->set_rate can be dropped.
> 
> Switch to calling geni_serial_set_rate() directly from
> qcom_geni_serial_set_termios(), and use geni_se_set_rate() in place of
> dev_pm_opp_set_rate() so the frequency is applied to the correct
> device (the perf domain device on the firmware managed path, or
> uport->dev otherwise) without the driver needing to know which
> resources_init variant is in use. Remove the now-unused set_rate field
> from struct qcom_geni_device_data and its per-variant initializers.
> 

This commit message seems quite long and repeats the rationale few times:
1. removes need for perf-level based set_rate
2. call geni_serial_set_rate unconditionally
3. use geni_se_set_rate instead of dev_pm_opp_set_rate

Review, if below makes sense, tried to shorten it.

geni_se_set_rate() now abstracts source clock programming for both
clock-managed and SCMI/perf-domain managed GENI instances.

Use geni_serial_set_rate() unconditionally from
qcom_geni_serial_set_termios() and remove the per-variant set_rate()
callback. This allows the UART driver to configure source clocks
without needing to know whether resources are managed through Linux
clocks or the SA8255P firmware-controlled performance domain.


> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
