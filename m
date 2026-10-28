Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793226508;
	b=2SHWoTKcCncnwE6VBMz9ua8Iw5BAtiDHJVwzlyHUcehX2bUlcvOGmSXqJ0+8RW6a4G0O
	 hKqu0k6+JPuiiCb6ISdOqRdr5s4E1/24r1FlyixSOLYh5a/ECgktD7BA88pUkRlc4i8Yo
	 oVuKZHOmSW3zV/jsLMjimixu4T1CPVS4xBDVzrm8lOpaPYlAwvH7DySw6DdUpR9pyvlTb
	 XImrIBEZfDrgQA4JMcAjJhb1yJp46euxnxFDMFXp804UztAZ/KC2iB1M6Jxkt1kaVFDer
	 KmELpC7dO8Y7aSIhDllNs0w1BeDkbfEZmijDrYU9W3Md6Jj4n3io1C0E4bcL8GCIBjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793226508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:References:
	 In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:Content-Language:Thread-Index;
	bh=sgJ5PTNqFid6MZM1r8iQFNCnYOqNxfsXQPmIc2nl23Q=;
	b=m8m3XtcZVshsr3JgmuilwYaZ3uhDDkc41uxBVkIQPR1G46+bj3DSVRG+9WDFDSON5Ht3
	 QqDhDivk6i/6ATa+fCKf4aNyLwTI8GLCKCfhJp3pyzbxoEt0I/hc1iSppIqArUqTDTDWm
	 oUJ164qYOfP6MN+At/s93an25sQXruizm05q9WCUnXBxdPdUdCuQD9xk9n+6zCLF/k/cF
	 ijKYLbkuuwCq6jlD8PaN2y3K3aIKVXxnykYJaoaorr9xMPsHA/N2YR9SCxspflugR1x8P
	 U7PxWs8JVxehLs6BqxzI2NkIBb8TrOrsku7b4Run3fxM6h8g0YevEgvImEHMTupG9Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=telus.net;
	spf=pass smtp.mailfrom=telus.net;
	dkim=pass header.d=telus.net header.i=@telus.net header.a=rsa-sha256 header.s=google header.b=BgmqJJqo;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D2E606A31C
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 22:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15D2E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=telus.net header.i=@telus.net header.a=rsa-sha256 header.s=google header.b=BgmqJJqo
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso712319a12.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 15:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1793226507; x=1793831307; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sgJ5PTNqFid6MZM1r8iQFNCnYOqNxfsXQPmIc2nl23Q=;
        b=BgmqJJqokN2u4Hh7rRBEBA0RP+A37QVcXFGZiQfu+Xq5hRgUcQulSTGZbF7qJDiIeb
         JhhqroUwN3A3o4A79c8lCi8996f2G8N/odtrpUl2ODuOP09ue9QGQytM4gYyKdyOu7pS
         sdhizgGMh9z/1TfV7VrxilZvK5FW5QajWeL0a8iLryn5X/epvab5m4FQtGVcjPVWxW5N
         sL+nrJSfJauKMyjm+FjCq8LWtRS1FD+N0wvBjRM7pXdFxDIfoGs/ltY/8Nlazz1M/QzW
         3tfuVb6dOyuOQH21ivLgn51X/VGk9ZodAjFdof5prKP9z0NyL+JdvWYknjantI8i0wP9
         wQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793226507; x=1793831307;
        h=thread-index:content-language:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sgJ5PTNqFid6MZM1r8iQFNCnYOqNxfsXQPmIc2nl23Q=;
        b=sellMSDEqOYfmciB8+4UimeJDTXoc77upRZ2ZLJJ3LD7YamGQRTHSkAKqMIPmcWd/j
         paS6CwmmsKGJulz3slW9RvCgAjIHohD5rBe8MpAhe8x4UIfzIght4LJtBEioO7xqsDoE
         z703HMR93dJA2uJQbaQrIXQ2WGc3AMst/EERjIicx4aAD6o1+o1Xwj1jJjE0HAiinPFZ
         I0yCtzinadVwsh2nxL/Jtht4g3PYoHJ17oliNd63LhJFxy59cItTzzENBJaRsae/Ij0c
         QRP9nl7WTO++Lqg3dXxVmGEVhynX75QZlI449mtfNL4o0o0g6/7vF2dquqqHkClSWFM+
         BfCA==
X-Gm-Message-State: AFq9FYLS9fjI3tNnoEWUYQC99Msu/ve7x+cdOdj+Xtnpqhk/Sntcrp2n
	FwlxUQC6jQFd9etGXNDVACQYms7ptzruvenocl2ZtJaNTBAz22b4vx7rWbQy5r3gAv0=
