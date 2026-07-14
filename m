Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C843EE1E3
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038100; cv=none; b=elRATwgHVqvWx2cLHn2QGFBNkbRLaM0CuQSdJR641KSLZI8E4aZtOoNh/RWuwk4HWrZ7t1BKjlSnS6l7vLMLUK5+L/kmYc7nsYS7w7PGux/zmmi0uqneJUCGx+IK4MKNHtDRQWsfomHx78jymTnkf6/r+ux3afhtSxni9vqZ4no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038100; c=relaxed/simple;
	bh=khX7qwLar0Mqdb8aPNPxZc0r4Kjxgk6Jqdabvxkd/zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mm18NgaLkT5fMoZEY3uVl7kl5iJN1OupAbd4hcOaVqIOeeIBvC0dh5LnhB1Hqi/kBz1XkN+zBstVSzdXAzXYnXSOHVb8JmVSZgMSYiIvVLrQa4Dbm1vTTvF45aQuoaTZwtrWMukmLx9pYjHe5hZ2OozY1jnN45qG8tf6YHHr5dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=pQ0hyung; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="pQ0hyung"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493bf73ec2aso29941995e9.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 07:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1784038093; x=1784642893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=geXw4PgN0i1OJ8WapCgUMy+MtRjT8+wA34P2h9GtemM=;
        b=pQ0hyungOkUr+o8fx136OwysrsqZ9japlFb1EKHKCk031YDP09TMX9Flego7V6QQeM
         KfWYhckcYiEKHjcCMEz18k+W5RLqqBCytORVHkt43k4tlceyw8h51HMPZefi2zZRzC7J
         9JYe8eMzwXoq2XP93YkOg1mTXk8wsb8HvMYZ4L87qcA9lg9f9fDhn0SeZbb3x6+ZTTfh
         vrgFjuTm4+wnsKCA1WOvjzJX8uVOWwSJNor7rpXjmyPk+QfD922PiJorqUSKXrjcGuUK
         Z7cW41P0UcDhAg2CONTooVj8nR5iaufMmv730gr21b+9ELm/2c1Ado+pDIj66YcQlTdG
         3X1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784038093; x=1784642893;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=geXw4PgN0i1OJ8WapCgUMy+MtRjT8+wA34P2h9GtemM=;
        b=GroS8P2i7BcsIeQ8mu6ATL67bFf7+US4D8LtMicnnAhAhI2ZLh2OlOKtimC26No5tL
         5c+54BD1tKJib+OFF5UfVKwmaTMgWGXEQvcgljpKmbk2lQ7NwwBDqfSDUPrDusDaMV9y
         4vYitLohmDSdb+3Ors7dyWyucCPYPcQlG7SU1PoAkXijSbErFFaiVY+Om8DKzuOeJVXk
         5rB2SY6ZCHFiOsgRT5xVJYMHCSupWIiLhyHrPhNENbTPDa0+P9dc3iWfEPCLRr1ryags
         s4QGYXXP+36TXUZRKq2wDFG1GSAGF+h525/hl/Rm+7w2AIsTs/dd7eavyf31lXR8d24+
         LEyw==
X-Forwarded-Encrypted: i=1; AHgh+RrbYNeyMabnnfzzQjpRqZSB5gW+92tR6qVZpIH7rqMV0U7EW8AM4+spsj6jtRAQQ19DQQq1JP6r2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZavJb9skXO98f4UAW1vUsXaDHAzpl+aCinnciMcchxjYdQgf/
	kdyrO7OeKxduOuNoCSxveTNNNte5xyri6lu2E/LmxQz1tC/tSOc/W6I3FHjEmtW4sv4=
