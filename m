Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC7D1AB6F1
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773728465; cv=none; b=ldcM3F7xLlVFRT+Uzx3BrU8f+V6KU+73CHQn6WxhR04lWdP6GcfxnH2ChfcFhrmxfSKfv4DBND6/nb/53YT34oLsuvZz09AuD1yKKMV631YXRWF3gp9sS4ASx+sg+fZu+H1RRqenioXbYOCHcoOdEtzvc54MidHvs24Q17UiQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773728465; c=relaxed/simple;
	bh=Uy1IbOQHlKPVOJmpyolrrv4g+Yvp57Zkw6XpvDtW07Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WshvvEsYVCKF7KfAZ5vk3zCmtCmDkn5hkt4/ancO8zQ9Tuko21iy8ngx9cz/P9Y+hk0IgyDwGbDBqr0MHtFrxYXQDxM9+70nmp6i/8daHerPbjINc8tHGPkjbiNqfkH3lLXh7LegNCY8jXRr/o27oMbSsDQk6cAw5MbZKdwc3/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TorgQL1B; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TorgQL1B"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so2088064a12.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 23:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773728463; x=1774333263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6nMaG1qGA6uaqs/VfGYNa7QijWCCliSoFjE/xNS5Mek=;
        b=TorgQL1BWk2pVj7F8vSveEU/zuCLryP8KPjVfEGHNOipM1zFt7mib88/ugvhzJAAC+
         bJlGu+cgj6/9g9QLX0h7CLF65tApgjzA8FQE4xDl6KjhnC61d/3HU+7T9vPHDr5rq+8b
         zpxZ3+mpBmllM6R235G/T0sTB3U4j8czm8GkZxbtjaxnBaJ7rVr2IIbz6Q7n6GI0LxUB
         PhD4bgvWDO9xQnkE1SDkP2ElYgjSJmkdM2aPHdU6gR5aKJuyVhhUKA+r11KQqbLXnn1K
         CjY2talkwMRXBhnRdexawJD7rUF0sBWiBPjU39BpLFyuOJBVVfFBoN8jSqa0n53Ucqne
         U9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773728463; x=1774333263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nMaG1qGA6uaqs/VfGYNa7QijWCCliSoFjE/xNS5Mek=;
        b=r3bd1gKfUkMISkc8FAKTktazKSDWCgugb2gEwN8WLr7tgbjcQGbulNQnKMOq3b+Xlh
         siNLEtmJjbSF2LuJlpo6s7wQL9o4ELctgMlt/Uhz1v1iS6Ntv2fTlW8N4vp4f2ld3umK
         rctiRvzeI/2p7yMwxlUkMWIEnHgjw9HOrDE7Y0YJ8RZNdpyXBrb4e+A21t+v+57m10SE
         zK4MoNDsyzxkqJeC98H4fLwgxfpj16Ub4YuJLhUmLZlQlZ0w468u6RWvBK/P6lQOkqjh
         yHyvPbH6K3rf65vvCPlbewSeISS7D7gRX4Z18eh/tL1eJGJ7hT8MLmtrEYRqKjU4YUfY
         ueAA==
X-Forwarded-Encrypted: i=1; AJvYcCWE71rMRVdYxzdMASDGCnIo3Szcn6uPHp81h+O7o+5vTZhpdIh7jhj4EQ6f8z+d+2hAl1LPfzx7ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKsn2bS6pWNlWeWvDoAHRU9HX7jpx0aFRVlcKiF3uxiJsX5RUA
	45rsPtoTQ5Ofq7YzhkTl5aZznj6ol62yX/2lScHmsL/yjpliSKfRuMxD4oZQM1XZhaw=
X-Gm-Gg: ATEYQzwIZhjtvVrWWxms/OQ5m4glYNkPJ+gQQR5KYMxw9M3jG2QycwMkgunlD3wJlC9
	2ou+esGkPOJxbtALlFKrdsyn5bTTlWyJO7EVe6gnkVgqi1O3zIVVPVJUH3zha8nksbHr9leTYoZ
	5pYL/GQSZJqreD2DQ3ItG1rrIgPsZ0IIr5gFoVlPpIBCgwnoqCNWK7jz50NuL4MVLXqeqxLtzCw
	A1TAPM/yZwI3w8Dmc+n0eHxMIngDbZ03mAth0yD/urMujJhuy8qWiyXduj+fUJChTFp0B3DWTrz
	TX/MXc3/I119x0H43iykzw0YMGKaKKec/PzI9E72qimBal8kSky2QOJbH+hT9yBn0n4ApXRtb2A
	m1mnJyTEV9a3uALkKS4rRDShhuLXW/5fS+blTb+vMo6D2kugQ+WvR6NPpbRA99fNYwfgksBcc7C
	TJu8e3JrmX53hzOWjC16vlzTXZ
