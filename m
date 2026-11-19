Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096126;
	b=D0tK8GhBxF8uMHN+6Mzp+biAXUUl1WEQW8stf1ZVqVViL6grGxWb/TGauWXdY0UvRbZ9
	 iOSgzJXERJur28dGrwNXlSoSA13VcDh0PLN661oYhF3TeqIgi1jakSP+WudVfRR8JpE9l
	 JCt5AkVA8Hc/31qZPu1q9MzHzXFpFCTFnlwjtPV3fLk84BoPwvbLQrn3RXfIz6gtU/VCj
	 HREUkfsi3bUF6RuKvXuc+8PR2Tns9gtdYiL/IsCJbNB64IgUEkm3N3x/EqgleZys3uWMw
	 7MAv/Rf8SjABQRzSrh6ktCr5TaFpsD0hsh/tNFQ53YrbijP1bNzGQ9ZmzPujFuskEdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=BKa5IC7AB3kLyLATonakZgU4RKoDnILa/q6mHie7Xw0=;
	b=YWrhqSNgwmUIsGndNxzIFt0AYxpyqcOTUSaA2aerJJtlbIjtF+Yy3xDcmgwyXHtJHi+N
	 GK2BrTBRW4uh0bvQYJ6Ovu8Rt8x5Ycu6s+vNDsbbjJdPWfHEHyBTL1t4Bps7zj4c4lrHq
	 WzeE3rgbrKn6S13yogcmPJURPfSp2yRRh58RVyqLaws4yXqaGDMQjp7C5HcbWo3qxK/s2
	 XirUMkOEeJlb24hKnL0eaV1iX2ODPFv6NKPtZ87iL1rS1Fj0MNi6IMtvjsyUbfFIOPGii
	 OE49h8OITyRICGy5j2vxcswFzJ3XJ8e0qpZBn9ygG/ubWTLTNw5zNHDC00s4jVkpT7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fL93sBph;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D3B606A325
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 13:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5D3B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fL93sBph
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e09aa5264so1313744f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 05:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795096124; x=1795700924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BKa5IC7AB3kLyLATonakZgU4RKoDnILa/q6mHie7Xw0=;
        b=fL93sBphOCi0c4Cbb9loeHvf7xl9+2wRsGNd1Zkk7WfkZbs7Br+PFcCik+0Qzose8F
         wlV1I5nH3tgPGkQAjg5duPXqhqd9s6Z5vPkS70cjUl95yVpMfiZITXE70sOC05uR4Y2+
         9HpGfjPiT/IOS9gSLXjBLURHQaAqef92Op4wStEFvcmhJKQgepquUQVW1Q2AKUpo3Mv3
         ohdXw1wJRFURvNCMejSS4JWuDBgXTp64OvouZBOVWfNP2jUmu70SzRI+wCopIcp0jEBv
         NSdAW4mQQSZzeFSQ1B8E12+Rqrv7aFHAscPvQtj7FYHoLcuw9DKHXHW3KGGuveUZ84Ms
         JVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795096124; x=1795700924;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BKa5IC7AB3kLyLATonakZgU4RKoDnILa/q6mHie7Xw0=;
        b=L0uaQkCrXhvk2rY8jkatkRdzfTNk2hyCNASLime9FjG5ypVaiXzeCa5gJ8bi3UN27q
         hxO3uKoq7WOyu5JprfYTaa9ETFcbzA1609cDiQIiwT6GhzvpWAclTbBRLsqggUJbl4q2
         9sqvqL+EBDZTFHnTHArfuPLk/XGew11t8sjFK7kQlpylApO2++5VAL0FZhV/p33ju7sY
         wWaYsST5S7rrpLireclzQ75VctK92BK08Zwg0nd6SEYvg9FeiVaUDOyVAiccOdoccETM
         hpDUxjuE6QUoHszfFVomFBoJcXtuqIGwuUgszYb3FFrReTmMGjeQJPSH0IW+jjlNPqwZ
         9kvQ==
