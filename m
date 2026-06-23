Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800F3B7B99
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210548; cv=none; b=HvjoBMzzHpOxk+FwtUxR8FnWRX1Y6NKFDL8xDwrwc7YAPX7yOB17CB4HrT5I/4/So+GQZM5lDk5JgpJFMP93GYxX3nd6msmk8zw35cHt0KXWC9cO7v2B8LbkbKFw3kYC1PHGBwjEX/GShPgAaYe4CRH9tzuQE+IiAjGKogPpFjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210548; c=relaxed/simple;
	bh=v3eDplUHHVICsrMYR/QTnNC5iCoLdoGY6rsHDchbcbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SW7642dvUAqqz8Y4miYNiPZE/xYm4KH5Qu5Rb57VUSdTQXlGEgWCcC6RU2u3hoFEkg3EzyfHlKpPJJAAi9c7rn7SjHLrcqu6RPvPOzdGb3jYB3pbW0O4yVXeY/FDWFfL7u+SkYW7nwRS8SvDdoyQioAC1ZlEsEKJuSx+VWbzhoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npZWjfl7; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npZWjfl7"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37d46e0d246so1610460a91.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 03:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782210546; x=1782815346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPWo06spGqbAeJokfbBIcmv9a6SZ2W1cWkC9LmvMBqU=;
        b=npZWjfl7aprS33CFwphc1cVQPd6NwFuxynUDSFx8OMR335wcEdPVNAAf7qKSfh5A9d
         fy6j0Tn3wJUsWR5B9MobQszaHs0onz1V6bydFl8Q3y34vcj3Y1ihyNvSqGsefKIf6OEt
         ozua7VQwBRlBKsXpLRV7J/cs2hUbOMx9BQsYZbkQBI9Oq0MYIENUQ0KX2Dq3hz/NTrLk
         A0qqBlNGm6hNn3kuwR87iOjL2Y3IbZawgZqyTGQPr50FXoRU7x3dG13DbgfITJgZrZGT
         xHs2zQLovx2OgJhZOTnH6qf9V+Q7FAZsyudiWbJUunT5ntO7cQZV4ybD7Rs4wUdrcC45
         3W0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782210546; x=1782815346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jPWo06spGqbAeJokfbBIcmv9a6SZ2W1cWkC9LmvMBqU=;
        b=DdFLaYgYo7YBJPaL36BSeDstTYGBGN80uBm1qfEQE2Qru6Xqib4msLoQhiwimCwRZF
         B/dNxI4YIm9w4qY6FpiezZ7r4yKNtRp/taZrKLVbUtEhxJZhnyZdSENMl+tUmJu3XYoo
         JrUfWh6mo6xVyPo+XVaMPDa3f7rG/CMocsflxCtIuVfUyiXduDnXkyos1jVkUM4iUGAQ
         uaKCdmNjORT5nBVv5bWkdFC6DRJm46kEwqMhluKQcq8lj0UySqBRW0V4O8ULPhDDoXGs
         TZLfSJSaVnZKFCwNqckGgU8y0xNdnjJ4EF6y+G6vtGMtrobkG9p5l3dRU9Rx+dXZhxdR
         c7sA==
X-Forwarded-Encrypted: i=1; AHgh+RrYU/kYPwaIUOdkrY4InMTuWbaqmtcZvItJB4yihb0Y0JSg7oVJJM37ALtKXpTuVCve5zpQnyik7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLqRspyS6logiKYMonE6oJq0ecTQkLcpIoNZj4hNJNyQCWrNCT
	w9LP7Js4G7ghdRUGhnTItpzMHNeHWSvjtprh5RnYtGVzNyq5w0k2vD7g
