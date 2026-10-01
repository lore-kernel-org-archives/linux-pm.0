Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04CB381AF1
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 02:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790821856; cv=none; b=ReQwKZaxzmrWt16xNkF9Hiwci/PhZHPMmMtt6lcyg7f++DlnB+Qhmb+M/cH+DXv3dgsT9+M/exRxVHPjp6gaSZSu8PM46brZCrhwNrZts9I/b0DB9Wdbrw/k2nuTquCEMgJaqF0eqSp8KEirNGSXnAPa3V8vg1Lch+m3yAUpcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790821856; c=relaxed/simple;
	bh=Qzj5pGzraqskHEzdoWlcKw/mKFLKYJh0TTlOiEgA/6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UdEkKPuvFX0GaG+13HoDX67YQzb3j8I0ZejzMy4QxJ+GhQoA3cJFGwU7xvxJFCBsMxRIACCDmXgXMvEafmExTYVEk6KRegqwzuNtu/30+z/EMfGEJ1wWv+rnvHSv5+1iQOJuh/BT3e4stdhDqhFqRn1dUJxi6lAEI4r8E16OlFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qby4BiQT; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qby4BiQT"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-88582e2153eso1942770b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 19:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790821855; x=1791426655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dLV+YqotDLXxDawySKCdSBP/LHKYRIWzAMZ3fLidsa4=;
        b=Qby4BiQT9tPQQTpVxXwizyaaVK/VcS5/G40GAIGWiwcUGCOadxP7uCzZF5eBEGkGOC
         g7hyxhDm+5R550sn3B03f4PIX7xTbhxP1wA+cv/PIZ7zv+bbuhbCRSZHb2wkvbOZZiS2
         orCrUL0DgAcfBJTRV3byzPDGgonlOXKwTOfaHMLrALFaE7hM9Mq5sguOWfdJEdHP0Pgt
         QABnYp5QGrwSFgKvyNa3BFFA+O7uKw6pFLF5BixYrv3evomPUvu1LwwuJ9y0bf3700XT
         1gjsfOps1DcRVXxtXT4f+lp/3VzHguo94fjrJfJvV/yJZgo8vb/se4eMQ1A3dpYsIdlH
         5rKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790821855; x=1791426655;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dLV+YqotDLXxDawySKCdSBP/LHKYRIWzAMZ3fLidsa4=;
        b=Njivv5+nLoaKRSz+Pw7zzQEG4UdG5eCsaLagQ1RS/jMrcOjt6KDhPkkjlg95Q7iWS3
         xiPmiYmhJy38aTWkLvCaCrNmQPehLTg2iXDaKe4FODOYjV5q3xrgR2TQ2c1NWpK1J3M4
         adDU/lUx/EjMF+5ZjftyQP10Njx8Tp2b5jmPPQExEC5tmEZPZd17jUN4x4xh545PcGUj
         iqwInSlWSlb+mjBU/mxW7YKLpBn/8sW5lKELNLQTi/GM/lDcrazHw540jiBeyEzS1UYB
         xAK4p+HqfbVBjUCJJbX9/aBtNWzCXsTDaaSXire3eRtWoUqcwb/BXN4B91gQi0uPEIF/
         uMjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdRNvQYXFSBTwCOFn3IqRN+ULQ7H7y6aLxPvS3sQZysPjNbdbqQryX1unRey7p98Ef6jSGsV86WA==@vger.kernel.org
X-Gm-Message-State: AFuF++mri2MneP4D6KMOT7idKeoYdiZTZFTL213fzIXkLbiFG+HZlX7B
	fD/7dnZ/5Ltx7VUPfy5VcNe6vtmooco+YL8aq2YAkrF96Wc5wwLUS+oq
