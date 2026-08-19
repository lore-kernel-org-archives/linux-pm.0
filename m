Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C5648A2DD
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156886; cv=none; b=WVGQdAANzEeahHMRXWM3MSfR9C7AGla2Q1unKQZ8JU610o/sat2JBjFiY1Xq4bWH8/hjrBHUr424roEkjLXU6YL/FqCpJ6X3wOsjfcWaRe1WnNHZ0b1whqzF9RT8+bvh8GeCiB+Wb81/a/4uq+PFnOEQp4z8M4G4SPflSD8hKoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156886; c=relaxed/simple;
	bh=gBkLv+jThAx5yh/3wbxgQH1veZQSTAkQPzrM4LwL1J4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ACSb/opYWG2vmDpM2z74isR6aATdj1slzXBEMK6WJa8a8Aqm3gqL4jIzBADbUp2dq5ANSJXIhpYIKvp1IKeSzy/px2RW2RaAudUebPuHmbCWScH1b2d0uoaq+J942oIQjM0c0V8KOyP/LlBx/kukYty8yAMnX6GUgAekSQ0CmsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=P1W8qIii; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="P1W8qIii"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cace91f112so12972865ad.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787156878; x=1787761678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RewVJCryqnh87giXeknqhfb7A3p8HtPWhy+6gjephd0=;
        b=P1W8qIiiPvER37kFg3sXJeRpZWxzIORuGdzY3eXE3KR2V2Ci2IvOLkJ+58zwj1dO0P
         LpyGTwup/LEQt8+eB5l+qtscRHL+LO5NluYo3dpOB781FK7us2T9Vdcf+rSm5gErY0sg
         sgioW7xn0/AxITBIsxZ1lMq5c4oYy1VmmOJG9STKLZoxK7nQZF++fMrHaYgnCbQZNOVe
         viyqFQ4JMTk5agQe6EMalGFFmV/3KRw6OsN/aYkLHDv87rcr2Fi1Rk6CmKhrtmQ6wtlO
         uaVYaxfQsAbFuikjg79YJc+fbIH5wl1wMcaLLBlo7LIP52ws3w0Pw6d4fNgD2wARK+jn
         8dMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787156878; x=1787761678;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RewVJCryqnh87giXeknqhfb7A3p8HtPWhy+6gjephd0=;
        b=ee6P8k4HTjg/IRocnpRMvNIW6pqn47J/Qpj8RI+onJxg6KRA5eQDUcfdh3gjMtwJnI
         2VdC2vCvHPZH3bit8lBpoCYH3/woAoT2bi4iH/ozUfZQaMQWxxQZl931MY6qQFzr3y3I
         sNOYkMoKbW1EsnVdm+QIA8SjpU/9UmdMS5mEsb6viExZgvNWRRejjovIfiozBfWd5fX2
         4sFNSjW91Q6Wd8wri3lJTw86owP+8GOwvO6ws1GqTunCEu0k5DebGi7F31Ljay/ti+3o
         rqp7pgLKFkgiDpEOioeNvrQpFSSEUQk+lrOCKD4h7SeBXO1s0ZZTEKo51azutr+XTJBy
         GnkQ==
X-Forwarded-Encrypted: i=1; AHgh+RrC0s89ujkPUuO5YqymhmIdRa/aYkIfeAanqZqI5786rAc3IpD57XITvtnxR8f96VGFE/TUW815Zg==@vger.kernel.org
X-Gm-Message-State: AFuF++l0LY9OMokae6YKZRK2s8HycZefD9yxiHBYXBlEyppLm5Lx068j
	sh8FefZdYHSpf/cb8zYSh9u7vApRq9gbRryZBuibgsltpfjxBu+15L5MRXvKPd+6G86Af33wt2s
	f4hXAksg=
X-Gm-Gg: AR+sD10pyO58xzrMBATgKRYPiuZNhV00FopzGpHbIGSV2WaikxU0hyDUtlgKvkefxvs
	dRSmuTDtATzdI28QrCgG11fpiyovWdt66YQfotfnVeiOXTQoCBmiT5AG6F4DrY0uaiIcqzTJIZB
	AezjhVagkfudYnBcUEMbd6owQHLScOUZp8/mn//CL4fUnnXjKmDyVo2yMc0VqjVgid+rKQopotw
	aBSzo4grrwDcL14+pZieeyCTAbYE8233nGlQKBCJUumESPMi0s1a6ffPsl495VV/NTEi5KJ/U2d
	q24XDWWkur5Zq6b8ozRTevWlsnQCazWRU0OBd6awboAODPOBX6HqLph9c4wq9mSO2H2EnMIrhkV
	svxYINxPXSEyOAEE0pj1nlBb9eihiGx9HMHhwXVQrDrk8eHPxVjZWAaf5UuMZuvFYzgsfV07k68
	HfetUj88ePKcUWWZS1k2+pWOIFjim/IojdRaaaHJuu/tHygeQDBWwc53GPQQ==
X-Received: by 2002:a17:902:c94f:b0:2ca:e62c:9e96 with SMTP id d9443c01a7336-2d5fd6acbecmr106588785ad.5.1787156878204;
        Wed, 19 Aug 2026 09:27:58 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2d5c1ecb2absm26359475ad.71.2026.08.19.09.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 09:27:57 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, Ulf
 Hansson <ulfh@kernel.org>, Dhruva Gole <d-gole@ti.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] PM / QoS: add lockless read for flags
In-Reply-To: <CAJZ5v0h15XmucddczVn8b4=T1axydUPB6J20uiOLEk794mjsiw@mail.gmail.com>
References: <20260611-topic-lpm-pmdomain-device-constraints-v3-0-75d69438518b@baylibre.com>
 <20260611-topic-lpm-pmdomain-device-constraints-v3-2-75d69438518b@baylibre.com>
 <CAJZ5v0h15XmucddczVn8b4=T1axydUPB6J20uiOLEk794mjsiw@mail.gmail.com>
Date: Wed, 19 Aug 2026 09:27:56 -0700
Message-ID: <7h8q62vzw3.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Rafael J. Wysocki (Intel)" <rafael@kernel.org> writes:

> On Thu, Jun 11, 2026 at 9:59=E2=80=AFPM Kevin Hilman (TI) <khilman@baylib=
re.com> wrote:
>>
>> Add a lockless read for QoS flags similar to the lockless read for
>> resume latency (dev_pm_qos_raw_resume_latency) which may be called
>> from atomic context (e.g. genpd governors running under a raw spinlock
>> or in the syscore suspend path), where taking that sleeping lock would
>> be invalid on PREEMPT_RT.
>>
>> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
>> ---
>>  include/linux/pm_qos.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
>> index aededda52b6b..439a9e779d81 100644
>> --- a/include/linux/pm_qos.h
>> +++ b/include/linux/pm_qos.h
>> @@ -219,6 +219,12 @@ static inline s32 dev_pm_qos_raw_resume_latency(str=
uct device *dev)
>>                 PM_QOS_RESUME_LATENCY_NO_CONSTRAINT :
>>                 pm_qos_read_value(&dev->power.qos->resume_latency);
>>  }
>> +
>> +static inline s32 dev_pm_qos_raw_flags(struct device *dev)
>> +{
>> +       return IS_ERR_OR_NULL(dev->power.qos) ?
>> +               0 : READ_ONCE(dev->power.qos->flags.effective_flags);
>
> So if you add READ_ONCE() on the reader side, all updates of it need
> to go under WRITE_ONCE(), or the READ_ONCE() may still not be
> effective.
>
> I don't think they are under WRITE_ONCE() ATM.

Ah, good catch.  Thanks for the review, I'll fix that in v4.

Kevin
