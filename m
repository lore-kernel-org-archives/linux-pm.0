Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAE238D015
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333207; cv=none; b=u1oqod+lsymjnBssHRxWbPh1nBUrImVfDuXFqbsilnJ1tWL2sZTehtBg1+ANoQfgIvn7/q2MphjotaoS4Nu6BiU6V7+dCIGPWBOTZHlw/cxGob0ujRV5ylNltLNQbqmuSt31KjikiLRDL52b0vJTtqfCDfu37ItHQ9j5cAWTDN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333207; c=relaxed/simple;
	bh=wmdel3mLs7hC9M+p95swPF8NrnocEAFig5U8QxTxaUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gN4jvxOm8nPT4orm3pv6CE315mkJj7lgTN4vBXmS8bDsWigUyjWIulyFRnX+vLleYe6UuoPc1BfiR/hXSNg3qWy/6ODZk4c/Dsfux+gm6MUOxW/9Y/GnUoCZQE67p7Idshyr9ha3bGTxZm0A5QkwhTXZUlP8ZLNfLB0LO0vteMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H4DwZ5hL; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4DwZ5hL"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-829b2018c94so797793b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773333205; x=1773938005; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BS4CcxSSZCC1r8MCRuXGoAWgXYra1zd0R2atasHTer8=;
        b=H4DwZ5hLxy7iwpCV26roYPPhCc0jJ9I0LXKpJBzb+B4y3RNxm3VtSARX7FdFZeqhJX
         9DYFelocbPez7qL0Cs4VkTRv04lW0/7QUWPKIJe4nX01s45yqdf9X9CjlqpPoLqhegx2
         ykeVZEblP4tMBO+wT60LPl1yp3KH4Fu1y+VjUP3csFhepCmBo4dMVOHZEMcEADvrxv3X
         npLhiJ95ybAXwWa7w4H7JkemzkH2rVsVW26XWi1ogzK6W6SoU1FgXkEzc5V5RApc8ppg
         pRHeLG3BXUoiDP/WZHq1K7P5/orgoeh+dBQ1EZHoFQ6B82T2vTubU6yQUjWmmyzivJDD
         h/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773333205; x=1773938005;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BS4CcxSSZCC1r8MCRuXGoAWgXYra1zd0R2atasHTer8=;
        b=pZMXipJrJjZS9BVq34myrGgvt2Rm5ZFD0t5QKbg5H6dKeeCRF1YFBAuchjuCV7EuMt
         Al4y79Fwo15PkabKRtZ7CUt3G0KSGNyqmn0C73TpL/LoM45dZwvHzh1VLSso+XkhjKgY
         ENMljZk+o0dItPRFpyrHeVxg/kHMUjTSDnyDkj2BG+ceNecXxx3X+zcFVoX/ep7neHhU
         nmqLuRfBhP/OWfTghpBnkZ0ZrIo4nrNFW6/t1UrP+X7fvGcvQAiS1maJGzBBkR1PMvz1
         ksZc3k1a95EtXlRu37c2AKVtQbd/ROGAu5g+7SMJZv1kvK9HgaGWWIX2KnMOKZw1IR0q
         D6AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSkenCCwN6yEcfxlRxrZfT2mx+E6j6LG+kp0zBEISDM7qSPvpghTB2I0ql6GTFxv0UmLgNoRhZwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YziSHenNDyW9TExMbrLwZRJt7HjQ9f4pboDZmtQHPq733SUgRCq
	3gC7Tw2mEJrsJqijajlf/vkoH19CN/xp1GZLD7MuWovE8oIq80M/bDXiVfmTB8y568Bctbs8bvG
	zsuXS
X-Gm-Gg: ATEYQzwA7Z2J3eLdjfvo12vl9H2wAMOfWj3HYWg1MONKM9euqO1awXGQXBteVq94p4L
	M5Kk6VQ9zkbRUiSyaZlbds/YwmVWO4qP5Zsmhhe84E9grhUlyYJyPkDPTb/Epmv4mk0i/LdiaCA
	j1uWTMhO01xrOT0c4xAtA8w829p83aTcPtyvHzXugfd7P95dlJYH3IlgA5NCD/4ueKm4+pmD2eU
	o2u8ZMpS/LnDX0AwPmXRxeG+5swFUv+FO4Uo+Y/EAJ9MS6/DPgPP4roXjg7cg7uWK3cc5kFz/FN
	vAOx4vFyFLpD7uqMc5jzHHLfOsbN3JUAkla5jJpQ8A/EFqo7GQ917ItyOqpt4EsbGpkuLRdCs36
	rG8exNt5e5s7DgbFKNg2q7b5YrNNGU4rDAlohMeBqJCGqtqcDE9DvfRspnxIG/jmbW7ZA1gvWN5
	YiaS2aFBNQsCC9cMrIhxbkoSj2us0RUwqsb4A=