X-Gm-Gg: AYBFou14EiBVxTiUgEeCzwotpy8kTCJxdqIwoiNPdsQb4MybBCV5CCJfTjo6nIKIYsE
	TCNEDXu1kFzHh4KL4/9JkqEdYpQvx4jgX8XtFBQ4d2PBzukrBxemKrsR2i9VH1nWa/e1kPSzIDq
	giS5TvCJ9clvMDE315kgGRwa8uOL85Ob3iFHfKnK7vNrCvtvQupy7/VPMERxVPme9XPaohyUR7y
	3uHCHq8uwN5VZBEf1B8puSjMDz8trt0I++PkMf+6UW+lqwlKvwkcZ7rdI0Tzj7Kyxnd+/Vv1F0s
	WYohkJ2mMfDmQW6C4xjGu1kq/YuMwuZPFoSEJj4E9/KMVusr74LCd/gDeuJgWP0taN9XGI9xSaH
	SQBYYM4E2iihCmz6OZWE7HiNQC1whAMU120mtydXzR4d0VdTNXy5IQoye9TwXtcwfIjK3J2SJho
	Woosexkvs8+P+yupGhq3dQDkB75U+zponj0syYe/2HZQKZSRnXgg==
X-Received: by 2002:a05:6a20:260a:b0:3cc:ebeb:3efe with SMTP id adf61e73a8af0-3de9e02b82emr2903360637.9.1790821854823;
        Wed, 30 Sep 2026 19:30:54 -0700 (PDT)
Received: from [192.168.101.188] ([2605:e440:15::152])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7e539b583sm676858a12.2.2026.09.30.19.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 19:30:54 -0700 (PDT)
Message-ID: <36bac55b-c7e9-40e3-b376-fb8d163fcd40@gmail.com>
Date: Thu, 1 Oct 2026 10:30:41 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] dt-bindings: thermal: sun8i: Add A523 THS0/1
 controllers
To: Rob Herring <robh@kernel.org>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li
 <tiny.windzz@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Philipp Zabel <p.zabel@pengutronix.de>,
 =?UTF-8?Q?Juan_Manuel_L=C3=B3pez_Carrillo?=
 <juanmanuellopezcarrillo@gmail.com>, Andre Przywara <andre.przywara@arm.com>
References: <20260913145527.18148-1-iuncuim@gmail.com>
 <20260913145527.18148-2-iuncuim@gmail.com>
 <20260924151758.GA75925-robh@kernel.org>
Content-Language: en-US
From: Mikhail Kalashnikov <iuncuim@gmail.com>
In-Reply-To: <20260924151758.GA75925-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/26 23:17, Rob Herring wrote:
> On Sun, Sep 13, 2026 at 10:55:23PM +0800, Mikhail Kalashnikov wrote:
>> From: Mikhail Kalashnikov <iuncuim@gmail.com>
>>
>> Add dt-bindings description of the thermal sensors in the A523 processor.
>>
>> The calibration data for both thermal controllers (THS0, THS1) is split
>> across two nvmem cells at different offsets, requiring the two cells
>> to be read and merged. To maintain backward compatibility, the name of
>> the old cell remains "calibration" and the new cell is named
>> "calibration-second-part".
>>
>> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
>> ---
>>   .../thermal/allwinner,sun8i-a83t-ths.yaml     | 34 +++++++++++++++++--
>>   1 file changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
>> index 3e61689f6..792081af5 100644
>> --- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
>> @@ -24,6 +24,8 @@ properties:
>>         - allwinner,sun50i-h5-ths
>>         - allwinner,sun50i-h6-ths
>>         - allwinner,sun50i-h616-ths
>> +      - allwinner,sun55i-a523-ths0
>> +      - allwinner,sun55i-a523-ths1
> 
> Why the 2 compatibles? What's the difference between them?
> 
> Surely this has been asked already, but nothing *in this patch* answers
> it.
English isn't my native language, and I don't quite understand what 
you're asking. It would be better if you just said, “I'd like the commit 
message (or somewhere else) explaining why two compatible string are 
required.”
Thank you.>
> Rob

