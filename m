Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2645368976
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776187545; cv=none; b=U2YVJA3fZrnh1PTOKMA8/1FSiUKmBBjRX73bDdzmVJ4NbiaaETi/G6sAG44R8aBHmBl/njY/iZ5lbiA6cmj3nfVHrauWdf+7XViJLxJKzIUL1SC1eKWHuoSM1nt4TKJiQQOM6uc2WSXyJ2zg4lsMi5a4k7ouUcemCrFljZq7YvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776187545; c=relaxed/simple;
	bh=Q9Li6IEfFolCG0UHL7CcRmbINp9qWSGmAYv9wveCFmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZGOCqQZ0W6oIQzDmUhnOwcxd/RKGnfaRy73FHKuTmH0GhdrKDUdx0wxiV/MDo7XojgYh9iDu1eKeACUsZw2B7wOcqtJ72s3GE/IksiOTsIrYKxahnAG3n8lGdhg3pQHaXBfAttwX06cMWMe5lL5h3ovvNs+KUbOcSWOKmYuLAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=XCG7he9g; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="XCG7he9g"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c565476d7so3065619c88.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 10:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1776187539; x=1776792339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v0I/6gn6yL3+F/vGBALh7XtrJMo526TaxSYPqk338Bo=;
        b=XCG7he9gu5CmHUOaYVyo/KsBRc3L1Oaz48GijqjD7WqC1zm4NYbY0Sgyz0CRFHYqTh
         6U7Ewt6HUoKacTF7Oqpo5/Yc+KqvLHxyIRs33HFyhUEECMDB3cSJO9enKKiuV4BDIjMC
         w049v07J+r2JrHRSN0CNG75T4m4itaF+kTaCK+pKj+dTvLteBGjVG0QF1ZSMGkJjH1zO
         Mo3ji9BjDTYtSt/sRwUyF3NZbVJR4ERPt3YQViRLZxKRD70Z6HSoClxzpsfGkiUdyQJv
         cz4LQmv2H5YnWWPVgy+tF8Kd8eRmoVdhyVVXMBpWD165F3AE3T2MoecHp8zlHJNsqgRa
         jWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776187539; x=1776792339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0I/6gn6yL3+F/vGBALh7XtrJMo526TaxSYPqk338Bo=;
        b=BTGyHv8+JqvQ/HgFnw9ozG+XWyTgDvcoPCkyD1iY8Ddqdg+wRQ2xs8jtr6rnjd/pFt
         JkzDjGtAsXK1aghiE+PtJYiSO+XM3/V7p96qbhDi+Igs3C7uIJXMyLewzPTGihFiOimD
         oFWw4AvL8b6Wgt9mE/XtqTXIJ5uEE82xtTJ22+MAn4R0xITXwQPaMjrJhASKrSM57ykI
         TbXfBW2WXi7HgnHCmMD3f+8xUSfB5dTb22AcwBxrmrlYTMzpYzevsZO59DTyIcSfEkMU
         uL7OcVldSa7psxFco3iuF/YZacck+xHmZPbKcf1fqK+VtH9nwpD3YNJZkckxH+nwXZ4O
         OMMw==
X-Forwarded-Encrypted: i=1; AFNElJ85/emJsWM31JhHQ3KTrAkmXZRPcKaM208mgT00Q5WQHPDMw0GVmGp06JmT+nMeNabQHYvR+876Hg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7GYoILT0LQy2hrn4Mt2W8LbojFS80ZYtKHBi5l4E56vils41k
	QskSgvZoMPMBxPu2vOjMeGmodlklRK4HDnxbMc6/2p8SsW2KUAm4zem6GD8k81tr/Pw=
X-Gm-Gg: AeBDieuaEaZOm3hHoPyryiwEbsTnqNG35i/9JFggNvZyn2y9d3fakwqLz6OU9C85l9c
	utW+he5I3tMpN3PQ46ZAjqMwLYGLHkhZ5aCRhRJjsX2K4VfM4QjOLmpi4mnO8b7QlluAW/mhElO
	0/ErMU6v9Vhi8kYkuA3Zb/ZWAf10wmE9WbbMgMrInIwSMZ7HwlIBRNILRPqeWm0MGc5dHm8yD1E
	WBgzAerKMoMWQMawi82Jczp+uKH30MM171lQDAeKd2i0XR/UPaujNd7kLqrSRoYTOgS9n8I6GYZ
	eq1dXhOHwwTtqBfs6GmOKR1jESeiAuwtAmZqeL/lOIyETqpacWxGK5HH4XLQIngmR1/qA64apIB
	K2f2pVkC9J/HjO2dwAjK7PhR70XVyF9qJERC+DannO6kUB4yUziuhTWuSx0AoYpwRIzj/7ACfsd
	ikc3C3YVkxGWWM5x8uqjTuJkFC
X-Received: by 2002:a05:7022:eac5:b0:128:d2b3:5df with SMTP id a92af1059eb24-12c34ecea05mr10134040c88.23.1776187539356;
        Tue, 14 Apr 2026 10:25:39 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:93b7:bacf:b594:6a9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d940083f49sm9555914eec.13.2026.04.14.10.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:25:38 -0700 (PDT)
Date: Tue, 14 Apr 2026 10:25:36 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Eric Naim <dnaim@cachyos.org>
Cc: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: The "clockevents: Prevent timer interrupt starvation" patch
 causes lockups
Message-ID: <ad54kGakZkvCoRaT@mozart.vkv.me>
References: <20260407083219.478203185@kernel.org>
 <20260407083247.562657657@kernel.org>
 <68d1e9ac-2780-4be3-8ee3-0788062dd3a4@gmail.com>
 <aeb848aa-404a-40fb-bd41-329644623b1d@cachyos.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeb848aa-404a-40fb-bd41-329644623b1d@cachyos.org>

On Tuesday 04/14 at 15:39 +0000, Eric Naim wrote:
> On 4/14/26 5:20 AM, Hanabishi wrote:
> > 
> > Hello.
> > 
> > Sorry, but this patch as of 7.0 introduced *severe* periodic lockups on my
> > Ryzen 7700X machine.
> > I see such messages in the log:
> > 
> > clocksource: Long readout interval, skipping watchdog check: cs_nsec:
> > 2897344852 wd_nsec: 2897356996
> > 
> > Reverting d6e152d905bdb1f32f9d99775e2f453350399a6a for mainline fixes the
> > issue for me.
> > 
> 
> Hi maintainers,
> 
> several users from CachyOS has reported this regression as well. We landed on
> the same bisection. One of the users that could reproduce this reliably
> reproduced this just by watching a YouTube video in a browser, and observed
> freezes and stutters when interacting with the system.

Huh, I can't reproduce this at all across 10+ machines. Can you share
the Kconfig you're seeing this on?

Thanks,
Calvin
