Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369DA2DECCB
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290861; cv=none; b=gpG52/Wlir0ySHhCwVELnH3kLEhAWTXKnPF6Wi14TIbBD+BJh4Yn6LHZAfRvgwwqYDPzjxMnb8s4FDYjNC9OvtkMyiZRnfylbr5S66QgZT7M9rSpdEAWFWBVoK3j+ZqCt429nyj/vTWNCTE+qHBn07Uo4v9P540iwnHF4xaNIso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290861; c=relaxed/simple;
	bh=yBcM7aZKODFxjT19UJ4EsfNOvYHO2x+rJA013Wih3Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rx+Y89LY/Ae1sFox71f2t0LH3dUVo97KmpIRqfZ7DDZGWJzoadciu703zBxhCaEr6kYgAQeyKPShEfRjaMnDrI6WYVtLxAwTP8bKOzLuqQNIUl363IUTmaaXf4V8vJpNKqJaqq25YvoR+/QN3X5qMfY8yUiibMwu9piO879eikE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d1z7Fjm9; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d1z7Fjm9"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d7eb85fb81so526179a34.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 11:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774290859; x=1774895659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tqCu7kEz9zwd2qtF1CAW/9ScR/xjHRltJKvoLIUB0yE=;
        b=d1z7Fjm9qphMDNDoEgijehrvA3UEsk1FB0XTX9Dsq06cnvC+9FE1XTJcfJIuQd9Ksu
         BDpVmebbFTZZGh3YWLZqYh5K0E8jWL/xc2idgs/Wg9sN+UZaQQ831BxyivCzBy14QdTr
         fJ2eP/JSXyBVDlwh7kmpScoSQtdmEHIK6VGLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290859; x=1774895659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqCu7kEz9zwd2qtF1CAW/9ScR/xjHRltJKvoLIUB0yE=;
        b=R9IpqjJGvnvSi6dP92lRqLoOTonV2dvL3OKxw1rPVOI+xsSlLaOhJWaMHDoYWJaMZl
         NPZNnCARMIKB6teaN9CG+E52pNSxvrV+HKR4m2Hkd5yMTSQ3iOcWgHGZ72U3T16hRo+w
         W5IRx0ajPDUE3u2VITencV52FSE3xfl3ETqvoeKidZHGxEROJhc3kUTcy5HZBi7sq/hc
         4LVuNsgRLDyamlE+g8SnmgwIRMIrXLCZD6jG9Nlwth6gomB4uKiLrcLUkXHtStPKitrx
         vyFHKHt9CKnGjSPhfF+kBdoMb+f7ypVqwBU+q+tAchLtz+xqeSY6RnWyZRPXrMtmJm1d
         PBKw==
X-Forwarded-Encrypted: i=1; AJvYcCUz1JV59SG8W7A/pGLT3tNJNp7PpclixCnS2ohFAj9HNQXKLtrR/uv4JW2kuENH0N3NGYc1eCJU7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj4b060KjClUCOi2cFHhrg6o0zhCHXnHetmavhm2IeJQoygTuV
	7AJJTW2booS3ut3aX+aB9JXGumdaGEqkdFAfyvv5Cy6i+us/oq31eUl4AHgYLxaj5SM=
X-Gm-Gg: ATEYQzxhJ2URW1tLUCVUtPBXZLozo0unqFJAbqG62VJCehbXRWQP0b47Mq4gEYS6+Ug
	wtR1M+A75apRjliV5nxAnwtIXvEi6fp3Ry8CJijrOJMWV+aZE0oHpylEj0hK7vdS1d40SdqmvOR
	GC+OcaRsEI5+crMGj7ujJBl4XNgnTUWvuBZFzFH0456+GKo2AeTjHPEoyTOntmWlYt/fP2o6CUl
	wpbXGNUQGH+8zDJTGIVkVuAH4EfxNwhOHZR+hNKP7lG2gkNFpxsalAsnxQc4wGZRfeMSxQ2ppWZ
	0ErkTQV3qlq9puBKXKwwR2vAB8GlQLvxYz291OapFjEV/pDshBbuuEQ97t3eqmDVjqtBmE5i6Zx
	trr4T+ol0t/NB1/PppBXuqT96O8LzXVUEPQHaaxfd5fTG+LSTEclREYMGw1XJOraCyJs11OrEvY
	LS14TMEiPipSBMRKtERF3njjMGt/X4cz9IwFI=
X-Received: by 2002:a05:6830:448f:b0:7d7:d50d:b088 with SMTP id 46e09a7af769-7d7eafd8a80mr8670001a34.28.1774290859184;
        Mon, 23 Mar 2026 11:34:19 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eae6a554sm9732266a34.27.2026.03.23.11.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 11:34:18 -0700 (PDT)
Message-ID: <2ca2810a-b9f5-40a1-a85a-04e4cd06e1d6@linuxfoundation.org>
Date: Mon, 23 Mar 2026 12:34:17 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] cpupower-frequency-info.1: document --boost and
 --epp options
To: Roberto Ricci <io@r-ricci.it>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260312102029.14980-1-io@r-ricci.it>
 <20260312102029.14980-3-io@r-ricci.it>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260312102029.14980-3-io@r-ricci.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/26 04:20, Roberto Ricci wrote:
> `cpupower frequency-info` supports the '--boost' option since the
> program was first added with commit
> 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
> but the man page lacks it.
> 
> '--epp' has been added with commit
> 5f567afc283f ("cpupower: Add support for showing energy performance preference")
> but it has never been added to the man page.
> 
> cpufreq-info.c:
> 	{"boost",	 no_argument,		 NULL,	 'b'},
> 	...
> 	{"epp",		 no_argument,		 NULL,	 'z'},
> 
> Fixes 7fe2f6399a84760a9af8896ac152728250f82adb ("cpupowerutils - cpufrequtils extended with quite some features")
> Fixes 5f567afc283fc9e7c6a34d013c4fc6c5e8d6afae ("cpupower: Add support for showing energy performance preference")
> 

Remove Fixes tag from all these 4 patches and run checkpatch
before sending patches to me adding version information.

+ add a cover letter is helpful and makes it easier to comment
on things common across all patches such as these.

thanks,
-- Shuah
