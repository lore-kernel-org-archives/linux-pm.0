Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794468801;
	b=VBYlXcpK2VhE2JpcA59FXkQAGYRUDTQANc0GDiIwU+ACYSW+VCOLavirIJlrM2aqW1c0
	 zSLyNkQnpyQRjEFDb8BtG8Ic6YiD0ykeO0A6wZEVZN8/Y9Q0ub43AlZNkTSPf/dJSJQ7t
	 /d6M7S+qgnRESLu6q0/XghQdmLsjqTJ5QH7b9M/gunbOUaVYxwr5VNCvF2g3XlIbFqS4Q
	 Rt2TPDpuaJQrizVpbOLahF8b/vEC8bSnH7rjFd7WVqQkWcTOquq9osoqjlqexxmQ+46pD
	 I4klAfTQJhKiW71zNzG7cVjP9pXoW+tpvtz9f2uBgRtMDZaaq6Csz+NkhiJdd0qKluQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=1O8ABzkG8YTENTJXF3DXPni2PNJOE/E2+2rzStU6Ez8=;
	b=l/R86QWWEEsy2L5GCi/Bi5cLMwiDeRSrtIsfxMqKWX2AgEDppI29G14vfVXbh0jxtb5W
	 +SDTBRNFJen+kS6VlyAl0iaZ0WBT0hGJ7oKs+n/iI883DqgG2olayZH9YKvauaDTwmkRv
	 8fmsdU+oQ/5BsPnoiYkxPfHG1vpcRQXpYYXFpfSwPpivQUy+5EDVvBTbx5A8GtuiXL21V
	 gOm9Voi4tP298NVXLvVs7If7pIKB+CviAiG/NYFCQbG2GrLuvCMEJQTNESnYBJAEk30Sn
	 FpjUxSQS7PP8BVQAPHH9hfsGb7GUbIW+nHk40djtIUhyqeu+8l/VnsMZtp1rUzGLYLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=amYZ82FW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C528606A31C
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C528606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=amYZ82FW
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b750e40ce2so628931a12.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 23:33:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794468799; cv=none;
        d=google.com; s=arc-20260327;
        b=MKsbY+SA6EVPFJR4Knh0CCMPqkJ/93OB+0wCXICb6b4lTAHgdp8ft48qBrg+hBTRdw
         N9EojgYNqS48/hfDwss4TRlCCc7ChacFrcSipP3O0gXaFoWbn+Yy2pAo1Ulh+Ci4yXJ+
         9uGCyeih4+fsQVX5UjELurnWPhD0m+wueY57RmDfNNTeHrf0y4W9Tq2n9rY5DnVbM2fm
         Zd4oqtKFSW+lH1uA0IJ/1wRiujOLU8cSS5ME5g6N6FF/nssbVQt9mxsSZKS469zIEIpe
         zDN4ttUdTtzGJwgd77akdxY/vI67bRW+T69p7hnioF486atHY8r8aSLfCGVMDHtyImCs
         WokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1O8ABzkG8YTENTJXF3DXPni2PNJOE/E2+2rzStU6Ez8=;
        fh=gMZ1A5xpq1EPpxma47/oHqCMo+RdidNMkYwLyMPVWQ0=;
        b=FsDh7FU7jMMZg3QPIEyGljnKjx+xApQILr7Zh1yrzS1xKJlFKQOokUhgudnFzNFFuO
         1i78qsuvFd15L+AWL8GF9AGQzNNy9eM1Atu9uq/Qe5EMPf/BN4fqFRZWCSzDdhRs3E+g
         vCOjkc82IGpH+7bzIHYuScFy1kuhMa83JvjQDc1j7s649g6d8ZT/S5ZWodZlUMLkJtlD
         +CDWDOc7NO6k1dm/f1pmGmX4erLFBynKnilLN1y1xt6yKSuPxFJ1DLiDz/oD5PdoO8xS
         fYOutTyQjNsIMEszCR1F3X5lSYufngRJqzWkHuoUAfJJaXbOtnQ1Dp1q0sa2/j+otJ7x
         ubvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794468799; x=1795073599; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1O8ABzkG8YTENTJXF3DXPni2PNJOE/E2+2rzStU6Ez8=;
        b=amYZ82FW3o6g+B/GcoNBqV5OTDLk8i6gPvFLe5TaaVQamS+IHvnLV8zt5oNTkwR3jl
         J/K3mDVJSWLJDjfnzvNRmcJUrSZjCo0jvD/eO1DlNYzeV0cmAgz3h/lEa/qUNWqqIhIY
         kDq+f5rXK2VzB5kSYSQZBOEeQZatz0TGSSfovehcSsJ3pns0y+/SmEnwNIY+Hj2HV7z6
         WGEwyY002cYx7a5+ikVJhYi+4iU1txTjvTjqR5NZOScN7241mI42dXXOASFUrHURMGOg
         4j2xHzzd3s4IIN2WGMIMA8m9eKhtA9t3Vtp5JzSuGWrdStCwF0AiOWT/kNfRUmgHRrxw
         /H1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794468799; x=1795073599;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1O8ABzkG8YTENTJXF3DXPni2PNJOE/E2+2rzStU6Ez8=;
        b=Cv9M+fgfZVEM1getoCjOtrnDhO02swtEtNkraz4Qh8LF7XkeRBe8prH4HuB41x1vek
         sXNR8lb0MYW6dUR1z7WGBSsh3JQerzMGd58Wcsr7sOEBvR1kp1Nk1hR1glfAZmVzWcTe
         IHNcYF2Ultbw0JabwEgWHwLwqbZAfsM125feYkf7cUxEJ8eI6cHml3qJ7zmlJkYKZA3G
         d15Tmf738ZdbOGuHRQb9+e5gk3nprNEoOHmXTtXYZH2p8bU2kS5phwfJfel8gHq4ihpc
         geAWkVsyN0ZpJGjL382kS68t5yXqw1szamCtqxeIy+yz0QIw9dVmoF+UK5qT2I+gceHl
         MxQg==