X-Received: by 2002:a17:903:234e:b0:2ae:56bd:5318 with SMTP id d9443c01a7336-2aecaa40072mr138771595ad.22.1773728462995;
        Mon, 16 Mar 2026 23:21:02 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06272ab03sm20780235ad.64.2026.03.16.23.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 23:21:02 -0700 (PDT)
Date: Tue, 17 Mar 2026 11:50:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxarm@huawei.com, jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, 
	lihuisong@huawei.com, yubowen8@huawei.com, zhangpengjie2@huawei.com, 
	wangzhi12@huawei.com, linhongye@h-partners.com
Subject: Re: [PATCH 0/2] cpufreq: governor: Apply limits with target_freq
 instead of policy->cur
Message-ID: <uo46emkyvpr4lzvnbdlkcgdrkvdzolkwuiqqey3pu3j3qqrbqz@z5ezeqhowy5a>
References: <20260210115458.3493646-1-zhenglifeng1@huawei.com>
 <javy6tllyw7pcnri3s6s2gnpv3kewe2b4zkyoz3vj3jzmfu6c5@nikhlydadvcc>
 <CAJZ5v0h1FHH0Cvn0CQ8gMk9Zzt=bcA-RUfya4hYH4Em3nDzm7w@mail.gmail.com>
 <d21b9ad3-72d9-44b2-b194-4e2a24077eab@huawei.com>
 <utvxk3rn6icadx4llmzfu32auqk4ql7rckh7kxtgdgmtoyovqz@vo2lmhip5vk7>
 <b7d3819f-168a-48f7-99f2-2ba04dec77e6@huawei.com>
 <dqyn4dv3ecbzzmqr4l3jxfctuxpehstjhean5gi2iqfllwso4g@i4nodkyrhwpb>
 <8f29a0ce-4cbd-4c47-b866-b4f015f0792b@huawei.com>
 <swdjuguqfniecaqxgdjwihjieiwdzxjv3vq2agq5sbd5kcftuz@qwzhr43ydzxy>
 <08b96039-e31e-4278-8077-1f1b7c244f3d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08b96039-e31e-4278-8077-1f1b7c244f3d@huawei.com>

On 13-03-26, 18:12, zhenglifeng (A) wrote:
> Let's forget what happens on our platform. The current discussion is no
> longer about applying this patchset. What I really want to discuss are two
> questions:
> 
> 1. Is the platform allowed to adjust to frequencies out of the limits?
> 
> My answer is YES. policy->min and policy->max can be modified by the user.
> policy->min can even be increased to be as large as policy->max. However,
> due to some other limitations(temperature, power, current etc.), the
> platform sometimes has to (secretly as you say) reduce the actual
> frequency, inevitably falling below the OS's frequency limits.

It is fine if you want to do that, just that you should use OS to make that
change.
- Update freq table to contain all valid frequencies (1/4 of min in you case).
- Update policy->min to current min, so you don't go to those low frequencies.
- Use freq qos or sysfs to change min/max when you want to go really low, like
  1/4 of min.

> I believe
> this situation will occur not only on our platform. The OS should not treat
> this situation as an anomaly, and leading to unpredictable behavior. The OS
> should have the ability to self-regulate. I believe that your patch is for
> this purpose.

When the OS is kept in the dark about such a change, it needs to figure out a
way to get back. That's all we are trying here.

> 2. Is it reasonable to update the target frequency when querying
> cpuinfo_cur_freq?
> 
> My answer is NO. The idea that "observation can affect the outcome" should
> only apply in quantum mechanics. If querying cpuinfo_cur_freq results in an
> update of the target frequency, it means that the target frequency should
> indeed be updated, regardless of the query itself. So I think the best
> approach is to handle this properly in gov_dbs_update(). But I am not sure
> if obtaining the actual frequency in gov_dbs_update() will burden the task.

Exactly the point. We have chosen to do this only when cpufreq core gets to know
the real frequency. Reading current frequency is a time consuming process and we
don't want to do it unnecessarily.

> Perhaps this is why target freq updates are made when querying
> cpuinfo_cur_freq now. But this does not mean that it is reasonable. It is
> what you call a band-aid I think.

Of course it is a band-aid. No doubt about that. It may not be the best way out,
but it is how it is right now.

-- 
viresh
