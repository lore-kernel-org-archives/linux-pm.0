Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49583B4E81
	for <linux-pm@vger.kernel.org>; Wed,  8 Apr 2026 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775644083; cv=none; b=OrkPfIShB0MutOKveayVa+/tAx+XNzMyUCfalTH/n7Q3w3vt3U4mwIylICtF6hP1bahb7h82NkQvjsX22sO3TtmnVyIvfdM0iHfiR8e67Z+ipPPZVXKnqU8ErtmkInrUDxWatHtz8rXnL6nbJN2EPlgBN9Mf3e6ra6sGui5KwaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775644083; c=relaxed/simple;
	bh=FePcsyiWzxrUbVucGBnF7RBqGlOruBPXH47WRerURPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvKUgsKzOyWi7+vgzeoigJHRgGlvdyWgjKJ9rUFpmOMcZSJNUtzFqE3l/PUeHT89FJM2Pmp+zrBYPSVjc2ItIhvGm0aTJ7/TXoanI6sbETBtF3Yny9YoByU+KMeYCBOjvfwW0u4nmoTRyBtGurdV+MwQc1jj3j12yztSZ/8wxNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVM/tcz8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVM/tcz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F392C19421
	for <linux-pm@vger.kernel.org>; Wed,  8 Apr 2026 10:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775644082;
	bh=FePcsyiWzxrUbVucGBnF7RBqGlOruBPXH47WRerURPM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hVM/tcz8CHpQYeF0HjTD7/SwnwpbTVj57uo57Bj92Z7I/V2iY14zw6ZU14Ds4UHv6
	 nN2JhTInOuRge54/RvTGBhDwdaUg55wxJc74rtyBlT0mbVFjxsKXYNy5hy4jYR3lq5
	 z1UBVH9yo9Zan8T76WtWVkphABSiZjFKy5UmQrZcE/B0jHv0VGEilELrpRLkAEaUrq
	 j/285StuBfUu4OKc2i98sdYaWTIojsDnhHD5jNIlUjpbo2TopG17K7CuJqv+edqvSY
	 YmW+tqLtK0HTUMTBL8gIZRYF8wRzTUh1rkbLrfjTqJN9YVxRum8zaodIp4OITWCHDr
	 rSRuVB27kxyNw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-42306f82341so3373076fac.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2026 03:28:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXWdD6N7AD6qYiOjNIA3yteRiANjyLPgZNvH3oEBwThpYOXBTkx8a6+3j1QfcE+A6pkmohIEM82ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVYfp2RVTnH71HFVMqMs9tZjSDXsKy3yRaHd6rjCHbdbP1aAQo
	nIEi7ApOJGGKk6UNkIdtljir+Jb3mVBfTK1H1ZruTMkaUgrf6+AmCKGdlxiXYOvY3WHeFYfq7A/
	Ip58TVHKYZYJdWsooS0ZEitlYM/Dct2o=
X-Received: by 2002:a05:6871:289b:b0:41b:f608:177f with SMTP id
 586e51a60fabf-4230fd5bf56mr11878684fac.17.1775644081514; Wed, 08 Apr 2026
 03:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0hzhgf3mvdtHgT4Hwiqv22=P=xsWO8QZpeSGayOP-HO3w@mail.gmail.com>
 <20260408014640.174420-1-nanmu@xiaomi.com>
In-Reply-To: <20260408014640.174420-1-nanmu@xiaomi.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 8 Apr 2026 12:27:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ie54h2aK05qNZTWNw5bu7GZDgsxM55KSsuF=ReLMkm-w@mail.gmail.com>
X-Gm-Features: AQROBzBYYDRjn08-5cot6zX6ZUutjo7UFV1xOv9QOHfaSDe2Bbimiez31fArHlU
Message-ID: <CAJZ5v0ie54h2aK05qNZTWNw5bu7GZDgsxM55KSsuF=ReLMkm-w@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: fix race between hotplug and suspend
To: Tianxiang Chen <nanmu@xiaomi.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lingyue@xiaomi.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 3:46=E2=80=AFAM Tianxiang Chen <nanmu@xiaomi.com> wr=
ote:
>
> On Tue, 7 Apr 2026, Rafael J. Wysocki wrote:
> > So how exactly would CPU hotplug be started during a system suspend or =
resume?
>
> Hi Rafael,
>
> Thank you for your question. Let me explain the two scenarios:
>
> 1. cpufreq_suspend() During Reboot (Confirmed Issue)

Which needs to be mentioned in the patch changelog.

> The real and reproducible race I encountered occurs during system reboot.
>
> Call chain:
>   kernel_restart() -> kernel_restart_prepare()
>             -> device_shutdown() -> cpufreq_suspend()
>
> Different from the regular suspend path, the reboot path does NOT call
> freeze_processes() at all.

That's correct.

> All userspace processes, drivers and kernel threads are
> still running when cpufreq_suspend() executes. This allows CPU hotplug
> (offline/online) operations to run concurrently with cpufreq_suspend().
>
> 2. System suspend/resume (Less Likely but Possible)
>
> CPU hotplug is less likely during system suspend/resume. However,
> non-freezable kernel threads may keep running throughout the entire
> process, which may still trigger CPU hotplug in theory.

Which would be a bug in the kernel thread in question.  So not really.

> So I added cpus_read_lock()/cpus_read_unlock() to block CPU hotplug
> while resume is in progress.

Please resend the patch with a changelog actually mentioning the
failure that you have observed.

Thanks!