X-Gm-Gg: AfdE7clQxPI4tzJNnazwXE8UUZQ5KrMSidEgIwwCcBCBghe3ABtIvzRzcuyziSf3IsC
	fze3jKkjVLWYCrgMbvEaGsdU6EILgW6uT5LZFdLFYuzcfZaz/eClbARluOdvuApMqWgREl+4bgJ
	eIcOKFFXx2NNtFrnwaDyZefs+AdM2t3fdSbodw8v1nmUZQpYPDQXeni7sn4Jd4ZRrCZmzl7dmVP
	QnAnn+uYTnNOoKGJFKo0qNLyoiC7GHXXmrZRgeM2w2xGC3c1qC/GiVvpZWzCjFNS8pEMzqFF399
	GUhgfA+RxJbjM3UigXDscYA3L8jwDPtP7CAywI1WvzMWlorX8zKXMwUmq+cMdAtTdtYmlx1ENuc
	ns71oPY6lL5tT8mJBEJ2mGOC9YxFkY257F/48Q14gsfwEV4dcWCWxgsn0UJV8jsxThJZ3rA4QxI
	rmU7ntnk6tCnJc+nESTiJJkpfJ4QZ2y5sYe1dW2SUkbM7RVc6HelRZJHT41za/sR68
X-Received: by 2002:a17:90b:4d01:b0:37d:cb42:e85d with SMTP id 98e67ed59e1d1-37dd0cfeadamr2124639a91.4.1782210546239;
        Tue, 23 Jun 2026 03:29:06 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d15e0b1d4sm13696862a91.17.2026.06.23.03.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 03:29:05 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: Qais Yousef <qyousef@layalina.io>
Cc: zhidao su <suzhidao@xiaomi.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Chen Yu C <yu.c.chen@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 RFC 08/13] sched/qos: Add a new sched-qos interface
Date: Tue, 23 Jun 2026 18:28:58 +0800
Message-ID: <20260623102858.1866647-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504020003.71306-9-qyousef@layalina.io>
References: <20260504020003.71306-1-qyousef@layalina.io> <20260504020003.71306-9-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, May 04, 2026 at 02:59:58AM +0100, Qais Yousef wrote:
> Provide a generic and extensible interface to describe arbitrary QoS
> tags to tell the kernel about specific behavior that is doesn't fall
> into the existing sched_attr.
>
> The interface is broken into three parts:
>
> * Type
> * Value
> * Cookie

Hi Qais,

I tested the proposed ABI on an Android device running
6.18.20-android17-3-maybe-dirty-4k with this sched_qos series carried
locally. This was a direct syscall preflight rather than an app-level
benchmark:

  - set SCHED_FLAG_QOS / SCHED_QOS_RAMPUP_MULTIPLIER=4 on an existing
    task with sched_setattr();
  - read it back with sched_getattr() and check type/value;
  - repeat with value 0;
  - fail the test if sched_setattr() returns 0 but readback does not match.

This exposed two ABI semantics that I think need to be nailed down.

First, a QoS-only sched_setattr() can return success without applying the
QoS state.

In __sched_setscheduler(), the policy-unchanged fast path checks whether
nice, RT priority, DL params, or util-clamp changed before deciding there
is nothing to do. It does not treat SCHED_FLAG_QOS as a change there, so a
call that only changes sched_qos_type/value can return 0 before reaching
__setscheduler_sched_qos().

That makes syscall success ambiguous for a userspace manager: it needs to
read the state back to know whether the QoS request actually took effect.
I think SCHED_FLAG_QOS should be sufficient to force the change path.

Second, sched_getattr() uses sched_qos_type from the userspace sched_attr
buffer as the selector for which QoS value to report:

	if (copy_from_user(&kattr.sched_qos_type,
			   &uattr->sched_qos_type,
			   sizeof(kattr.sched_qos_type)))
		return -EFAULT;

	switch (kattr.sched_qos_type) {
	case SCHED_QOS_RAMPUP_MULTIPLIER:
		kattr.sched_qos_value = p->sched_qos.rampup_multiplier;
		kattr.sched_qos_cookie = 0;
		break;
	default:
		break;
	}

If this input-selector behavior is intentional, I think it should be
documented as part of the query ABI. Otherwise sched_getattr() looks like
an output-only operation, and helper code can easily confuse "I did not
select a QoS type to query" with "this task has no QoS state".

The same preflight also checked that short sched_attr sizes with
SCHED_FLAG_QOS fail predictably. That part does fail today, but indirectly
because the short copy leaves sched_qos_type as SCHED_QOS_NONE. It may be
clearer to make the required size for SCHED_FLAG_QOS explicit, similar to
the util-clamp size check.

With set/readback checks in place, I can observe a narrow scheduler-layer
signal in a controlled native transition workload. I would not treat that
as a generic Android UI latency result or a Tested-by tag, but the
preflight made the set/query semantics above stand out.

Thanks.
