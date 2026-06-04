Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4043E9595
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2026 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563033; cv=pass; b=RAjteqmBYg99dLzTDL5KkpXFhGR1WdvtFW7TbiW0s7AFgWol/ynCcRbZfKKBah6Ksqoy0eSLnKcitySTC3U4hzuSbRtOIZfp6FrsUnfVWWHzGj6bS9rxQ8+U0IyZ9+cVaw2POc94vGQHG2qODL0Z/HHBz3Cy/b382FbKEXJQVB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563033; c=relaxed/simple;
	bh=a228Gt6fnkhJ73AS7B3S4HY1Zsd1Op8IFvXhcAR/kSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8uJHWeqKn7i625OIxOCdB0rd1IdKlpeoo9JNQTlJ+FiRX8qYy2Rtx3gMrK8crIXNBpxCQsor8G/aprINlzi+CNiUhLgRa1PjgLphA376kEKEpEdhC9QxswYXTWrYx6Ja5UTCgaj8oAPASYx0hz1l7s2rbS6Wxr0tWhGYIU1xd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EdsRDVmK; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EdsRDVmK"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68cc6c7df99so594871a12.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2026 01:50:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780563031; cv=none;
        d=google.com; s=arc-20240605;
        b=Q+/2cWJWLASbwNM1RuiO5+kvXPg6eYBzAueVLclQnWVZCfNCyl3KZlPn0SF4YdQgY7
         HCqYzR+yLw0p9AkE0XD9nEK3Ju+zhSQLVPjRCNY5TpvA4e+51zvSgn2e6TMmMk6VGx1d
         aGgEzL+yxWxgLNRKx6JDMzsaNT2AcIun0QrOOtpMU7yzWKiMCJ1CvtqeFfn5lH5F8Tah
         RzUcWEp3uAtpY/pVGRNLoBqTbjaHL7JxndpkYSNSq7KfzjGCdGjW6Sf8At64pOTvaks1
         w9kt0LM6P4fTU1Zp16uDOq+rJmD/wE95xTLaY8jfy/leInCwaNTGBpbA2u7XnUBDOxEi
         aDLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=81kvzpOgBt7BGWeChgynHiNk+vsODuQCAG7m3vW5XqY=;
        fh=G3kutoZ7dWSwrMHh0ekSiNDquzdBPZYazlgw0/JB+fQ=;
        b=PLj4uv3c8Pj35NvOTCXCwIvWuYqX2Ve1RIXRVT+9vnZMC72svf5mQVMYaRHjsJtzzT
         TuS8vGfcpjTMUdCqBmySr5igOCMfiJv8s+EjirtXevfz2/x0471JocqehyeXasjwYRDg
         EWwkAoqCOu16/5EZ5kqFgzAsdJ5g40ZHiofkwaZ2Fo5t1wCdDIvlMz7lPmDyfMaRKoor
         XkIvwWFstJU+WLeURWaJjl6JWGzS5n2463RbI055+tMaz/I0IEjIXFwc6qCuQsCoVBFG
         BZBINb8l3cBFmccRXgvZsmVye18O/EiSL0KCsuDsL4dV0Ybkoi5fANH59GkDrW4o8QxI
         mD9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780563031; x=1781167831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=81kvzpOgBt7BGWeChgynHiNk+vsODuQCAG7m3vW5XqY=;
        b=EdsRDVmKQH7QHlRJ8v5FbXrXugwmGddkxhMK1RWmkj7BwcnBYoyj/e8cYgmJQndDQQ
         ypMEFEqJ731NP+GIp9ajqglrcRUYzr342zpa+Cdm9haYpXYAt82m83P8F4XK3yVjgeQF
         2eSiZfri1cq+ZnIJV/GO6pkkXCQoXlxeobWKBKwd+4bO5uADFalMnGH3gBjgjuVgB3oE
         WXtVvsYzZprfaRljIb4CKUN/TOnLyTTk7eTkdS8lkQUdNVLOVjW3N8cAf+GhkhwaqvhI
         cbFjgh9ajz04toqP2huqnsN0iOcGRoH6fNNayMuZ4JFmq0iEssTQZ4U2XlT91ruhOkW+
         z1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780563031; x=1781167831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81kvzpOgBt7BGWeChgynHiNk+vsODuQCAG7m3vW5XqY=;
        b=C9qOv/dQ4dKEtpbQcBLeZ3h+MrWyaGZF0t45EPeuFCkUBYyQIqg3W9rXL44rAeik/z
         49v1Uc4NLTJLmKzmdx7deE3sNnqTSWxZ9hU6GuyRWDrJbwkDR+C1+qfJogKTEOAxeLPZ
         n9PwSzXY1V43dUmDIUCU8qWkt/2oOIfkSPQE15wVP3Tup0EIUiNn4Nh240sOGu/XiwVj
         0qLq/ubJHvfu9QGLHob0rk175SuxzM8YqK3pQz4cN1bQkiJm+u+H5Cv7Vrz+1XbdE4mg
         ZOUO2he1VSVF59GnbXKXphT1zhazvkmb0ezS8Pp0v4iqOKo5kQU8+e1AE+W0bsUhFvuA
         N3yg==
