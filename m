Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8FA156677
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382430; cv=none; b=JRuuPeodVRdOxp0aqwjFV76geCJ4VvEglPSsEiEbL78zIVEyGEcgH2XouDIqfzo/qji2l1vgKeuIvy6xk9vfPst+rwCaIXSvmi2Hpk7q78F0Qm0QH8xgii6JsLzm6hcC7qNE+hVTuKv83V9j1CBV6NJ8595WPlBrze0eKjlMgQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382430; c=relaxed/simple;
	bh=CRgV+9RQqEMe89laHpOgNDyGF0EGHN6ZegnYaeKRrHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eyM51GUKvh9uRPyUfbjwMe7JUdNyFWgLuA9Goo+bmGP8waC9Wm6/KAffVoZmlDi9UTNhuQ0eIbALFCgToxQ0P/V5YrJm+K+hQijqcZewLh/+VBjCRRij9wNxkQO36g1DMyXixSr7ULMh8PKp1p0jvZIFfFSLvpISsjkoz0EZgDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fxwfpzmc; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fxwfpzmc"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-467161c4b89so3113189b6e.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 13:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774382428; x=1774987228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XzZztcbbwprheUgN1gN9rW/KXrvhYpn8l39P+C7lIlw=;
        b=Fxwfpzmcx2s/ofBdQ+9mwVr+QUtHSb4CrTZR6ZgO3EWdPWrILLw27eIS8dY1YtFBC1
         2HBrop/itNpewuYh2oj9rh4b0N5c8RrFRwds0rQJ1Gmx7uIcqOPHvUSVeAHpXuBJ66TO
         8e94sPt6keWBhdXHvhaFsGk55GGEIJNWAvrDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774382428; x=1774987228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XzZztcbbwprheUgN1gN9rW/KXrvhYpn8l39P+C7lIlw=;
        b=eilMq89fWIwbTOnJArrnVPUyQaib0srTTuvXEzNDf9axErKuhMndaZFaaKRcBzasW9
         hRN+uJ3HK2x5fqi2xfS/2h4dw9+v3mPxaVQTcZNPv69D3D71fcsXgdXSMGlK1awTSEg1
         Y8j3r0aVsTuLOshJWiz5+6+CGyFhbyOPQfMAV1VOXuBV4SD+X25HSuD+qQg2KJ7Wum8V
         /OJAwS+7CGzdXe1XZdGJOMoLjvOBWXYhislVQygZNO8ikXHE1CgzR+YeSYLZ1IBeTuAP
         kXqN4gttgZI7Ysrs2pszMnLlSgmfCXio4TNOUSVBDPc78MLH981h7xUo5l1I10NlreXJ
         dxhw==
X-Forwarded-Encrypted: i=1; AJvYcCW3nHRvfUFHCWFW+lpHULneCRDZ/TKOHaJbJtlBTKnBuZJs1nSaFvnmVWmgdST+2VJjwqpYPbR+tA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtx07jWsikztIx2EzJTDyWAUHxs3DmJrL73jkYCtxwf+fLQohr
	tsVH92F02D1gFxtxdRP+KvEUrR0j3BNPb0/yIKmjDR4IBV+Z1y+sllahjMjTN3qemP8=
X-Gm-Gg: ATEYQzwQF2MmyaP8WzzuB13/AqdcQWdy/DVcqW66HBQzBBXaDwxumXGUBWcNmCzhisO
	G/Y3Jgi4PFxzNm+aJpryxDPObl/xCFzUv54QpSUOB+MRnpA7qg0QkJzVu6q7wQkkbqLOAa5oBMx
	f7GToSgN4wvSetc1w9j5EcHj+UCpPmse77oR9Anq51/9yimusLRWaalz+n9vhGx8vDoifmfIgHc
	cb64EtCO5PGAEnGPGLHcBNVHX3+RmEtl6ltIBFg5J4tg3NbE4iG8MVvr1gSflC95n6ETxEl0gRs
	qYBYnfi0xnBasn+w6H5mkXMPYtpIjNzjUsSOjHMF3P81nO/Xi26s+1KPlAK/OoDzAOfEP3ZrUd/
	d6SLw28JDDo2ybXeYJgXNbtJ1ixwN2+i8lq21ZSVJInXOIKXme3SdUW7ahO6xhJngpZskI3Bmtq
	zN2T0P7sxhuTfRgM9r/7/kOt4FjFTDigzCIWU=
X-Received: by 2002:a05:6808:1987:b0:45e:e07d:85af with SMTP id 5614622812f47-46a5c58587fmr444520b6e.2.1774382427732;
        Tue, 24 Mar 2026 13:00:27 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7d4b19csm9896069b6e.5.2026.03.24.13.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 13:00:27 -0700 (PDT)
Message-ID: <f229ee71-4297-4fb8-995c-16e86be6e953@linuxfoundation.org>
Date: Tue, 24 Mar 2026 14:00:26 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] cpupower-frequency-info.1: trim trailing
 whitespace
To: Roberto Ricci <io@r-ricci.it>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260324013543.4776-1-io@r-ricci.it>
 <20260324013543.4776-4-io@r-ricci.it>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260324013543.4776-4-io@r-ricci.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/23/26 19:35, Roberto Ricci wrote:
> Remove useless spaces at the end of some lines in
> cpupower-frequency-info.1.
> 

Why are the spaces useless and what happens if you don't
remove them?

thanks,
-- Shuah
