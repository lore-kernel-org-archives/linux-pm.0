Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE52184
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773276002; cv=none; b=gy52TNnueU+ZMEMXdStDNbKY41CWtEWFKgh2RHJykTMj8BCHFPoqeUFaPQ7LiVX68JU2oSVq2Outx8hTnRIwxkNbY4b0nLq3PBgI1OlTwaH4ecH4HYwL1F1txoDAj9Ca23tb3z+FAZrKvDHZFwD7rLgHOHgRTKsk/CSSDs0k7B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773276002; c=relaxed/simple;
	bh=2OsQQyjEg8oHxbd3fkYOx6qDa+QX17E7YUL5n7sIO0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0xg21JRg3BPB74v09HGHKJfBeFigRJF0xb8dpTJI2FfHa/mLZKYCLZcpf1TJKD3qZp/RNlDAW/KHRwjo3bz6vZea+WaHgzKs7Hp2wHaWjHH3DQ8zYijaOORPp0R6NK5OOeOPpdX2u9RhWLU3tToV14Hrfu8V9HWOp0NhPJeS/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y5DtYMDy; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y5DtYMDy"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4670bcc40d7so217122b6e.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 17:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773275999; x=1773880799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uaieczpVKcUk7SmgMzAA6ayZuqjqSdWTOwuR2SaeV54=;
        b=Y5DtYMDyyvVRtdmH9H+5ao7Pis4STSWh3e1uq7XP6fOVPXvRzyiaAOlewX6r6ZHrXj
         dGCa7r/r+7oExBfv+mXaqxiJkOHovud+IaYbvGB4wC7r4BefEPd6yDi3s2QQrpgh4RKI
         798ImE6z6FS+4md9v53KZ9F+M9pghG+OFSzZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773275999; x=1773880799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uaieczpVKcUk7SmgMzAA6ayZuqjqSdWTOwuR2SaeV54=;
        b=O0skcaGqRsLh+5MJZpfSIpHQVH/jrArM6S0+XRBTbOCUbnrYGuZI7GMpRvcm9iJlhc
         j+VK5TGuS2Aw/tE6mb2vGPuhFMOTFSR47MuMEnpJE3qxRJzS/u5f4Ve5b3kQ29yi2QdP
         UWsVqkaCAAq/domhei1hd1Iqwm1jSiJGwlda9riyOCPKn4X9Lx5HUOS+UOFHMd4rNVLX
         3RQopBalsBbCm7gvOI/F7iiJOaBX0SFLWjPYWgw6tJzAsdDGrx4iZzsBM67Od6kG/g9C
         DTRBiqzn8LRVWIwpGr8U/SFHp+kerwfDjZFCb/K6kusj0h/Ehsg6ehOplLii5YET01AR
         bwhg==
X-Forwarded-Encrypted: i=1; AJvYcCVR89pA0zh2iBMkf6wLXRxi86CyrSzjXn+WqdnHtEvyOEFctf+S6+XKttjr+pXciPY/zDbiLBY8+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvRQQ/YB7L2c405Av7d1Qmk/qlVZRbCTLtv4kHcuX0tuqwuuqT
	dPWkpejfdBaucTEQPIC70G+48ei7V7Khz2/NVmy96Kv+3a0Aujivh2s83YJ09hztRtI=
X-Gm-Gg: ATEYQzxUYhM/cF29FsatuulCLbKMtXmdOvLOO/lOXVxylMjkewzRL2NblAzRS06EVnW
	PXZ5HQxzkSEyl68IDArmWiOdX1P1u8dnm0JgKgnIgNdE3eWMC03cFF8Id1Bfm0QQDKDkfk334Uv
	2ruhG5HfxTgatFGw+RGYSGhH28QSiU2VvnSoRjQuZ3xwfoLsxQ/mU4avMpnZkAT5DSTmkf/Qvga
	vF8/We7vbIzdHF04Zs/S7Xp2cYrKiblGPz3FhpBI/iN9b4jf/lfdIP4b+S5ejwZa0cv0RNnAiKg
	K+2r1jcyGY0neQliVApbtO9pigIT6sYtggtYzZr9G5R2tZmsjzJEZatkkwG1Kvd3QAaLVm2z/K7
	qZid41CL3r14tKAZYjxknjsYama1KmcYvZuB2yI0g0gV3AwAygFdWcAO1/JvYIPYgxL4XX6c0ze
	GXhJl/YZQ8GwFIbK0AdPyo8CYiYsb/42FJ6TooEoK/Fj0WgA==
X-Received: by 2002:a05:6808:15a2:b0:466:fd2c:9570 with SMTP id 5614622812f47-46733433d09mr2479774b6e.18.1773275999021;
        Wed, 11 Mar 2026 17:39:59 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6c7885sm3405525fac.17.2026.03.11.17.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 17:39:58 -0700 (PDT)
Message-ID: <1471739b-6809-42eb-9aaf-b0700315c5a1@linuxfoundation.org>
Date: Wed, 11 Mar 2026 18:39:57 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] cpupower-idle-info.1: fix short option names
To: Roberto Ricci <io@r-ricci.it>
Cc: Thomas Renninger <trenn@suse.com>, "John B. Wyatt IV"
 <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <abHAZj9xwfDf5JVZ@desktop0a>
 <2d96ad0e-4341-4085-b2ed-1ef23e7b8949@linuxfoundation.org>
 <abH7pF9p8KxAsHIE@desktop0a>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <abH7pF9p8KxAsHIE@desktop0a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/26 17:32, Roberto Ricci wrote:
> The cpupower-idle-info(1) man page describes '-f' as the short form of
> the '--silent' option and '-e' as the short form of the '--proc' option.
> But they are not correct:
> 
> $ cpupower idle-info -f
> idle-info: invalid option -- 'f'
> invalid or unknown argument
> $ cpupower idle-info -e
> idle-info: invalid option -- 'e'
> invalid or unknown argument
> 
> The short form of '--silent' is actually '-s' and the short form of
> '--proc' is actually 'o':
> 
> cpuidle-info.c:
> 	{"silent", no_argument, NULL, 's'},
> 	{"proc", no_argument, NULL, 'o'},
> 
> Fixes e7d85a934182d5bde1eea865169fbf2e0637a3ed ("cpupower: Add cpupower-idle-info manpage")
> 
> Signed-off-by: Roberto Ricci <io@r-ricci.it>

It is odd that your patch v2s are showing up as responses.
Please send a proper patch so I can review - same comment
on the other 3 patches.

thanks,
-- Shuah