X-Forwarded-Encrypted: i=1; AFNElJ/eFNVF8TwhsnUSQg/9jk1dW1MQxa5k3ktmR6H3+fL+Su845uUfQqbTMsBYTufAUsrjE5hqhj5NUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeFTh74X00j0uhYocbHdokMy/4TE0B0xIGCbqoLHwmsGit9X2b
	98ExLNDxvzfCS7k66V7wrodm9/SWFZGqz9KSxUpTkqA6JYdGsZA7wWCdxotfPp4bSayMfB33/mq
	QK3dt88gBEgIQCq0O1yiQV+VDDY6E3wb/ccw8ZvqaB2fESnF0sR7N
X-Gm-Gg: Acq92OEv787EyRNxEPnju+e0Pp90Up7nkx+4oJdPPASflBv7s9gvpOe2J3MJiGHRWtc
	DFZqy4jza7XfU6jSUamdw94gERVNTx8P2hgAe2+and/ll5v9zw8pIZQT0cSl1rKtGOg+AdAO0Ov
	OASYju0ZewBBmaXdEScuyDr7WqWW23apMdwYWV9ZMVndkzdsD45apNUnJvqPbQW24GxwVBDU6Eu
	JlwpTDH1oH519topoa39YzriSidPGTWI0ou894/BYrOfH8LiYZiCU54Cc/i8lZDnwhaEtUp6h8h
	3WMyqfvltvf9IiaYunuJSGr5Cy97xe5B+FPXEz7sA/U4yD8=
X-Received: by 2002:a05:6402:5285:b0:68b:767b:40dc with SMTP id
 4fb4d7f45d1cf-68e710eb7b0mr3753880a12.14.1780563030681; Thu, 04 Jun 2026
 01:50:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504020003.71306-1-qyousef@layalina.io> <20260504020003.71306-4-qyousef@layalina.io>
In-Reply-To: <20260504020003.71306-4-qyousef@layalina.io>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 4 Jun 2026 10:50:19 +0200
X-Gm-Features: AVHnY4JZzQVDpWl8sWY-XdShGeUPmZWtoI_tKx0co2pq6h7zCYao4oLn6YuAVl8
Message-ID: <CAKfTPtBxVZ-eB=sjj_ry3=BBHrCt5JUq0dbBS0VxLqi3LBfQ7Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] sched/pelt: Add a new function to approximate
 runtime to reach given util
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Stultz <jstultz@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 04:00, Qais Yousef <qyousef@layalina.io> wrote:
>
> It is basically the ramp-up time from 0 to a given value. Will be used
> later to implement new tunable to control response time  for schedutil.
>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  kernel/sched/pelt.c  | 21 +++++++++++++++++++++
>  kernel/sched/sched.h |  1 +
>  2 files changed, 22 insertions(+)
>
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index 5a8f4dc99ffc..dbd450798b03 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -508,3 +508,24 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
>
>         return sa.util_avg;
>  }
> +
> +/*
> + * Approximate the required amount of runtime in ms required to reach @util.

Why ms when we use us or ns everywhere else

> + */
> +u64 approximate_runtime(unsigned long util)
> +{
> +       struct sched_avg sa = {};
> +       u64 delta = 1024; // period = 1024 = ~1ms
> +       u64 runtime = 0;
> +
> +       if (unlikely(!util))
> +               return runtime;
> +
> +       while (sa.util_avg < util) {
> +               accumulate_sum(delta, &sa, 1, 0, 1);
> +               ___update_load_avg(&sa, 0);
> +               runtime++;
> +       }
> +
> +       return runtime;
> +}
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 190515b50dc8..a445add5cc3a 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3528,6 +3528,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
>                                  unsigned long max);
>
>  unsigned long approximate_util_avg(unsigned long util, u64 delta);
> +u64 approximate_runtime(unsigned long util);
>
>  /*
>   * Verify the fitness of task @p to run on @cpu taking into account the
> --
> 2.34.1
>