X-Gm-Gg: AYBFou2d5rffa3sOJ5NNrxqOx6vnI8/+s4ePEUEyxcNXOD2P6fusQ4PTKRw+t0AoPpX
	xmuVuC/TvzQGei74gNaPAShR+PyYDgaegtqrXeYfwb+IFSsSr1FvV0hnh0RFMIWiqotvdTiq5++
	SJtGRUkxPDMYQGdTsIorgBlj7qIy0+F3M0w5KnBSund28YxXdZGgZSJla2/nzcKESAT6yOO6vQc
	Jv4NUBUdHthzdaTLxCYCADB/NfoYAu2YU9urodMdfc5Pm7SwTJCE9oImrp38z5+lyowwG9hbMMs
	Qpko/n82z33ZQR9/yc+uCYvbNiXuBWC717vu91Ovss7mVhE0u42nCyB1Tg8IO/o+iqj690Xb9Qq
	Lj6kTq4uyDZMkk4ALCyzkUUR++LUBAFPVNYqhQvwtC1kIu0Z8eo4aI46ETzooNawwztfhS5mkJA
	kVWmPZgwc9RkxHZ66N2XWjiueBaZycclIVO0o8gORIrtY7Dw1TZHROd6br+ctxxKpjyk1F3xdps
	aoZzOBjGeY1HuHeaX9EGXNKJazEjYqvMLP/J3oE6P09Bp5flG4cfkyCPitwi9vLRzim9+EBBvua
	9yuKFPkMb17hyUNv4mVB6UUSE8IgNgy/cEQl
X-Received: by 2002:a17:90b:4cc6:b0:3aa:f4af:1e16 with SMTP id 98e67ed59e1d1-3ae57e08be7mr2233816a91.7.1793226507332;
        Wed, 28 Oct 2026 15:28:27 -0700 (PDT)
Received: from DougS18 ([66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55a6859bsm2548569a91.0.2026.10.28.15.28.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2026 15:28:26 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki \(Intel\)'" <rafael@kernel.org>,
	"'Zak'" <zakbrightonknight@gmail.com>
Cc: <linux-pm@vger.kernel.org>,
	"'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
	"'Viresh Kumar'" <viresh.kumar@linaro.org>,
	<linux-kernel@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <20261027143725.3763827-1-zakbrightonknight@gmail.com> <001101dd6631$6167dbd0$24379370$@telus.net> <CAJZ5v0gVkYuZAh7H8KFakN+vHkJTjzvmZsLrUVP0MXkaKLVoCA@mail.gmail.com> <004401dd665c$97eda060$c7c8e120$@telus.net> <CAJZ5v0gvruWF7VhVuLrn4AgV9_n6Ayektrh+jB=eLY79ufw4UA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gvruWF7VhVuLrn4AgV9_n6Ayektrh+jB=eLY79ufw4UA@mail.gmail.com>
Subject: RE: [PATCH] cpufreq: intel_pstate: Restore P-state request on resume without HWP
Date: Wed, 28 Oct 2026 15:28:28 -0700
Message-ID: <006601dd672b$a7d67f90$f7837eb0$@telus.net>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQG+ka4iSAouj32QbdBtcmCOlo9WegIHF20PAY25hX0B4KDsxgCzt23+tx/ofyA=

On 2026.10.28 08:54 Rafael wrote:
> On Tue, Oct 27, 2026 at 10:46=E2=80=AFPM Doug Smythies =
<dsmythies@telus.net> wrote:
>> On 2026.10.27 Rafael wrote:
>>> On Tue, Oct 27, 2026 at 5:36=E2=80=AFPM Doug Smythies =
<dsmythies@telus.net> wrote:>
>>>> On 2026.10.27 07:37 Zak Brighton Knight wrote:
>>
>> ...
>>
>>>> I confirm your findings and tested your proposed patch. It all =
worked fine.
>>>> I had not seen Rafaels's reply about a possible race condition =
until now.
>>>>
>>>> Test computer: i5-10600K, 6 cores, 12 CPUs, HWP disabled.
>>>
>>> Passive or active mode?
>>
>> Apologies for the incomplete report.
>
> No worries.
>
>> Passive mode has the issue. Active mode was fine without the need for =
the patch.
>
> Thanks for the update.
>
> Please check the patch I've just posted if poss.

Because I had already done so before this email, I tested Zak's V2 =
patch, and it worked fine.

I tested your (Rafael's) patch and it worked fine.

Tested-by: Doug Smythies <dsmythies@telus.net>

I have not reviewed the code and will not have time to for a few days.

... Doug


