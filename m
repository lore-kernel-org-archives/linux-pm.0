Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C48A4594A
	for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774685388; cv=none; b=Pe0WqFkgzN3AeP5H9wmFvv6n6NdW0+lRjGXwXSmVE8E0YelDVdR8Ak57b+xHC/LITAVfC+1GLKtLz5Idng0WjwIQiKOKELKN7vHEizWqYjB+6VxAOM9B/EG3ECDZn2O9HHlUdNx8rWae4y4+ms6lN2JD19EVOokLV+kzuNZSB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774685388; c=relaxed/simple;
	bh=Dn/RRIPyNQwDmxrrO1MlbAqqoPYy/h8noOG7m+oHPIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8pejEgTjjjZUvxiwFwsuUFWRJjgyMWaJW9POSy7xDbGCLz3DHJMsgpYWpBAthvLMu0H2X9m+SYIIlmJDf2MJVlaABhQh0icj4gCTYSk9TL0MQdIzeaICkrMJut4T7iBcNuXa9gn+7TqjWWm1J7XEpr4oRdj3KjQR94t9RXtK7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=wMDLZ3Fz; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="wMDLZ3Fz"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66b51bfe5f3so2196520a12.2
        for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 01:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1774685386; x=1775290186; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NL8uAC59PaSPLKf8xzxeIAjHZUVHr36poGBs8Hpe20s=;
        b=wMDLZ3FzrVv5hihRimk+cldKbjA929Ajh6OeilPF75/1SEMNdfTrXAVxEDFgREDJhT
         IstNNWvpBmMsfGCBK1e1Y1Uy0Aox54q3wdx9h10E/V4nxXykbHYXXkA7fRSfzMVQY/nw
         4awOSKKRgkSPiZZe8mvWwEnIqHrkR1n9IyXT28+2V5lEAkYwXQkNoXCsvBnaWCfuYH+e
         6LEGmgg87ihOYMhVqZ2fI/ky4bh695ITG8vctDCYG1iKP2pSSHzCgL675HO/imSRfqo4
         GvZTl+C10qIYXOpgfKzEgb4PuoyB8Xt9dtLz+lnqNo+JkPY4BRc+2juKKlSnM81xy9ht
         /G2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774685386; x=1775290186;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NL8uAC59PaSPLKf8xzxeIAjHZUVHr36poGBs8Hpe20s=;
        b=Hrw7IFT+EQyBX3DO9mYDDfeiSqAriTydnPhL1Hi4Nbe2QeaEeWBhPFUKlrVx2LEo8p
         A+boKEqywKyNvp0PIrnRAxTqAoKlGOwjYYPX+aIHM/IzxZWQMQcqsjOX4dOyBj61o28D
         9r9as7wtGjZRIzX9uR3vWH28YP9IL33rGMl00fdufUN06rIYag5klVtwy/cph/4ENoLA
         h6z8mbl+bVcWM1edzHZvHKVBSQnVubb+JMsBJtHVXmWOjbVlAs+6WUaCoAJmgeCJQDsa
         H4XdFvzNSsfZbmz1Er0joDK5D8HDMgHHdqZhQQxANP+4x2jrNXsVDw5GH6Ez5hrtvLHO
         pLMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOBxeqBPzsVUDb2Dwh6aHkLdA2DuSjFNFE710SWn0IYcN1zIyUGxxU/IeCYCNTOQACMxSXzk5T+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOsDbXHOW32nvV37ElBxqsO68TmnQBwJ7F5KS3NQiiJjPKkkqj
	YYZHF9YJZ3weQHvjDb5HYJ+KVy1kGqmIIM1gss79sDmXbktDTKdKvv3cMmkRPcZ+ue4KD5C3SsJ
	TLKH5iN2Skg==
X-Gm-Gg: ATEYQzyy0d5GYYRlDI5HUkAHToEqfGsWm1ROIzP0Bv0PYv2z0zpQoT/cht5qjSXbmK1
	6aMQ7xuEheATuPOWY7UwInS7DyKizUFyllleTPhZIfcpnP7W0BMc1AUZ0M8iB0vGd3i/Q/o5pz0
	Lpl2C0Wzzyj9bfMXS9GvnYpZb4U4V2agMVtw0xYdiqBUVvOVuse1Ce/0TMkLXqHoqbDgHIe5WRV
	EaaP8fRRwsSRP4peBNlvzWA2DxHdiX4APRQmPa2NajmJgzOy28BWL5/V5ypfDTLjdgZqCwojhoT
	DYrzS/vAIlGRRe1oZMgJgn62ox3xiBzQ+UJ3Nnu/AHPMy0kJZ2fzK7meQuo2zLqU4nWkQVYFSAR
	t1LVMcYsDPGt29xkr6mLzU1lW5nAVLB3TNMtfti3W4HgSsTRScM16uBE81plSqiwHSYbHShbLy3
	xEZTU4aQzvTCWpFOCx
