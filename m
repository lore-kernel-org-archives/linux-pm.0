Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A0386C3D
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515962; cv=none; b=Q1RQKWKUKayl7iUMB2Yy/TiJ8U/RE/gkEFpwZQvQ2DEDK6sGnwPMRbVQHnrQdlQYU34zwZGDnml02o6U+8Xm0P/dScz1Z2QGRJPViScMvRGtNfB4svs2CPZlmkgNTkGZ35DpGJ4iPw149zlwoCcZqukwrfXSdno3IsqNV+mntG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515962; c=relaxed/simple;
	bh=UAvOrVGVgu7HVDoR4wnTJE0tExSbzsApz16NV0VySLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktrOWK9O81oLzCrz3Up4bAJ54sMHMzhgO4AdS1MmbaQxQMKcgHlXp/C74nWg8s6V8ACqORegzJuKV4fuZiPvRX6KdopZ2p7oqPrNmI+17LEWwrvck0FZQvRFs5egjSMWCUPDEGDCbT33oIBVXrcGfWmicFPhGvAodrbqLYYr7ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=lL1zqd2k; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="lL1zqd2k"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-667f8794e97so1278627a12.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 02:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1774515959; x=1775120759; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3oDe3JQHGbHK7W58Xverm3NtmKUpUSNCvgw5cg/WZ7A=;
        b=lL1zqd2kh0dR0Dq8dkivFhJACUUBGZFJR2RdPg2+X6xP4WXgN16pB9v4ihmsnFD9DZ
         bvS7T3k7tudske7aP3p7KmGR3Sz1lKeMVDhxgT1TeE2C/fzzRnNtHhuo0Lwiu33KRINW
         4vFtIcEtW5BMf96N1lcdN9/034vVeU2NVrY81qDiwVRPkAPE8fkUsOY0EsSOf+6W8xgs
         Eo/LU+NmCsGNzXNVB0Q89RhiI6bFDuVuI1pjzi/6VuaHCAxX0VmTdCMIiy/RGTHMScTB
         43geWeqsvPbi6YriT2kMiSqlxQp0R4g9dXn0Oq0AHWNIt9p6Phbt74EuLNq72YOWCyAX
         V0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774515959; x=1775120759;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3oDe3JQHGbHK7W58Xverm3NtmKUpUSNCvgw5cg/WZ7A=;
        b=ACouVvIkXuUWcuZExKqav2ppAkt+iqAJZinHR65G70HrJUnDdHbYMfYtDw6/eb92jR
         4ggpbPIpa6l7xI7FZ/Nf5aeZalG4sY2DRtkVtcjCEDFgGBFAu2kVwbGjxtHFimBbN47t
         KNy0/avtatcc+t8kEqNFKrlHxAqb3kMMfs5hT9VWhf8sDypy0AOHipNVcOQ/2h6yBDJC
         9S821VyQrlhJFy0KLkiUUnDe1b5e7jmn/ufnJhX3s/VoUerXCJNNxMkTk8Q0ovnnM6q8
         iledCTjzk9obR7f2aP6hvPgkhP4xQoozhiUssoxOo3w1WgMsN7f8YOPV/jGCufsU48WY
         xfgw==
X-Forwarded-Encrypted: i=1; AJvYcCXwQGkQtKQiCwcJap4ZQBCwO2R5vWmws2UPIOVk4cwX/OLh6Rp1srIX5xBmhV5HHi0LKAs1tBRVdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPDnGi1ZMOn4Lxdn0jZbqSmb84pmT32UrGnGGS88My363SXnM1
	IGDNRHXYh34yj8Ik4GT7aJpWPd8eRcnzHRuOxTiBhjQu4kHI2YFcFftVkmRSsDg63Nw=
X-Gm-Gg: ATEYQzwevqEgbwM30El6j1teU/JDEFedCzsg+ZHqpCTSK8Ys9scKIPy5dnv4L5xe7PE
	ONlVCJJgCru0XCb0SXTq6UZx3ejdma0Hj9nU+NyhaHIELjWYnvroV7NExuf/IkLT5iIch5Qpa9a
	OLENpd+js9xc0c0cDPvc2VozilIWcMmzwbWHmmR89w9wM4ARyd2v01qOvXvucRXlrkm5U34kBEs
	LPtOOxNsOsSgjVWuZirR3Thi5yHCPGDVyQVXtbSJCnXtiz2IwMjl9PyCbGUAv/6ZU1JHiykEVNp
	Lk45o7NI2ZpuiFNX8JmLLDN5Q6o0J7wI3jOCgutjZtw4LKUs7tkX5a3OlUsNItX3nz7O5XkAeX6
	H/z2Vm9GzuoK7NYlacoZ5pgVbGjHIpL0daL5pxd8+Oui0lc6GYOhtbLb9v75x9feORI32/Sxfw4
	w35l8xh3wU2L5wyKFy
X-Received: by 2002:a17:906:38b:b0:b96:e3db:9e04 with SMTP id a640c23a62f3a-b9a5a23b104mr369725866b.53.1774515958782;
        Thu, 26 Mar 2026 02:05:58 -0700 (PDT)
