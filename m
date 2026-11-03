Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793748373;
	b=NWK+0WJrX8meDAT32+KXPU+CrU/4EPUD1yBRT3idiRneP4PX+Z8ULmNncot38zuVjIOM
	 IPxy/Ic2Fslhlxd3wOrQvKEOeJCXxDNNCp9hUZMrTZxEWqV2uW3PIAcMwNEpF8Eo1h8/3
	 b5cCJ7VLjtlqwKoMNdacuRfURk8UyJDKjyCZihgF+O/UXgJF27RCQnajqPXw5RDjG7uVD
	 MSh6LjrPAzD6Y47xXYd8hnSz31ju5trkgmt5I6LajJbtdeXApdVKljz4TFT+qNp4BPpfR
	 kOqrdYQtCzea5oBqOTkphUw7w9AhWd9Se968YYZiHR66dPapkIOq4+QSJc8jA7J6xlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=NJKFflPEUa9YDSnKO3Lm9J1+6kKD7zdG0pGjdjM/xio=;
	b=b/0NYNDSy7/xfUHAb69/k5zaF/b+glwVQbXf9UnqcAiqkDG86pH+HD5BR0Y9/pZaV6Mg
	 j4ihvBg4zZ0hvGJZg4uuTep0+feGkyXcmMEkfwnVX1rAgUUbIn0c34CkDL/HWzq3YdOTa
	 f0vrrY/c9Pvv76tqfdd7JertDQF3YKPyUANPmsmi5UY+49CQGdbYFOsDP+YfGyWcIiaF1
	 sk6IjCezKWR4uJOWtnqHqgrm8nvWBZgbImhmvOlBFvoBzyMjocPucEriA74vk7RdVAXAL
	 fmIwiUe+Pq8VnZQfxNa07U87fvDVrgHQQL1GzPhCS/4ZuqgvJH3SNdA7mz3TYc4cjpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ji+zxbi7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60738606A324
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 23:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60738606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ji+zxbi7
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6deb848ddd7so72515eaf.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 15:26:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793748372; cv=none;
        d=google.com; s=arc-20260327;
        b=Wh+iWE8vr1TXOXoOWct8s39BH9Qz8ChvzyiBEwSj5XHMux558DZLc7JcrGkETHAvHq
         dRNjNvUb3Vs3tvT5pYDj4Faflaam90/oO7IZ6gGPoBwhVprsF/1lxLv7npFpm3rO2SVz
         lOihUE3iYWL0Jbwh7rTEVDaI0A9f5XfP+NbNuZQlJKbeSlcZis6i8C60bGkOmoOcY+fz
         FEUl02YfuJIYAH8vIv0p1D+mJaW7aYZN50LQWJ66ad+oCZ7cnnwN8ZFvuFaG+zvA7nTc
         hUmdEk/od95+XbRcEVIao5uSdMQ6c/N5rpHxyY0Fx2s5wmh+kgmIk729CFq1v9qnOnnv
         D1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NJKFflPEUa9YDSnKO3Lm9J1+6kKD7zdG0pGjdjM/xio=;
        fh=AMDk5MWv7Id71qPUUme4X7eYHY76M4RV2p4QrtQnXyc=;
        b=fE3Y+YpT+D2ir4fLG6mXVR4HoKKHfr4o5PJ54qQ98VU+B//TONKcePh03X71iSWna8
         KI6113xFmKOpbGej6/O9Xgwye/eV0hHP1Fkev/3uZeWotZu1vp529a2X+4kcdDK6paTL
         O4geu2H6iptRO+GtauYzMYQ4C0CfdMCL6bkX/9Pxk3K6R02ytd/bgXwNG4cHXRIGuQaP
         k1C/w5dd2F724QRTzZrH3FXYoYcdN1e7/RjaAhoiqmulqU56+RlnH+S0eiUkVcFPelq4
         6YykX9z0P0COesmgYOLkvlPJv4MI1nEOkivLBT7QTEYaCpKS+DUll4Y+CdWXyEjaggyU
         RFcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793748372; x=1794353172; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NJKFflPEUa9YDSnKO3Lm9J1+6kKD7zdG0pGjdjM/xio=;
        b=Ji+zxbi7h2fDtWO23kVqcrlCQLxq4GHjTI2HDHfu4oag9Ugcq01VCUINkuq/zItvoA
         Itba07VBeNWa8UNDzR0PENIvzsQ8r3+29RwaaVpYSf4AN6XIgUFGq47ZkqX1hw4eHlqR
         ZhJsyb4AWOEpM5+GnhgBu4kQtbCBhVNYx7afVXv/lBPm3q+GakjjzvyV1UNFPHxaoCIl
         5a/LXtCTF3fbgxAsLrpgonWpz33c/teOeSHVlg4cKLRYfopYw7bp5Z4wNosdhGs3enpw
         X8R5vhGgWE38eC2BPnx+T2pdrsfJn8sk0nAejJQ6kke0Bq2zSLcwnyGqpy++6WAp1NEK
         IZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793748372; x=1794353172;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NJKFflPEUa9YDSnKO3Lm9J1+6kKD7zdG0pGjdjM/xio=;
        b=zPDga9fmbYs1oStxbPSZT9+gMzbEJBX/sVFXEslALU9J9h1xHSwpSmA2+dJO6307Vs
         2vj4g6f9rVgm9lac7RCojMbFnyLpWk3gT6KoeE/7bUELHoD81hU3z0QG6GJkyDq6Vgh2
         r+nD8Xfdi/aViPFLMPFuS9g3x1h1GVmb9CMvFwo+rD3FbKGCXnngcGjj4aYcdyHoW6e3
         s0VTepCfo+NS2FJlHArLbR2CESYRBvqlOx3Jhubmw2/ykklKyEdtlsA+gC4M21bOeCaV
         nSUmIYnjkMhg2ff+e6p0e9YcvQekO3DSoZmQ/GowrpCzO43EfBXPRUHMcu7qphFaklPd
         hDsg==
