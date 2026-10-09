Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670534DD6DB
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554664; cv=pass; b=HxngT4Gjv/zQlfdtffR6pTIcQ+bPaRAPR3bq+6Ko+1ymibT/CZz1whhHJphb73+Hd9Lv6FWahvbqpDd3zaLPklKtYBIyWtRR6U+G+iAB6WmF345mtdPLNld8E31521BfJ0u/mMTGGsjantVD5OxsYLkLrTBpNwUsMoYc8aR5DdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554664; c=relaxed/simple;
	bh=+HnSit/5/uIBAXvpoT34XbcMxm0QUvBctmOU9VDQG8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGxSt3UNxXusIHkjKQMzR9gGEl2SwPbGw9UC1Unw0OEiulS8hdp6ao/xniHhTEnzvSRSQb8y0indMWz2au4qmxJCCtWjT6MJiiyenUuJv5+TREfQqGMzTZtNRnT73WL8PrGDqIFXJ9z+UP+inKcXwmlG92v2L4UbZEmdphz8vvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UwhCR56/; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UwhCR56/"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c31745ad205so302965866b.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 07:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791554662; cv=none;
        d=google.com; s=arc-20260327;
        b=fGyvUpEZStuVGaczT1PNIr0l3wmnviSeO/1zDEtgp7DJXsU3/rjwcYWkKgA2YmLluA
         bJ9EkZ3QxatREtijM6Wzi8oFUThf1PjRYX7SdBxrQMuPGWcjf6pbZA4OJm282N+pijbj
         L9eK8Y5U2cZTCilABTvOKJyY4fJYjiGBq3VOPcpQ/Pt8bfBLHn4ts8Ikt8CZxRWzYYlX
         /MfopJFMLqLOxAgQ2jozCq4pXPNhtDMrJ0qpLzlCLMXSpGEyABDpp9wjX+0zNbQxMcEQ
         nF0fSHUYy2ZSRmDPSgSehMykQXujK9kZ0GhmcpCI08phymorJy+qsQbmeLI4mYklJdZY
         737w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IeMqwdQ4R4qb72l2CyUr/K1XQPmObo/435VbGVCnIr8=;
        fh=YZHWnsrfh26u06OrX9iL1LStd5yVm05kXqxEp8klDSs=;
        b=hjC2O7CQCGaPqOXqrRaGEtpdf8sL+2dnULE+3viWypX69h3iAIvpgGDdAfoWZDZ0lw
         zwRODw76rY85v5Th/BO5gUmpxFv9ubBkvlvLVphbvyO00Hkwfd1Ti7lhUQEE2n9ODTbd
         /YX89yNHOnCa0ZSba7VyjvxiMEkuT40OHjXfOoNZ9uUlgJZpB4z6B8RfS8QR/BzO253M
         nifXuZMN8NZyMRMg00p7qvv6crDWh1aY9X20M3+3dJbVRBtQGQN75uxVP26OHcq3DtlW
         CnPTYGFUtua6dCi6XmunnN3T+c4T394TA8KV0/dIAtvc7O90mDodxRh0/h+E5vlTmpC0
         ZZDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791554662; x=1792159462; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IeMqwdQ4R4qb72l2CyUr/K1XQPmObo/435VbGVCnIr8=;
        b=UwhCR56/4HCe/U7/N5flKGhytQ1/JkHyzbwYvLl1CHqK7HfFdYmxGfI2eyoZnO3fYx
         vy6Km0qIuY10atB4p+IijZMsjVOdhmYtprvjScxTQke2BZk/03vUwxblqe5gKmuks9Vr
         Xm0iKxD2zBYO4yfziXgssRzNdQqPIpfpzL8henl7egCMtfttSpswKzS6ba3/fWMQ3Gox
         v0n7K2c0NmEnTHLxtkzgFaCphBRczWFf9jbplBh10+GOU2l1/+v1UR9ZuL16S+133POp
         114YdIDBOuNYb0rx2dIP3BOj9cjZXG5sC2FqvE1LeWyTfn+afy6+rt9+6FApDOEo92en
         w7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791554662; x=1792159462;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IeMqwdQ4R4qb72l2CyUr/K1XQPmObo/435VbGVCnIr8=;
        b=0PXZd30xKkWg6dyNaH/f5BlbbgqX/cyzuIzrkAChcLIb9JAHMUIfnDwHPxjjCq38cb
         I9eHXPsyXxOlCUVPRQ7dNtY/POfYqNVInkJmo0p1qVgSQ6T8DA/7I8CDsVjhJiHYUZF/
         yyT+iJJT8IHirnUa26ERQvOD5LHHeANj7hkkMCdmKD3whjuWzkncwcB3w3981g9ooq3O
         rfMxunoUQm1gEESxrrr2aYnev1LfrfKrMPUuKdCn36VZX6QuvVIo2KXmuRNTpxPRlEGK
         ez7LOksZ3sT2W6x/BiH9CDqt7CcHBQmFfQ3xuz64jg6UYx5BHWzElTWE3Q77eRQY7El5
         8GxA==