X-Received: by 2002:a05:6a00:9501:b0:801:eee2:45b6 with SMTP id d2e1a72fcca58-82a19703e5cmr154010b3a.24.1773333204892;
        Thu, 12 Mar 2026 09:33:24 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0727c1d2sm3474255b3a.25.2026.03.12.09.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 09:33:24 -0700 (PDT)
Date: Thu, 12 Mar 2026 22:03:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: conservative: Drop cached requested_freq
Message-ID: <i46fhgpoq5vtijgpzlp43g5zhwjrfwu7c7n6zxsxkvwabqgqof@xfqzbkwmdvpb>
References: <c3e22128e6619d24f3fc6ac07d1c854c664a7f1e.1773124395.git.viresh.kumar@linaro.org>
 <05feb9ed-3257-452e-98e9-89637431a347@oss.qualcomm.com>
 <u4k5z6yilgjqajy6a4zxyt23tgmtp5hxqm6jlc55y2ize4rs46@3czv7uoybqbz>
 <CAJZ5v0jvVNd3v_LcsM9Q2tZRavx0OQwZ-R4vWSzYr6edinRk4A@mail.gmail.com>
 <z33jb5vwatwba24f2ftz5zb75qzqv7h4tljq72bwbvgphuvuds@jtxtl7geedtb>
 <CAJZ5v0htdQqaQT+-FJ-Agt4aAONXH36Qg2htoo+onLmst0ZoZg@mail.gmail.com>
 <laiiguxeqjrxk36txx3g2ij3yzz7aldzcnnqoxdv3m6pjo42vz@e6a3mvnusqrx>
 <CAJZ5v0hM8wdug1xJ7j0sdVG+=xr3WcJ8OpfRDnmSOt6Zs=h36Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hM8wdug1xJ7j0sdVG+=xr3WcJ8OpfRDnmSOt6Zs=h36Q@mail.gmail.com>

On 12-03-26, 17:27, Rafael J. Wysocki wrote:
> On Thu, Mar 12, 2026 at 4:59 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 12-03-26, 16:43, Rafael J. Wysocki wrote:
> > > But how exactly does policy->cur get out the limits?
> >
> > From the first email:
> >
> > "Later, some frequency division strategies on our platform were triggered
> > and the actual frequency become 500MHz -- 1/4 of the OS distribution
> > frequency."
> 
> Maybe it's too late into the day, but I have problems with parsing this.

:)

> IIUC, the platform drops the frequency to something small without
> giving a notice to the OS.

I think so.

> > > I guess there's some notification from the firmware or similar that
> > > causes the limits to be updated, but the only way policy->cur can
> > > change is to still fall between the new limits AFAICS.
> >
> > AFAIU, the limits (in the view of cpufreq core) doesn't change, just
> > the end hardware frequency changes without informing the cpufreq core.
> > And if someone tries to read cpuinfo_cur_freq, cpufreq core tries to
> > get everything in sync.
> 
> In that path it ends up calling cpufreq_verify_current_freq() which
> invokes the driver's ->get() callback, so I guess that's the one
> providing the "real" frequency.

Yes.

> Next, policy->cur changes via cpufreq_out_of_sync() and
> handle_update() is scheduled which ends up calling
> cpufreq_set_policy() via refresh_frequency_limits().

Right.

> Say the limits are not updated, so we end up in
> cpufreq_governor_limits(), which calls cpufreq_dbs_governor_limits()
> in this particular case.

Yes.

> Next, cpufreq_policy_apply_limits() which should squash policy->cur
> between the existing limits.  Effectively, this means that policy->cur
> will become equal to one of the limits after that.

Right, policy->min in this case (where we went below it).

> Now, IIUC the problem is that a change of the limits may not be the
> only reason why requested_freq may need to be updated and adding a
> .limits() callback to the conservative governor like in your patch
> should address that.

Yes, it hopefully takes care of all the cases where policy->cur may
not be equal to requested_freq. If it is same (or close), this change
won't harm.

-- 
viresh
