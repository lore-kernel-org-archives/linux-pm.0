Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4003E3DD53C
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510644; cv=none; b=eqADgxrS6hK2J6cjI1XhYFdq6At3OqAoanq7Gc1yMm6kfP3uN1h6fjHBiYkpgrI9kAIWysuoAbEGC57najIY5XNaLr7boNo2aMaOavJB1Dvn1xC5GoiLJgAZHMB35+U7EnuOv/ZRBvXVsWwQfldDmACIgk5rI5JmKxTyOaDWeIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510644; c=relaxed/simple;
	bh=mR4+Ie2bbuKPIew7pLbo5Lq0aWKZQl1rt3zOr2eMg8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJq5otQBsMXchDRdKE3AXsCC7rVF9jiotos/qpQrDAY+8yge9t0BaI+29UShMxRFKD0wGg3LZ6gZFoIKvttWmgDecaLamYrZ7k6njhMMWJt4nlIA8db7eJrGykW41/9wEgSzMHKe/Jb6LwrZx+Ivouz0DZQdFf0TcrwXHNRlJmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vw8rNWZe; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vw8rNWZe"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-43b78b54dbdso8117447fac.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780510642; x=1781115442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l5Er5Wpg+r3gMIOrk4BdcNKYR+hF85apkXNRWWoLPtI=;
        b=Vw8rNWZeMZYzEezuM4ch0Wyn7fdrxwa9unlZ0fFkcUx0WMep65ITYKSKEQXvslsJA8
         MLMRCAyJ6AM8aT2EcqpcUPMczAO2aI+R0/GKTxqAE+tPg5uKJidEb69Mug81BIVtNceO
         5cFSFQavV29Qw6Sura1XSBK+tfQIja+jfh8Bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780510642; x=1781115442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5Er5Wpg+r3gMIOrk4BdcNKYR+hF85apkXNRWWoLPtI=;
        b=O57rX3Va9qBFAOSukn3Rj3H2ivApOW/T3yzNyT6ZpJadaKyqr8Rr6G6lyhGzUrm/wB
         6f0CxdYCjtv2+1uLQwshOxC+EWdv2TtyZcwCGELUpX2D3NpaMu1en/YU4P3ixATAI5eU
         Cyljm5vcCjkkCNKB3aJRh7pJpz+vpAUMUhNgnXPAj0VDfjK/NwVMjh0fu6fqinN/Btjg
         batDfYIFQ3aQFPcQoXN0ZaYAkq58vGl4FvfhetME5haLVzlIe4bU3YMqqcVFLD9R7qs6
         maYpYchYeKC5oIyis7XRli6keoAygjGUgCmfacSCqagATA7P/Ayz4a8TExX5FVtzHC2A
         +q4A==
X-Forwarded-Encrypted: i=1; AFNElJ/D7nIpBveHPCHOd+0WrZPHY16SutDS0sj5qOchsvuJvi4Qrun1vKPSR3E5qkPzzBdSzm3Cq/afGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYQCwzlI2ud74LgriSuOCKeg6UdloZ/C3Nj2Z2FMkzxyXnUYNL
	9cavxzFg06298LpGG7QvyRLp64di+T6fCRwWSZwBYviDgN6J8Jey2Y5UTW+paTEFOgQ=
X-Gm-Gg: Acq92OH71+wDoUxo0IDo/T44uZhYK2hJH6nR5bNsCEUtOOCUJO84OLDMHWZcY2pYWxf
	mBj2leiPwfwZsFkgb5qysuIP8Wh4GhQNwIJ91ySAofKXS5M2qCqnw74B5C7jVrrrdojNdlaT6Mn
	DBQLcgUI6JMrI7S/F0El9nuHP1yP5Dj8gbyaLYjc9h6rmy+K4HEt8qxD8OXpQ+WDP58u6JTh8Iw
	SxF7ibnBaAc0b0tKOOwxKuGiB9FAyDhMaMdS4pHEncKVpgjMFH2Ad8UV7ICOCM55ywXg8sz1jgI
	VTK1/cDb3VoKKJY1nCMX1m4gKXvPm5ZO9mM5jjY2YNVB6CML/pKhMcpCfL3oBS07Bl8jYK38XTn
	1J1kxaBKEaOvhYx4gOV3jaXHXUOT+WJE4zQ+JuIN+nAb8EpzTE1T2tDmlIBJ+Bw1fARa3Ge6E/d
	Yu+hBvp3RVIU51f9upXx5aicCVs6M7jKVT5XTF2gpxZw==
X-Received: by 2002:a05:6870:a447:b0:417:ab68:fbaf with SMTP id 586e51a60fabf-440db9db66emr2976318fac.20.1780510641909;
        Wed, 03 Jun 2026 11:17:21 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8500f0esm2778781fac.18.2026.06.03.11.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 11:17:21 -0700 (PDT)
Message-ID: <9e4994be-008d-4c0b-9bb0-1ff782ad00f5@linuxfoundation.org>
Date: Wed, 3 Jun 2026 12:17:19 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cpupower: Implement powercap enabled setters
To: =?UTF-8?Q?Mateusz_Ja=C5=9Bkiewicz?= <jaskiewiczteo@gmail.com>,
 Shuah Khan <shuah@kernel.org>
Cc: Thomas Renninger <trenn@suse.com>, "John B. Wyatt IV"
 <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <5ff19049-a83a-4ef9-9cae-b97438fb3e77@linuxfoundation.org>
 <20260528153248.4114324-1-jaskiewiczteo@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260528153248.4114324-1-jaskiewiczteo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/28/26 09:32, Mateusz Jaśkiewicz wrote:
> powercap_set_enabled() and powercap_zone_set_enabled() are part of the
> public libcpupower API, but both currently return success without
> updating sysfs.

You are right that cpupower set_enable API simply returns success.

Does intel-rapl:0 implement store function on your system?
It doesn't on mine.

cd /sys/devices/virtual/powercap/intel-rapl/intel-rapl:0
echo 1 > enabled
bash: echo: write error: Function not implemented

> 
> Write the requested value to the matching enabled attribute so callers
> can actually enable or disable the powercap control type or zone, and
> report write failures back to the caller.
> 

The patch loos good. Is there an existing use-case for this?

thanks,
-- Shuah
