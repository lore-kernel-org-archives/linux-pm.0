Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDFE36A352
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785953141; cv=none; b=EvKDIRtwEEswckIVqDzhdBnt2PpNA+HAkHOQ3IO2WHEKcDmqUxxI3/kpaqF7lOFMzp3jm0AneJDFkcaBntsjcLlOf2o1sdtfoD4ypaVP6jBi+rPTcn5oTEoTpYnnIxPcNw7uZhd/eJ994f46gF5rBke/FbLD738ZSZPTR28lFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785953141; c=relaxed/simple;
	bh=DW9yyV0YW4K7ITId9k/H+TK5L4C3ALvWZ49D9nbQr7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7czoQIFk9f/Ii4NKJdBXciRYrM1aTgeCMOTYkDbjGAkYD1DyDnvvdqmBznRT6e4H/tUoDW+7vXct1KgXk/eq7DH2NomMmqGDSNB8gHnRuHx50E2+60e9tO97PeU0rfBYVrkK2fVMpeBthk+FWlbMXuSUJJ+3Io6jupjf2E0rkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBBl1Nen; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBBl1Nen"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso1603793b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 11:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785953138; x=1786557938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WpaDgwWMnqY4lhvXrcB+QWEYFlki4Y+NO5ZQwCLRbhM=;
        b=QBBl1NenudvDBIfmiUjlNpf6ad7N85Q9sN9JzftGg9xvAUBzceXi8pTDUNxEDungPV
         hBMetXcWthOQmgZ/rInJ5Vkd+pwEVv33wB3PVfaRXFCrVPTMRYOiwxNGNtyQXobTpE1V
         Td3lUv1D0gZbbZbM314XelAjHnImIjiKcJjzOe7Rx+w6zg1hDStqpUHxcJIqBwk4W5Yx
         7jHNgZnumEMNssgMOsiCrOSqeGlwKU0n0qx8Br2WgoOOhcovDJLYpfWfJfk9IN9zefSr
         sqNMu/aRqueXv5X4t+vZU1g2ShI0meYnnM4mRsjAnNUdgyEFUc0IRxL96yEzo68ej7jh
         IG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785953138; x=1786557938;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WpaDgwWMnqY4lhvXrcB+QWEYFlki4Y+NO5ZQwCLRbhM=;
        b=jE+EVjQIbb5Pgq9Zoct81RVSNt7gK9b0552Q9eNzqHQjojJYq35TMh8Esbx9wutESr
         UR74XyU+fZA0K2Vjfo+ylhe9pue0eLVLTItRyVHfeF5jcIq1E2U7T6rJQVHevgfBaSGU
         icxzOljC7/gGm0YfDLtjww95xqzj6qaYzqeFtJtX4HtPEg9rQq8Eu0qsN3XWQA9flcWb
         KmuYn4ClRtKBZLf1oB1QmQzkOAAg45bgeL4UdnJYSVvw+eIRqeDtK4r7Q4XFDXuF1Bq4
         KV2B0bJ+DdXrpRrUpcNeAInL2apeYb2L8vqtZr4j/DJv4fyY2/qYsOg8VcHuAV9zH41B
         y0qQ==
X-Gm-Message-State: AOJu0YzlBr28etYaQ23Wp8fI6Vqbb0VK9C72AuipKp8WmiEdpFvgenbU
	i+x+5aA6evk1UJDWv89DDWDeVVxLP1ox7T7sAQma6mdD7KeycD1XmGV1
X-Gm-Gg: AR+sD11MdYBezq/h5zT7PrRxyVgItPygRwIjtWQEcF3skA6ZgLAlL8K73tdlP9yUFnk
	JbTbqNb8R3cLTIRuGFHE6DbA1UD8RHX5yw/Nf2qlayluQxJNZSwAE9Nb2x2kPyT6xntpbYg21Z1
	RlGy4iIePh8bMhlfBEE8FxwwscsYq3Mb4td9/imCu8Z3q57kOZV9Gs00ezj2y+pvx4AEaP8fG/3
	rUxbr869g/ZiPfincu0aRLWj7ZxNKPPAxYsDzxcIQHBzRn1mHBnjFjsc/rpvyimlJZ4wngHAJO3
	NJUJyXvT7yHcFW9CtD75mdCjiRAIMRZITHJUTCG+WX+VTZfhqWe7Ya+ZVRjncuHit3j5+lL+PkE
	gcax1AH1LCbhoxmTOePZddL8IMqiNWBT5H64NTxccUG8oTfVZtlVRoL/gbx58RH41a7gwo6DP7H
	t9GuK1E4iMyPwRFvgaY/Wi1dVvK0tSUSmGNXMLLImBppooWAjOk16xOeezCMsfm9StSZUPIO9ud
	AE1dpbn09sN/RSynnoaYOG5avqJjEjwME++dccxNg==
