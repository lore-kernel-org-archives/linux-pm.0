Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C23502A6
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036231; cv=none; b=BPNNDysbXmBq5ZxEYJnesQEWSj2kcF++WNhrM99HZS6jts6Ydy7W1LHqDLsvdTBIENUNKGYTn70wcjLvDXG9Yhz9wTPRHWb366TUsnYQfxwlKLJELIHb1AaCAJtJpnz7NA2gYHP2BpnivvhmEn8BJzxFv3flJYavs/dEyGSq814=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036231; c=relaxed/simple;
	bh=TQ/F5wJkdoeg0crfUfU5t6VJUqBLg7vlSXVJxmnnn78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLFr2utfi2j/tCt217h7cCQeBUjfXjSXx4eYon7nNESntOl99CbMdZpGKyf3PUaHDBKBoK2OTuFLLza+f4Va77AWve3E37vOG9IFn9jlMJhRjw7GjnUW1k3TX545qeHRhhYml5P5a8kSt9nMjh7pbyEoAtPgLv6F9aqN/C0FCFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=j2IUa21O; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="j2IUa21O"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47de008b020so543906f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1784036228; x=1784641028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=asew3vqgJR8atRVj6FkeBywlgWqbCgDZZtKWBL12bZw=;
        b=j2IUa21O+vAEU22pqfVw/MIIBwUmMa0NH6ef+N5Mzyspk7w9F5HgkqoSjD6jgmR7eX
         se68BBh2vyGfh7hGkmSvA5pflNMBvtVXD+AzLsYk259miSGXcD3S9z9Gq5oFTs347wL+
         wBWvFWW+oCNHYosxFjK5RHzf1m8qr0YCbm3ETeFYNycAH8I95oB7xfJPK1fukY2NrvdB
         wD64+kIoOgCOrKH26q3ok27y33o6AKNst5dYdWBHleBwSFTrkJlf7tpq9/GXCxLtHRSI
         W9vaEeNI3PsTvmqs2TbdoQqVWoJ1pzFT6ncf627ZrOiZ3Y/uqR2y5kTTUrQ7ccAA112X
         xk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784036228; x=1784641028;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=asew3vqgJR8atRVj6FkeBywlgWqbCgDZZtKWBL12bZw=;
        b=n3qoinC724Zfk75BRfhZ4p1uFhjahtrgrgSjr6g8TqiBE8bgVISdZIS0F2JM0Lw9xM
         QMqMBhM3QHehHqWcGgWqiLTdwOxgT4RzMp4jpqoACOvbMDY6/EEkzhnGa9Zbo+smR84X
         nRFSjraZ39TbWdmwTreDIkma9NRfwS+cTuJGHEM1Su6YxIghVAdWawcy8aQzvGAQ1nZJ
         vdAhdJprv5+dOZ1AB3sDJQiWDsHbhI47lV8SyyesMYGw3Z+pkSM4lwjaTWjxKGYXfZIh
         A2ppaYCd826msLPnE53TF5LeEfQ9suhYfL5Ty74XBen+YEj6A5xpDYYEu/yS3BCy4nAc
         WjhQ==
X-Forwarded-Encrypted: i=1; AHgh+RpIyr9iw30AwxABfjPyGCRPdLR3caVWVVJN6MY9wt5oRmgtnrD7h6N4vP4lJeMMsySuHn8ZMQuRXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRMDcOzI+DveWUpXNtLB7t0ifwN497Sa9YvUyJN4JYV+aiETAU
	ogigbGmoYuNo0XtF+o3QyGF+9J9nwvXHrW0RwNppndvIBF7lq3ZHovpVuNyk3PwwIHI=
X-Gm-Gg: AfdE7clqb1b6N8NYd341RfwbBCp9hRT5f9BTrm5+PWmoTe3IfYyOLWzaDSQc74G33lT
	wxYBSH/Ng0Y4D9+nOzlILP4fTu7MGeajCN6Uv6dRJmXrUT53G1bS5xOlY9iVQNA9/xzANkd590F
	xXHjIOWBFQQNbts7oUopaLYUbqL0VoEHOgjr0cWz/tcCmaWtJMTKGwJ4Ts0g8E7EUlnjGU4Aomm
	iXjpybgnyTrrTDWwU0cb23nH85M/2eck/l3iNsSdpcCJh4MSq6HMw/2dgUJ89CB1GKlbaWBZeeq
	aL0Toq9ZawZLgYp9SI8fUpcKpa7EuuNDk05bA1+8w667naQH5OrWbaPoAjozlVAjeSQDreRGlZF
	2CD6VDf8B/gDrgBnya/b/50TLEzdZ4AuBiaPYNpRFubOvt4Q5l4uORTmxE8o8YEj2xsb2KhqeCz
	wAj1VQo90=
X-Received: by 2002:a05:6000:250a:b0:473:6590:c42a with SMTP id ffacd0b85a97d-47f2dc86338mr17485204f8f.9.1784036228303;
        Tue, 14 Jul 2026 06:37:08 -0700 (PDT)
Received: from airbuntu ([149.50.209.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm8289819f8f.35.2026.07.14.06.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:37:07 -0700 (PDT)
Date: Tue, 14 Jul 2026 14:37:04 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 03/13] sched/pelt: Add a new function to approximate
 runtime to reach given util
Message-ID: <20260714133704.hjwlprhutfbatqht@airbuntu>
References: <20260504020003.71306-1-qyousef@layalina.io>
 <20260504020003.71306-4-qyousef@layalina.io>
 <CAKfTPtBxVZ-eB=sjj_ry3=BBHrCt5JUq0dbBS0VxLqi3LBfQ7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtBxVZ-eB=sjj_ry3=BBHrCt5JUq0dbBS0VxLqi3LBfQ7Q@mail.gmail.com>

On 06/04/26 10:50, Vincent Guittot wrote:
> On Mon, 4 May 2026 at 04:00, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > It is basically the ramp-up time from 0 to a given value. Will be used
> > later to implement new tunable to control response time  for schedutil.
> >
> > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > ---
> >  kernel/sched/pelt.c  | 21 +++++++++++++++++++++
> >  kernel/sched/sched.h |  1 +
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> > index 5a8f4dc99ffc..dbd450798b03 100644
> > --- a/kernel/sched/pelt.c
> > +++ b/kernel/sched/pelt.c
> > @@ -508,3 +508,24 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
> >
> >         return sa.util_avg;
> >  }
> > +
> > +/*
> > + * Approximate the required amount of runtime in ms required to reach @util.
> 
> Why ms when we use us or ns everywhere else

Yeah us makes sense. I think it started initially for an older user to
introduce response_time_ms knob to schedutil. I'll update it in next version.
