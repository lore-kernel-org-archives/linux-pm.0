Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6523D668F
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522302; cv=pass; b=gFiBCzJ0D/6OxFS7hpGuFmsEg6y2eHkWbv14hprKbWa+UWpTiD+EKtuRSvz2xvOU9hs801NGiA/EG0Yyrl2YkqEGqN7tfWNDs2EzVvEOc2RJMenTmze83ayiDl0sTGjOfmV3qIf5+vCkPgNdNSMq1ZYh3SnYgxRcSo/+wFgrobc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522302; c=relaxed/simple;
	bh=BKXbZOBiAXH2P/40TtKb0nWzOlRV1dkQEeLK1phSwdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpuyJThh15EUT7gz7OvS4Vhq1EXjIoUsv9As2ii7TgJFygye2oviCgK21kavRh9rLewIHSifcsCrCx9aSfgAKOZcgdVavce85w91G/k779fvMjuuqOs1gJta4lmgbPkabUgDwUD21sdD69pgQtZPqEtGv66KeTWqTy2VeHZPf60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBosLmH9; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBosLmH9"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-130b2295ed0so12322969c88.0
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 10:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778522300; cv=none;
        d=google.com; s=arc-20240605;
        b=EeKAi2AtyDW5CA6+KFErzQ4H7qho4rqvg08CJbd7EadcYo5XbtzFYtj8/RoGOAj5gf
         X+k/b6IR62uOc37z4RAfXz24RJN8MyF+1ZwT3AUPn7KWGCLU6ahnFC3aWTOMUTpLJ4wq
         0goPYt1hwbwUTz4/CTEKw5UyqmPZ7eDQ03JWyWbFiH9NFroIzD+SaYVYiZlK3qIoIKOs
         jdXkWQtv+cyhmuOB58XcN289+5Fyb7NxtVCc4BIWUcjhSVj75tjhs0sWSlqMpi2q5/aS
         4PZUt3lbW0gZWxuRPfOAfN5H4IigEIwHwINyxk2ako34xYpkBqwzTQRwcDR6L0EsltIs
         5diA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BKXbZOBiAXH2P/40TtKb0nWzOlRV1dkQEeLK1phSwdg=;
        fh=nmweUaLHyJIQ6sIvEHIZ3ExYzPyTNzC5gN3lmNwid7I=;
        b=KY0GM1GMKsr44xxh7Yg4IZ5X2/3KZdlMfwBafQ8eK/3zwFcn2CGCsi6g7rVNbtq4DE
         Kwq6SW2JBgVS+HZr1MjH9rf/eI87p68gkoa9tLcJK3lRkH2LU5YOWR2QKNhN06PhJ8W9
         +BgSgkDrcjow5N7Lxc77HJHXMOiIPm6h2Ylpz/MabLZZEWcAnUOWQlZDS+Z/HK7lpS3W
         xMaJIP9LOGU723IsPcPj1UO2jtttsSNUWEwv30uv+dVM/FjBRFDqHTri7vcfy+WGIoNM
         oP3aRCNxkPxEpHbeg85CFmOZi5QFvF3s3kwjWQFredj2UBS1gWy2PatFeeEdch0BkKht
         Jl/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778522300; x=1779127100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKXbZOBiAXH2P/40TtKb0nWzOlRV1dkQEeLK1phSwdg=;
        b=WBosLmH9h1xS74rbqg5PH2JktAOYFaqBfHSJzcpWHbeoCColttmQKNIGH2zcQ7KdNV
         ZG0HQAFppFusG+hWNXCIx6mSqyoi3J+8J2eiH3brEwuMOktNyNd6m62kCKKgalLnZ7sL
         vLZariaNbCQ40sl6bZf4E5gFxhzkxV/A85bElnOdUimSYm14TuUuvUoQIc3nKxaBrSRY
         dcOqhbqE6nhT5xubpzsktMIwn7a6S6jBMJHpZDrM9dYSPqvm928Su8ikwa3hHYmBl1jv
         jKDTGffzjbmgFsGQZ/dqlNsXCtmTHgjsKs9Cd9xRmZoHjztRGIyR71WH5QRM0hhB/m3w
         yH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778522300; x=1779127100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BKXbZOBiAXH2P/40TtKb0nWzOlRV1dkQEeLK1phSwdg=;
        b=EUPl4At8yGjPoqA4ydq7oQ3AYuVkVOHq+8NMrd8lXo4IGJUbWNxrP3x6bXKTToNQBy
         sNcesiUf3wt6NsSpJr6KxUyklNrV9xRvh+Jp4IGHnUMsvIEOKnD3+YAJ4Hp0zsPhHCwH
         N5I+6ZJoNg9FCpsw8eS2uzyihKMNtWFe9TxTEHGrZeMRyznJyNDz4IekttnrUJ8FNMpq
         ArG9+6PNSvFG/ngz+Y07486O6YVKTwfFZKBnN/PE2mnXJX2aXNx1S8I+O09FH9FZq1XZ
         cLaOfRyfFqQFsUVxnZ0TD7cB6tz/q6QXvbldaPPjpSH4nh63RbQkV5WMkP7yjX9HxKe2
         bSAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LG6PNfM+o01AYbOI6uVkb2y+v5+lD2GulAhGG4R6eNqnyqGaVRl62hWCPeTxz6CmNGbfLTKpBOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YymWk+nZEGhVRIP9heWh2PsXtjLRMMMDPERU39yVJFLmz/nuKN5
	/tL6lMDLiNDOtVKV/hpzrf1XoPx3LgjQkxKMG4BFgvntkxQcFU7/+3EyQYQJiSccr14uYaM8Z7Z
	s8Dk4YnQ2qe9zpTe+bkrBpZiRC12HOEZUtM7orO0=
