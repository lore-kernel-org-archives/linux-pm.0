Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03DB3D3CE4
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784589818; cv=none; b=fSgZcDSme7/Lk8Ljv10deqLYhXGM3t+gKONcZ61i9PDPTS3dHl/7co54Bfz10Lj2P5RA4uWgEB5ET/MA2+J2Mqq6WssfKL+3pQUFQ7AU5BEZIZivwv2IJAd1B1Ui1AjW6w4PzxwbpCSPRRMvEoxlhY+pFRCXCQniuqXQ9AhMAhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784589818; c=relaxed/simple;
	bh=Y8ucYllA00NDACNtxf0vRCQlG+1ca/Dbv+etrzE2Mlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8OmzVab5yL7hKXJFZL0MGtUEcgXFUgO4kVRt0G2RMIY3zyK2Aw/Sz72wYWEeFh0HRAENdHgIwpx8zip6I2Ey/fvGcJzukSo2tR+Nmov616CynyiZUi8CdXNDAXbXperDOXd6s7Lj9uvByjEFXScevf8RYrP13qRyoxbbR188Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GVQaCSTJ; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GVQaCSTJ"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7eb29ed2bbdso3304954a34.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 16:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784589815; x=1785194615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nExiJSGJrJwr240zadQOA9A64h1dG0UL77xGOKdc2S4=;
        b=GVQaCSTJCTTFR8fhk/8Xyl43D2EgvQAUGUmxfjDOuX9u91/tFQc0Ud10/hUsk5OFQy
         SnZ2G6GTzfKoNABv03R9tzREx9E5wMyy9zju2paGxP+tKmcD7sBwSdWrf5A+4AuncMX9
         W5WqmEtK5hpFwEFb9nZB++QIMdPA92CQe87dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784589815; x=1785194615;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nExiJSGJrJwr240zadQOA9A64h1dG0UL77xGOKdc2S4=;
        b=lzDT02BgbDZW03n0V6wh62MJYJklogCF6Lc47okdguD2exTc4yX3GnxDXC+M72iHhT
         ky5tw0RKP1cg+Bec9i6PtdmophVqFlClhbegNTw/z1U4gzxe2Iv+2HeS8Zv3ht85pMdz
         ucXd6Dso4315apQaDxDAil6n5r+8Zo0amJ9AfKLaWJwfKMJU4KSIwidC1zxHkIQatrO7
         NfBMJm6JumCWUc1pvcRl7bS1TUO1V3wW6OB8s8USC+OW/fytaGDrGL+SuT1ULsK5ERtg
         w76zOhqGhc5KuFPWs5YbLfrKsFEGeK0tjyY0bLvnUnN4FxHRwZ51SwQudw84O6fhbAyB
         lB5Q==
X-Forwarded-Encrypted: i=1; AHgh+RqWR0dW3KjVIcK5FCsjOE0y788fMNHyG8PxZ98cNkrqiF4HiakAcgc4MKpJrEeiHzrhU7KXO2lDHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKKP0IZ7UFK2reJf3hh86NT6q48yNBE7e8HjEg8OtpJzrr8X3f
	2xqSnn+ehBe5fQ7ikA7y61/ptjU3FHQpzPeIa5mNcYpgvEjqRKE40s0EAYcGDFmehT0=
X-Gm-Gg: AfdE7ckHpKsI3F7AjIYwINyUH1m84WRDVMXMdmjqO5zZM51ZY8WeRrQJVVfi+/zNpHo
	r5wxVrmQFE3gEJOSGa8LxpaLqwlnMPhlmHnkaRcVjId3ZIEQehs3La5g0ri+TYZxzTVni848Hvo
	KmxP1+KFS7lp8fchBjS20bgwRpul5jsU1BQWmT8fSA7aTZDNy3VdljL9f0u6F6IgBSUFAfpoua7
	+VxUCJd5A2Sk9Z8mQEKqIYdZMQwsN7OTTK8Ks7deHqiIsJG54asD+vg273/7FBAf9hLc48Zh/LZ
	HH7ayrMWnEFkdOKOZBzpIIPRKe5j6a4sm1740XA/4RR76qTOAlrg79pWD/cBy39FhYItquxylQD
	/A6L/Fh3B3v6r14M3d3XGQuhls9rPtaA0TX0DfvwJMdzLKT1ue/TANAsgPsAGU9M+HQxsLEpk7A
	9MlpDkzHnROJI=
X-Received: by 2002:a05:6830:4517:b0:7ed:ceed:95b9 with SMTP id 46e09a7af769-7edceedb831mr5088468a34.32.1784589815440;
        Mon, 20 Jul 2026 16:23:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edaf9d5b4fsm9145613a34.24.2026.07.20.16.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 16:23:34 -0700 (PDT)
Message-ID: <3be08875-83c9-48af-a86f-58e9e8ab7ff6@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:23:31 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cpupower: Add generic CPPC performance display
To: Jeremy Linton <jeremy.linton@arm.com>,
 Thorsten Leemhuis <linux@leemhuis.info>, linux-pm@vger.kernel.org
Cc: trenn@suse.com, shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com,
 kaushlendra.kumar@intel.com, sashal@kernel.org, fj5851bi@fujitsu.com,
 rui.zhang@intel.com, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260709221344.1919794-1-jeremy.linton@arm.com>
 <20260709221344.1919794-2-jeremy.linton@arm.com>
 <b87c77da-d207-4b9d-a36a-5cdfd03eacde@leemhuis.info>
 <611fb9db-6263-4e53-a2cf-9ec35ae8ef17@arm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <611fb9db-6263-4e53-a2cf-9ec35ae8ef17@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/20/26 12:33, Jeremy Linton wrote:
> Hi,
> 
> On 7/18/26 1:12 AM, Thorsten Leemhuis wrote:
>> On 7/10/26 00:13, Jeremy Linton wrote:
>>> Arm64 machines, and possibly others, use the standard ACPI defined CPPC
>>> infrastructure. cpupower has CPPC support, but it's largely written
>>> around the intricacies of AMD processors, using platform MSRs to avoid
>>> shortcomings in the specification.
> 
> Patch to fix it.
> 
> https://lkml.org/lkml/2026/7/20/2191
> 

Thank you both. Applied the fix to

https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah
