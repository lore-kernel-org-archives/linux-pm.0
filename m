Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6260E384248
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 08:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513475; cv=pass; b=kcjydt/e20rfXf7fi0vREpIscyVCRpmZVwf3f/fU8gdwSbu97am4r2o3IvuxzDbgRkvGu+kKGJutKlUs+nknxc3Y7b0DQolg2NKLvxFTDgDgyTYMr2cw4pImInJXREAcG6kVYkv7W3nWYrtZQhJXFSDufwXOBfMMp8MA/9ydTT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513475; c=relaxed/simple;
	bh=brpxdB1vAd5vzNXTPizWqf7RtOgCA2SwUuZei1Zx9RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BByApIZJOioLXeAo5K67uq9otUs+6R+CrcfYLkTfMjSrvMFS98DBpQ5vii4OG5T5VXiDoYExS6A/cfWMYKk3+6Ry7pF0sEi0TOF3GlvmRJ+bDS6HTsIx3CQR+kG+yZHNIys0rNIx2dywhvr32+q3nznw9jrVfzJogMduxycfU/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rB0KRKVy; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rB0KRKVy"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9961e4f71bso108135066b.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 01:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774513473; cv=none;
        d=google.com; s=arc-20240605;
        b=KwDck9CrbNTh4ne2R5QdSElPtktD5768YcF6HECkE9/ENy3a9x7jOItSqc/yMlkmrT
         fK+nJPZ+DDcLrLE1N17Bp+Z4/EWyPebvtzfJcd8YvMEnCZnJOs9tlDeN2ojm6yNcQmm4
         RsEBdUiXdaRx+8FT3myt8sCJ/ufevcrJfJZEpuE1bxX+aaxQLueMc+xfZS4V7houmsa5
         6TnCVkht1EUUBD8pPwo/dm08qJ8ooFtKm1wOZWUnL31mqCTDZimySGUJAFKbkvxywdtW
         7qrhOSF2sA8QUaj0dItUbhGKIik4z2F52VL5p5c9igufZ0aLRof3QWkVmJ3pBt1HrNit
         bCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=loSpBIFFJ4Yff2Sj92mHvsVD93OiQGALKP93Z38iAlU=;
        fh=cn+UxduwdeJkOdKRoQnFSi84Tzd+ul6KWP2Wjk4fq20=;
        b=XSv0OMG3lDoRirZsklURFtsdBJwQI+c904jU0l2xonKLalWIk1hTw+kjDwchcckUMo
         F4YAhumi52zgkfp75AZ5Z9xHenWwxJZKRTjUukdMbYXc8WFrP/AI/j8J/oMXN5JWVHmJ
         K8EFLFpi5OxnApUaszT8Skljjj6Kgg5KVIzDltHnKWLOqtVPN5KljnsVXsbfTAgjc0Ln
         jTQzUCloQSBX01N+P73xxmkkyQLr9RDl/+uLVCjdjTxInzTYf1Lc1netxc/5b/QUCC9T
         AdYieKv6xJA3n4A4c4RrAgYBQrhHF5Y8o+fUUUdKz3qCTp7i3/Sq6x1J9+gndNzPIQLL
         Bnpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774513473; x=1775118273; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=loSpBIFFJ4Yff2Sj92mHvsVD93OiQGALKP93Z38iAlU=;
        b=rB0KRKVy5iUVi2ksU1XlrgENEAiR8pQiAMsPske44Qt/IZSSY3fb4g+DvqbL7PrQ2k
         bUMIFPmu1EuZ1LqHpFYIx15HdAxxrgG+yJNqLF8ykoSw3UDmicV9f+plm7Fhq096seGu
         /fnOWEhGXis4EyilDO7+QTVJUDlYQxwyFgTeg0lCkniu/+NVzpv5qzX0AHRiK59t17AK
         X6WERbZmtJrzbdjnbqzMK08ImP1ZMN9/iETkau2/RHkLCjHIMn0H8vq+0yXCSFT3movo
         nxKZZXT2Xg74tWfbz8xIQTpJhRCFlVPCXmzNx1VVIBPs4c0b0K1MioAbCeal9UA/tsK2
         aRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774513473; x=1775118273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loSpBIFFJ4Yff2Sj92mHvsVD93OiQGALKP93Z38iAlU=;
        b=V8YzPmDcnLyfrPUk2nVSC/8nuT5lMft3L5D9OOnMaYf/Ec+2m9glh8FgKR366QJUsg
         eVu/MPxDF96Cdq1ttfMHgWRyPqryksbhSZvrlqw+mxadfquiz4ziUIZgWlMTKZb2G9J4
         TAW2VahhVT/azoNk6erZX4uGeqNrW8hqiVKNbsxledEWI9MPvng0WrJdw1Ylz/PHIRPU
         vyuBQ+/P6fobbm3F8KT/UWjfoCVoxwTOpsMsy8I9C+BNH4scQwVcwIMgaf4te68FI28b
         EsVKvaPWp70gbYJha7g2fgMJTZGuulG5S9vVtPmtSUkV9aPn10xDX1W2cyHG0XPvaZs3
         laIg==
