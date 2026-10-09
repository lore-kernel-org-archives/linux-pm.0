Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92834E73D3
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557258; cv=pass; b=T9x5XQ5sUSXDV6nHb4ucLcZHOY18okauEWnCDGPRdzK3Ck8xScCDgj4NG9yGXIgq8h7OnqZ6Jd/Tz/0WPO7a8nM8PJBXcgMZygYQtlNoCtskw0R03dd90ls4WeTdIr2sF5rlhsT4pw4hGRdqNg4aJlmYNqKqNG4U7doc1Npn2nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557258; c=relaxed/simple;
	bh=Blo9bZJVD6llKnlgZ8v9dI0/4WMj577+qqF42yQZww8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZ/tx7ux/OeJrHQ4f2N1oXwtt7vZW12GtCCixR/RKMSRyF1Hub2xNF8O2vMmuZra5NmocEdD/kpRLuifhGeEQbq7PXb8S+dXBRq0YEr4pLaSLaqk6mj7HmQfsfe+Vq50YVpcorrq5CEOAk7ihgSRxU77WJiIHI3dGbgNlQpHaMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gUERJ0kg; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gUERJ0kg"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6ae27f06c2fso10415176a12.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 07:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791557255; cv=none;
        d=google.com; s=arc-20260327;
        b=kUmIVpnh/YNjiSX+/OP4DR5zfkgvkI20+2kJGeJmhX16B0Q8bIa6kbOVMdyavRhQf7
         fnS5UC1E7jtNxvkDXrCZp+AaEOn05E7DUYVIjmGH7IBTXA15xt9m4M60dpDjP1/mqIol
         j7a9mbgSLMOCUAvtaeiXaP5mAySRcs2dkeUXj7jumwXmPphxKdUhnC0iCuImlKS9Dpe4
         WWzP+m6K723wkhU2MSyaq1jaVUOfp50mmEjF2S+67CEduv3uujDHPEtNmY/mAyMSreLW
         gTCrlf6sy3puY77sbd+wzI0ePcOYWA9afcKkE6+pwXHzI7kzqTZAjaRiBMd5fxz4sxSh
         avqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fYrhqlvlDqZyhpHYosM1z+TE4xAbOSyFmrTsse4+jk4=;
        fh=Sy80AZ+Jf0CZd/0SI8mAR+ICwql8XRpCB6TO/zG4JnQ=;
        b=G8leM/KaUiM2/03nUAo/EdY2AFvKVSoeRLOpaeIG1155P+zQri6EMC0ZHdgsslSIGO
         rOfUEjq+y3BdH12G8L+CGJDqjJFXbNjwEtcvdtohG5uxLr7uWoq0rWJREXkG4xJ7tUVk
         HDS+Dp7114HahRXb3FbZIVZgOOPsaYLoQoHQBzwT1cnzlrEGCtR4ml8KRXksQImDBOeV
         mrDvGUAajez4e6LGNxKg7h4ritgjuvYPXJUpPi5mMVx7pgxxTz5f1DxoSfuvn1Pv+Qha
         dPwbNyMP775lzDIRD3pJGK/Aid8h9HbwQVaDe32o0gg7dTqwRutZgdlZFbkrV3ksCSzV
         kNgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791557255; x=1792162055; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fYrhqlvlDqZyhpHYosM1z+TE4xAbOSyFmrTsse4+jk4=;
        b=gUERJ0kgym684iLhcbTDTPx/5podNuSRG4d27JEmB1T7OKDPO7oj2MmzfX9gDQBTMm
         ui8JzOM9Tg681FB8uNUtNm7k9ZKHaHlnfwML3F1Tke7JfRXFWm1nKrI1EwHWLT+FBHwy
         vPAXRZwPRpU+bn1UF5lEfdypNcHkl4BySGrxr9jjT1ni6yCGQ4dJY6+inpUX4uQxP968
         fTrR5j9K2v2sOr44LZ0xxUFKFI3y2sBpwKeTfEQIAq0BVmJHCRxZx8KYGmZyUGMx1/d3
         wmzwW4R6HO1ptknETnvxg5CEocB2LQY0ofMwb8o1deca69nGSefNK7DUDBqdycWcW5Q1
         /CTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791557255; x=1792162055;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fYrhqlvlDqZyhpHYosM1z+TE4xAbOSyFmrTsse4+jk4=;
        b=QbIQKWgYF2UW9fSDRGzHy7PgBIHbb5gRvJPb6mwX8/8oYjqhuVh2a+0KjVPiwNHL0P
         gC+w+hR1E1Nu+mEjCmgY5zc2w7TgQ6k5VtLLPxA4zhfoaFw0mbrQVEWglg2Jh7FEfFLC
         q70npwub2N4LufMlAPCRo5cRFvDJ4i7Ta4oDi9ugLuDzyBYrTFBQvFSh5DgIrDFl5EWf
         r6Kxz5WfunGdYJdGD6M45PjXTQrlOW+/9MObTxe+0/+wvgSSoNyx+Rbg5iNfBEVDv/Sy
         MyE+gHYuEROfOS7GXPAnmRuNotmPb1J2Y6Hj25cRShN6FWO/isic/902O03tYnmtwQvU
         H1fg==
