Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794034408;
	b=eyC+zwNQcTd7oiqrOrolDd+XYDsfUZ4/TaibMC9T2JolUZ9qi7NmM22cXDsnVmiMH9lO
	 yUlECZuiOsgJ7YLAMKI3KStk5LyZB+VZJ2pIAcw2E3DMT9A5Tnd6VRnIpuOBd/rE1n7d7
	 n5rlOE5PlJ1kvkRGoMuORJCkn00AR2lG+caauqA/KTQafNmgRVrRZB9uS3IPGZym+F+9h
	 BKdwV/lWKrS0TDuIyMA+MlPakpnWh/5HSIn5AUHMQuTNYF8zc+GpmctOnMZuv64GnALrr
	 62O0454OuWXFkoT9PSqFfxOKHdEkygXMMmpaTnnlt+M2bWNcbWYP7WWiw88gKvNXPag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794034408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Eto4368JR2hmRW7wKGSiDlCRlUrolYOPtl6iuMGKc+w=;
	b=lqVHG/hyXZaB8/etIsN2gqS3lB6AJjaGwOpXoMZaPph9YRwASbul0ue2KJ2cJjFDsakL
	 QskrEe/pC+uQLi5LuJBgeFv4t/hvGhBLevawVD6tR0mWkGKzUObbn5Z6KvK8sXDkpz7gm
	 mDDbvpNhx8MpjrXrkoPilovF0skl1LIycIP3vp9Zj4EkhgOnUTURxYDkNnU8TqyO8ukMw
	 nVCqaq9Gk+YRp82QL05eEj8CcZCguHgf1iI9arzI5udckEN+s8R8XAtw559ntegCChzJn
	 jJzGmM/WNhMkXfNcWKT+geyir3mr1qWhxV41Jy/ELwj/BEuE7tt4Wlye1QXFNVa9PnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mY+3oYdC;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC1A606A32D
	for <linux-pm@vger.kernel.org>; Sat,  7 Nov 2026 06:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BC1A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mY+3oYdC
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dc1508191so47101f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 22:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794034407; x=1794639207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Eto4368JR2hmRW7wKGSiDlCRlUrolYOPtl6iuMGKc+w=;
        b=mY+3oYdCiSGPTWaKrvVd9svyYYnxgUHya25yRswOZEN/Er+kukrUrCdwZfyVZejP9X
         GUXexxRtk4JsB0CgOp4UTsQgF8jsrHiLYXIZDtdTLA25587Rk+1tlYx3yrI1iudpKpJD
         FzBmWZC+DspYwu5AFCgfqdpbCueeT7r7AIWvWscWNFv9UorWUi5DK58WJe6ojB33JMIT
         UIMKzd3bIxmYXgClNX+Xkuq8oiUX9JYxG/Ym6dQXTUbZYS/EmF9kbJzxUIegeasuXBV5
         oUyP506SrftH2aLOykclmV5dVvdPSt4ibMQ1koik9WRPUAtD0pEpirDpqTtsSzySyiv1
         /OBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794034407; x=1794639207;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eto4368JR2hmRW7wKGSiDlCRlUrolYOPtl6iuMGKc+w=;
        b=SGzS9cmnOZ+6M4saknLe2qw03ZD2NNB9EUWVOFzj2eokXLHRRyZTZ+wJY5VJgcPOfZ
         MZeZQEwcV0O5DK7pZY0jx0kfSzwlVTSFGR4HvsqBkBJykSZpcYsNrX89NnuzLFEUpOOI
         7cTYUxolN6NQ1YcobT34947DEbbZpzggiWvbko/Hj7+hioTcKOpk/DRKLLuX6i/XNoDz
         Q/qW9wh3kKKa2+vI+XSfO2OwprLukDHZ/Nlk6jqwYI/hgtPxu52eN9Jyt8qFta2baSnz
         xTbBbyxzS/EcRTMFQhV0X7l1IJB8QnxuXVnYWSFDCuXzRqtEXurXQwslVSMqico47Non
         6Fnw==
X-Forwarded-Encrypted: i=1; AL+hErFUQml099vF1Ok5IEQOUMXfipRgX3kDAZ/hIZTzEWv11emnO+CAiG5fRhPDZ8PXsV0x0WUpKQE9yA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8c3zSgfp5ySH8CsxWa5qctUKBgw46oQC8+yZCl8QPX3EWV21v9
	b+Eu6v3G9iwxyCgZ+fDBKikoU+0E09za4X7YNs5ISxPlLQI1Hy+0/fQj
X-Gm-Gg: AYBFou2q/htdW1DWtZUrRyKFfE8WFeNK/utP54a7aFbZATXEqS4C/qCU+0C4buyS9QM
	SM/N+APN/jafeEuyMI0X5EehJ9J2Iwu59tl3OmuWosMOm1LYjUDKvmvwN+dJvHhV+03/h1rM70d
	zpQ1c8TTbt03qQ9g5fG4OyKtkMmdvpAiq8OdrcdyUG/Y1BU2UM5wIT0k7wEkTiP18ZQfzM7Klb0
	4p+10wagn7N/OYEmcbqmHn9JKEs9N/r273m0aVEXq0nCrKiazgnmZp63cJep/ZPCwuxAHDfFiKf
	ILhh/fXcxK6LHRPmkTbD3dZCc7DY8Nf8ascTW36/6mLVqvkzehoL+qqZxZbfRmajFZfOv0WTbA6
	wybiiDK5T61QmU6QrvQW0jQY55Mt6bNJeW2thrkI8Q9SXdwlZssDOS572HP15D9gSJWwUBUia9Y
	8ihrkRAY7EvZAJiZW2k5p1EyA0+QNawlh6aMxxKEoZpGCiz2yR1g3aNWO1UmPhLmdHy8ebMhdIy
	Vh9d73Vfy6NKsxO2UNXwvmvlGXzS1mtYW/+0HEYWn0V2cNqg/LwIhfI501CzEBrr7PFUAVC6m3T
	UtZ22qojaq7arFwLqV05y5BMZSxQ8frKqh4p9ILekQx1b9h7Q8y6dN4=
X-Received: by 2002:a5d:5a45:0:b0:493:9233:ce65 with SMTP id ffacd0b85a97d-4939233ce93mr3783631f8f.0.1794034406420;
        Fri, 06 Nov 2026 22:53:26 -0800 (PST)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d837e3f5sm8000337f8f.56.2026.11.06.22.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:53:25 -0800 (PST)
Date: Sat, 7 Nov 2026 09:53:22 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 05/20 v3] sched/eevdf: Add per cpu cached min_slice
Message-ID: <au4i4IWFvJw-7Q0Q@scheduler.schedules>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-6-vincent.guittot@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106151947.3991524-6-vincent.guittot@linaro.org>

On Fri, Nov 06, 2026 at 04:19:32PM +0100, Vincent Guittot wrote:
> In order to use min_slice during CPU selection, update a cached value when
> needed after en/dequeing a new task. This cached value includes current
> task.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/core.c  |  1 +
>  kernel/sched/fair.c  | 28 ++++++++++++++++++++++++++++
>  kernel/sched/sched.h |  1 +
>  3 files changed, 30 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d7c3b43158de..031efe7d49fb 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9012,6 +9012,7 @@ void __init sched_init(void)
>  		rq->sd = NULL;
>  		rq->rd = NULL;
>  		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
> +		rq->min_slice = ULONG_MAX;

This is already getting changed to 0 in 6/20, instead of changing there,
wouldn't it be better if we changed it here from the start?

Aside from that,

Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>