X-Forwarded-Encrypted: i=1; AJvYcCWvVEX3sEfze9ZCcg/7WsJU+izq8qIZXHHyu9ARIhMvScG2GkAq8z9gcQOtLPaTJqoes2dq2olIxw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3zgjRD6TScMPbgC7+NOJFFNKhym13+Re2L4wvtaIvitURcwZx
	A3+02Yr9AEbdpJ/12uldV84CbEPfz7ILqs+IODwoEUAD3NUs6xrXjwaqpRH4yEquJurttQbxV+4
	yQyOQTpkN+ljeEZkuL+Wc+XjMlCB7eXCq2fjL1zkeTA==
X-Gm-Gg: ATEYQzw9ZdzMZavwbbGYR0zFLyLQkgmbO4ekArgAnFs4r9/pTE9Anneeh37650G8cKY
	PNb9KsPbfsibxsJn0b+xcruG5r+hnWA1XcQ8mKarNm4pjl2OKNMHwMQ6OnVXisYUC3DMOplp0xE
	I0zktb7M4nSJhYzG/ICh6hce4L3f/SX92y6nhDe3XQrPuaZXtqXfzjdeup9Dz2JdUjGj8hksStY
	lAV/0tXRFtjMqeKDkW+TRorpX8ItiC3RvS4NWylQECNksLVMBxI+ZZdPH+GxUBGl9PvcrAXxg2d
	nVxoZTJEyDoeBlHzInyBhwwxkfD5f8cMEhO/
X-Received: by 2002:a17:907:61a7:b0:b97:464:956e with SMTP id
 a640c23a62f3a-b9a5423686bmr385754466b.34.1774513472552; Thu, 26 Mar 2026
 01:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325181314.3875909-1-christian.loehle@arm.com>
 <CAKfTPtAOd2+e1Wyy1uhCzLANh9-KJpR5zc_RSSt+dQvHHxhmMQ@mail.gmail.com> <d40e57e0-aeff-45fb-82c0-6cefc4f4899d@arm.com>
In-Reply-To: <d40e57e0-aeff-45fb-82c0-6cefc4f4899d@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 26 Mar 2026 09:24:20 +0100
X-Gm-Features: AQROBzD8dxwWh8JTO_dZdabbrem4zaQ_KsFGOVVLc97XQXFMB4qzILPu0AOs_iA
Message-ID: <CAKfTPtA+rcVCLe5XOKwu+0bsc8_ZXc1TH4qrYo4x5tNwz9ZO5Q@mail.gmail.com>
Subject: Re: [RFC][RFT][PATCH 0/3] arm64: Enable asympacking for minor CPPC asymmetry
To: Christian Loehle <christian.loehle@arm.com>
Cc: arighi@nvidia.com, peterz@infradead.org, dietmar.eggemann@arm.com, 
	valentin.schneider@arm.com, mingo@redhat.com, rostedt@goodmis.org, 
	segall@google.com, mgorman@suse.de, catalin.marinas@arm.com, will@kernel.org, 
	sudeep.holla@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com, kobak@nvidia.com, 
	fabecassis@nvidia.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Mar 2026 at 09:16, Christian Loehle <christian.loehle@arm.com> wrote:
>
> On 3/26/26 07:53, Vincent Guittot wrote:
> > On Wed, 25 Mar 2026 at 19:13, Christian Loehle <christian.loehle@arm.com> wrote:
> >>
> >> The scheduler currently handles CPU performance asymmetry via either:
> >>
> >> - SD_ASYM_PACKING: simple priority-based task placement (x86 ITMT)
> >> - SD_ASYM_CPUCAPACITY: capacity-aware scheduling
> >>
> >> On arm64, capacity-aware scheduling is used for any detected capacity
> >> differences.
> >>
> >> Some systems expose small per-CPU performance differences via CPPC
> >> highest_perf (e.g. due to chip binning), resulting in slightly different
> >> capacities (<~5%). These differences are sufficient to trigger
> >> SD_ASYM_CPUCAPACITY, even though the system is otherwise effectively
> >> symmetric.
> >>
> >> For such small deltas, capacity-aware scheduling is unnecessarily
> >> complex. A simpler priority-based approach, similar to x86 ITMT, is
> >> sufficient.
> >
> > I'm not convinced that moving to  SD_ASYM_PACKING is the right way to
> > move forward.
> > t
> > 1st of all, do you target all kind of system or only SMT? It's not
> > clear in your cover letter
>
> AFAIK only Andrea has access to an unreleased asymmetric SMT system,
> I haven't done any tests on such a system (as the cover-letter mentions
> under RFT section).
>
> >
> > Moving on asym pack for !SMT doesn't make sense to me. If you don't
> > want EAS enabled, you can disable it with
> > /proc/sys/kernel/sched_energy_aware
>
> Sorry, what's EAS got to do with it? The system I care about here
> (primarily nvidia grace) has no EM.

I tried to understand the end goal of this patch

SD_ASYM_CPUCAPACITY works fine with !SMT system so why enabling
SD_ASYM_PACKING for <5% diff ?

That doesn't make sense to me

>
> >
> > For SMT system and small capacity difference, I would prefer that we
> > look at supporting SMT in SD_ASYM_CPUCAPACITY. Starting with
> > select_idle_capacity
>
> This series is actually targeted for primarily the !SMT case, although
> it may or may not be useful for some of the SMT woes, too!
> (Again, I wouldn't know, I don't have such a system to test with)
>
> >[snip]