X-Gm-Gg: AfdE7ck2SFvvRRCyE7lcro2CVuwrqasHqsY1TF91pXH6+VsfYbYBFygs6F0fV6jddSU
	caZj0nX7TpX3cla+YxrHgJlSSS8IT7AGsfbxqFFzvM6hOLCTTxHfytiEgVRASgc/Cq00C77KJpw
	zBjB4H/cxvr8vRdt54Xi6X8hzjGPLbxwqhizf0N0rGLwQ10U6dyYV/rCnQKw6BcxvsDduJTekyT
	BchVIF8JOdjPYjWjuKWWs6qC+MTkLNzyo6glw14xW6yOFv8Xn33aG59mZQ25S1Cgw/FFmTchN+Q
	qQFpDq6bYJRzoSCcpazHgXmFdpvY3Duu0vjrHMD2pp3z1KVKRNyKCrT9S2Gppnq7CFraJ8LIsm6
	zOM603b2zyJyfisNDIQrBcH2RdFeO086VrBYJeOdcQ+35QmWWTukrSlzgaZ1xSbC42Z4XpNpzOA
	Gaya6fhlmrVr+ftrVJyA==
X-Received: by 2002:a05:600c:6296:b0:495:3aac:1098 with SMTP id 5b1f17b1804b1-4953aac1123mr6062045e9.32.1784038092955;
        Tue, 14 Jul 2026 07:08:12 -0700 (PDT)
Received: from airbuntu ([149.50.209.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a33a926sm70929785e9.15.2026.07.14.07.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:08:12 -0700 (PDT)
Date: Tue, 14 Jul 2026 15:08:09 +0100
From: Qais Yousef <qyousef@layalina.io>
To: "zhidao su (Xiaomi)" <soolaugust@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
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
Subject: Re: [PATCH v2 09/13] sched/qos: Add rampup multiplier QoS
Message-ID: <20260714140809.bs7qimvcvfgk6nha@airbuntu>
References: <20260504020003.71306-1-qyousef@layalina.io>
 <20260504020003.71306-10-qyousef@layalina.io>
 <20260618083005.1432882-1-soolaugust@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618083005.1432882-1-soolaugust@gmail.com>

On 06/18/26 16:30, zhidao su (Xiaomi) wrote:
> Hi Qais,
> 
> I did a bit of testing on an Android device running
> 6.18.20-android17 with UTIL_EST and UTIL_EST_RAMPUP_ZERO enabled, and
> sched_qos_default_rampup_multiplier=0.
> 
> At the scheduler level, the behaviour looks as expected.  With
> rampup_multiplier=0, the worker's se.avg.util_est stayed at 0 in my
> runs.  With rampup_multiplier=4, util_est became non-zero immediately in
> the high phase and reached ~1023.
> 
> For end-to-end behaviour, I could not get a useful signal from longer
> steady CPU-bound phases.  q0 tends to catch up via util_avg quickly, and
> the result is very sensitive to the frequency state at the start of the
> high phase.
> 
> The clearest signal I saw was with a synthetic low-periodic ->
> short-burst native workload:
> 
>   low:  periodic short work + sleep
>   high: 5 CPU-bound cycles, no sleep
> 
> Each q0/q4 case was gated to start from <= 940800 kHz on CPU4, and the
> worker set and verified the QoS value in the worker thread.
> 
> In that setup, q4 was faster at the 5th high-cycle in 7/8 paired runs.
> The larger wins also matched q4 reaching a higher sampled CPU frequency
> during the burst, e.g.
> 
>   rep3: q0 691200 -> q4 1344000, c5 delta -41.9 ms
>   rep5: q0 691200 -> q4 3398400, c5 delta -79.2 ms
>   rep6: q0 691200 -> q4 1344000, c5 delta -91.9 ms
> 
> The main negative case was consistent with the sampled frequency state
> too:
> 
>   rep1: q0 2083200 -> q4 816000, c5 delta +34.1 ms
> 
> So this is only a synthetic transition-workload data point, but it does
> look consistent with the intended periodic-to-busy transition case.  I
> would not interpret it as a general app benchmark result.
> 
> No Tested-by tag from me for now, since this is not broad performance
> validation.

Thanks for the running the tests. IIUC, you're reporting that all is good so
far.
