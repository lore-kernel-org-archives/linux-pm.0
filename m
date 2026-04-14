Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C625319860
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776191134; cv=none; b=ddGRQYVEa5C8g0Ar7tKWMz/8w95gbWYtLt01Rp+mz6lgJe3MD3PRB637CZAzj/MbsTU0J+T1O/ssClEOWHvAatdgGQc3lfFOUWVbSd86Lq0Icy6mqsuyXKXpOqKwh7/8L1JYOlfU2ehSArhdqrlPCV03S+CoexAv9iKoAthTgmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776191134; c=relaxed/simple;
	bh=G3w0DZ0WFidkPB/uPrbI9py6h5O7bcwpN2Dv7lkGGTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ir5Rr/M5wZzPOBmh1VQ0jo8dEugH2bW2UKwYtz+YOW3mQU7VdW9DyWNd4Fd02OG5DnLcHRKW3z43NuplFHuYbhksypRRbFwDJuR8fgUtSEVBJ+e1wU/+Q2yiGt0u/J5WF0YpuRzP5Idephk2zIMDk3oUS1xaIob8THfSuVHMY6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ytag37WK; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ytag37WK"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b936331786dso692883266b.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 11:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776191131; x=1776795931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KPeEClNJ70HwQFmMmwRFDNn5+7Dvy+a0H3+D1LydCmU=;
        b=Ytag37WKLdbqkETC1go8+hSa41sqknKPK00yveQS2qYT1LiCo/j/KwYrjg2H6iatuU
         pkDk5rPhf10HFL7dtHqlw48wEu/4U0b6AIYYO1QChHcU7XK9yb9/QxbgJzA2AE3ELtlY
         KGYvLXE9EQe7/ybeL4Jh+zuPB6NpeQXoi7Gru2woEZDd7z4SPw2SJjEHMsT2W7oMQK13
         v/o/f5vDunRfIM/PMrFcuRtg05cZOFXRRGIGULmn/sougVse/toHSYm+puqRiPlTNO/C
         e2MhPpCHeN8e+sbzGpDxvcZfdNM3Bv7T2dNvJOB3oIeaG4a17W7hPKgboELXceXspSH2
         /0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776191131; x=1776795931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPeEClNJ70HwQFmMmwRFDNn5+7Dvy+a0H3+D1LydCmU=;
        b=TYcycnQaQZHG4KxOXvfy7ex6xDpTQ7eLrDMK7CODADoqv+gSRgSHQtKH2M0ul/B1xH
         6YYNzfZxmplq3vZm3ICoQPvgxY3ymQ1SO1iYQEWKWoUlzqO+ORzoPF9RssRr4bpo9wE3
         HY0ityi9dThjgBjzZauHsSkJWbeu1+KeWrS38gsRKxUl1tvZbVi/neURNCwXkfDdXoYi
         Mf6edXwzV3XpqFrXH3y2i18IVbruDObVrqSPQWUSNUChTN+qaqyZ1QAzw5vyPZiLo7Jc
         xZZ2X88KHALlD3DobMl55TxayK3DzliiuEr/VHlUaWTL6vDIhZ5VtfNks4F751N/XGNX
         Jw8w==
X-Forwarded-Encrypted: i=1; AFNElJ+gm9acOMdcly8wc3Q9tXOXjbDvLhCWANWYDKIi4IqKreTStMX2kQvt0RbqnIQlOUQD+7efZeiHuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyqWXjQ20ycywRcbECb8yQdDEA478KHnJtr/4FtkRA5S+6BTUy
	1L3tL3lb8KlrC8m9Dm67GeiNV8fk56LB5dmQtkFB7Zg2UOTdvVMwmNxi
