Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D81336AB4B
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775593196; cv=pass; b=OBGo/mGtC1Vn0RGYKvj7suo3x6F5IgS46mXHHpHaHiEKpUPSsSOTbT+BJXZsWDOoT1eTv3nIBBz0z2wpLoCKTUCVCwxv3OlL7LQFVUvts5hpYzqsO9CLVvuVuoBrWqzDhmqJwXxHH68i92zV7MYmFL2IILyL/WjMX81HV8uPJ0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775593196; c=relaxed/simple;
	bh=cIcwh02YeJrScNHPq9X6XdHj5CJSHTdteY/DkuKKTzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuCwcT4cwjgxMLDzpjDvRsAE33FfUKo1m2Bxu09qMM1V5KjtIuXCa8JibdhjT5GzTWDNZAa7YptlALL3j9AWloWwzwDZiacj2DwKOITWHbBbHMa0Lpeb1AfvKPBPhhlAE2GMt0QHasz3w2i9Ao5yQc1c8PLSAGnUc02+e0QsVMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CJzTthZs; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJzTthZs"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8f97c626aaso911930266b.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 13:19:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775593192; cv=none;
        d=google.com; s=arc-20240605;
        b=UwXzVG/u9+KhvD7lGdynTUcZEVWXjnl4OLeMoTcCTZYog2uakZ999XS4QyWt+FRx9p
         J7ebQUpS989I3RAHcMNX6UMO2Xrv3tUuTgPmeFTNyBPa2MKvcGCpTcxi9xw+0tNQ/Ice
         F1etAsypnExrt4X7l/xkf/0TpUdySa+wtpCCshxHgLBr34KvVgu4rIBTuhNujG7hM2ws
         oaIUKUBFJw6AeWzc1CvkjvtoUqGJsFjEYojFuoaXYlOzYf1+IqC0Hk6G+ciFTt77CIcM
         T5Yvg/dX8188JHFm6Xcutr6AL39BNRmExs64foLzxmzg9rLndIxiii1mt0+hjGGb6c3r
         YnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5F/h7KugE6fbvjgPOHVFnVDYl0H2cgQ8aKqNXa/3w5M=;
        fh=jWmgUFCiEzdxyuyqbejeX5WkqyKhwqKj4mSbF8KPfC0=;
        b=hkcgdZbLPHjqw1y8jMofalr4lrvV0XpnHxUmc+XBljVQdLTVziETb5VuKl4OxtNsjK
         wRkKz1NmJTzP88STS5/QKMjha1U0FHZP04mA4zdAlH/uIPR1p6wgGnYaaGZnzU3AXHkf
         P41oQ15Hu4VnvFdLXKz9oakZdporIKK8CSeMxW1MTom+vEv1bp0ELsHbgYsixJUuuaC5
         qE4Lk7X5WPm0QDyUcSohjHPHx5FW3pJGPMWRLozDgt2v6nFnMOeZVkuONv6W4TJPofeA
         H1gsj6/td5T3TsbZLpGjhA0Y9uW7sHYiWcMdFtL/upMQNOWKcufawwDmuMHjTnDjNlwl
         T3eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775593192; x=1776197992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5F/h7KugE6fbvjgPOHVFnVDYl0H2cgQ8aKqNXa/3w5M=;
        b=CJzTthZsicvaYDSAqkcV9esA41ipyUSssZax+j3EkI1EusdOVdTk9qmMP3ZzxAbQuP
         arOlA2tVispXM08ee3P5K0LEmZ6LQJYeGm1H07kM9LjI3G7z3U6hPr9qJHiOaZGP0SsR
         voGK5gPMRC30sJqeTD3NbBmDebq4g+riI5vNQrtAXXDwjeb4h8Kb48AB12zNQWRlDVtY
         d8XfTBe20778fIJlFgsjRsiKCfCXKrEbEjY7REIHFBfzwP06DnJa531yrNZXd0hjzI/X
         KC9h/NRDvcU8OrhRRpsFc5jKWCTfO1jCYTUSRwFfkPBafMGBHwZF+71iF/u2uJVvFffp
         rTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775593192; x=1776197992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5F/h7KugE6fbvjgPOHVFnVDYl0H2cgQ8aKqNXa/3w5M=;
        b=Mhou9F/Cbj5RilNg9jgzdukjMALiuCv5gbckGAo10/M9A5e7aP1FndiL9hoH+iB966
         //qVhpPfrcot0I4Z6hsUfMEV/OddzYK9rF3DpqV4WT78p/I7OB4sGfRIr5jgn6pOjA4V
         dUZJ1upYk9vbRMMMXRoFrcugev+y+7d5Ds5s7SqqebwV/hS4JPTMbkbrNZRO3pFKZQM1
         JtqxOIEqw9lysK04bOKqavmUCr4Q6F1De+6W0uzVOl9NUc6CzLw1T5jYirSOsbFLtDfS
         tTCxnWOfKW1ppH8cPvqzxfKjlcTAhOI6C+JTnGraeEueJM5ffEqEsBY/KNQhdiDliGpO
         M8Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWsqvbAWZcF2QBRWN/E55GjBnBt86LfS4B7dzfH8hKk08/Fb/xg6zXXweHlcgXbRcDsKigyRUuHjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyONQYINgii8i+FWyPtvdWDq1mEZ3JP4qL+FfjmMmUHJfAMXDvN
	CzKWVFkHy1Dkq6nkt38yHqk5iIf+fTKEj0jrZaKv6JHGyKIwmeBOY3Ya/NIBr4mPUjgULMruprb
	nVw3FD+WyYBMiR946QxtxQiR25swSpx4ZhxYMk4o=
