Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D5031E844
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 02:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292590; cv=none; b=YVgScrKG5/jW2kzVkSJaV65pz6tJkCoTYR/LspVucoPsqFK5V9cdbNqcn1FFsvLETWZVvQhiCDXpJW7v54QdO5LtBwGrtAhvQoydE4LRS6g6IZGKUqa41NSTEOpUAoABkjYSLEgQod1+ehY0YfsbbYWOdlA8uOa5C8o8kc3HN4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292590; c=relaxed/simple;
	bh=aMtYYfhYERME9KhULUnK6J5JCQwQ2EthKtQBUzr6fBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQQkQv8ajvuGXvaenX7s0V7RLHGRXoBCyy/+3/mykXNqsO8kFQwh5ZUKlUeixORRpT875FpIeRGolPd87ItnVejpzl2dclSB4ZVJ3Ket96aSZCNmT0B2qa0JA0Hn6RDXYMIJEPh1uS5lr6le7uXmmOedayr2uHmWEmxPN13esHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9R7OY1O; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9R7OY1O"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47362928f65so412714f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 19:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785292587; x=1785897387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aMtYYfhYERME9KhULUnK6J5JCQwQ2EthKtQBUzr6fBw=;
        b=p9R7OY1Ogj3iAGMxH1Ys4nbhhnVJtNxpK6XqRbFjjE/c1h0nM1tJgU0Zc577FIHuxC
         EvNs2cxYEG9iklmM/3lhUGTjSP/j7EixJoYs4CXupmBr0qOTKW7Bp99+m77/LDgnUAZB
         pqc6RuWM58Vjj/uWNGw17rBtOl4DhkUBXW0sTqmBl6ddux+yiVvMaEy8ryR3+LvGcaZl
         7LCKkG2HZ44jUnsMnF3cGPqV4lcPQo0BMb6WDmK5J4683i8NWxa1pd6SEbDeUHVdnzhP
         R31xUcdZ5HgIoKisqcp5AdNfs4QknhvhUmvKLdBiBHprzZgroGFLqSSmgcvkZtA7hS3d
         GeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785292587; x=1785897387;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aMtYYfhYERME9KhULUnK6J5JCQwQ2EthKtQBUzr6fBw=;
        b=WWZSqd+h9y5+gOo1DgZp1zzFSnTHfywTHgtD9RuHvzI28WSv5sUN3ErVF5eRcCtUzH
         YRFrdQdIOFa52/LiyYfzZKyoNkLnM+s1vAqELoL9qUefidTAjNbPk+IJHWoASxHqxmzc
         HUw3EGl1/AjCplzJsJ3RG3i7cah1McIW/l5CQ8YytBt+DfYvAnrdZkUl/GFJoFtOVPe4
         9mmZHXzwl244yzJTVk6qUHhrT3Iuc3gnJ8h9VGIKbvidgPk/jRLfah2iqUjRnIePLK7b
         MCwLP/tvk/t5j232kShIgWGUgKSGHfJIJ3d4F5RC9Qqiw/DzXRRW/9PuEW7agAon5gjU
         oe0w==
X-Forwarded-Encrypted: i=1; AHgh+RoBrobowhb/To/eSYDkJ/1K2Wp2HGmn7c5iGbusm8FtIoZk2IaHqAtBK1txJZvidFlCVq07AMe1TQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyd3StDrv1u1JJWFRIgKeOME2xBZp5IYiqGOzjpE1rtGKqRq4R
	MTOrEKgtvmggvyFQUaKcUi9eicHKbwzS+DbQdP0EXdNwr4cHU0rRtCM9
