Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A732322FDE6
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876357; cv=none; b=hOscLlQYsNudcl1PNl/kiHBJ/D49RzzzSDjR0tQqGREeaF5sOGzCLGif4P88x/qERbo3+ItBUDTQ9wrKKoX3Uu/6jlQdmrTFbHNaw/z2H491nxI9M3FSDlLgNc1JTQyn9C6K2txFtnaoEbyqvLguwfpwsPKtS+0J/I+ELa5qUkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876357; c=relaxed/simple;
	bh=p2hL1KmPuqgpzwu8jtruJ3j9pIGD/r7WuE+EXQfFu30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTPjc+ju3ziRGWiUSTdSDieiH5mJIRJhPlEtP0rfBb3oWVux1suYoiQBx569fJmGZ/0FkUhdxWCv2zJbS3ZmcbazX1dzJz+UlO4eS06QLDkje02wcWQ3pbvdl5r5gQdrre4dM4mbzTGf/CYA1nJccqalrSH3MvApEUfVsUFM/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SBZlitvg; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SBZlitvg"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4560d6f82edso143061fac.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785876351; x=1786481151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qaL6InyMRx3887cIgsi7UMEZhQ8AgbGemHIp8YVHGfg=;
        b=SBZlitvgwtD9n12tFzRH5M5X9iWOBomJ2g74ONM/CdCN11VTVggeNPNixMDM2Cc+pw
         iEagCasqNA+7S86VAc7xWMmcy032+aMOXkZAqE4vZAVXsF3yA+u9i2H2Ur6Cl5zGpl6E
         r3SmS0Yp9RP9Qu+9gGYoDgb0h7ih52g0XZasg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785876351; x=1786481151;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qaL6InyMRx3887cIgsi7UMEZhQ8AgbGemHIp8YVHGfg=;
        b=qjIBmABlHV+WRhq1XuIU5HmdwHTI+DyZr6z+ClPQz/mmcDI9Xkb1PazZsIqHCHL+Ba
         S71mqnGWShdOWGLigO6QPMeYq2S8BPDcD9w54p1p8+qcWq5DKcjC9kfoS99KCoXzP7gh
         lXS119J8I0qlhFa4vCK/hw8s4rlb/xiaw7AgH6LQ9EAHQ/NZ+iw8Ow7ivzQ5HaUQ+gU9
         sASM1t6bLx/6RMa3FS06CUAn0H9/ar9YB71NzrcqdksJNec0ohumWNHNEkTWTDXBCC+V
         +/SRBr0CtOFqvtTvR4CryDs3BPCNUa3IPbl1STSGx+2eMwJq74zLfc4vq1vvjn78flQg
         nAaw==
X-Gm-Message-State: AOJu0YzQ2CEpHdLanYlIrbZHp0+7+RnU8EDVIG0f5duUX7WEofjVeglp
	fr7dnBCZJBGnQnbA7p1Go5obnXgHZQMBDU5Ll94UUm3u+FXvq7XkaNANmfVcowubldI=
X-Gm-Gg: AR+sD10UDQ9lVn7mnajGlrN+sv+qW7rapsGqDiZfv5hGusXVCa/evg/jUjCPCS+P3v3
	jQDzcqdLK1c+96izTfrBFRFVeq2BTA2OUMSz1tbw++xSxhViTMUJy409Yft3tziJC9Qws83uziW
	aO/uXjo+73M0RaW3OVzOohIxbiVbM2jP6+plQIwKExlXw19LxViaJu10TU/ZIoV5Rh/4nz5XZcd
	V/lcvyXrQOEUPArEsNVslbv5bd1/bPxPHE2m5HjHOEDdlPA7S45tJJT0eMZZ4aTLAIBiebo3uXJ
	TDT8/64VgUsmTf+RqlNCo9iVTE8gcH3AHfQanzBUVXMlXemCO8FGfdAXzMq3iZqedTcQtn0DARi
	iYUjqZ0oQ0z3ZZOsm1+0w3iAPoOrtF+FF83bRrKXKcMuUI5a5whgFhRkT0dgfgK1XItBMmMGPe5
	ZJG18XPAM5LiVK47ooO6PdZzfV++7+sD5CZ4OmKiYBOGY2f8aMT8SLZqAd/N5cxa7+cONwpg==
X-Received: by 2002:a05:6820:1c89:b0:6ae:4ff6:8d99 with SMTP id 006d021491bc7-6ae96f658cemr1057525eaf.26.1785876350998;
        Tue, 04 Aug 2026 13:45:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae93d61482sm817337eaf.7.2026.08.04.13.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 13:45:50 -0700 (PDT)
Message-ID: <b503143a-4716-4af2-a754-9fcef9eced35@linuxfoundation.org>
Date: Tue, 4 Aug 2026 14:45:48 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] cpupower: fix topology array handling
To: Ali Ahmet Memis <ali@iusegentoo.com>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B . Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260803175215.117518-1-ali@iusegentoo.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260803175215.117518-1-ali@iusegentoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/3/26 11:52, Ali Ahmet Memis wrote:
> v1 did two things in one patch. Shuah asked for them to be split, so here
> they are as two.
> 
> Patch 1 is the uninitialized read: get_cpu_topology() allocates core_info
> with malloc(), several paths never write core_cpu_list, and the sort
> comparator then hands that buffer to strcmp(). calloc() fixes it.

I agree that core_cpu_list isn't initialized and that needs fixing.
It can be done with your first patch that replaces malloc() with
calloc().

This code path can be improved to initialize core_cpu_list.

Did you think about a scenario when the following check will
be tru - i.e core == -1 is trur?

if (cpu_top->core_info[cpu].core == -1) {
                         strncpy(cpu_top->core_info[cpu].core_cpu_list, "-1", CPULIST_BUFFER);
                         continue;
                 }

> 
> Patch 2 is separate and only about the physical core count. The counting
> loop seeds cores at 1 from entry 0 without checking whether that entry has
> usable topology data, so an incomplete entry can be counted as a core.
> Patch 2 depends on patch 1, since it uses an empty core_cpu_list to
> recognise an entry that was never filled in.

Can you elaborate on a real scenario where this could happen after
replacing malloc() with calloc() and making sure core_cpu_list is
initialized to "-1" like in the above conditional?

thanks,
-- Shuah
