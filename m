Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8410B434408;
	Tue, 22 Sep 2026 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080414; cv=none; b=L2c+LTDIYlGqIvLMFu5rZzVbkO70CJrq3ZZGWIUKYMybTLlrujMwS8RHMv2wJlslg1hDU9Fjur6H5hCJlhwjhYYJXhHpVsbvDUxH6jj5vRl1awbxurpPV9dzefQk3aT56XIfHVA+TSoklX/eZ0nk2bvAzz35sqzoWyjWgj+23fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080414; c=relaxed/simple;
	bh=W0u4tVLE8c7p0C+3P8Mp+xVEBvJ4vBCxw4pUyIjhKOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJ4DNBmz9ka+LeXrJ6XWOn+jmUHlX7j+YrTDZyrpKwUpWKXAuZjdi3tBCjRlNiyn0jvG1sgsbkWsfEwzemxgQw78rhn70gVbr8KPf++TETIpFUHsxHH1qkg/W+tdHGOLmXi3KCAtwX+pqJQZlAHfNW5Wh//DySWMN1MCdqX+r0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOSn8itt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOSn8itt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D305D1F000FF;
	Tue, 22 Sep 2026 12:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080413;
	bh=Ed9tjCC2cu3Dfx39Y5UOm3PozqDGAxUybKbOVEaNDLo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kOSn8ittHdEi0s8VFg4XqxaQA5jSahyXH02rRVSrvF+7wtDnzFjwj3OEpyr4ISqml
	 /k0arKVbodZoLe5nRwngCKYEIu94VMzXPsDYQL5j1mwHNRMPNaLWnFHY5o+Mwd0lI5
	 bDRZEsFfDxjVHIV3W5OLnR8IuRlk2jI7AhY1KlLRZrbHrPQVSWYZYU94upUDTPXaZv
	 Wsqd66HO7GQ9mWVldsLYBhnZsG+yVjEWml1zB+oq67mIhOtmcVyjU5lRZ5BVp19FXv
	 6jo3UnF/rJ4wImbKsavXwCyGPxjGmnq6hUgrrHG1gAYXz6tzfWw0ba5eAcL0SZEcmn
	 ZRuCyVF8H3w6w==
Message-ID: <69c93c76-edbf-4c52-9dfc-877d80390d6d@kernel.org>
Date: Tue, 22 Sep 2026 15:33:25 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] dt-bindings: qcom,ipq5424: add NSS MEMNOC clock and
 ICC IDs
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Kathiravan T <quic_kathirav@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
 <20260921-ipq_clk_changes-v1-7-d242e3d49648@oss.qualcomm.com>
From: Georgi Djakov <djakov@kernel.org>
Content-Language: en-US
In-Reply-To: <20260921-ipq_clk_changes-v1-7-d242e3d49648@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 9:19 AM, Kathiravan Thirumoorthy wrote:
> Add clock IDs for gcc_nssnoc_memnoc_clk and
> gcc_nssnoc_memnoc_1_clk, which provide the NSSNOC-to-GEMNOC path
> required by the NSS block.
> 
> As these clocks are exposed through the interconnect framework, add the
> corresponding ICC IDs as well.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>   include/dt-bindings/clock/qcom,ipq5424-gcc.h    | 4 ++++
>   include/dt-bindings/interconnect/qcom,ipq5424.h | 4 ++++
>   2 files changed, 8 insertions(+)

Acked-by: Georgi Djakov <djakov@kernel.org>
> diff --git a/include/dt-bindings/interconnect/qcom,ipq5424.h b/include/dt-bindings/interconnect/qcom,ipq5424.h
> index 07b786bee7d6..50b883b16a12 100644
> --- a/include/dt-bindings/interconnect/qcom,ipq5424.h
> +++ b/include/dt-bindings/interconnect/qcom,ipq5424.h
> @@ -40,6 +40,10 @@
>   #define SLAVE_CNOC_LPASS_CFG		35
>   #define MASTER_SNOC_LPASS		36
>   #define SLAVE_SNOC_LPASS		37
> +#define MASTER_NSSNOC_MEMNOC		38
> +#define SLAVE_NSSNOC_MEMNOC		39
> +#define MASTER_NSSNOC_MEMNOC_1		40
> +#define SLAVE_NSSNOC_MEMNOC_1		41
>   
>   #define MASTER_CPU			0
>   #define SLAVE_L3			1
> 