X-Received: by 2002:a05:6402:448d:b0:66b:82e6:5355 with SMTP id 4fb4d7f45d1cf-66b82e65456mr531421a12.19.1774685385125;
        Sat, 28 Mar 2026 01:09:45 -0700 (PDT)
Received: from airbuntu ([146.70.179.20])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66b7607a87esm396989a12.25.2026.03.28.01.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 01:09:44 -0700 (PDT)
Date: Sat, 28 Mar 2026 08:09:40 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xuewen Yan <xuewen.yan@unisoc.com>, rui.zhang@intel.com,
	rafael@kernel.org, linux-pm@vger.kernel.org, amit.kachhap@gmail.com,
	daniel.lezcano@kernel.org, linux-kernel@vger.kernel.org,
	ke.wang@unisoc.com, di.shen@unisoc.com, jeson.gao@unisoc.com,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 1/2] thermal/cpufreq_cooling: remove unused cpu_idx
 in get_load()
Message-ID: <20260328080940.hhfeqisvr4lpx4yk@airbuntu>
References: <ajjgf7xg5fwo6uk5ualkzoupuyj3pmp3l5yb2i2zfhop3msfkg@ieoosfn35gth>
 <3daf28ca-48c2-477f-ad06-5704b17b880e@arm.com>
 <sbtbzkzrtgrmqhxnwcqrvxprgzytkzwcsanooyukhphymgt4t6@telvhz3yolx3>
 <c19fc390-ca3e-4ad9-92e8-e30dfd6fc95b@arm.com>
 <psrlnsgdg4afrbk7u3vq35bsqc5msncrfifrl6ee45usn27r7y@fwjklu6mcutw>
 <2a71d446-3277-4b8e-9b29-b77ebd3a4381@arm.com>
 <CAB8ipk_7MGUza9_izMypMxPFUjAoB34ZZp0-ts4w6eJ+tr+MDw@mail.gmail.com>
 <35d472ac-8a58-44c5-a0b1-5e1de8ac6cfc@arm.com>
 <20260326090554.jerlaudbe3rkovsi@airbuntu>
 <c816757a-3169-4d5f-942b-4c49be89ebe1@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c816757a-3169-4d5f-942b-4c49be89ebe1@arm.com>

