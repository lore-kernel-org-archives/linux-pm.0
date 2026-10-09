Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221C4C9E1B
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554515; cv=pass; b=BeYjvyZXpqarFC4CnDzNQ2E/pLixhvlbnO92OvN7xJaMS00/Rw7y53Lml3pP3oTk9d7qIJjVO3zSl0LfnZOsGkEuHL48RthqEZxzy5PCUMPft3y7oKi7YGZt0hb0/B0uKzIRCZsYFb0rtfHgqp57NOHttLl2UR+GfcEfV8yjH3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554515; c=relaxed/simple;
	bh=ITqMKvjpOuO0AQUkP3fW5wgzA4k30wtF5NYHyj6W6LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u02xC7PK9uUalEUJaC6NPHskuhYSdxGDQNA+3di66ffe7eEwHqK2FWlVhiaWee+eeuBms75b+hi1hkV5Ku/r48kHRrJW4SpsyZQFHWzpk/w2yQHXUSK8/5aNbewURnfXs7kY9FNwroRAK3euHpxPobJvg2ywFMSq7DWFqOUCzJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y4sTcuHe; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y4sTcuHe"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6afb0d2a586so7949115a12.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 07:01:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791554513; cv=none;
        d=google.com; s=arc-20260327;
        b=ly6xGK0Pp6CI6a8l1ZVXWbFxGYBNpbItAbZGWJUHWVr+L2SxMjsTLtl3bXDlbxemjK
         8ZU6NGb6fw2vyV9pIrs9dLMjbSWvyqmVj2AgEnT3VqJC9ZYoHMDyB9Q8X/iVEPODAK0P
         fxJRkHa5a0pd5Ox+AFDPK5DOtxunDXNsKlnwM8fvQHwSVtMORYT7SrFvBdX9FQ18k+7Q
         8eKJ3NKvHogl70eOyQK25KLj3qspCAWpjrDn25jQ5jYxnI26SxAi8GlE5F3o1Ihp7iNH
         D0kp8mypqaa4oh+I67pzdkXmLmBtlfT5FpqzPKFV7HYDgjYyX24z7qSv01ajKH1bTgfH
         TqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VCymc19pFg1e7iTVrFtMCVn58qnf/FH0ex401YjyIug=;
        fh=t4JCJDCldE3dxNfJdgLLPE0db7IhORMgPnrWfEwhaDk=;
        b=H+c6d87B9jFzmW2n1P4uN2PEXl3xSTv/C+CR+dmiCRXl2D5q41aBA1kU6aKH1zR4N+
         JleO/aQl/e8VgYX55DzrQSEL8y0YpLhkbIGrrRSzPZyqVdzE7lSDkuysm5IJNYqTVVJH
         glmBJQckc8hHBfKyrVo8bUtsKHEH5NtnXru+O40jPSANZzz3H54ru4VAIm+U2SGrbWc0
         GRb5KrvqU5ihYln4v+xDtKe6Y+E/NsmmELXia2R4lG6U4Bb7JGTLR9SQ+QKAqffeSkEU
         dMuLb+ZqR7x4A1QqFrSgZo7TFEGmvXrzgz1Vlv2Bvff7fa6Qvh8mDPDft6R92G/vo60I
         DmIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791554513; x=1792159313; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VCymc19pFg1e7iTVrFtMCVn58qnf/FH0ex401YjyIug=;
        b=y4sTcuHe6tVvSruWAGDEiSlOjE9zo+ysMqt9m6pFZilk5wzEmZX+GP0cOQTagQokTA
         q2pqGJprugLAgoK3gXKTJGLSs6YKVky4SQZtqDDdbJsV6SX2iEjMaB7pbo6zFMhF2wMY
         qAV2cjbqRIcbQHlrQOnDSo4CdoXA2oF1Znw+pOGS2hXK+RNGHXXp3fFNwaApNt3W86zd
         AdLa/rGJzx9ukdA9ySCXxy1Qs2M9/HwcCrIPRqu7t1So6SbyuG6EJH3zuPXtpCX8VjR8
         Klu77SuI6OlVPm7qg6C/ysiQitv62H7g2ojQvHI7eOD9R4GucTomi4PU9/h10Y8md5n2
         WEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791554513; x=1792159313;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VCymc19pFg1e7iTVrFtMCVn58qnf/FH0ex401YjyIug=;
        b=j42/eaaknFWC07hAvlMxq5d6D1F6WNH7+iBN5ccrRzkN6rSXswwyXhYcZpQy7iVK9O
         vnaJHpwx/gp96VKp6AtmbbKuX4TxZuUAkT+DtJYf/iSSmdJ30nP9Yu9frjKTAzhcPe/U
         TAYPVk9ygDjPO14AMpucpRIG1djZ6eGdlfvMPbvI0eraddC17ekCVKAGCq/pH7p94zVO
         r/uCJfVEAKg3m2pQAFcY4vQwjVfMPGoveHlLlkdYdfQUW++U7YN74U0qRIyJ/jhkwCDL
         XR3eMWlemsn2Uf61pgjuaXtcuQyKpq7SX0t+7RgNP6bkH48xkTOKAnxbWgB1+8B0LP4M
         Rtvg==