X-Forwarded-Encrypted: i=1; AKwUvBzn3mZYAbSvsnfFryJ/qiFk21pYt4eeyrv4U8kIcB0W0LJ8n+o10E9lKOKSoLQbVLGH/S/GkM+y8A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJl4VHObGRvqxfQXYCVG5qaVRBu32VsjvYXCIJFmUVY6FhvvLaE
	X/mAri8n8BlS55yq8GsXVMHr9Qfy6ulrmihOsoRsaL732uDOE72V1XO18pUJV2hg1nTgLsoK1qI
	aL49xhSz8n0VfNoI9I5dSK+K2VoDT5PDfv9dAniwIPA==
X-Gm-Gg: AYBFou0g7nZO2Q78+2QZvGp6RvVqE3SjlDEb3iUjwiWD1ubz1AeFKD9XBJeWVBftLDJ
	AQNZ6/hM8zxraHHtbqipZG9Rz6Dv/KeHKQEgCaH93ezUNpmFJ8aZDvv4kPGsQ/IFlNKxhHHcDs6
	L/3M6/1nv0fexZmXSVrfYYy3D45VASFDL0t40gdcir4G7yAB9jco3w1k5NsVT5i5UYSpf+GY0Py
	VqlVJ6Q4B0VNImm63FRr8FzsVI4IZZ8oOJBiIQ8mmqGvq9vP9Z5iEjdYc/9pKHkjYT+1PXFJ3cH
	ORwCmKQrQ65CWKaXQQ6kDvc6FS1ybuM+xwcus2B0dMb4KT3Cs5zYArareb+lvmER3JuRt59hhix
	QP2UnC5z12oQ=
X-Received: by 2002:a05:6402:2489:b0:6ac:8dce:5a8a with SMTP id
 4fb4d7f45d1cf-6b17c25d1dbmr1911978a12.9.1791557255037; Fri, 09 Oct 2026
 07:47:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002154415.2270586-11-vincent.guittot@linaro.org>
 <20261009055318.29609-1-kayracizmeci@gmail.com> <CAKfTPtBvGYp2S4P-k_SsFAXMVSSQ6j4F4LO44uUoDo5ZaUe1Bg@mail.gmail.com>
In-Reply-To: <CAKfTPtBvGYp2S4P-k_SsFAXMVSSQ6j4F4LO44uUoDo5ZaUe1Bg@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Oct 2026 16:47:23 +0200
X-Gm-Features: AclHuK9iGeFj7ZuSh47IJz473HQO92ge7LwBJsa7yRJFssp2W5pUDwwA41CDc9g
Message-ID: <CAKfTPtCAbreGDhesDmFNvXEzjj+anmOH1=jqT-1B6Lfj0FfPqw@mail.gmail.com>
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

On Fri, 9 Oct 2026 at 16:04, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Fri, 9 Oct 2026 at 07:53, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> >
> > >       task_tick_cache(rq, curr);
> > >
> > > -     update_misfit_status(curr, rq);
> > > -     check_update_overutilized_status(task_rq(curr));
> > > +     if (!tick_pushable_task(curr, rq, rf)) {
> > > +             update_misfit_status(curr, rq);
> > > +             check_update_overutilized_status(task_rq(curr));
> > > +     }
> > >
> > >       task_tick_core(rq, curr);
> > >  }
> >
> > Hm.
> >
> > I think this mechanism added on here does not works.
>
> Ah yes, while factorizing the code, I removed this main diff between
> tick and put events

In fact this is on purpose.
fair_check_pushable_task() is the function that is called to decide
wether we try to push or not a task. In the case of short task, we
will not push a task that is already alone on the rq

>
> >
> > Before fair_check_pushable_task() is called, we check
> > if nr_running is bigger than 1. If it is we return false.
> > So when we enter fair_check_pushable_task(), nr_running is
> > equal or smaller than 1. We first run __check_pushable_fair_task()
> > but it doesn't really matters, since it's output
> > can only return false. Next block is skipped to since
> > next == NULL. When we're at the check_pushable_short_task(),
> > the h_nr_runnable check is always true on this path,
> > so we return false.
> >
> > It this intentional? Or am I missing something?
> >
> > Thanks,
> > Kayra
> >