On 03/26/26 09:21, Lukasz Luba wrote:
> 
> 
> On 3/26/26 09:05, Qais Yousef wrote:
> > On 03/24/26 10:46, Lukasz Luba wrote:
> > > 
> > > On 3/24/26 02:20, Xuewen Yan wrote:
> > > > On Mon, Mar 23, 2026 at 9:25 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> > > > > 
> > > > > 
> > > > > 
> > > > > On 3/23/26 11:06, Viresh Kumar wrote:
> > > > > > On 23-03-26, 10:52, Lukasz Luba wrote:
> > > > > > > > How is that okay ? What am I missing ?
> > > > > > 
> > > > > > I was missing !SMP :)
> > > > > > 
> > > > > > > Right, there is a mix of two things.
> > > > > > > The 'i' left but should be removed as well, since
> > > > > > > this is !SMP code with only 1 cpu and i=0.
> > > > 
> > > > That's also why we sent out patch 1/2; after all, it is always 0 on
> > > > !SMP systems.
> > > > 
> > > > > > > 
> > > > > > > The whole split which has been made for getting
> > > > > > > the load or utilization from CPU(s) needs to be
> > > > > > > cleaned. The compiled code looks different since
> > > > > > > it knows there is non-SMP config used.
> > > > > > 
> > > > > > Right, we are allocating that for num_cpus (which should be 1 CPU
> > > > > > anyway). The entire thing must be cleaned.
> > > > > > 
> > > > > > > Do you want to clean that or I should do this?
> > > > > > 
> > > > > > It would be helpful if you can do it :)
> > > > > > 
> > > > > 
> > > > > OK, I will. Thanks for your involvement Viresh!
> > > > > 
> > > > > Xuewen please wait with your v2, I will send
> > > > > a redesign of this left code today.
> > > > 
> > > > Okay, and Qais's point is also worth considering: do we actually need
> > > > sched_cpu_util()?
> > > > The way I see it, generally speaking, the request_power derived from
> > > > idle_time might be higher than what we get from sched_cpu_util().
> > > > Take this scenario as an example:
> > > > Consider a CPU running at the lowest frequency with 50% idle time,
> > > > versus one running at the highest frequency with the same 50% idle
> > > > time.
> > > > In this case, using idle_time yields the same load value for both.
> > > > However, sched_cpu_util() would report a lower load when the CPU
> > > > frequency is low. This results in a smaller request_power...
> > 
> > Invariance will cause settling time to stretch longer, but it should settle to
> > the correct value eventually. But generally another case against util is that
> > it has grown to be a description of compute demand more than true idleness of
> > the system.
> > 
> > > 
> > > Right, there are 2 things to consider:
> > > 1. what is the utilization when the CPU still have idle time, e.g.
> > >     this 50% that you mentioned
> > > 2. what is the utilization when there is no idle time and CPU
> > >     is fully busy (and starts throttling due to heat)
> > 
> > Hmm I think what you're trying to say here we need to distinguish between two
> > cases 50% or fully busy? I think how idle the system is a better question to
> > ask rather than what is the utilization (given the ubiquity of the signal
> > nowadays)
> 
> Yes, these two cases, which are different and util signal is not the
> best for that idleness one.
> 
> 
> > 
> > > 
> > > In this thermal fwk we are mostly in the 2nd case. In that case the
> > 
> > But from power allocator perspective (which I think is the context, right?),
> > you want to know if you can shift power?
> 
> I would like to know the avg power in the last X ms window, then
> allocate, shift, set.
> 
> > 
> > > utilization on CPU's runqueue goes to 1024 no mater the CPU's frequency.
> > > We know which highest frequency was allowed to run and we pick the power
> > > value from EM for it. That's why the estimation is not that bad (apart
> > > from power variation for different flavors of workloads: heavy SIMD vs.
> > > normal integer/load).
> > > 
> > > In 1st case scenario we might underestimate the power, but that
> > > is not the thermal stress situation anyway, so the max OPP is
> > > still allowed.
> > > 
> > > So far it is hard to find the best power model to use and robust CPU
> > > load mechanisms. Adding more complexity and creating some
> > > over-engineered code in the kernel to maintain might not have sense.
> > > The thermal solutions are solved in the Firmware nowadays since the
> > > kernel won't react that fast for some rapid changes.
> > > 
> > > We have to balance the complexity here.
> > 
> > I am not verse in all the details, so not sure what complexity you are
> > referring to. IMHO the idle time is a more stable view for how much a breathing
> > room the cpu has. It also deals better with long decay of blocked load
> > over-estimating the utilization. AFAICS just sample the idle over a window when
> > you need to take a decision and you'd solve several problems in one go.
> 
> We have issues in estimating power in that X ms window due to fast
> frequency changes. You know how often we can change the frequency,
> almost per-task enqueue (and e.g. uclamp pushes that even harder).
> 
> Simple approach for assuming that the frequency we see now on CPU
> has been there for the whole Xms period is 'not the best'.
> The util information w/o uclamp information is not helping
> much (even we we would try to derive the freq out of it).
> 
> Now even more complex - the FW can change the freq way often
> than the kernel. So the question is how far we have to push
> the whole kernel and those frameworks to deal with those new
> platforms.
> 
> Then add the power variation due to different computation types
> e.g. SIMD heavy vs simple logging task (high power vs. low power
> usage at the same OPP).
> 
> IMHO we have to find a balance since even more complex models
> in kernel won't be able to handle that.
> 
> I have been experimenting with the Active Stats patch set for
> quite a while, but then FW came into the equation and complicated
> the situation. It will be still better for such platform
> where FW doesn't change the freq, so this approach based on
> idle stats is worth to add IMO.

Hmm isn't this orthogonal? It seems cpu util is used today to estimate how busy
(or idle) the cpu is. You can decouple the dep on util (and scheduler in
general) and monitor system idleness.

Anyway. Please don't add this ifdefry and the strange deps on scx. This is
a recipe for shooting ourselves in the foot.