X-Gm-Gg: AeBDievZNLbCyUz7Spax8SzrlfIW5PNkDIfGzyQdVAAOrB1m7qVjQhaO6rO0jN9jDij
	1AlHCb2GavoEfM6eFNM09QnXpoU3H9DipxYR85EjMp+675uU6PHKUS7xwWHyGMX+MVTLOQSbzr6
	bivHLwQn2iBkL8wuqK67i+1SMhvPa7gOtMHsi1bpfwQvHWu++ln04ooSBTmOO8TmFL27MM+JFDI
	4LaIaN29wTr6b7dB/ywoPpIHUmE1cucJ6cr7HKcO2JJCU3HGxuX6gw2sdiWteUBv2UYI78UKENS
	Jq6gD48qi3KEdwx9Y/GjHqRL+io041LtiU/1
X-Received: by 2002:a17:907:3e99:b0:b97:7d03:68c1 with SMTP id
 a640c23a62f3a-b9c67957b45mr816891966b.30.1775593192032; Tue, 07 Apr 2026
 13:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407083219.478203185@kernel.org> <20260407083248.035227538@kernel.org>
In-Reply-To: <20260407083248.035227538@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Tue, 7 Apr 2026 13:19:39 -0700
X-Gm-Features: AQROBzB5Kk-9wmWuv1ZegtmjY7I9xuAgB8C2jMw495vm72Eo-cG6s6UJbujlAjQ
Message-ID: <CANDhNCp9TRWAF1EHQAcFHLv3eRusVycTrNDk=UFpzg0oTBjQyQ@mail.gmail.com>
Subject: Re: [patch 08/12] alarmtimer: Convert posix timer functions to alarmtimer_start()
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Calvin Owens <calvin@wbinvd.org>, Peter Zijlstra <peterz@infradead.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 1:54=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> wr=
ote:
>
> Use the new alarmtimer_start() for arming and rearming posix interval
> timers and for clock_nanosleep() so that already expired timers do not go
> through the full timer interrupt cycle.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> ---
>  kernel/time/alarmtimer.c |   20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)

Acked-by: John Stultz <jstultz@google.com>
