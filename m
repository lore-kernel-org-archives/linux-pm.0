Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C317A424642
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791527508; cv=none; b=Qoqc1avBQ2WOD/xAXW78ZrwywM8LKiDQFdr+PZ5zgpjdYmF83etsIJ/2KNN53HlKfsnROS2wd4ytM+3xkigx496YKYL5ypZTvzqQB7PfCql+EWY35H1MHpF1q4gbUz6mcgwg6UsBQlSEh4KPihq4uYWoOrKORsYxIJdEed+00PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791527508; c=relaxed/simple;
	bh=G8p969TSPt4pRVkrqnzxS3mmH3ELFFspsjEpF+ZfLvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZipEzYgDal9mfM6WCFZ5DbElbT7dbwNAEy5y391gbolYdmSnt68qiJ152aHZ49NbUyuTWl3aVn5vMJ92IHRVA/aNvVGXv61mSJiKHxezcr37HX+l/HGBfeIfbeZCGXhc0RRWBm9lejbVVKTN01BPYZfM7wZGWPxqk9Zbre5x/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vi7w+Jv+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vi7w+Jv+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49e6b771d06so4457715e9.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2026 23:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791527505; x=1792132305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/prsEyltlekkl/5pKA40pBQXK0nwU4kVOsJT37viE/Y=;
        b=Vi7w+Jv+kTuWpR2zqD04rBbY+7txxW51rM9IshH9lE7fgUzp4+T56d8m5wYQ6coNoW
         fHljJAaZNSf7Z2Nr58vw29jH5sG8ehtwOxqduznxl7AbS6qFNuvCFCQLRkIcPt43FKWM
         Jjy16DohP+I97Pz7ieNfHjBKmLXkMLaqbJUjMsfVr7j8r4vj6Dy5iIJDGLtO4IdciCNr
         5s6Ab9/KZ7PcmnFrM9Ar7l8kmTLhUx3pEZmNBb4KH3WTO267cPhKPowhCFYTnhKkXkWl
         9jVzGgZ0X9SCDYeo2dlH2a9y9YyktCwAHFqRL8TNWyneh6UGf5K68WHOmj2cViakN/3S
         2upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791527505; x=1792132305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/prsEyltlekkl/5pKA40pBQXK0nwU4kVOsJT37viE/Y=;
        b=lThas5Dgv1D5I9+J/zWr0Z8lQdgN12FfoQi18AskswQS3uWzDGFpOC/wlccnrr7Baf
         pJxGNVxwyAIyo8zcMwvCRjKRL4c/MGIyQkR4HcTtFcWsVNg93TzPWCoYIZIsh1O4AgPs
         nAHYt2RPfHdAJcQCv6TdL7w6ha5736BtWoTk56ROl7gSUepLMbbOXECUIO8gbUpGzLXy
         /HwGs++/SsJziKY2mn1hmWYUIx2B5mesmzSMLoACiJpifrGGjHRQiXGXz8uHgmXHqPhx
         7UTIk59z0cnLfV+Ej2L7sxuIll4p67cFE3tJMwVwp7DroduY1fn+pDuG4G4mL067o7Dh
         /yVw==
X-Forwarded-Encrypted: i=1; AKwUvBwxkzzGCNb3ZS+vwJYOqPahn5yDE3RjWePFPr2NSPZlGkbV4JRtwuYoKIecYmdqRyeq2iNH3L53TQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nKWyjBQUtwMZWz8ZrwK3uOZTiL6ueWnXcrkieu5qX678Mzpy+M
	NkD36ZpPfYuUfy2UhzGg/8HpAvdCqTxIA3dw60fVeWPBMqVV8PuojMtuj7HVaQ==
