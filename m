Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BB340DFA2
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155036; cv=none; b=cwxUgbbWIckFresSXVi/ipaD1XFJyrXCow0zquuNIzGxUfBJEOOk4gCf66elNLvDbjhEgPu2XZYl2GwflppMkSQYwPZGTswvSWKprE9voxqRcx8xi82I97tNpxCQgBUEnHPq2I5Fd+aq4cHKqqDS2EGbM0hadn2vS7qByZeazdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155036; c=relaxed/simple;
	bh=aj8LutELrRgFFanMshC5f8wHDa2FtBJ0U/1tKlzk+KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+cV5JtW5UDYLvA1hAUnkMSYlDZOZpBqqu8rTen+7corCugYC0SzLRxJLk0psIVyJc5II+SJtguxjy8iC9En0yRTY0W5kh+ca5jVOyB319pQpZ55sx3kqA8QiC3DAPU4ECz/plSTf738pIqtZKLpHO7waonfXlsZM8pxUH+mJ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=zNswpa6z; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="zNswpa6z"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439f59dfda2so396332f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 08:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1773155033; x=1773759833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oCccoqS3evK4HLf4A7FonBQX3DUGSE0/MG43OnHaf/A=;
        b=zNswpa6zbwntSBOmGdg7AOdCkLqmZSDNuQ2lVHwf0g4BvSEalK3Zic7GKumxoT9MB/
         ReA7RVco471kdQpc8sXPXF04MrraMtSO3LMarLa3BsCM5nYvmZNyw+PHlrItz82l7cDJ
         VYUIcZBa2DMircp5vl4cXDXydZY3gD3slxsUawicQBrfaM/DUywB8IAYFezM9mJ4W/2t
         9k6nQzTpyifRNnYh5Wxv0CoXmhDOA1AvafdInOT1VWxWVl3BHyYHS2ILsfo3Q+jwyGea
         b0pKatYcrlaxSF4STo6ONINjjkEY/NuXO8S3HGrK+GtY/zZfh4xO223bTBfXzdjKw6Qr
         hF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155033; x=1773759833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCccoqS3evK4HLf4A7FonBQX3DUGSE0/MG43OnHaf/A=;
        b=oZL5X80AhlM05rBGDEXPXQY94PCt4VzJW+b7rRoQzQUMXztwTOUF4JwoAuHxQewsV7
         mdsWD5UI/pbUrnw6tePrRFfw3Yki8PnbCCBxkcrOue0qHnAA2AnrvbrtIn9y5QcdRU0t
         1Snvj4wdoEuB0AXdSxJPeXM719QnQBxjeOHkDuA1hczk7yQy+LrIZvBxFXmZ5nUo1s6p
         H+qoFIAz2BS6tajitA3MqcWMg8H6kzIR/ddMCDUXKw2upFGdqIPrVahLO8gptrpZktAO
         amCJOCk6C14NeCIiMcKbWEvUe6yC/5mPPcyBy8UGpdBzp8E/ZE0WLD5MnjfchqRBelxK
         MIZg==
X-Forwarded-Encrypted: i=1; AJvYcCVq2S0toAZyUbYyVCP92Ps8QW353LYOCzMgqN5nXb0XvFGtemuVbBx/BToyEcDL5QBwYnS9bGq7hA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVWTJwpyKFTfWqMvyvzPpSISy/JIqTWdgarTFTh64v20XNKnKn
	bd5yvvP6c4/TJxJQe4AM6bvRa1LupoSWFNPDHrgAQrKNqUb/yB9goV2q3hsG515PQHc=
X-Gm-Gg: ATEYQzzNpmI3TRypCR7jB1330/lFx598pCbcJuXHkvtb4v1lhWdGEG/KOQy9F+G7j9K
	yiMuUmr8MLZsp+yu5+jAhW1So2BhhYm1Ogs2PIS6cFdOZsCasbM96t7Ggf13ejvseK8KS7fvla0
	zjEIBxJf2R/mP5+8i5shi4t0ah6Z+OmQNrZGWTEjSt7Gs/uCxmS3d/HOpBwL3EryQ3hYSo6ZxJB
	RjDRHGOgmG7NlneDlGu4Bec3jn3K5vR1sATtcW6gKJU54T0ZBuodQKipmiZxT97pqzZs5OBiGE/
	QyBaJa2zyN3TuLQEefF5zeldd5x2K+R8Z+6k8Q3tRKMsyXGfYDVkrwrQo1TYvLt/74qFAaR+o0i
	vkkQJwRBieRECqJfOjDhPb7PuxOZGRIYgw9Ff+X3BHIInAAiRNYPF7XCD918LsX/vT2ZbLy4en5
	PSsTiBmFPV+JHJWWzk2yIZiBFqV6s=
