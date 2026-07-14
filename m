Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91A42356BE
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038661; cv=none; b=o2Sgk+7BTCwWjvankBEPv1Dk8Q+DhmgD9OrX0ExX5U1joSjy9EbSAVaY0mlTFDfJX5oTw4F0xc8RGNAzUUcGUPir3hjg1PhWTPH8wNZ1O/qKq5tW/nvy/xhcn6dGpYJJGi43vCUBzcMnOj27rmzIKOts+3CpE6UeAOiFwP5T78U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038661; c=relaxed/simple;
	bh=Qou9KF1ZyhKg/b4S+eAv/lKZWaeMGImXF6jVQFtad0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkXFQkh1CQBsppc+aGedaHEV+vCdQKbh+Gbxp589KHz+I8SLn+9gTu6xxDuYYpiD5gPbxMrWnEHalhQ5EC4BvWXACu3WMY9zlx5AAXo5RJz+G8xd7MDI9kVdVqveIJJI3KIckNT3QQBfEfoQPjsMUFIBpRpnd1U/EvRfLiVPENo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=Emz+EzJL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="Emz+EzJL"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47df440fcd5so2439950f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1784038658; x=1784643458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jMsfXHlyn80iYs5pu2l/GiQdJ127GeZd2nn2EHPSV04=;
        b=Emz+EzJL/vbmZppcK/AxJwnPkSN1IPdpmcBWBvjD/e8eWuH+Y2HiADdKk2gpLF2qi6
         nj0pCTp5FHs1bbV2u2Fuf77mcUmrKM1iW5nYTb3SoIc2hKn5rGI7eR5Wfm6tgYi0wgS3
         bgxiSBngRSaZLSSvSlY2b/hAfahCHjZpQsx2tkIUe7Q8xgXunldCeZalK4bQXBljcNdE
         IrkIohjgCEAPuOcP67fZwVEtVBk1loMlgZiilKFmWITs3WiiyqZkg9NpcOhm43wAHDXm
         0bZQKYu0F9LQqJiLs1VvZdiXhM4EzxN1XYP07+KkzrXpSM29jpfib0Nh8gDFUVk7GdMw
         jEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784038658; x=1784643458;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jMsfXHlyn80iYs5pu2l/GiQdJ127GeZd2nn2EHPSV04=;
        b=ZZsc+aKFlEFmT25sEH3cM43Z294GWbsR8aEiqQZOc3mZu6LkTcH2wCx4G5VlBTaqoR
         Y/eB45RmLpDi6103SCpoaqbLg/o5syng0wfj5oP4P4kBcjrIQTofDKchVZhe/OwZZgoU
         BcUZUGnWUDrYVKAHSLuI9kb3ZF6cJnGy/WsR3Jfrpp8G1urhzAsUfyLSszil0DAjkl56
         aU9J6EuPKlocfRNUxl4MdhS9SLC+kulmL+1AFvLX+yl1dXOg0nY9U2VIOrlHqppUOFmV
         XftQ7UbtXKMYeEKNvgF0mx+CAlatXrbP95IL1QE+uKvhBtL2XpNndYwM02uXl/eCmb1M
         wEgw==
X-Forwarded-Encrypted: i=1; AHgh+Rofok4y251Jl0L/2vfm14e6uwkbZgfY+wF+/CBAxRt4xuxKkGTYMPEEew62kZATxi/psImeBOYajg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoFWPyAuibnBdQG+9D2oVVruNlKjETxuzn4uVM8+xUHyKeC4i+
	ny0+dJIGTeGx1vCI0uStDGaKm6XvEHXyskftdAq16nM2uVCQK53pGSxEReBvYtihR2Q=
X-Gm-Gg: AfdE7cnNQXHQZNEw141pQWBTS2RB/PDNpDBa+cdgjUUKd2xCzKjznby/fMQ3FnTVYsh
	YXZrbUomtYvlv1pw9MKVfgVEX9FpsXuZs7tmwWgUj2pa1sOR5VBBCUoQhzheny+Ve85GQp7Q0mt
	uy2v1l4pbDmb1NIz7eWGAJOwpzSMou5UD8dPYVYyOcvN12s+Yhwo2pY44ouviHZyzEwMIe2CjFn
	5cobG6P7O89Mug1J/BaeUSgWUamC06DhfdU2+SSVYvzFYMkBmpK9oZ010pchJPA45Jdvj72+lFH
	agMKdYphWyZQq6UAoB/zB3esXnSYYpap+dbmVStfoKh+BygNOhAW9wkDX0zcp4s46x2nqIxDMj4
	DdkJGSJyv8Sd0lrnzVZ4cKgQa57wonQGr4rCAVlr+Th3hu3FLiggd++BV7PDkwuw1nUSGVZT+GO
	wrqRh6GrU=
