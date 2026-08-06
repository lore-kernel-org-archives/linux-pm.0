Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E00247ECDD
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031414; cv=none; b=SrI04t8KPi3NfQRIPCRmmzSA1xSHE0DeGnZUf0bWHKHChrVtMXypuLt7oXSlR321H02Gh88+jkJYd50B0es07dzwmiPTn/AsuoIORGpzpzmX/PVdgVrlIL6QBlk7HhiGTxQxK5MoUg9RHfwpOUUBCzSB7P+dYogga09MH6Wdadc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031414; c=relaxed/simple;
	bh=ZXflIJh6gXo/o6+vJH//R495vESydSLexbO1Blx5Dcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVRi7bkoPI6lXsURmuD2twEK5Am7XdGXqdNbWoMu0eOIaQ7LvHRkIpG0FWRbCqGos2tFb/9N30TxjHKUGtDHpH2TfO5tofnyGqXwrY2/KexBS8RkorYIdTDolL7w++Bvo7BMjgBcr7R3P0ZEbhpJak/Q2t82kskunJdbPoF/FfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ac8vE4Nn; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ac8vE4Nn"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1f5208b38dso425994066b.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 08:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786031409; x=1786636209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=asCFiYJveau6ClMWqMUirF9GQ1J++sD+ZiiBvAODmD0=;
        b=ac8vE4NnA0/DIeo408i1/AoUGZtdCglYQ6GZ/O2hu7l5fGxoh63IxsBbKC2dxmp61q
         TTsh3f6VyerC4NK1KrUqL2sRvLir5mX6Vn/aO9X3aUmodLGraWztOVgVhUkTfwZKw940
         V5qsrF2Zc+TKwvxN4apADpNZr9zn03nE8ow9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786031409; x=1786636209;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=asCFiYJveau6ClMWqMUirF9GQ1J++sD+ZiiBvAODmD0=;
        b=pon1+Tngf4UPcp2Ac53mui5v45vzWFE9gJquW9Jq/mWwTRWQI9oMvdnZ3pTQ+nnTT5
         45eDNa1f870tX0lW4pfULeWw5mHGdadeyJVdK7qe/59LLZJEGlhdf7zGTiw6gFCc23di
         skYpZ4dRnGRAHBI836c6x4ECBxcKoAxLhAgYDmsSNyM9j5LB7+8fpa6Ia8RR3+pxfs2Z
         AYfbhxUko4LGpAyOZKwoFbhpe4ZBzZiOkQ8FaWH9GiVUzL1ABxOdC7iSBrQKp2RUOpqP
         NzHSwAdhAUHdfDesgDke0Ekueyu5/8xxUlVtNMzfUFdRSnjVhMIfEWItxauTipaqQgyW
         iHrA==
X-Gm-Message-State: AOJu0YxqzkS9/zW8RtvK5tHFTIMsWCgtxUhsHyiKgdj6YEBRGhfRk2WG
	jMFzEqEURO54TcFbaFsUoseN6V3VQpE0fJ5o4hKMc2vma63+ujurlXdqU7J4AnDhXL0=
X-Gm-Gg: AR+sD125m+BYugjMmVpF9ntFKUpVOkqwd2Tcblrliy9ibML8jgHUuBFGrgbBiXL+ZiH
	+tiRZF61H1xFaXUMpKpVvhMmWaFqEig7IwlC/anmVNzFI42e3+3BgTZMqt0y0RCW5mL2LximKba
	sM2w1KW9ihEBLzMe419CFJQvPyVhc+ynPCQpaEIAUplMEGyy4+mYKPWLxgRS21YEsk5V7NT764b
	xd/Pmv7+/X6io528Zp2cb+24N80MfjiJWOU4zT7R88DXn6H0D08v+0nC464HK9Kp2Zzvgfigpzl
	5ZR3pzHoGGuD5kcSdxbprgbLAtFbnA7QogkgTOthY2BpwxuTp5ZG128abmmc2sJmgIYIpuUO/tQ
	8l94faYiqTE0+XYPmW35KFXfXBlkmIsb2xtCOSUXzcRbUmVTDbfIkDrlWAaV/e2U/foHuO0atNn
	dT8ZfkeOFZ4wxSWNmMCpbTXgJytVbcZALBBmXCBaLDw6RmSyAZsULTqR5tgCXxN+FbUZ0+5Q==
X-Received: by 2002:a17:906:fe4b:b0:c16:6c84:4b8e with SMTP id a640c23a62f3a-c2039cc42bamr762859666b.14.1786031409153;
        Thu, 06 Aug 2026 08:50:09 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c203624e6c8sm270451566b.15.2026.08.06.08.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 08:50:08 -0700 (PDT)
Message-ID: <22e2acc9-b822-4119-802a-74efc6df1509@linuxfoundation.org>
Date: Thu, 6 Aug 2026 09:50:03 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] cpupower: fix topology array handling
To: Ali Ahmet Memis <ali@iusegentoo.com>, Shuah Khan <shuah@kernel.org>,
 Thomas Renninger <trenn@suse.com>, "John B . Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260803175215.117518-1-ali@iusegentoo.com>
 <b503143a-4716-4af2-a754-9fcef9eced35@linuxfoundation.org>
 <20260805114305.97160-1-ali@iusegentoo.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260805114305.97160-1-ali@iusegentoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/26 05:43, Ali Ahmet Memis wrote:
> On Tue, 4 Aug 2026 14:45:48 -0600 Shuah Khan wrote:
>> Did you think about a scenario when the following check will be tru - i.e
>> core == -1 is trur?
> 
> I went looking for one and could not find it, so that branch may well be
> dead. What I checked:

That is really the questions - the branch isn't dead, it is in the wrong
place.

Sounds like you don't have a real scenario to test this change. This why
I am not eager to take either of these patches.

However, did you consider simplifying the logic in these conditionals?


if(sysfs_topology_read_file(
                         cpu,
                         "physical_package_id",
                         &(cpu_top->core_info[cpu].pkg)) < 0) {
                         cpu_top->core_info[cpu].pkg = -1;
                         cpu_top->core_info[cpu].core = -1;
                         continue;

-- Is this continue necessary here?

                 }
                 if(sysfs_topology_read_file(
                         cpu,
                         "core_id",
                         &(cpu_top->core_info[cpu].core)) < 0) {
                         cpu_top->core_info[cpu].pkg = -1;
                         cpu_top->core_info[cpu].core = -1;
                         continue;

-- Is this continue necessary here?

                 }

I think the following logic makes sense without the continue(s)

                 if (cpu_top->core_info[cpu].core == -1) {
                         strncpy(cpu_top->core_info[cpu].core_cpu_list, "-1", CPULIST_BUFFER);
                         continue;
                 }

thanks,
-- Shuah
