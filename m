Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F3947D927;
	Tue, 22 Sep 2026 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077122; cv=none; b=C01VNz63X9WiAaTwXmzi2NTQjD2g4cbUFHn/5iqz2G9299GXNnBkP2qqhXUixzLix4pJPRmzMzZv3o36gGa67RglZ16QYAwDaDMKehXNoJKWd6z4iYGiQg8Kyd56tC37tf9ElZ2Fu/8eMP5HUHyYz1lVJlF9vQmzFoC2mbXWKZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077122; c=relaxed/simple;
	bh=WosUaYn7HqRDaOXLYdRn/vZ0BiZSawb6oYRU0rz9/0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgiZlDY9nSKqJSLuf4NNmJiMc5OnWo5tTJTE8x5oGIGB3aTNpcFFyyEbajo3cRkq4qT7Km4tcEFvqd/Jg0rfbqwWNEmXHlcmrVJEiV+WxnrtRPnojNKoFCfKj47V5m9m6lMM1P4t2j5DOu/X6Ti4bxHn5Zq9OjCQqTc/HFxkxjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhmMrWgO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhmMrWgO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFF21F000FF;
	Tue, 22 Sep 2026 11:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790077121;
	bh=AE7SoZH1UVm6dwXo4QotbJXzN4RRQJKVSZjbDTPVSp8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LhmMrWgOqztxpmKvUpwWyYorjz/IirOzFT6Th64vMqz2S1grprkTveRE7fSwHhBKJ
	 ldedRiIcSM6AdmFzAtjXFY9/3o9+OYp/i803UwwL6BAxH4FhQB0YRvxlYriG8tCgRr
	 MzSA2nXDWQHr5FEEJOeeybUIFX1pJQy8V5rNchlAqHMsfi7fRgoBSZBhP2dOmGkhjI
	 dRhMYP1MJkVsJL3MZCCwY8ykK+CfkX1E0uIX84zA0t2GWMdWi5jd5QvKM9DjoCTKyH
	 kVnIKEky/6H93xDbjnlCQBBWjkOcViU/epLAYMlwOJOCsXOIz7PcglzXyb1n1kncHh
	 nT7wY8HsAcA2g==
Message-ID: <21aff47e-07cf-48b5-9752-b1a9dc7e6095@kernel.org>
Date: Tue, 22 Sep 2026 13:38:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: add nord cpu-bwmon
 compatible
To: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>,
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, shengchao.guo@oss.qualcomm.com,
 bartosz.golaszewski@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260831090134.585588-1-zhangfei.gao@oss.qualcomm.com>
 <CAFkd8hth1ds5j9jbe3vjjpCYkbTVSeTiVsQvzy30YCyFUH83ZQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <CAFkd8hth1ds5j9jbe3vjjpCYkbTVSeTiVsQvzy30YCyFUH83ZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/09/2026 13:21, Zhangfei Gao wrote:
> On Mon, Aug 31, 2026 at 5:01 PM Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
> wrote:
> 
>> Document the qcom,nord-cpu-bwmon fallback compatible used by the
>> CPU bandwidth monitors on Nord.
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
>> ---
>>
>> This compatible will be consumed by the Nord bwmon device tree nodes,
>> sent separately by Shawn Guo.
>>
>>  .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml     | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>> b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>> index 21b4e04727de..8c82103fb86b 100644
>> ---
>> a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>> +++
>> b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>> @@ -30,6 +30,7 @@ properties:
>>                - qcom,hawi-cpu-bwmon
>>                - qcom,kaanapali-cpu-bwmon
>>                - qcom,maili-cpu-bwmon
>> +              - qcom,nord-cpu-bwmon
>>                - qcom,qcm2290-cpu-bwmon
>>                - qcom,qcs615-cpu-bwmon
>>                - qcom,qcs8300-cpu-bwmon
>>
> 
> Hi,
> 
> Gentle ping on this patch.
> 
> Shawn has posted the corresponding Nord DTS change [1],
> which depends on adding the qcom,nord-cpu-bwmon compatible in this patch:
> 

Based on acks here, this should go via qcom soc, so part of DTS patchset.

> [1] https://lkml.org/lkml/2026/9/22/844

Please avoid using lkml, but instead use lore.kernel.org.


Best regards,
Krzysztof