X-Forwarded-Encrypted: i=1; AKwUvBw6oLCBxIO88014ifvyDNxnKHWQr0sV4HBFwlLYLrhHkdFMmxuAasDscOR9Xq2ugXh3kC0uAYx7JA==@vger.kernel.org
X-Gm-Message-State: AFq9FYK5E5mKjeSB72XVz6JoQapxk6nPjgIjAEIKLANJ2mfht8WB8P4m
	81F5/B+pnEOKidmf5eU0trQILNAvwD7I9I02anxCoVvr0Aqr59YoFZtj+yPgLv4qJV4rBWbnSc9
	C4mr/w5ul5kIsyTOM+xHkT67nNofYiYVpXAFpo2CdZA==
X-Gm-Gg: AYBFou0qAdReo2/CVx+Fl8Ylo5bVdpONGTCraKdG3tOCRHWDnmx9kP9FakVzDQCpfQZ
	tv2SkJcAoOHtRNQzGYR/2RcphxP3UzK3MzCYlgagoLEbL3aGRsHt+Sgx/rTl4nEECdAfMd2EaQk
	WH7mnRuYY5co+6eHNtB99b6A1FijicgrvYRBho+CETQN3woLI8s/Uf5tKqhwwhQNJCUMPvYPV0x
	EQk9KF+YVw2sMnCVrhTpPvV67++k5YqPoSa0110/Ue3oh9R2CprVrKnvALNItNvc6zXG9/mQ26B
	SzD9spVS6lEvZdzUxcgm92yC//sY1AwC2YtMJInezq7ea8jSS+8pXkbUukhZX74FEfrqpUmBZlt
	Q5l37LlTCWJE=
X-Received: by 2002:a17:907:97c2:b0:c2e:2b9b:f16a with SMTP id
 a640c23a62f3a-c31aa0db298mr219331566b.39.1791554511699; Fri, 09 Oct 2026
 07:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002154415.2270586-11-vincent.guittot@linaro.org> <20261006192414.7308-1-kayracizmeci@gmail.com>
In-Reply-To: <20261006192414.7308-1-kayracizmeci@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Oct 2026 16:01:39 +0200
X-Gm-Features: AclHuK9YZ_WP4WP9H5H0CuoIx36QiVr2v73i8ApazR67nIerBidlId3PkJRLutQ
Message-ID: <CAKfTPtCqz8AVqzo5gEfidftPj2Uebd+QDZs8RKmY4mvi01QRDw@mail.gmail.com>
Subject: Re: [PATCH 10/18 v2] sched/fair: Add force push task mechanism for fair
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: arighi@nvidia.com, bsegall@google.com, changwoo@igalia.com, 
	christian.loehle@arm.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, pierre.gondois@arm.com, 
	qyousef@layalina.io, rafael@kernel.org, rostedt@goodmis.org, 
	sched-ext@lists.linux.dev, sshegde@linux.ibm.com, tj@kernel.org, 
	void@manifault.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Oct 2026 at 21:24, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> > When the task is alone on the CPU, it's never put back in the enqueued
> > list; In this special case, we use the tick to run the check used to push
> > runnable task on a btter CPU.
>
> I love typos. Like, in here. 'btter'. I think it should be bitter. Like:
> "In this special case, we use the tick to run the check used to push runnable task on a bitter
> CPU."
> (Or maybe by a really low chance, it could be 'better' too. Maybe tho... :>)
>
> > +static int active_load_balance_cpu_stop(void *data);
> > +
> > +/*
> > + * See if the alone task running on the CPU should migrate on a better than
> > + * the local one.
> > + */
> > +static inline bool tick_pushable_task(struct task_struct *p, struct rq *rq, struct rq_flags *rf)
> > +{
> > +     int new_cpu, cpu = cpu_of(rq);
> > +
> > +     if (!sched_push_task_enabled())
> > +             return false;
> > +
> > +     if (!rf)
> > +             return false;
> > +
> > +     if (WARN_ON(!p))
> > +             return false;
> > +
> > +     if (WARN_ON(!task_current(rq, p)))
> > +             return false;
> > +
>
> OK. So, this is called from task_tick_fair() and task_tick_fair() is
> called from sched_tick() with rq->donor. So on Proxy bla bla
> this could get true. Or maybe I'm missing something. Dunno.

good point


>
> NOTE: Some more places could have the same case. Again, dunno.
>
> I need more tea. And sleep for not having to drink that much tea.
>
> Thanks,
> Kayra :>