X-Received: by 2002:a05:6000:18a7:b0:435:e3bd:5838 with SMTP id ffacd0b85a97d-439da33af85mr27508575f8f.25.1773155032597;
        Tue, 10 Mar 2026 08:03:52 -0700 (PDT)
Received: from airbuntu ([146.70.179.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3a20fsm36265514f8f.28.2026.03.10.08.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 08:03:52 -0700 (PDT)
Date: Tue, 10 Mar 2026 15:03:47 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [patch 2/2] sched/idle: Make default_idle_call() NOHZ aware
Message-ID: <20260310150347.ji2fdpdvw6txspc4@airbuntu>
References: <20260301191959.406218221@kernel.org>
 <6250711.lOV4Wx5bFT@rafael.j.wysocki>
 <CAJZ5v0jb7wJFQEfP_-JRv4mwh3qveq+VPoy8k9dmtmigoSyKhg@mail.gmail.com>
 <2409653.ElGaqSPkdT@rafael.j.wysocki>
 <20260310035406.xnu3nlqp4ldshxww@airbuntu>
 <f11fc45d-314a-4e2d-bcd1-9d8b1a49c87a@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f11fc45d-314a-4e2d-bcd1-9d8b1a49c87a@arm.com>

On 03/10/26 09:18, Christian Loehle wrote:
> On 3/10/26 03:54, Qais Yousef wrote:
> > On 03/07/26 17:25, Rafael J. Wysocki wrote:
> > 
> >> In the meantime I realized that if the .select() governor
> >> callback is skipped, its .reflect() callback should be skipped
> >> either, so I've posted this:
> >>
> >> https://lkml.org/lkml/2026/3/7/569
> >>
> >> and here's a fixed version of the last patch on top of the above (for
> >> completeness):
> >>
> >> ---
> >>  kernel/sched/idle.c |   25 ++++++++++++++++---------
> >>  1 file changed, 16 insertions(+), 9 deletions(-)
> >>
> >> --- a/kernel/sched/idle.c
> >> +++ b/kernel/sched/idle.c
> >> @@ -161,6 +161,14 @@ static int call_cpuidle(struct cpuidle_d
> >>  	return cpuidle_enter(drv, dev, next_state);
> >>  }
> >>  
> >> +static void idle_call_stop_or_retain_tick(bool stop_tick)
> >> +{
> >> +	if (stop_tick || tick_nohz_tick_stopped())
> >> +		tick_nohz_idle_stop_tick();
> >> +	else
> >> +		tick_nohz_idle_retain_tick();
> >> +}
> >> +
> >>  /**
> >>   * cpuidle_idle_call - the main idle function
> >>   *
> >> @@ -170,7 +178,7 @@ static int call_cpuidle(struct cpuidle_d
> >>   * set, and it returns with polling set.  If it ever stops polling, it
> >>   * must clear the polling bit.
> >>   */
> >> -static void cpuidle_idle_call(void)
> >> +static void cpuidle_idle_call(bool stop_tick)
> >>  {
> >>  	struct cpuidle_device *dev = cpuidle_get_device();
> >>  	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> >> @@ -186,7 +194,7 @@ static void cpuidle_idle_call(void)
> >>  	}
> >>  
> >>  	if (cpuidle_not_available(drv, dev)) {
> >> -		tick_nohz_idle_stop_tick();
> >> +		idle_call_stop_or_retain_tick(stop_tick);
> >>  
> >>  		default_idle_call();
> >>  		goto exit_idle;
> >> @@ -222,17 +230,14 @@ static void cpuidle_idle_call(void)
> >>  		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
> >>  		call_cpuidle(drv, dev, next_state);
> >>  	} else if (drv->state_count > 1) {
> >> -		bool stop_tick = true;
> >> +		stop_tick = true;
> > 
> > Silly question, but wouldn't this benefit the normal path too to delay for one
> > tick? This will only matter for the cases where the governor doesn't explicitly
> > set stop_tick to either true or false - which I am not sure what they are :)
> > 
> Right now the governors will always set stop_tick explicitly (and overriding
> that might confuse the governor-internal state).

So we can drop this hunk then