X-Gm-Gg: AR+sD124kOhuLFj3dyBYca60zU+iqgAUTwUP9PaAqMylrqtrTI9q1VNlZXG/M9AVzQ7
	Fg46O4knI7amlndFqmKYxmjMOLEszTXFyq9ZpeadMBZcYj71VdhHVyGCxH7QuUt/a6y+n/slAGT
	2OByPD2c7CRYuJ89hEqUhbGK9A1QrMlGCa3Td79fvq2yvXDEpz+EMnw+Az6gcoJKhBm6RQYYu4A
	6IZwsNhKY41/DTElodKRl86zZMXKlBVSUp++BmjLrRSf3S46EFFQ4497V4a8YrJmu5G6JM9STJI
	UQCbfv+vzv85fTSsjiR8i85qS7LGhUhwOdRqe5LYYah2emGVxDZg5jWhzm0MKXNwAqF9WjvJ9vd
	GZeshh4jY1ikMAr6jpBiSDZCLpZc140h38jOOPVfWhig2LCasXh/nSVVmIPxYKpmdekRnIDBgjk
	gjR6F49OT8SNY+72CUydBjv7+9p6jZhySWVsRHXYfFcINJlGvRzJKgCxW2ol7CO9eaxFXtceJP
X-Received: by 2002:a05:6000:22c4:b0:47f:9266:7cbf with SMTP id ffacd0b85a97d-47fb1ed729fmr5347599f8f.20.1785292586645;
        Tue, 28 Jul 2026 19:36:26 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0f295sm3784213f8f.22.2026.07.28.19.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 19:36:26 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: christian.loehle@arm.com,
	joseph.salisbury@oracle.com,
	rafael@kernel.org
Cc: rafael.j.wysocki@intel.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Zhan Xusheng <zhanxusheng1024@gmail.com>
Subject: Re: [REGRESSION] sched/idle: Sysbench threads regression after f4c31b07b136
Date: Wed, 29 Jul 2026 10:36:15 +0800
Message-ID: <20260729022930.318742-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <774c3a68-6a6b-4e2e-a347-03e36953b750@arm.com>
References: <f5946a8a-43be-49d4-a827-25149112b21f@oracle.com>
 <774c3a68-6a6b-4e2e-a347-03e36953b750@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Zhan Xusheng <zhanxusheng1024@gmail.com>=0D

On Tue, Jul 28, 2026 at 09:30:39 +0100, Christian Loehle wrote:=0D
> Interesting, so your guests (no cpuidle) need the tick stopped at every=0D
> idle entry to not regress, i.e. the below?=0D
> Is there anything obvious that shows why that would be? Maybe in the=0D
> hypervisor behaviour?=0D
=0D
I think it lines up with the got_tick heuristic rather than anything=0D
hypervisor-specific in the guest kernel path.=0D
=0D
do_idle() resets got_tick to false at the top of every idle episode and=0D
passes it as stop_tick, so the first idle iteration always calls=0D
idle_call_stop_or_retain_tick(false); tick_nohz_idle_enter() hasn't stopped=
=0D
the tick at that point, so that takes the retain branch. Only after the=0D
tick fires once (got_tick becomes true) does a later iteration stop it.=0D
So with f4c31b the no-driver path leaves the periodic tick armed at the=0D
start of every idle episode, whereas the old code stopped it=0D
unconditionally.=0D
=0D
That also explains the test results: forcing (false) keeps the retain and=0D
still regresses, while (true) / the direct tick_nohz_idle_stop_tick()=0D
restores the old always-stop and recovers.=0D
=0D
The hypervisor is then where the consequence shows up: a guest that leaves=
=0D
its tick running keeps a ~1/HZ timer pending, so the host sees an imminent=
=0D
timer and keeps waking/scheduling the vCPU instead of letting it idle. That=
=0D
is at least consistent with the shapes - the x86 shape at HZ=3D1000 regress=
ed=0D
more (-29%) than the arm shape at HZ=3D250 (-10%), i.e. more retained ticks=
,=0D
more interference. For the no-driver bare halt there is no governor/state=0D
selection that a retained tick could help, so stopping unconditionally is=0D
strictly better.=0D
=0D
Thanks,=0D
Zhan Xusheng=0D