X-Received: by 2002:a05:6a00:4482:b0:848:42d0:bc91 with SMTP id d2e1a72fcca58-84f2dfc89bemr10533575b3a.12.1785953138226;
        Wed, 05 Aug 2026 11:05:38 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e2e3089sm1288826b3a.19.2026.08.05.11.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:05:37 -0700 (PDT)
Date: Wed, 5 Aug 2026 11:05:35 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com
Cc: linux-pm@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] freezer: Restrict unsafe freezable tasks to system
 sleep
Message-ID: <anN7b-WbFvqAsO4l@skinsburskii>
References: <178404715617.1031850.16243528040694432110.stgit@skinsburskii>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178404715617.1031850.16243528040694432110.stgit@skinsburskii>

On Tue, Jul 14, 2026 at 09:39:51AM -0700, Stanislav Kinsburskii wrote:
> TASK_FREEZABLE_UNSAFE is used by network filesystems for sleeps that may
> happen while a task holds locks or transport resources needed by other
> tasks. Allowing the freezer to park such tasks for administrative freezer
> requests can therefore block unrelated users of the same mount until the
> task is thawed.
> 
> The original purpose of these unsafe freezable sleeps is to keep system
> sleep from being blocked indefinitely by RPC or filesystem waits. Preserve
> that behavior for suspend and hibernation, but do not freeze
> TASK_FREEZABLE_UNSAFE tasks for non-PM freezer requests.
> 
> Make __TASK_FREEZABLE_UNSAFE independent of CONFIG_LOCKDEP so the freezer
> can test the unsafe state in all builds. The lockdep check still uses the
> same bit to suppress the locks-held warning for these known unsafe waits.
> 
> Document the PM-only freezer semantics for TASK_FREEZABLE_UNSAFE.
> 

A gentle ping on this one.

I understand that this change may not look like a pressing matter, but
allowing a process to be frozen in the middle of a request, while
holding a lot of locked state and without any guarantee that it will be
thawed, does not look right.

Some applications, such as Mesos, use the freezer to quiesce processes,
and if they are killed, they may leave those processes frozen. If the
frozen process leaves access to the NFS server locked, other
applications cannot access it, which may lead to an inability to log in
to the host.

Thanks,
Stanislav

> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  Documentation/power/freezing-of-tasks.rst |    3 +++
>  include/linux/sched.h                     |    2 +-
>  kernel/freezer.c                          |   10 ++++++++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/power/freezing-of-tasks.rst b/Documentation/power/freezing-of-tasks.rst
> index df9755bfbd94..0ccf2ea041cf 100644
> --- a/Documentation/power/freezing-of-tasks.rst
> +++ b/Documentation/power/freezing-of-tasks.rst
> @@ -16,6 +16,9 @@ II. How does it work?
>  
>  There is one per-task flag (PF_NOFREEZE) and three per-task states
>  (TASK_FROZEN, TASK_FREEZABLE and __TASK_FREEZABLE_UNSAFE) used for that.
> +Tasks sleeping in TASK_FREEZABLE_UNSAFE may hold locks or other resources
> +that make them unsafe to freeze for administrative freezer requests, so the
> +freezer only freezes them during system-wide suspend or hibernation.
>  The tasks that have PF_NOFREEZE unset (all user space tasks and some kernel
>  threads) are regarded as 'freezable' and treated in a special way before the
>  system enters a sleep state as well as before a hibernation image is created
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 908aff695ef8..67e052dee1c4 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -122,7 +122,7 @@ struct user_event_mm;
>  #define TASK_NEW			0x00000800
>  #define TASK_RTLOCK_WAIT		0x00001000
>  #define TASK_FREEZABLE			0x00002000
> -#define __TASK_FREEZABLE_UNSAFE	       (0x00004000 * IS_ENABLED(CONFIG_LOCKDEP))
> +#define __TASK_FREEZABLE_UNSAFE		0x00004000
>  #define TASK_FROZEN			0x00008000
>  #define TASK_STATE_MAX			0x00010000
>  
> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index a76bf957fb32..bf7bb15c144f 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -124,6 +124,16 @@ static int __set_task_frozen(struct task_struct *p, void *arg)
>  	if (!(state & (TASK_FREEZABLE | __TASK_STOPPED | __TASK_TRACED)))
>  		return 0;
>  
> +	/*
> +	 * TASK_FREEZABLE_UNSAFE waiters may hold locks or other resources that
> +	 * other tasks need in order to make forward progress.  Only freeze
> +	 * them for system-wide suspend or hibernation, where failing to freeze
> +	 * them can prevent the sleep transition from making progress.
> +	 */
> +	if ((state & __TASK_FREEZABLE_UNSAFE) &&
> +	    !pm_freezing && !pm_nosig_freezing)
> +		return 0;
> +
>  	/*
>  	 * Only TASK_NORMAL can be augmented with TASK_FREEZABLE, since they
>  	 * can suffer spurious wakeups.
> 
> 