Received: from airbuntu ([146.70.179.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b20218f2csm93739566b.3.2026.03.26.02.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 02:05:57 -0700 (PDT)
Date: Thu, 26 Mar 2026 09:05:54 +0000
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
Message-ID: <20260326090554.jerlaudbe3rkovsi@airbuntu>
References: <20260320113148.7308-1-xuewen.yan@unisoc.com>
 <031562ee-b88f-49b9-8b1e-dbbbe1a508c6@arm.com>
 <ajjgf7xg5fwo6uk5ualkzoupuyj3pmp3l5yb2i2zfhop3msfkg@ieoosfn35gth>
 <3daf28ca-48c2-477f-ad06-5704b17b880e@arm.com>
 <sbtbzkzrtgrmqhxnwcqrvxprgzytkzwcsanooyukhphymgt4t6@telvhz3yolx3>
 <c19fc390-ca3e-4ad9-92e8-e30dfd6fc95b@arm.com>
 <psrlnsgdg4afrbk7u3vq35bsqc5msncrfifrl6ee45usn27r7y@fwjklu6mcutw>
 <2a71d446-3277-4b8e-9b29-b77ebd3a4381@arm.com>
 <CAB8ipk_7MGUza9_izMypMxPFUjAoB34ZZp0-ts4w6eJ+tr+MDw@mail.gmail.com>
 <35d472ac-8a58-44c5-a0b1-5e1de8ac6cfc@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35d472ac-8a58-44c5-a0b1-5e1de8ac6cfc@arm.com>

On 03/24/26 10:46, Lukasz Luba wrote:
> 
> On 3/24/26 02:20, Xuewen Yan wrote:
> > On Mon, Mar 23, 2026 at 9:25 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> > > 
> > > 
> > > 
> > > On 3/23/26 11:06, Viresh Kumar wrote:
> > > > On 23-03-26, 10:52, Lukasz Luba wrote:
> > > > > > How is that okay ? What am I missing ?
> > > > 
> > > > I was missing !SMP :)
> > > > 
> > > > > Right, there is a mix of two things.
> > > > > The 'i' left but should be removed as well, since
> > > > > this is !SMP code with only 1 cpu and i=0.
> > 
> > That's also why we sent out patch 1/2; after all, it is always 0 on
> > !SMP systems.
> > 
> > > > > 
> > > > > The whole split which has been made for getting
> > > > > the load or utilization from CPU(s) needs to be
> > > > > cleaned. The compiled code looks different since
> > > > > it knows there is non-SMP config used.
> > > > 
> > > > Right, we are allocating that for num_cpus (which should be 1 CPU
> > > > anyway). The entire thing must be cleaned.
> > > > 
> > > > > Do you want to clean that or I should do this?
> > > > 
> > > > It would be helpful if you can do it :)
> > > > 
> > > 
> > > OK, I will. Thanks for your involvement Viresh!
> > > 
> > > Xuewen please wait with your v2, I will send
> > > a redesign of this left code today.
> > 
> > Okay, and Qais's point is also worth considering: do we actually need
> > sched_cpu_util()?
> > The way I see it, generally speaking, the request_power derived from
> > idle_time might be higher than what we get from sched_cpu_util().
> > Take this scenario as an example:
> > Consider a CPU running at the lowest frequency with 50% idle time,
> > versus one running at the highest frequency with the same 50% idle
> > time.
> > In this case, using idle_time yields the same load value for both.
> > However, sched_cpu_util() would report a lower load when the CPU
> > frequency is low. This results in a smaller request_power...

Invariance will cause settling time to stretch longer, but it should settle to
the correct value eventually. But generally another case against util is that
it has grown to be a description of compute demand more than true idleness of
the system.

> 
> Right, there are 2 things to consider:
> 1. what is the utilization when the CPU still have idle time, e.g.
>    this 50% that you mentioned
> 2. what is the utilization when there is no idle time and CPU
>    is fully busy (and starts throttling due to heat)

Hmm I think what you're trying to say here we need to distinguish between two
cases 50% or fully busy? I think how idle the system is a better question to
ask rather than what is the utilization (given the ubiquity of the signal
nowadays)

> 
> In this thermal fwk we are mostly in the 2nd case. In that case the

But from power allocator perspective (which I think is the context, right?),
you want to know if you can shift power?

> utilization on CPU's runqueue goes to 1024 no mater the CPU's frequency.
> We know which highest frequency was allowed to run and we pick the power
> value from EM for it. That's why the estimation is not that bad (apart
> from power variation for different flavors of workloads: heavy SIMD vs.
> normal integer/load).
> 
> In 1st case scenario we might underestimate the power, but that
> is not the thermal stress situation anyway, so the max OPP is
> still allowed.
> 
> So far it is hard to find the best power model to use and robust CPU
> load mechanisms. Adding more complexity and creating some
> over-engineered code in the kernel to maintain might not have sense.
> The thermal solutions are solved in the Firmware nowadays since the
> kernel won't react that fast for some rapid changes.
> 
> We have to balance the complexity here.

I am not verse in all the details, so not sure what complexity you are
referring to. IMHO the idle time is a more stable view for how much a breathing
room the cpu has. It also deals better with long decay of blocked load
over-estimating the utilization. AFAICS just sample the idle over a window when
you need to take a decision and you'd solve several problems in one go.

> Let's improve the situation a bit. It would be very much appreciated if
> you could share information if those changes help your platform
> (some older boards might not show any benefit with the new code).
> 
> Regards,
> Lukasz
> 
