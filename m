Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF344195C8
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791314661; cv=none; b=RgU+qgYEWneKrnaZUXzKTomUc30C7sjQOamy5cOilgCkJ3RHM+M7KYuwWx00m2S854B+drOEjk07NhqQimfuNhnwCMKnZCSovKjmrRsWsb3sO5oveE3crR+GbPEfuZ7iAN4MRPqrT9kAS4L5wE9QPVNOhyewiushIZRLS5JKu/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791314661; c=relaxed/simple;
	bh=Kt8YNEWfbwDWsI+SQanVP9qIuuvXMzBnWOpvIaiQncQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlkPSWaINg/r+G+kPgS/opBv1PuJkAanITc9ahv2LW+Lcy45eFgfudqzlEoOrk/23SXGkqI/L/HFWLG6VXj+qYovXJYMwo1Iu1s7sDDMpHNbc0f1s6KwFXfImRtyHobPs3k20EVnLweVzSW4ZhkpYYuApavxYztjXRGj9mMd8o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iy1T48Dc; arc=none smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iy1T48Dc"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-48c6a19c353so105889f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 12:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791314658; x=1791919458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yx7UFENNd+zDz7Za9PxYYzlJTn11JexZcpPUkJvIP5A=;
        b=iy1T48Dchs5Q595vWIwkVMbeW1aZ56l2G1vcSpiNPB9AH/Mp0esmpojfgjE8sl9HVV
         hSYXFf6hQYA1vsIxUm3N3Xser62FnQQe9UNOMF3pSiiUA6uE+L9WlS3ODyfMhOR5y7sI
         t7Jwe/J9Vw/8TgMCcWJZetavAV+wk1/PO6hWTy0YAjMHoEEBXFBr7dPQbuXjkxM79ZQY
         U7leNZwrBorpLgWZ0/eBfQ18KQ5xp6YOWaxRx7SFBRxbH+kezexLQ5t67HWftgISxutj
         YTlVSn2VEw/kPAmUq/HTQ1N65nLNMMtYJpUvL/ehYwWBXBR3g8tvNeUMP5+OTCZgDicc
         r+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791314658; x=1791919458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yx7UFENNd+zDz7Za9PxYYzlJTn11JexZcpPUkJvIP5A=;
        b=n5MeyvmpOLYMvcL306aIZscbVmj+mQGT/7CLaUllWWcOr0LJ3L5U/juHQVVPCCsKNt
         fIvrVTAAXy/u1RoFH+Dy1012Z/galt48MsDeUIf7fJQf1EYu7FGNuWdxmwjWg7Y1AISv
         i/db96fhxKV7nMsuSwWucXwu5/7Fms5RDK/PWGbtO8HID8a0OivoV92JlxecbkrFvLaI
         gP2XterxvpHMBjALe6X2S1fZ86JQVdnl9oOAmFWGZzIToi+tHMLtNjRns89rOvlnWhTU
         7iR+a+s3XQZ1pAZdO2zCxZ3B6Z224gj+AwAuUbqIpIHVIY3u9R4vGghz2k9xJHU/rlv5
         Bvjg==
X-Forwarded-Encrypted: i=1; AKwUvBx91Kf2ZIGSx8Iucw2mNQX01xa4EKU2YuC1c53TvXTBTSOB7y/qyWTNUvU3CndxbuDabocmccTXLg==@vger.kernel.org
X-Gm-Message-State: AFuF++msKE7Yb8eQOwdzgSUOGdJnapsV592qe5UYf3LqoyELIiZaE7KD
	aLmxpI/hnF8btbZCKPs6PBNws+KYpwU0KuczdyTgpINyRD40Z1iq5HCO
X-Gm-Gg: AYBFou3fV96esY8JkN0xv7/ICsp6LBpuqcb+B14b66lsbVODs28TkzaQ8bJeNqUg2Bk
	E7lN7Vwbe6nSkQ9a1gQ3iDTSDKA6/XFniVtJG4mGZAHGyEF4DxhnoZBWcaUpK6Xk9F+l0OM63F2
	ZKN7462EoI5oa1Y/aJY7VJEogvXo18U7ZKs5tM0ARSXcCvDYv5e6s4kRcwAAv9v0c7ii1uwEjVa
	Jg6T0JkZTGNK3nybxBUoviCtsio0o6CnlbVR+eRwD43M6LKdbcDefF/SSj0exOIxVBWgyIroFH0
	OxXjmaayJT8azqkj9CRB1kW7EyGhEh3B0qQGHnh4GW35NAukYrlIV4r2tsr2h3SgUpp3hLjfx2T
	1lzKt4OOQq+hufYrIB3+ml05c1OGUhFBS5KeEzUf6tmjbTyuhxXF39y1/FbQYu3utkDOTlOVFLw
	+X81t9o8bMVhgLiy7ACUsi92IeC2IhJbo0sN7wMjlZuh/mKTSBUsQQO3cJzJMqno455ccbA/X/R
	4VAfflETfTCrjjiAYiZ9I0WcdCcQIY=
X-Received: by 2002:a05:600c:46d5:b0:4a0:1ca8:70e2 with SMTP id 5b1f17b1804b1-4a02751fa7fmr252725835e9.1.1791314658282;
        Tue, 06 Oct 2026 12:24:18 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f54a5cesm6315185e9.5.2026.10.06.12.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 12:24:17 -0700 (PDT)
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
Date: Tue,  6 Oct 2026 22:24:14 +0300
Message-ID: <20261006192414.7308-1-kayracizmeci@gmail.com>
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

> When the task is alone on the CPU, it's never put back in the enqueued
> list; In this special case, we use the tick to run the check used to push
> runnable task on a btter CPU.

I love typos. Like, in here. 'btter'. I think it should be bitter. Like:
"In this special case, we use the tick to run the check used to push runnable task on a bitter
CPU."
(Or maybe by a really low chance, it could be 'better' too. Maybe tho... :>)

> +static int active_load_balance_cpu_stop(void *data);
> +
> +/*
> + * See if the alone task running on the CPU should migrate on a better than
> + * the local one.
> + */
> +static inline bool tick_pushable_task(struct task_struct *p, struct rq *rq, struct rq_flags *rf)
> +{
> +	int new_cpu, cpu = cpu_of(rq);
> +
> +	if (!sched_push_task_enabled())
> +		return false;
> +
> +	if (!rf)
> +		return false;
> + 
> +	if (WARN_ON(!p))
> +		return false;
> +
> +	if (WARN_ON(!task_current(rq, p)))
> +		return false;
> +

OK. So, this is called from task_tick_fair() and task_tick_fair() is
called from sched_tick() with rq->donor. So on Proxy bla bla
this could get true. Or maybe I'm missing something. Dunno.

NOTE: Some more places could have the same case. Again, dunno.

I need more tea. And sleep for not having to drink that much tea.

Thanks,
Kayra :>
