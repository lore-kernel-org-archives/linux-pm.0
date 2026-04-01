Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6BD47CC87
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069600; cv=none; b=lcK959siaKJ4ReZvdMHJcvgtpPDHuLHNc+Mi9g+G+JOWJbzLC118/DoC1/mo1uIB3X7zseH6a87UjEZLWcZw/G/IUdU5ZUSs+oQBFMhAzx4HAa7JSIDPf1z01zeIVrQGYet7X7UDvxRPO7olfHZdXt+Ga7cue280mhfWypTVHtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069600; c=relaxed/simple;
	bh=kC5OouIe8JLFNvSAHb0QM0kS2o0uDCv9ZT+G6Yh3kCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+zAL29KjkSBjBQvCmGS4sP6BYWYwvpRD13/obHte8gY272rs6CoryvNdt55np2jK5WYNxJwKhgEfj/sSn2hMe+QVojYAuNnO/yizPokYirddhLDvL2NB4Lvxb/tGIohD1sdReEb75ge72xap2txFhm7/JVpM/mvoJ/IPLXaziU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g/fYh67q; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g/fYh67q"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40ea611d1a4so38970fac.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 11:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775069598; x=1775674398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ermOPMI7gPtP86hr7nxX3Quhh4GuerIQcTNRh/kJzK4=;
        b=g/fYh67qgUOPJJ+Mmsu444eNr4mefTrXZW+3th1+SzmvjCIutWMK252jUCKR/gbKSZ
         1PiVOX5DMfnnDPIUP8NUoLIQkTg9lkOjidowN+Kk9CCeZCHTS4sAAOEfntCuIIz9d92X
         fo+P/p067aQr/8Lj2OH4D4kKXUmNcDxBaxLq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775069598; x=1775674398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ermOPMI7gPtP86hr7nxX3Quhh4GuerIQcTNRh/kJzK4=;
        b=c5erlRx3+21LMmsbfIQrSFtHbvsJF8v+xGttRFs/Shtyo2tSxGHpo4nFEhgSKTgh3H
         j2WvGWa4GYFcU5EetY3e/iYKwd6cChYy0KfJnLZyHJFA9kTsjq+HRt4TaiMWHn76kVel
         KNL17sstSlOUlH5EpE4qb1SnjwSiZXKWlpVdORhTKGOSk8VnZmYJn3mM/n7pjSBFXgom
         bZNkyGscuka6OEYImtX2qzQvfV6Q7sX+8FJSwQCCgPKOb3SYOzcNpX7TXZ83yfOHvonw
         DFtHDXFYGM6ZMch0AG9R4V0oh39yRlJ/jV9E3VCHP5xiZTCzkU9Iy9+mVUSdCjTamHRU
         A2rg==
X-Gm-Message-State: AOJu0YyrGyba/xY5wnOfiIIp5U8vUcjHDtQtYjEdsvKilg7d/VQTYPqA
	XDn+TwOmaCvsd3mrtqea3MzrI9ikRrhZdv/iQkqC9VlGd1BbaDov6fk3r+KMB3wi9i0=
X-Gm-Gg: ATEYQzzUybHjHuYbrcyun6G32yoCOAYl4ErpFMaSVW1dvQT1sMsudbMnGl2cOF9UFed
	6zHuW/vq/XA9xjvjbhIjzcrbypbWaX4ADiArwq+ZP6TS27oxmfpBR/z0ImUFDoyMSfuuyDBORIr
	pd902mYtXEa2nLlhwuOn4xV73EpyBFmZ9xUqAIXVZDNxoeUANbfFQYDT0WNkbu8P5RCSpyO/SDz
	iADc0kQsRHTT3hKuM9EFthqhgLKnxXoO6Gx47e/GBRBsrQ7d5nVKiXFxv2U15kndZqSHZcof9rs
	/yXw9JKcT1DZP2Hs2OkfcyIlMcvFosgmgt6ut7tdRa3Toa2qD2n0QXbE4WfUHx2ZXGu5JjRV1nV
	e4Ls9O0nv7Nn3AAC/fylK8azg24fdJCYDD0nBdhyyvwLIfu1FE5njlLi68xsB7vIsNjd0LxMGra
	2VskD0yTL9U8GvXwo5krG42HvW1GZrl6USWBA=
X-Received: by 2002:a05:6870:1b87:b0:404:3ecf:9ae5 with SMTP id 586e51a60fabf-422cfedaeeemr2881535fac.40.1775069598284;
        Wed, 01 Apr 2026 11:53:18 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eab0ef68sm478476fac.0.2026.04.01.11.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 11:53:17 -0700 (PDT)
Message-ID: <f0bcad85-81e9-451d-8267-729b60531590@linuxfoundation.org>
Date: Wed, 1 Apr 2026 12:53:16 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: remove extern declarations in cmd_set()
To: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>,
 "shuah@kernel.org" <shuah@kernel.org>, "jwyatt@redhat.com"
 <jwyatt@redhat.com>, "jkacur@redhat.com" <jkacur@redhat.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260331045906.1935188-1-kaushlendra.kumar@intel.com>
 <3c2101df-c3a8-4761-80d1-ca7b7c6aaac6@linuxfoundation.org>
 <LV3PR11MB87682C0658A16EC72B47FB72F550A@LV3PR11MB8768.namprd11.prod.outlook.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <LV3PR11MB87682C0658A16EC72B47FB72F550A@LV3PR11MB8768.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/31/26 20:49, Kumar, Kaushlendra wrote:
> On 4/1/26 XX:XX, Shuah Khan wrote:
>> Okay - are there errors from compilers or static checkers? How did you find the problem?
> 
> No errors from compilers or static checkers. We found this while doing
> local code modifications to the file. During the review of the changes,
> we noticed the redundant extern declarations and cleaned them up as part
> of good housekeeping.

There are a few other places in cpupower that can be fixed. Send
me a patch that removes just the extern declarations without the
parse_int_range() stuff

extern char *optarg;
extern int optind, opterr, optopt;

thanks,
-- Shuah