X-Forwarded-Encrypted: i=1; AL+hErGopudgUgfVRf1nR/LM6NweIIig5GgDSdKbQEJVqcp37skD77yUnM7vItHFkURX4Wq7zRR5Hllxtg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8dScQFQ6RDd7HpifCNGHbRDfAG870A53m9fxd8X9M1pE4guS0W
	VlzHK/ffAMdLoO/yUVpfE+U7749QWGdpEmk/5Sff2HJr4fTITYgTtRs42m0eiBqB1AA=
X-Gm-Gg: AZFdTZfyZw0bk77uW4iCbdARKYP3bEL64QPpqd/nD1qaW8mHJqmHs+h6TmqXLKkacH8
	1dvy32sA/sPgQQZuZPzsqkIHIlx4Ilrrq+V5S9NfH4a9wCusgHoxPeVMEoMsnbcJh3KFuOSbF02
	VkmfCNtqk5o4Y7lWtPu4CKvDUXn13m2iBHvFI/+TVJBppPmG/DtPPX7QwLvxc05vaHZ86I+apl3
	ApFku6RKB/Wym9PvjcjJ23ljGdol8bMW5qZcz0JO//Jt6hGEmG+NIUunCCVgPVcLc9qFYAwiIPQ
	LyO03p8zdlW080b+Q1j5FSIqZnbhNXkTIyqQn56h36jUXNDAZQDWdB5sAkgzOrsmTzH1Y7RrXs/
	GPMaiqd/UV+rZykC/zJTgvjKWkf8zc2rFqIU/A1bckGqzy1doEZyyc4tMdVY1EjEaSoIKM041V4
	pmnLllu6PmRRTqwjlX5eejRkFaPP4lJYu7Tkar12Ik4TW4VLn+S5fHs+laYcLsAFg2FyVTvqb1Q
	PaAQD1mjuII+gntlwQ8VTH8MXBhkVF0Wc7IelqSv4nfnNSqK9VrnF77CrA0vO9oM7IrItJiDP+b
	crTplgA4L5sSNLnGC5WWx8/6/zFSuIj9xo1HFAo9
X-Received: by 2002:a05:6000:613:b0:4a7:45a2:ec26 with SMTP id ffacd0b85a97d-4a745a2ed63mr12002121f8f.16.1795096124130;
        Thu, 19 Nov 2026 05:48:44 -0800 (PST)
Received: from [192.168.0.252] ([79.115.63.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65609391bsm10932012f8f.36.2026.11.19.05.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 05:48:43 -0800 (PST)
Message-ID: <96fb6324-7563-4d0d-88d8-cba55b92eebf@linaro.org>
Date: Thu, 19 Nov 2026 15:48:42 +0200
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: samsung: acpm-tmu: Fix spurious CPU throttling
To: Christian Loehle <christian.loehle@arm.com>, bzolnier@gmail.com,
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: krzk@kernel.org, rafael@kernel.org, lukasz.luba@arm.com,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-pm@vger.kernel.org, Juan Yescas <jyescas@google.com>
References: <20261117083442.830549-1-christian.loehle@arm.com>
 <3ea5d94b-6913-4534-816a-3935c689225b@linaro.org>
 <56a7a762-7667-4186-973c-ca0fcb399ecc@arm.com>
 <b2b0ddc6-964f-4d8d-86d4-a0bc24d9022e@arm.com>
 <4d51fe5f-d233-44d4-a50e-ef168b6f0402@linaro.org>
 <2cc6efc8-db35-4b40-ab71-815f08ed9dc9@linaro.org>
 <a1c4e409-2d73-4689-b136-41825ee2b61b@arm.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <a1c4e409-2d73-4689-b136-41825ee2b61b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/26 3:24 PM, Christian Loehle wrote:

> The alternative is of course to just hardcode slot 7, downstream uses 115C
> as a default value (supplied by DT trip point 'hot'). Or do that as a fix and

I thought about this too. The problem with it is that we ignore the DT value,
and downstream relies on the DT value too.

> then follow-up with a proper wire-up? What do you prefer?

I have no preference. DT was queued for next, so nothing enables the driver
in v7.4. Maybe that's why Daniel queued the other fixes for next too ...

Cheers,
ta
