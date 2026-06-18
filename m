Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306752DC357
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796234; cv=none; b=BYx3oittY/o4YUBee+45I0qinrMCnEU3bSxAaqMnDk8uYCYsGTuk0TfPbDDPsygUrgRiCC4R40Muqq+KChVhq0JXWicraoa7FRzQ+kwfZ6MC9UOHFzVD4h9sZ5qZWa6LMsZGaXmdGSQ00dMcaEWQSYfPJ+9YI43aNUI+2irCO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796234; c=relaxed/simple;
	bh=mfo2nNVlU3eqMt+gVfQt4jB8xwDnCElPo6ZYaSV7Ar8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ny0ioqjWR2iYERjFumoy3nNJguBiN03GgDbVP3cOO1Jy0FkdpdKpTctzsts21B+Mc+U2Te2b7LPvivfZheCxUtlYTIrZDsm8y2EXptxn85MgvQWt1P0AIRZGERlE3cD5XvIgeXnwF3ixxXb72FnGpA+qNHs6YuW1zqxSvawD4/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y5L+0wbN; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y5L+0wbN"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-48662d16d08so431508b6e.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 08:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781796232; x=1782401032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6B/IbNdF7W08THyMkolQP5SVZHowNzPQFBoYdQdeI0=;
        b=Y5L+0wbN19tRlEd+Lbm1VVAt5fzTSgeKF0r6RfFa7UZxq0TlM6zU1e0uad33clNCUk
         Y8FvYy9L4V4K55nYu33gGRTOjDwks4ce7q5GZJRe5gDwyxxbiXXsYGw8z3klxQyXSk1e
         RXQVzyBukBy8qR2NgZuRN2LCz2nLU61h6g7us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781796232; x=1782401032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6B/IbNdF7W08THyMkolQP5SVZHowNzPQFBoYdQdeI0=;
        b=YqU3iQhLa8eoJHWHnEcHpc1QPSPCW+IO2yzNho7Dl/Ug0WgqWDl4AIjmjQS2bbF8uA
         HSlAFUxeSKxCYhmBHktfsTqxyIeOATb2lIB+uJhuc52s91DkyhUEpOfo8bCkJTHrzh8d
         tLhC7WaU/zaysE0rv8qtEvw2t+Je71jBrm0DRhIE2z0CA15K0wPlGPe8HnzROxjXnaWi
         yrQFQPiVf1jl/BlS9cPcjT0EsysJjof+gOWVnNOatMRLoQiGq+LvWzwiYdi4B+JOqB3P
         g/o8bkxWSxR8fEEqZUL//rYZQKiXVs0tXtujo0ww0uRXmX/irZ95RzpTz3yEHJcUCqY7
         DHMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rZ7idrAqLLtW/xesSH6ZUIAxyrqz1lMJklCmSDL7x+jreEKrxv0LAap3R8Pf3qAOIvn/zmz1dBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnLXR8RXRHUcd5dfub8z7TKoql0JZr9Vg3p2FJ7q1y3VIuiXC3
	hAkUkP9+OBcb0vmcHK8pLxnrQ63biNey3/4pju3045vNulBVmQwZmwGnQNDNKUFXDzA=
X-Gm-Gg: Acq92OGIpkdC2TSXSclr9mJQ/UkfTrYRGOSSYMrKlzxrDyBFRvHyPElguDTjFnU3s1t
	pVLU/JnQD5Ygffzggd8zwZl+AkRvk8xmMTJSYuKaOnxrubuKcuzTqQvwf779WqOoUs8ORJoFk5D
	SUNKskFRo7hkvRIJPvDvpcH8Czu4/dtqQd5ZbualEfodWVXzRR2WeY3hmTTCPuv28wWGJkv9MOw
	cwtMgGiVb1oxGdbfciioWcrpaI7/qEsAnHl2ru0MdLMWBG93YiiWDDiNgox7xMtylp0D7lV+f9N
	HUFoRUyyhGC82ajCWKjKm+JCT2jQCT8b6Ld5zYJz03VYHhJHrgQ69H47bSPDBS+AQk5fuQNyMqZ
	/M1Mf29kdgOOHEw5iPdX/jVUfLYUeyOy+WV9jqMx/OX2EqhMM3mTH7quoTtAqU8L5aRj7E8bAGf
	fGhHU7td1P2+k2ezdNF83Co+EAqBbLFFM=
X-Received: by 2002:a05:6808:308d:b0:487:4f98:f379 with SMTP id 5614622812f47-489572495d7mr3493352b6e.36.1781796231961;
        Thu, 18 Jun 2026 08:23:51 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6b7e6csm11706074a34.17.2026.06.18.08.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 08:23:50 -0700 (PDT)
Message-ID: <a376a0c4-8fb7-406c-84be-5adce388398a@linuxfoundation.org>
Date: Thu, 18 Jun 2026 09:23:49 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cpupower: Implement powercap enabled setters
To: =?UTF-8?Q?Mateusz_Ja=C5=9Bkiewicz?= <jaskiewiczteo@gmail.com>,
 "John B . Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 Thomas Renninger <trenn@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <5ff19049-a83a-4ef9-9cae-b97438fb3e77@linuxfoundation.org>
 <20260528153248.4114324-1-jaskiewiczteo@gmail.com>
 <9e4994be-008d-4c0b-9bb0-1ff782ad00f5@linuxfoundation.org>
 <CA+Z_OmTMGTib=eCEGNhCbd=7pmR8Zq7cResyRb=v_wWyRoEdfg@mail.gmail.com>
 <e056d7f2-935f-4efd-bdef-d0f696026d7b@linuxfoundation.org>
 <CA+Z_OmRN0bFXCxRg4SVNP-M0v6G2cME0HszPNyHhP5w7ti2Usw@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CA+Z_OmRN0bFXCxRg4SVNP-M0v6G2cME0HszPNyHhP5w7ti2Usw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/17/26 22:18, Mateusz Jaśkiewicz wrote:
>  > So when you tried to write it worked looks like. The new
> 

Please follow the kernel mailing list convention of posting
at the bottom of the message you are replying you instead
adding your response at the top. You can find the details
in the kernel documentation.

> What I meant by "silent failure" is the situation, when we call a function and it just returns success without doing anything (the situation with current implementation).



> 
> 
>  > value is 1 - what was it before you ran echo 1?
> 
> It was 0 before. That being said there are zones that after writing 0 to them remained 1. Should I add check for this and fail if the value remains unchanged despite intention?

Okay so in this case it worked the way it should and the
value changed. When writing 0 (echo 0) to the file, did
you see a message that says "not supported"

I would like to see an concrete use-case for adding the
set enable API. We added this stub when SWIG support was
added.

powercap_set_enabled() could return ENOTSUPP instead of
0 if we don't have a concrete use-case that uses this
API.

Also if you are looking to improve things cpupower,
looks like sysfs_read_file() could be improved. The
return values are inconsistent and confusing. In some
return values aren't checked.

thanks,
-- Shuah