X-Gm-Gg: Acq92OH3K7nVt41z8LhuQYSUBUu5qx25FLZuvgUnrPCZjsOQGM3mJnbQD6SvmxJ4HMQ
	lbLGCzMjCC27Yon84KhGpNZjzDjGeyZP4ZVqJPzd6kR70B/BLqI2a9xaqoI8X/i8jsWkOGEqrgj
	7mAVIrjdVGRe8pJd/V6Ix8WSHI3JA1ddtqJhB03bziQJipKk/lzX538MKDdeaKHxjVj9F1Fr6HJ
	qls0uYBkblqb55mv4F04UJ75uQEx3wJWSb7zETEgnRCuX2kk8zlJqwxZQ+W/1EOqWZrnV/uc2bn
	5voFxb6jHi2A+zu7yZ+xYqPI8HBndH677Ea65tkFQZu9rOle/1hHV1B/vwZDTKjCFYybcOkW+KO
	VodBqOIHKLHFGijXqARua2taBsZkN2SnAHDWcs6MNu/722A==
X-Received: by 2002:a05:7022:4384:b0:124:9acd:328d with SMTP id
 a92af1059eb24-1318e91762bmr12601254c88.22.1778522299831; Mon, 11 May 2026
 10:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504020003.71306-1-qyousef@layalina.io>
In-Reply-To: <20260504020003.71306-1-qyousef@layalina.io>
From: John Stultz <jstultz@google.com>
Date: Mon, 11 May 2026 10:58:07 -0700
X-Gm-Features: AVHnY4K9jHBTY5-nkB4TjLSWtgH0gkTj0Fu3LMDcVw1wmY6aFBiiweiafSPJwLA
Message-ID: <CANDhNCqoqmU=xJJUhD3P5=5N=qqNNZ4DERezxecJ4HHuivRQpQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] sched/fair/schedutil: Better manage system
 response time
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 7:00=E2=80=AFPM Qais Yousef <qyousef@layalina.io> wr=
ote:
>
> This is the long delayed follow up to the series sent back in August 2024=
 [1].
> Life got in the way to some extent (I had a baby, and now my time that I =
used
> to do upstream work late at night was stolen :). Apologies for those who
> replied and I didn't get a chance to respond back.
>
...
> Open questions:
>
> * The details of the QoS interface is the biggest one.
> * Would debugfs be better for setting the default rampup multiplier inste=
ad of sysctl?
> * Patch 13 makes updating load_avg unconditional not on period boundaries=
.
>
> Patches 1-3 are prepatory patches renaming a function and introducing new=
 ones.
>
> Patches 4-5 handle the magic margin problem but making them dynamic based=
 on
> actual hardware limitations.
>
> Patches 6-7 fix the black hole problem and teaches the scheduler how to h=
andle
> bursty and periodic tasks via extending util_est.
>
> Patches 8-9 is where I expect most of the discussion on as I introduce a =
new
> sched_qos interface to support the new rampup_multiplier to help manage D=
VFS.
>
> Patches 10-11 introduces a couple of necessary optimizations to counter t=
he
> power impact of increased responsiveness by disabling some features that =
we now
> know how to handle better.
>
> Patches 12-13 fix a couple of issues causing util_est and util_avg value =
to
> swing for a periodic task. Patch 12 must go via stable.

Just a minor nit, If 12/13 are fixes, should they not be at the front
of the series (or possibly sent separately) so they can potentially
move forward while the bigger changes in this series are discussed?

thanks
-john