X-Gm-Message-State: APuU4Z/6fFDqE8/5wPaIzNPxImN5muVzS5mhtihQB5UOkMmO2Vwy7kHu
	MtTIGNkN+IJ/ROiaiv0cPspVUTmsKx6+TvokqLY6SeaXKShK6d7T166k6qB/lNUB+dmVCjqbMjo
	uNQ9bMXV/J6FKwIrlGK3xK0UmSnukRJA=
X-Gm-Gg: AYBFou2V1+HJ5sYpzvootcsObEjy5nes/Wso5sqWZwieLhkXocicC/zfoY5Vv9R8+3M
	Lppyhb0zcubgzfoqVTcOJWQ7x6WGEe+Zdp531Jei0VtPWQ0/hfUPCqf/iTGRayfH4fKvrBp4pOB
	kHNOe/9gZFd0Nbra3D9jlLBGW3YBrZ1Xj0oeSl3Cj+bXsTXp/SdPg5aAUV70S+0GngW5BAX4Pjl
	3HT0Q6gS93JzC143EsC6EgQZykpX68COrw0ziOwfVUJqQeeiLwMHTe2SeB5RvreMdz4nXsvigaE
	mE89FMsqTXXtNqVZoD/Xdcqx8GeezoE3/smspH9J+Q8DV3saoIBLQ07754ReUbtaTVIFmpbG03H
	T+qP9EDQCPiK6DJJiL29V2WMOSEJ2ibnEpN8ynqMJ5nLrpNIushKvh5WyBn/z
X-Received: by 2002:a05:6820:3412:20b0:703:39f4:c02c with SMTP id
 006d021491bc7-714f24821cfmr6381608eaf.55.1793748372118; Tue, 03 Nov 2026
 15:26:12 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6065833.DvuYhMxLoT@rafael.j.wysocki>
In-Reply-To: <6065833.DvuYhMxLoT@rafael.j.wysocki>
From: Zak Brighton Knight <zakbrightonknight@gmail.com>
Date: Tue, 3 Nov 2026 23:26:00 +0000
X-Gm-Features: AclHuK9xt0fqS6pCMmzJtEMFSiMRitx0zwi9gEsXXNe-46jEmtuV8Dqdn0y1J3A
Message-ID: <CAJsH6h8tLLX8ugiwLA0U4+xo1P4HHB34pGdfMjE4+NsoqrPSOg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] cpufreq: Fix synchronization with system suspend/resume
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Christian Loehle <christian.loehle@arm.com>, Doug Smythies <dsmythies@telus.net>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Nov 2026 at 19:49, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> This is an update of
>
> https://lore.kernel.org/linux-pm/5162355.31r3eYUQgx@rafael.j.wysocki/
>
> that modifies the first two patches in the series (to address Sashiko
> findings) and drops the last one.

Same tests as for v1 on the T520 (7.4-rc1 + v2, lockdep), same results:
the P-state is right after resume in every passive mode case, active
mode is unchanged, and there are no lockdep reports.

I also made CPU3 fail to come back during resume (hotplug/fail set to
irq/affinity:online, passive + schedutil), then onlined it by hand. On
7.2.15, CPU3 comes back without a cpufreq policy ("Failed to initialize
policy for cpu: 3 (-16)"); with v2 it's fine. That test also gives a
WARNING in rebuild_sched_domains_locked() (cpuset.c:1059): the rebuild
sugov_exit() asks for runs while the cpusets still include CPU3, since
cpuset_cpu_active() only updates them once num_cpus_frozen is back to
0. On 7.2.15, switching CPU0's governor in that state gives the same
warning, so it doesn't come from the series. Onlining CPU3 then also
gives intel_epb's "duplicate filename ... energy_perf_bias" sysfs
warning, on both kernels.

I used Claude Code to script and run the tests.

Tested-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
