Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C073F1062
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 05:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791525205; cv=none; b=RQyXBDcH3DMXVjjeHsbV4QrkVm8lMcYo9vSEqXzyDnyth108/yCctl70EEIfOEgxMMv7mvsucJ4nAUhbeIgjr+WAveOb14MBDBOjZ0QagKFbP33UOlFZKK9TnAxqSUyzBV5tFxkTK0vTGNtz2Bo4usyFqgMTQMdTXI5/kc4wxSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791525205; c=relaxed/simple;
	bh=Ban0n7745AzBI+q28L7dD9Gn9SbstwTnM2yds7GYTLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WufPhktXNCY/WoQqBzka0pGqjC1oRiJyYFMXXQD8Hjkn73X3VjvdW0RFe+X+6oIEb3AcA11PwbRVN6+n6CGWb2yrecRHIcb8KDPQDGRvEekPsYpZ0ZiEenJbYU4DyMIiBYOFTNIUoHpMAxI+G775vvneFNwiN3NQjCMIdtBpEZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPFkhcT5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPFkhcT5"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b00aa033bso165066f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2026 22:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791525202; x=1792130002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wVlDnOJmdRHsN4qn4A2HDhzFDxkd+SqZNh2m1iwQaYA=;
        b=YPFkhcT5vfxb1V5Pgkij4XWrcW4Lf19inD+lUsMtD4VROFaLvooWnJY80wkW0qLubj
         svMDNgfRJaUzQHD45XvJS5cGulxeSNK8ENB4sNZFkt186MTGIs2UTBoJLYAiR5ynwdfQ
         679mocTqwmQyY+BBfZv+tXNhkc4oZCGGapwCHMvSWIfBJoySLqQa0b/TPPjK7aSu442l
         XlcxV6sRlfG9NqYv0GIeZlg2B8p0SnqG6mal6odXG1EjMXHjR3pG9eKb+Sqsva5J63wh
         E6VImS3xfX5JJ6UfMSjPeF/urOjjUt9R1bZZqlpBTc2+S21yQpf+kTFu6MLpGUp5LcuI
         rHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791525202; x=1792130002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wVlDnOJmdRHsN4qn4A2HDhzFDxkd+SqZNh2m1iwQaYA=;
        b=wGTTkdTliNXANsoxBLE05CNskZylKLHv25MLSXLdFpnP7AN9kCfQfWCzuPDt7u/ZkF
         6lrlAJFkmoguaBAvM56HtseEXoBv1+mmz4awVRiBBnR5WmRY++WF+KA3xnphXkiHPPwB
         XshoMWSWJSjD8kQ+KpmTvHc6Cm9bC3ssX7WckpTnicw1IgYMaaTK9PwnXN2O2nFjv3S4
         Jg14L5cn3fQL5NDyB8wsI5fL1V0IK5ZRuHyjRmG3qr5OUfYPtq1+jmkt9qs2/YZ+oDqi
         vb0RQL4bgldCkvW/Vmaha5ctht4Ga3imXkIqPGUOmg6Pwyjm3L19U1Nub1vvKQxdGD4D
         lJ0g==
X-Forwarded-Encrypted: i=1; AKwUvByDd2vesn9mw/bOKx04XW8vUTq6A5wOBp1I5sYuU0nNDZ356PpDiprc/DE1/3edAoLbUPt0PssDiA==@vger.kernel.org
X-Gm-Message-State: AFuF++ldlBA6F54ckH0+p3AHlQ5bPvEBAsOTVumC30Z8l7kooT/69Dr/
	wFdJtM9zPprhT1B7v67Sj4oK6EkV1ABBskvQdfOJNNRoiNo3sgwnGf+m
X-Gm-Gg: AYBFou1OxK/oYoWVjRjZNASYXTv+LpRJ/Yzrc1W/T42/eexoU5xU9BYWKF7GhnSR2GS
	fZWZEcTJt0EZlYNWPvPOQILBUF5ClzXsq60qVRkcnlLyHKJPBEsskdxDXEQeZj/0N98o+zyybaT
	E4VXkMnel0o/5fICmhKbNI4Fn/9ow60EOaZePNcfkUn1LC5JUhrauj+4twfY2X2PRdvwq5/SAua
	MvkrAcLrLmBphF4N1LkJkzktaT0iDFYWDbJyIUWGjMOHnVtVzqINaofKEEI4qhGZO9DakVohq+Y
	0rWClvHSKilAP7DeWtasMAzRMvgmOokqtkd6wJUk0qqK5ziDZKp2uLypFoB5VHFkk26JYfcHh5p
	ut7rJq9if2T41noOOYEGjrpfu7q6upLp+30WWs+OnoagRESgOJZKm5yG2ld66UAQgOhEARwqCho
	h/7tWtQmb5UA5rwhjy2VXiH0YNNrQVu2QXzUc4equ18YaUxcV5JOgRzorDwLBO4H9t4vHSVyS0T
	M5s6jKCI15sBhFNHysV
X-Received: by 2002:a05:600c:1912:b0:4a0:73b:a222 with SMTP id 5b1f17b1804b1-4a18e3ee97dmr11594485e9.0.1791525202556;
        Thu, 08 Oct 2026 22:53:22 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18ca51465sm22826485e9.4.2026.10.08.22.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 22:53:22 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: vincent.guittot@linaro.org
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
	void@manifault.com,
	vschneid@redhat.com
Subject: Re: [PATCH 10/18 v2] sched/fair: Add force push task mechanism for fair
Date: Fri,  9 Oct 2026 08:53:17 +0300
Message-ID: <20261009055318.29609-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-11-vincent.guittot@linaro.org>
References: <20261002154415.2270586-11-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>  	task_tick_cache(rq, curr);
>  
> -	update_misfit_status(curr, rq);
> -	check_update_overutilized_status(task_rq(curr));
> +	if (!tick_pushable_task(curr, rq, rf)) {
> + 		update_misfit_status(curr, rq);
> +		check_update_overutilized_status(task_rq(curr));
> +	}
>  
>  	task_tick_core(rq, curr);
>  }

Hm.

I think this mechanism added on here does not works.

Before fair_check_pushable_task() is called, we check
if nr_running is bigger than 1. If it is we return false.
So when we enter fair_check_pushable_task(), nr_running is
equal or smaller than 1. We first run __check_pushable_fair_task()
but it doesn't really matters, since it's output
can only return false. Next block is skipped to since
next == NULL. When we're at the check_pushable_short_task(),
the h_nr_runnable check is always true on this path,
so we return false.

It this intentional? Or am I missing something?

Thanks,
Kayra

