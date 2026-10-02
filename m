Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A89331EBD;
	Fri,  2 Oct 2026 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949906; cv=none; b=siwuaUz9gt5mHJIlE1K3z7G+YJG3o+s+6E8f3YxNgA+P9S/ApbC1DUBQc6aMCmltCQPSudukwMk9Bag6dn5iZagvhztDb0HVAP6CJEgJWtvEcX2BARDlZGn3/ihJn5TMs+5Z9sB4kzWobsKAesqK48oU/tWX6pwcpL5IXm6bFgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949906; c=relaxed/simple;
	bh=UldxzhOOWn+zI5xQbXHeUikgJJze4n+aXzYCUyjeO6w=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Z2AcdhAalqkoEUI3j0wBi+xmVqTUa7rMu0ENTu2/WrqHDsXJ7tI2TJO2umEg6EEdIeYtWFycLYVYbcf7DZBuQmy4LLAZ06DDyW6zgrCGBJ617bHtRmxs9qPkqkx2PA8PKHBl7IHFpdKv8bOP3AHOGnBeMcmcFfd10ObWcKZ+33Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ZRn4taga; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=tmXg5zzI; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ZRn4taga";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="tmXg5zzI"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790949890; bh=NqakC2EdNOStp+MFCguvI+4
	5LmlhJls++C1rbkxt+2E=; b=ZRn4tagaX/5foJfAFPqsvz1sDldX6OoFbBkeRMmQ4fdZ8SEw+Y
	tlXOy1NVsIzhp19d9M/xrk9TAwdb3BZvon94PHGuifPnpaXaY4rn8V/hdI+oPEfFqXayMxfP1l0
	p2ThB+93usHK2v32i9siEJ1HIOpLzDAq4LKDhk1a/OILHT5c2fzAeJzGkU9UNmM0rXy05tY+AXh
	BnBBqAnaFXVMQ7cFaGi7rpd2U4tdfd89M1ywnCQ9WV8xJLlP9iPZRctb/m3AMAUCIF2D22x9xVK
	orOTJqfjfRa8HN9FueASyJN1TAsK/NkYTx8KMqKn5IzHRWqAcdgLDqCfDcoLHYqLq5Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790949890; bh=NqakC2EdNOStp+MFCguvI+4
	5LmlhJls++C1rbkxt+2E=; b=tmXg5zzIeYR/CTi+kG5mVr3hdVw3u9Cd7do+OA9bRnm1HypYCH
	ERedvrHfzzeD1WVBuv5PbNHcZ5loINw7RKAw==;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 16:04:50 +0200
From: =?UTF-8?Q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=
 <barnabas.czeman@mainlining.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Konrad Dybcio
 <konradybcio@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, Ulf Hansson
 <ulfh@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: power: qcom-rpmpd: define RPMPD_VDDMD
In-Reply-To: <20261002-devious-mauve-wrasse-66bbeb@quoll>
References: <20261002-sdm632-rpmpd-v3-0-95c47d0f26cf@mainlining.org>
 <20261002-sdm632-rpmpd-v3-1-95c47d0f26cf@mainlining.org>
 <20261002-devious-mauve-wrasse-66bbeb@quoll>
Message-ID: <d5e9ecd991990098a4f1724750ed47f8@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2026-10-02 11:57, Krzysztof Kozlowski wrote:
> On Fri, Oct 02, 2026 at 12:38:29AM +0200, Barnabás Czémán wrote:
>> Define RPMPD_VDDMD can be used for SDM439 and SDM632 MSS.
> 
> There is no sdm439 RPMPD... The SDM632 is added later and bindings
There will be.
> header come with the compatible patch. Squash these.
You have previously commented how that is connected to the indices.
> 
>> 
>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> ---
>>  include/dt-bindings/power/qcom-rpmpd.h | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/include/dt-bindings/power/qcom-rpmpd.h 
>> b/include/dt-bindings/power/qcom-rpmpd.h
>> index 4371ac941f29..beb066b3aa8c 100644
>> --- a/include/dt-bindings/power/qcom-rpmpd.h
>> +++ b/include/dt-bindings/power/qcom-rpmpd.h
>> @@ -15,6 +15,7 @@
>>  #define RPMPD_VDDMX		3
>>  #define RPMPD_VDDMX_AO		4
>>  #define RPMPD_VDDMX_VFL		5
>> +#define RPMPD_VDDMD		5
> 
> Problem is that it is platform specific and comment in that file says
> "don't do it" yet you do it.
It is not completely platform specific and if you have check the 
previous
reviews Dmitry was asking me to define it. If i set it 10 what will be
very safe for every platform i will get warning messages.
By the way 5 is fine for SDM429, SDM439 and SDM632.
> 
> So the device has nbo MX? Why commit msg is silent on this? Explains
> not much except repeating the diff and referencing users which are
> almost obvious if this is properly squashed.
> 
> Best regards,
> Krzysztof