X-Forwarded-Encrypted: i=1; AKwUvBwDI65INRoC6vq8CmkkgpJheEf+bwe3pux5mzklDtrculJSpT6TYcKSla6Yqq5vWLvbVa6Yp7An2g==@vger.kernel.org
X-Gm-Message-State: AFq9FYJgpxSVBS+ELTDEgv2CVF7WIfbe2Jw77ktM33ebHR4+L+5LEsuQ
	jjdrmIkukqoiS+uxGl3KFcmEDj3U1qynvdtaIb667wPy//3WcYJw+fxq8WqhEiUqZwkUd7a/354
	MHBWnOKYJNW9kiEjoPtPDMBotpWb74RTW1sE56RyGpQ==
X-Gm-Gg: AYBFou0mYwpka/VhA2BCnrUlVyCLnsF6+IcAxnlEEYqtUcDOqHyBGsvKEmCysNfWveJ
	amZHdaoaGYZfdMRGo1YtY/W6XFbhVvAanvYRuLISncgcOX95DidmUxSguws8RtROe6g/WeI2ywt
	L+4LD7FBqaPk5Zst9bCLwGMsKm2ZIB4+G9xaG+waKKHXMDaBspJJD6ucrWoPmSbNSRyjXs4YlbO
	V6gyURPVEZZsvnjTtfr/IiXj6FnInBZ0F4sBJQYc2aFgYpvIDJBPO2x+bUKUwRH5LHsm1esB8eF
	eaLwW1O/9hcznlhFNZGEeB1dp4XuyBfsgFXTHgrBDf7hIxnx+7uUtcwconDiK17ixuPz7HdeAzj
	fWxfYnci0xs8=
X-Received: by 2002:a17:906:d555:b0:c25:5159:6a25 with SMTP id
 a640c23a62f3a-c31a7006d53mr258933566b.6.1791554661604; Fri, 09 Oct 2026
 07:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002154415.2270586-11-vincent.guittot@linaro.org> <20261009055318.29609-1-kayracizmeci@gmail.com>
In-Reply-To: <20261009055318.29609-1-kayracizmeci@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Oct 2026 16:04:10 +0200
X-Gm-Features: AclHuK_rHLMmKPRTiOq8naJcPCrEjVVB0YgPUjC0ODNFXpu1g2ATxHoAse5_WlY
Message-ID: <CAKfTPtBvGYp2S4P-k_SsFAXMVSSQ6j4F4LO44uUoDo5ZaUe1Bg@mail.gmail.com>
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

On Fri, 9 Oct 2026 at 07:53, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> >       task_tick_cache(rq, curr);
> >
> > -     update_misfit_status(curr, rq);
> > -     check_update_overutilized_status(task_rq(curr));
> > +     if (!tick_pushable_task(curr, rq, rf)) {
> > +             update_misfit_status(curr, rq);
> > +             check_update_overutilized_status(task_rq(curr));
> > +     }
> >
> >       task_tick_core(rq, curr);
> >  }
>
> Hm.
>
> I think this mechanism added on here does not works.

Ah yes, while factorizing the code, I removed this main diff between
tick and put events

>
> Before fair_check_pushable_task() is called, we check
> if nr_running is bigger than 1. If it is we return false.
> So when we enter fair_check_pushable_task(), nr_running is
> equal or smaller than 1. We first run __check_pushable_fair_task()
> but it doesn't really matters, since it's output
> can only return false. Next block is skipped to since
> next == NULL. When we're at the check_pushable_short_task(),
> the h_nr_runnable check is always true on this path,
> so we return false.
>
> It this intentional? Or am I missing something?
>
> Thanks,
> Kayra
>