X-Gm-Gg: AeBDietud1FMUl5qLhQAxOF5ZfN9dHW6Luu+zBUKxlctzzyzUPMoifWdQjyiwnNg+ZL
	eB4s7tAj1Wx9zMxztxYdGOMwZZTMILXzMhaLSKp+5Dm5DVuWe+L8OgIL72osIctD5vlzQKJivop
	HjN2e1nrGQDru09mtsXgS0c0LyOFwUnoAhmlRhdot93GbnDoXm8Bk7q6i+pGBu/BqQk0jcVptG4
	M3TXqzdLbb73xGnMwP8DX9h8nNiMuwRdOBP8j7xaqMOoh6FkMCc7NdfwJonHP5Wk7sr9jcboAl2
	hFrhHp9vvuVy2WtvN3DFQQcn1os5s6hVt9QNqP1wgMtZ388jiNTYzaOiaE0wCUJ3mWMFUz8aDGZ
	uz5ANQ3Ik/tsl4NF9i3Jo+y7pw0GoeqwXIYrTg5UNiOh7AKKnxJYtR8BW8NfWmC+yRvPrmCYikd
	93aCzfGk94xesDT7EyOEcHAQMZ7D4ndEyLnw6/Zu7VVpnb6J81GnqNLQ==
X-Received: by 2002:a17:907:3e0b:b0:b96:e593:fd1e with SMTP id a640c23a62f3a-b9d71fe2c9cmr952390666b.0.1776191131309;
        Tue, 14 Apr 2026 11:25:31 -0700 (PDT)
Received: from 127.0.0.1 ([94.41.86.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6db92792sm413467066b.0.2026.04.14.11.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 11:25:30 -0700 (PDT)
Sender: <irecca.kun@gmail.com>
Message-ID: <a3ac856c-914c-4b39-949f-634bed501e7c@gmail.com>
Date: Tue, 14 Apr 2026 18:25:28 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: The "clockevents: Prevent timer interrupt starvation" patch
 causes lockups
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Eric Naim <dnaim@cachyos.org>, Thomas Gleixner <tglx@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Calvin Owens <calvin@wbinvd.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Ingo Molnar
 <mingo@kernel.org>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
 Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
References: <20260407083219.478203185@kernel.org>
 <20260407083247.562657657@kernel.org>
 <68d1e9ac-2780-4be3-8ee3-0788062dd3a4@gmail.com>
 <aeb848aa-404a-40fb-bd41-329644623b1d@cachyos.org>
 <ad6BtKRj1GyreNCS@localhost.localdomain>
Content-Language: en-US
From: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
In-Reply-To: <ad6BtKRj1GyreNCS@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/04/2026 18:04, Frederic Weisbecker wrote:
> Can you try the following?
> 
> diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
> index b4d730604972..5c6dfd6bed28 100644
> --- a/kernel/time/clockevents.c
> +++ b/kernel/time/clockevents.c
> @@ -100,6 +100,7 @@ static int __clockevents_switch_state(struct clock_event_device *dev,
>   		/* The clockevent device is getting replaced. Shut it down. */
>   
>   	case CLOCK_EVT_STATE_SHUTDOWN:
> +		dev->next_event_forced = 0;
>   		if (dev->set_state_shutdown)
>   			return dev->set_state_shutdown(dev);
>   		return 0;
> @@ -127,10 +128,12 @@ static int __clockevents_switch_state(struct clock_event_device *dev,
>   			      clockevent_get_state(dev)))
>   			return -EINVAL;
>   
> -		if (dev->set_state_oneshot_stopped)
> +		if (dev->set_state_oneshot_stopped) {
> +			dev->next_event_forced = 0;
>   			return dev->set_state_oneshot_stopped(dev);
> -		else
> +		} else {
>   			return -ENOSYS;
> +		}
>   
>   	default:
>   		return -ENOSYS;
> diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
> index 7e57fa31ee26..115e0bf01276 100644
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -108,6 +108,7 @@ static struct clock_event_device *tick_get_oneshot_wakeup_device(int cpu)
>   
>   static void tick_oneshot_wakeup_handler(struct clock_event_device *wd)
>   {
> +	wd->next_event_forced = 0;
>   	/*
>   	 * If we woke up early and the tick was reprogrammed in the
>   	 * meantime then this may be spurious but harmless.

This patch doesn't help me unfortunately. Thanks.

