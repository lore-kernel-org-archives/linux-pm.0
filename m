Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76826485CF7
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718059; cv=none; b=RbPfB3Mb/XPD3iQ3aZEOaPIErklEfRJuIx3mL7Wio3nScV4cualRa7y3zBgLc64h83RHIjUSOWkLXNBkATNPaa2eR9t3LD2/TjGgrk8bxpqcdylhVkHxVcar++wPwjZaubY0wgm5544Y2tks9L8pUXBrMx5MPT+jNS/k4JFtFPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718059; c=relaxed/simple;
	bh=kNjWH5+CMgW1Pl5h6a/fYwVArl9Y83OAw6Pl4E7UYmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFZuWXM8CNJQCbC/j7t4AGd3FUvVneVGpCe483onzlqBwUbnIgr5rTRlk8sUHUeSZv5fBe/Vtrw/3l2tPN2ETmDTjsWsqsordW7secKmxV2s0VOfuhVvbpTyLA+rqtm6jWn9mynBKIkcEnQaauAIxGIo9z/G8zuW6DmhA89qcLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxIs2gZ6; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxIs2gZ6"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a9ac6aa620so1953987a12.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 00:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789718056; x=1790322856; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drEHSSlhuZVaxkDlnBGA1Yj/cgZE9sePJP3czUIslhE=;
        b=AxIs2gZ6VH5UgYIFr9Yw9EV0BCQ1R8qky6GwRmk7r36t663M3YjIgQ45OrUYfvv4XU
         1xPInICkSV1b1a9Vdi5FMVoRtYq20V65xznc5G72rrvLXaNzISvbtExVX0apWPEvEN9M
         4z+VqgE5GwR/bi4IuI0rzKmCkRiGDk2oF71M3VWMdbTsFGggVQn6A5qBg616EmD512HA
         d2F6EczK4Tz+gjzGHGjLJKafFc7qINFjW7QTeRscKoKwLAoUWo3vJx4aVi6CVuzjq/zM
         BNbeed+DRZDosI+MoHynG6tjI0BQXwrju6r6/VwkAZHbv+rKEmMCww4PmPsAL8TDVRWG
         jNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789718056; x=1790322856;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=drEHSSlhuZVaxkDlnBGA1Yj/cgZE9sePJP3czUIslhE=;
        b=K+hNWXBNiOK72ONSDTeB4wGE85BCV4alHPP7N4CWd0b343JwB+2WiHB1lpIaq0FqJQ
         OWTkaJd5hhdyBR49dnwjD7IuCbnWuGYYIRNtxKyvNdYyXSNmBlsN5KAADk3HGAIZb/KG
         hyxo93sDLYyY+gj+v++MRiGXhPavelQwdxRqF1m5dTlGv9+oIyt+WJUJe/ccXxX0f/yi
         mcMomnfPT7TZqgUQk9sCyoVOWut1ASgAII/qejZoN1MurJz99kyx7ceZ4bvEJ3wcc2vb
         yT00CjgX2oaNI3p3nIZB/TLixz2LgbQS7Y+xjBnzndm/itES04s4ELu4cic0K3Q3FLes
         H9Nw==
X-Forwarded-Encrypted: i=1; AKwUvBwckbskXaWbOexBrW96MQwzkaQWBQJEYyEukq/HMzgud8tM1Hfju6eh8Vyg9WVYjGQGWv0bgTVMrQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mdbdIYJfS05zIgbbxAdt2E8s6mBS03wM3u8txzdHwKqbNjFX5r
	7otMKL3od1cNiSnJHJRXZ7Ohlyu6Clo3CFKwwqCL3BnzPQ6JozThIKVN
X-Gm-Gg: AYBFou1/1LBWZOP4dCboQSRINjxMZlJtxxTPYXdKUUN6XcA7OZ8E+bcB6NLXjUEJHbr
	GxsnLSAAMqoxurk2N9yx7ianscdUhr0ERuC3TS7kKe7j77/U3sCamVaEX190YpikVQ+j9PzvG0V
	BMtdEuaznLtoomAffIR9F4hDZssGg87Oin2WTXR7bdrVHO2plLImTPSKTecXx27xmG+fUNKZgsB
	3nuO4Gh+Yf1WEssWoWr35/FtR2ZlPMUtFdOJYC3wvaZNqINUKMu4zF5XplenqFo3PFO1YYZM9GR
	CzVFYidR4PyRAfaxnH12ZGy4XKp873aHPA9ltX6GtVRp1vxN20iy3eDxi1SAaBbN6E+HhTCIqsU
	CkNwCuTqsYBLCsuGivkZDCJ6f143q1uGykKMzzby1ChpO4nWRQ+AWFOqFUeUOiVkklJFzvhMXsM
	uDq7pGT3/38I9IicoLQ6nwiTQS9U7+qWPzMgSPECEjUVnUbkYSzzS4+mbjGnak/eph3eG2pokfW
	BkUKFilNKDWuMl6+VszT6SK1a2y1GxE1hI=
X-Received: by 2002:aa7:cb1a:0:b0:6aa:1d71:4a7a with SMTP id 4fb4d7f45d1cf-6aa36e04b69mr2998119a12.12.1789718055453;
        Fri, 18 Sep 2026 00:54:15 -0700 (PDT)
Received: from [192.168.1.30] (161-53-210-87.ftth.glasoperator.nl. [87.210.53.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa59605618sm469752a12.11.2026.09.18.00.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 00:54:14 -0700 (PDT)
Message-ID: <c7fd0dfc-5da7-4bad-bfb0-308e3937b1cc@gmail.com>
Date: Fri, 18 Sep 2026 09:54:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: soc: qcom: add
 xiaomi,taoyao-pmic-glink compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260915084901.56622-1-zstaseg@gmail.com>
 <20260915084901.56622-2-zstaseg@gmail.com>
 <20260917-sticky-sheep-from-pluto-adf65b@quoll>
Content-Language: en-US
From: Stanislav Zaikin <zstaseg@gmail.com>
In-Reply-To: <20260917-sticky-sheep-from-pluto-adf65b@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/26 12:07 PM, Krzysztof Kozlowski wrote:
> On Tue, Sep 15, 2026 at 10:48:59AM +0200, Stanislav Zaikin wrote:
>> Add the compatible string used by Xiaomi 12 Lite 5G (taoyao) so its
>> battery manager can be matched to a device-specific variant in
>> qcom_battmgr.
> 
> Previously you were asked if the device is compatible with qcm6490. You
> responded about something completely else - that you need qcm6490. That
> was not the question if you need it or not. The question was are they
> compatible and you have entire commit msg to explain that.
> 
> Instead, describing standard Linux device driver matching in commit msg
> is redundant.
> 
> Best regards,
> Krzysztof
> 

Yes, apart from battmgr, the pmic-glink implementation on this device is 
compatible with the QCM6490 platform (base communication & UCSI 
implementation), and therefore should keep qcom,qcm6490-pmic-glink and 
qcom,pmic-glink in the compatibles.

I will adjust the commit message in the v5 to:

dt-bindings: soc: qcom: qcom,pmic-glink: Document Xiaomi taoyao compatible

The taoyao is the device compatible with the QCM6490 platform (apart 
from battmgr). The device also requires both UCSI_NO_PARTNER_PDOS & 
UCSI_DELAY_DEVICE_PDOS quirks.

Document the PMIC GLINK firmware interface on the taoyao by using the 
QCM6490 bindings as fallback.

-- 
Best regards,
Stanislav

