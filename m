Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16C47DFAA
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 08:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572923; cv=none; b=oDpgDKN14lPHgGwN5a0JJVLziFhm8vBiZoZUJgyVqznb1k2tyghd6fC6UD4pU7hdk9GxJROfANeEPQpF4p/vxFsYqFT+2FsZEQYl63YGLqQgvjyjw15E4AntkU7SP8GruXJ/QUrc6FzzcQUQ7Q1rMQUA2OsXIOVoRve/HszgL1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572923; c=relaxed/simple;
	bh=HRve7wISN1SNhRpN4L+rhZ4bIdfnZccVt4pYYR98JBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pftjFJNAczJtF6MsC9Oc1GvYJ4hVdEY5aCEE0nVUtKXJgBnC/Qb+9LAFnSdS0ZHTabDJfczrDZ2/Pn1dfQkJ5H1HTQx917zdkh81ZBBUd0dmv2p2AxkMmz+rVLv4o64RotrkPvWdxVLxsYwL6hvAQY901d8YMntLyBivdFxpTPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=p6FJ7l3D; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="p6FJ7l3D"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48d102471a4so51296295e9.2
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 01:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1778572920; x=1779177720; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j1XXmfhXa3+8cYJPPCDgRrPxl9mG1jVMFRcDSWwz1sw=;
        b=p6FJ7l3D6N2I+kgf8q59BfuKwzicPLqncR1jeJVZDNXMKhv6hpAnu1hP+VMvIawMhL
         BhSyZgWLOtMhSunAPsMgYOa/WseXDNDNiiAHsQVle+wRj0L/rM06RaajwJWwSMy8JXka
         ijQMMwVXg2wMJvttdPPKCcO6z1bPS9OCDyWnoZxSYp+XsXns9/jzQl2gsEvi69b0zGir
         RFHKX/uJZUr9r3aah0h1A1DnpULcx+JdRTsVW70W6IzQbRUkG6JB8/FMdsh9rjfRFiRn
         Ig3DNkH7ZyhVMFzjD2cYRk4VdZrekiuGiszjohuCypu775JOcleLV94iLwC0PkQm0gL7
         pa0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778572920; x=1779177720;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1XXmfhXa3+8cYJPPCDgRrPxl9mG1jVMFRcDSWwz1sw=;
        b=o05VCh9BLljLFkrTAhMaDhNSJH8oqxQHr4pBM5IzxRr6qWqxhagyyf5Hecte+jnl5T
         Eo+qOpaPEHByGzSpEB/T8dRuc8NVm7YbmasdRRrYLgfK5p/SV7+cCoyrfyNfh8vkCgMS
         d20uPCH1OORwNhS5PsUPPpRg3jR7dyRLGn3An/JL1w6p2K8kKNqEK1Kz9wZLmbzgdB8c
         Y8gP8oX96xi6L0hGS/k8h9WnlXU4OOZLnV1ZyaTjt1tc0pMmT5ZgUQjJmNdI0EbzYp2c
         yM5729vGDaOR2C3dpEjEdd6ggFlg+J14qCzZuZ64TjECKzxk9XKQr7P0jbBVDjh0Ar7r
         voGA==
X-Forwarded-Encrypted: i=1; AFNElJ/pMlHOSvhMlfsyCnHeG/z/LSQUneT/PYw0iYrk74yxeqBm+ud54+MsiQS9hJYMS6KAPF/n3PUhTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4QipcpevwFWCZVcu1QrQcuJp489jeByJOvNPDFmcDfOHfTui1
	/QVazLMHpCB0pxl3TrVlX51mZONe59hW6LALv3xZNd1GaUMUfwFzMfHifV8EeInr+gs=
X-Gm-Gg: Acq92OGm7gVepzAepzx1TCu8sSQ3ol0rj23t3B6oroqyt+F6x+55tdju50SZrWd3/7K
	NlUNoRkouUxA1z2P0X0mD0wcw9Xgu19VAZy3k7CCk+YsnP0Txiow588W9+BTSzr6OydMGC3PI3J
	x9NL6X8R3vixn8g9xkp1SU+vaivBWNH7FdCA3jGSUoUJ4kOjpfjbwLzkpmo3ClienvX/gfLbv+X
	zM1ht2Nl7pcPQWmgXMUcND6/8KXZFSkRP4w6Ta9lscznG1WUVGsereaXFdscSzCkcgt7bhhESDL
	sHXKuD/L1bwFuhKuhS1wt3+n7XP5PF1lOrIk7vW17QtA4cGE4EQf63M5je9O1tkohfte5AM1l2f
	KPx1W9W+rebVn5P6SMRrRlVXs2XVgt/ImeHt8Qn1zhSz8IHGYBnXr4mdAu4+Jppw3WQ9WCkdDve
	kWEIdt1VQEVnffpTTD
X-Received: by 2002:a05:600c:4686:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-48e676b6882mr283181255e9.26.1778572920015;
        Tue, 12 May 2026 01:02:00 -0700 (PDT)
Received: from airbuntu ([185.253.98.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e9053f690sm30133255e9.7.2026.05.12.01.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:01:59 -0700 (PDT)
Date: Tue, 12 May 2026 09:01:57 +0100
From: Qais Yousef <qyousef@layalina.io>
To: John Stultz <jstultz@google.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 00/13] sched/fair/schedutil: Better manage system
 response time
Message-ID: <20260512080157.ozdvvmezgkeurwbu@airbuntu>
References: <20260504020003.71306-1-qyousef@layalina.io>
 <CANDhNCqoqmU=xJJUhD3P5=5N=qqNNZ4DERezxecJ4HHuivRQpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCqoqmU=xJJUhD3P5=5N=qqNNZ4DERezxecJ4HHuivRQpQ@mail.gmail.com>

On 05/11/26 10:58, John Stultz wrote:
> On Sun, May 3, 2026 at 7:00 PM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > This is the long delayed follow up to the series sent back in August 2024 [1].
> > Life got in the way to some extent (I had a baby, and now my time that I used
> > to do upstream work late at night was stolen :). Apologies for those who
> > replied and I didn't get a chance to respond back.
> >
> ...
> > Open questions:
> >
> > * The details of the QoS interface is the biggest one.
> > * Would debugfs be better for setting the default rampup multiplier instead of sysctl?
> > * Patch 13 makes updating load_avg unconditional not on period boundaries.
> >
> > Patches 1-3 are prepatory patches renaming a function and introducing new ones.
> >
> > Patches 4-5 handle the magic margin problem but making them dynamic based on
> > actual hardware limitations.
> >
> > Patches 6-7 fix the black hole problem and teaches the scheduler how to handle
> > bursty and periodic tasks via extending util_est.
> >
> > Patches 8-9 is where I expect most of the discussion on as I introduce a new
> > sched_qos interface to support the new rampup_multiplier to help manage DVFS.
> >
> > Patches 10-11 introduces a couple of necessary optimizations to counter the
> > power impact of increased responsiveness by disabling some features that we now
> > know how to handle better.
> >
> > Patches 12-13 fix a couple of issues causing util_est and util_avg value to
> > swing for a periodic task. Patch 12 must go via stable.
> 
> Just a minor nit, If 12/13 are fixes, should they not be at the front
> of the series (or possibly sent separately) so they can potentially
> move forward while the bigger changes in this series are discussed?

Yeah  my plan was to split it and repost it with proper Fixes tag. I found it
while verifying my patches so lumped it at the end. Will repost as soon as
I can.