X-Gm-Gg: AYBFou2TNH8Ziudu5q+EW9c6lcWY+0r+VFRh7VvMZ0fXL0feCiC2eIUqhaiapf1YqOl
	xnELbLRfTNN4cxIo7UiJQTI/UFvVpOQSMqBU71fk6TWi0ZUOQz027rMEhn9VuqdiZD3G4uPZGJU
	2Lkmw0tdNQmkIibpoglUAkhkEj8U3eJG54o3wXCVcGmYKpHh587meN68+Ec2jT2kSTucOukxBZf
	D5CRy+LlGj2MQHhmJNHwnmJkz3PP2HUBIZSl9Fypn6o/q3v2Ufuc6tU9g+wzzFPhc0gSMYEdgnY
	qzPnZWotN0WyaFOvYx2cv6gyyM4IVmj3OqpUf9LQ2OqUCwrnGH3V90ozjJWJumo2XvQp7F2GgoW
	4G+NU7/L0ZAngNGhu6+TfGyjYe0ojKbR0a8wVZt+d3RS85tIwg9R15C0ausGkksuo/v4SuXKtgM
	VFsoUkeZ2q0e69tLMDazqQZdYHtq5RRDJGpFBQzjpLXjqNvJu3GcEUjE/j/JbDNdgGvSa7n0okH
	33sLJmeVb+yJsdOiRhX
X-Received: by 2002:a05:600c:a086:b0:4a0:1f9e:5f78 with SMTP id 5b1f17b1804b1-4a18e3ea887mr14032945e9.0.1791527504788;
        Thu, 08 Oct 2026 23:31:44 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf0abcesm39170955e9.1.2026.10.08.23.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 23:31:44 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: tim.c.chen@linux.intel.com
Cc: arighi@nvidia.com,
	bsegall@google.com,
	changwoo@igalia.com,
	christian.loehle@arm.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	pierre.gondois@arm.com,
	qyousef@layalina.io,
	rafael@kernel.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	sshegde@linux.ibm.com,
	tj@kernel.org,
	vincent.guittot@linaro.org,
	void@manifault.com,
	vschneid@redhat.com
Subject: Re: [PATCH 18/18 v2] sched/fair: Take into account slice in EAS
Date: Fri,  9 Oct 2026 09:31:40 +0300
Message-ID: <20261009063140.30016-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179bcb50be21f834423f9b5c068b5fce4cb65871.camel@linux.intel.com>
References: <179bcb50be21f834423f9b5c068b5fce4cb65871.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tim,

>                             struct task_struct *p)
>  {
>         unsigned long task_slice = p->se.slice;
> +       bool target_first = task_slice < get_rq_min_slice(cpu_rq(target->cpu));
> +       bool min_first = task_slice < get_rq_min_slice(cpu_rq(min->cpu));
>
> -       /*  Select the one where you can run first */
> -        if (task_slice < get_rq_min_slice(cpu_rq(target->cpu)) &&
> -           task_slice >= get_rq_min_slice(cpu_rq(min->cpu)))
> -               return true;
> +       /*
> +        * Select the one where you can run first. Check both ways, or the
> +        * result depends on the order of the CPUs in the PD.
> +        */
> +       if (target_first != min_first)
> +               return target_first;
>
>        /* Favor previous CPU */
>        if (target->cpu == prev)

> Take an idle CPU X and a busy prev_cpu. Any task can
> run first on X, because an empty rq has min_slice == ULONG_MAX:

> - prev_cpu scanned first: when X is the target, the slice check
>   selects X.
> - X scanned first: when prev_cpu is the target, the slice check fails,
>   and "Favor previous CPU" then selects prev_cpu.

> In the second case the task is stacked on the busy prev_cpu even though
> it may not run first there.

Agreed. 

But ULONG_MAX doesn't always means that the rq is empty.
(See my 18/4 review, maybe I'm getting something wrong)

Also, I assume prev == min-cpu.

Scene:

target is X, min is prev, prev has a 5 ms sliced task while X is empty and task_slice = 4
target_first comes true and min_first comes true they're equal and min is chosen.

If however, the task_slice was bigger or equal to 5, as correctly target would be chosen.

LGTM atleast. Eh. (ULONG_MAX could be a problem tho.)

Thanks, 
Kayra
