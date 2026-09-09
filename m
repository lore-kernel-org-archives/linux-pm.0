Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D984054EEA5;
	Wed,  9 Sep 2026 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955833; cv=none; b=BRBMmrgBYZGfUpMdWBNFylR4Fp0+NLkHkJZHzi/rCMJS8vjmIniMxLTZ+FFSPXJ0lZ9tqcT455AIsT2JVDvGP2ljurXji8X+lWGWfKRDyzzdRTVF/+qL7s70Pc//HOaWqocWJeH1ofTpA8kJLEpPUQwFGn9JJ8cfNzFfN6WDS3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955833; c=relaxed/simple;
	bh=6Gk9u0oSqBQ7pqeGbTieHQOdGP3n5QrcHyTCokPJ5VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGcckbeFRECh3Of1DUVIVB1yURvFg/YXbvClS+Q+DRHToJZFphl5fGt7oj1gi6cpyGoOmsD8hT9cytPA//ZwFcwUSYOdEfKvtW5w40Xr1SF8jlqKl58pse5tKBxVQvE3bRlp14m+JPx/4UX/t3RmggjL+Fh5Pxtjnt6eDyZCKPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCNBvIaw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCNBvIaw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5151F00A3A;
	Wed,  9 Sep 2026 12:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788955832;
	bh=XJJNXelHGfyOCJIhWPkG86Eo900eGpI89H0jQPU9A4Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BCNBvIaw0Kh0dEDVF+1a+kRtz4UsUrDiXB8o1jjKvXC39dKMRF6W3nLxVzT/axCmz
	 +w+syaDqTCxCcyRGpjcFIpn7os1f0CMR+M+BvgUS+gbzTbejmqSYYSutw0aDl7Z6DC
	 7EqAZRmw/JCcF+xBu8gw3m2duYuLYf2Tz1vA3E5IA+oCoDeMB2zb6iHnw7aYqf7ldR
	 OK1WTZJdNGl7M2S5QMpMYrCKbZCWJSFlEArVfKocL65Wlm54jBL3YH3xU7KlXc9HlE
	 4H3RRV7LnZXtjQS+I/dTscuvMqAQUz9Q/XEZDOU1B5GJo3q1MIQqADPfL5HI+dUMuq
	 d5dyuOp0gtylA==
Message-ID: <f5ac42a1-d24f-40d5-8803-be147491c994@kernel.org>
Date: Wed, 9 Sep 2026 15:10:26 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: add nord cpu-bwmon
 compatible
To: Bjorn Andersson <andersson@kernel.org>,
 Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, shengchao.guo@oss.qualcomm.com,
 bartosz.golaszewski@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260831090134.585588-1-zhangfei.gao@oss.qualcomm.com>
From: Georgi Djakov <djakov@kernel.org>
Content-Language: en-US
In-Reply-To: <20260831090134.585588-1-zhangfei.gao@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/26 12:01 PM, Zhangfei Gao wrote:
> Document the qcom,nord-cpu-bwmon fallback compatible used by the
> CPU bandwidth monitors on Nord.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>

Acked-by: Georgi Djakov <djakov@kernel.org>

> ---
> 
> This compatible will be consumed by the Nord bwmon device tree nodes,
> sent separately by Shawn Guo.
> 
>   .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml     | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> index 21b4e04727de..8c82103fb86b 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> @@ -30,6 +30,7 @@ properties:
>                 - qcom,hawi-cpu-bwmon
>                 - qcom,kaanapali-cpu-bwmon
>                 - qcom,maili-cpu-bwmon
> +              - qcom,nord-cpu-bwmon
>                 - qcom,qcm2290-cpu-bwmon
>                 - qcom,qcs615-cpu-bwmon
>                 - qcom,qcs8300-cpu-bwmon