X-Received: by 2002:a05:6000:26c7:b0:47d:f441:5f93 with SMTP id ffacd0b85a97d-47f2dcc02eemr15424831f8f.25.1784038657983;
        Tue, 14 Jul 2026 07:17:37 -0700 (PDT)
Received: from airbuntu ([149.50.209.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4829896asm6726842f8f.23.2026.07.14.07.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:17:37 -0700 (PDT)
Date: Tue, 14 Jul 2026 15:17:33 +0100
From: Qais Yousef <qyousef@layalina.io>
To: zhidao su <soolaugust@gmail.com>
Cc: zhidao su <suzhidao@xiaomi.com>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Chen Yu C <yu.c.chen@intel.com>, Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 RFC 08/13] sched/qos: Add a new sched-qos interface
Message-ID: <20260714141733.5zubzp64zm3f6p6a@airbuntu>
References: <20260504020003.71306-1-qyousef@layalina.io>
 <20260504020003.71306-9-qyousef@layalina.io>
 <20260623102858.1866647-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260623102858.1866647-1-suzhidao@xiaomi.com>

On 06/23/26 18:28, zhidao su wrote:
> On Mon, May 04, 2026 at 02:59:58AM +0100, Qais Yousef wrote:
> > Provide a generic and extensible interface to describe arbitrary QoS
> > tags to tell the kernel about specific behavior that is doesn't fall
> > into the existing sched_attr.
> >
> > The interface is broken into three parts:
> >
> > * Type
> > * Value
> > * Cookie
> 
> Hi Qais,
> 
> I tested the proposed ABI on an Android device running
> 6.18.20-android17-3-maybe-dirty-4k with this sched_qos series carried
> locally. This was a direct syscall preflight rather than an app-level
> benchmark:
> 
>   - set SCHED_FLAG_QOS / SCHED_QOS_RAMPUP_MULTIPLIER=4 on an existing
>     task with sched_setattr();
>   - read it back with sched_getattr() and check type/value;
>   - repeat with value 0;
>   - fail the test if sched_setattr() returns 0 but readback does not match.
> 
> This exposed two ABI semantics that I think need to be nailed down.
> 
> First, a QoS-only sched_setattr() can return success without applying the
> QoS state.
> 
> In __sched_setscheduler(), the policy-unchanged fast path checks whether
> nice, RT priority, DL params, or util-clamp changed before deciding there
> is nothing to do. It does not treat SCHED_FLAG_QOS as a change there, so a
> call that only changes sched_qos_type/value can return 0 before reaching
> __setscheduler_sched_qos().

Oh, this is a bug. I'll fix it in next iteration, thanks for catching it.

> 
> That makes syscall success ambiguous for a userspace manager: it needs to
> read the state back to know whether the QoS request actually took effect.
> I think SCHED_FLAG_QOS should be sufficient to force the change path.

Yes, we should be only to query the value of a specific QoS.

> 
> Second, sched_getattr() uses sched_qos_type from the userspace sched_attr
> buffer as the selector for which QoS value to report:
> 
> 	if (copy_from_user(&kattr.sched_qos_type,
> 			   &uattr->sched_qos_type,
> 			   sizeof(kattr.sched_qos_type)))
> 		return -EFAULT;
> 
> 	switch (kattr.sched_qos_type) {
> 	case SCHED_QOS_RAMPUP_MULTIPLIER:
> 		kattr.sched_qos_value = p->sched_qos.rampup_multiplier;
> 		kattr.sched_qos_cookie = 0;
> 		break;
> 	default:
> 		break;
> 	}
> 
> If this input-selector behavior is intentional, I think it should be
> documented as part of the query ABI. Otherwise sched_getattr() looks like
> an output-only operation, and helper code can easily confuse "I did not
> select a QoS type to query" with "this task has no QoS state".

It is intentional. If QoS is 0, this is treated as NONE and nothing is reported
back. I'll improve the docs, I do try to say that these QoS must be set one at
a time, which also means must be read back one at a time too.

I tried to trigger discussion whether I should make this an array of 3 or
5 elements to allow faster writing/reading. I'll keep this an open question
that can be added at anytime once we address the remaining areas of supporting
cookies etc.

> 
> The same preflight also checked that short sched_attr sizes with
> SCHED_FLAG_QOS fail predictably. That part does fail today, but indirectly
> because the short copy leaves sched_qos_type as SCHED_QOS_NONE. It may be
> clearer to make the required size for SCHED_FLAG_QOS explicit, similar to
> the util-clamp size check.

You mean this uclamp check in sched_copy_attr()?, right?

	if ((attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) &&
	    size < SCHED_ATTR_SIZE_VER1)
		return -EINVAL;

Yes, should add this too.

> 
> With set/readback checks in place, I can observe a narrow scheduler-layer
> signal in a controlled native transition workload. I would not treat that
> as a generic Android UI latency result or a Tested-by tag, but the
> preflight made the set/query semantics above stand out.
> 
> Thanks.

Thanks!