X-Forwarded-Encrypted: i=1; AL+hErF3eJILKiZsSz+gYZrn1VHJAJYosL3CRJoUVl7G3dVo/fr5xw/ymwRpqTlvciHzxd+t4cSwFjdV9g==@vger.kernel.org
X-Gm-Message-State: APuU4Z86pfc/QgwhUJdnS9u5BCHsiL0WUIxKpwZ/6wClnaH7QUS4oPlU
	i/kRwRRXwHk/jFOMw4osnNJCqL++bLEpafoBNPeEj8XThCdy63fEkEh1VU5uJKt0yEkdBRmng3N
	8/AjmJ3Q7fEWjX7CktGjkazhO4bdmbJoXK0c6Zd4olw==
X-Gm-Gg: AYBFou0LOpOpWP+b17S8y9pBHkLYnKY0LRZ2qWQ4F3qeLdHotkIJCDTgZivtItWUSGu
	ijBdwPsrvRFAsAu8K7n5mBRIuigF5rePwxPPFryvgiNsvp7spPApKXB2n9XPk2Y8C7rZ/pnht9K
	qqaT6xUmvSjhOv36/uEr57Z5v995EEAaUSuD+NtrRVmSOtgL6SywqfRGPM3kvNWlBMtifkdFxcS
	QWSLH4mWfRcBvC4ISKTN2No0FTF9EdSk28x9RcJYe1vEfUlT/wHTICErGGA3596kvm10/zfreAO
	JtSRhG829pHOK1YEbOxQfUV7ohfqHDJmGPuFDklASKLE7Iznmlvus7jlTs/eBylFf+NWe8M6eMt
	GECLEsN4CTI7pDCHJPwxoH0/oVoD97Mhv/RXdilpyFz7T2rQ5P5HlW2e/oyJpwjW/sv4cLiFgFp
	yJVqFR7gJSIlTDT9w=
X-Received: by 2002:a05:6402:1514:b0:6b5:e088:eb92 with SMTP id
 4fb4d7f45d1cf-6b7777064a4mr2609898a12.34.1794468798919; Wed, 11 Nov 2026
 23:33:18 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-3-vincent.guittot@linaro.org> <f0bdf36b-4453-4d2f-b82c-85d1d62c5f78@amd.com>
In-Reply-To: <f0bdf36b-4453-4d2f-b82c-85d1d62c5f78@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Nov 2026 08:33:05 +0100
X-Gm-Features: AclHuK92tODV1WML6aevk1idgLovQjoH53-Z16DSkLaGxCj8dkYMqR5c5OIoS3U
Message-ID: <CAKfTPtBT1anicEwxsFRNbO4FAmfmpAWT0q-EyHqW2EHgJeORUA@mail.gmail.com>
Subject: Re: [PATCH 02/20 v3] sched/eevdf: Reset lag at wakeup when prev CPU
 has been idle
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, 
	tj@kernel.org, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, kayracizmeci@gmail.com, 
	tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Nov 2026 at 11:04, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Hello Vincent,
>
> On 11/6/2026 8:49 PM, Vincent Guittot wrote:
> > @@ -8376,6 +8383,9 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> >
> >       dequeue_hierarchy(p, flags);
> >
> > +     if (!(flags & DEQUEUE_SAVE) && !cfs_rq->h_nr_queued)
>
> Should this also consider DEQUEUE_CLASS which will move the task out
> of fair class and leave the rq idle? setscheduler just adds it with
> DEQUEUE_SAVE when moving classes.

Yes you're right, we have to update idle_seq when
DEQUEUE_SLEEP or DEQUEUE_CLASS

>
> > +             cfs_rq->idle_seq++;
> > +
> >       if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
> >               se->deadline -= se->vruntime;
> >               se->rel_deadline = 1;
>
> --
> Thanks and Regards,
> Prateek
>
