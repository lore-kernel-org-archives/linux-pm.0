Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794560812;
	b=e7DQM3jZS77aW9IPLnTNLWqaioUzDt8Q9j3WOpbRvaz84+LGMHqowdSxZTUIkj8Wq27m
	 WYtCXJVb7G39/cGQFa8antV24yamnU4pXNR+X4Xb9YJQQCUncGyM4jkUSYzvIwZ0vrxQ7
	 QAdjyaNVoYrAgYQ5wrW1mtDdT0HmeWvmi08fdxsQZeA4YDCOVzRr3p0diKN2P+h7ImAlN
	 To8YVUfjR8gc9e6okjtQVEnyNGCC+qK26kKKSajha+y62DaUCdZtqK0iPfIO9vdN9jfP+
	 OLNA/riYA9BJCUpyQPolXFwp8M3Cyb2D1J3l35MhLOx9YIYv8S21unqRxhPKgsanj3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560812;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=vtfYfPkpsM3aevCNl4mNbvXtj6ZUPVZ9KyzCjRAl4TM=;
	b=5IRz0AuzggrvX+1IUp+UfjfTocBpbxn6c8+nE69TCCWQS/K1+Wn5xVwDHtPHeNLhGfhK
	 /U8RM3rT0vlSXvYvLkBim7Ww1ohNc+npyHTuxZy650DzSzqKdaN/HMeqIUBIseKYxD8/d
	 yGsj5XQVYXmZ7o2hWBu3gASTlC4u8fkpiqUAlUN3BCOX6vd3jx4C673VyAEPi/6cbwxKK
	 visfNQZQYNzZ7Knle7qx2ttoGiJGNtpFYoXoPpc53q6bRSVmAOrKHHQKdhmb3rpj0ubE8
	 P9j9GjJRNs98TKISG2ih5n+BALCIzYNZhePW+zWxhetoVkAvK3EJmCXN63WBFu6zJpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qZMvMuN6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB99606A31C
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 09:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAB99606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qZMvMuN6
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c50a4a2132cso36802166b.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 01:06:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794560810; cv=none;
        d=google.com; s=arc-20260327;
        b=luftNrhIwMKIM5xw7oYxJFBXGkZGP8vVu3Dn5Ydqk0zlOj3xwGSMf5xxf87JBvubW/
         P88kgVxM4UQl/OV4eEoBDYLnalfmMmo+ud+5uSLxSVpYQ0Y5UambrLPvrBuWPEE5zIoT
         XHT2B8f/7i8qENMf2F9CPInCh4DlbUmhJaYQ+zncekL6o4jAuILmYWC25Uy9VBJn77lD
         /ByuP3204yTFyAEvtgqkSF5g7q0MuI1drIUFIMQVtr/vPj61qT015ekOCzYPCFeGlZYB
         fayPDcFswnYzZzhecV2r8DMa3v1G6hyoHYNUz8zAkl6TIkpMsu4kPkLyo973b1NTRqy/
         LOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vtfYfPkpsM3aevCNl4mNbvXtj6ZUPVZ9KyzCjRAl4TM=;
        fh=sHUrdZocAzzKO0p90OqZmIqZXyGTOz+AJQtwlrtUoPg=;
        b=EdxbvT4KAp7P74A66JBHPXMpW/FCWqeVsrpx93jckkbhRowXeT4o2VLI6/rn6tZPx8
         cK/i6TwJNkkwIEnpp9zn7rNS9PqDcIkx2gO6U1R6FZkbcEVUV9cpR61n46Ha5BPfZjQt
         RcaHbI5sEPGronMN723QAfyRDk+WUOX8MO7PKitlswh7CVIgsVK75tQRlBQ2T5xOQ8Yj
         qr3fdaMclN+/BLkzSExZrIL6PP3iF1JnDMBc/of4/vLTwnqkiB6mfaLQo5sSKAsF6NfK
         zw180QXRuM2xmiMFRREsDG5VmxT3EvXtotu+uCUZEtrPTUQKL3UFbTJttZ0gVBZ4ld+l
         /Hzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794560810; x=1795165610; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vtfYfPkpsM3aevCNl4mNbvXtj6ZUPVZ9KyzCjRAl4TM=;
        b=qZMvMuN6mF9hs+FYGXmLcF4W7l8B9TZOEm23Bx6Dx9QSxdpB91QNO2XOT4Dj2GvCBE
         lE12t2JBRd2XMRu0ECziNZNvKYOEDPd7AHI676/89O+qJXIahxDHCAD6oNVBONFjsWC3
         Onu6zaQ5Mh3+v6nJZFCXfFHDU3sFLrvA8QxoKQsfZHstZoiWm+x0iTD0NcUf8AgO+Hoa
         vWGrDP/MLf8pA89B8fkUQzKmiCHcH6lHJHCXtFrKUr8iDTgETpaD5iHE9vyR9lCQxLis
         TpU/mKCM8hu+GdZHxjT6+1GlgJxobUrAG0thSyXWAKClkxpllZnTsv459Z3cqx7tk2u+
         5kRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794560810; x=1795165610;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vtfYfPkpsM3aevCNl4mNbvXtj6ZUPVZ9KyzCjRAl4TM=;
        b=V0wzeOeKXnpBPMQNflYc6m/Oj1XjFwZGfX6aWUYIB8CQCz1mLeZdoauVWKLPfs5Vt7
         VChLuGRYYLgewzHZmZRFpwm5OXlF2WwiDQp79GdE1ZGZuYLUpV+bt7Sj1H9IhYYwty+h
         Rm0ygQU93ji+Au0xgR1YIHOBO0HIuohmWAdL6pQ20ULph/UW7FzjXIe3Tu9FN8BMOl4N
         JrMyLVUbKP5gjSm9LLjF050ugE2eOVlal12ZXnP4KTm/lJG/fwLp5wqVlMIRMGJpsyRv
         dbnyEwhP22MZfL8SktKyjj6gRopgxNoJqjjYmPwBF7j2x9lyTRHMbIwHftpAzkU+C5CW
         gAKA==
X-Forwarded-Encrypted: i=1; AL+hErGBnD0VeFw6K8CJ7dQiisV8kBNWMqkAqk2+fjBbOCmDniAn2Xk2zZxpk+f0SRZHahKJp6hRghT6hA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/HVsaz/2se3FBOkop68j6Mt75xB1uIwHbv8QHM+kN5QFj6n3wy
	J+1W0mSlt/BZHhMLNo1wF0FBbJfGmPXfoSojFn+RLnIPpuyIO5ErWvKAjU/jmK4lmd4lLG42pcw
	Mk1STQDzRljAyIX+DYq4ia/mIGWXTfI2nyabm1V0vPWeOYdOVMmApF48=
X-Gm-Gg: AYBFou0+STrKvHEfzD1xJv+XpS8OTeoQzIcXzISzJ8yK2OvxASyFmz8IMAozAJhZvSL
	l5/vXphNdlc0eqJOsr0BXB1suz3BJdrx9sEFGPfDRTDNGDf5czCfv0glpPUY9Ou3jQGNNs2UMeb
	qbtCZKJ7cKyr8ZMmXHcEvKfGH2vb6h5m/epyETc/hcteWhvnKub7p1qE1DIleSqaPcghX1HyVcn
	cgD6FavLahHEEzuVHZ07dZ8wkM8W5+IDs8KZ+dBV6fX4vvGywE96BXcwly7G+3mEm6oR1KwyhHs
	hLQFyLR5wcgYtRKzJ/DdIjLIn1g+mEWMaN88MCY1ZYINqkk9FGGtryMlEcrvygcYuaifr93H1PE
	paREK+865hyRXgEiYSGm1PeXosuFVgtnSGY/VWb1c/9nELjoIBsZ/eQfrH+wuotQppWjyrws=
X-Received: by 2002:a17:907:930a:b0:c40:19dc:a24d with SMTP id
 a640c23a62f3a-c5096344fa5mr156377366b.9.1794560809980; Fri, 13 Nov 2026
 01:06:49 -0800 (PST)
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
 <20261106151947.3991524-9-vincent.guittot@linaro.org> <6033be91-bdb6-ce15-5b65-eef73256d175@open-hieco.net>
In-Reply-To: <6033be91-bdb6-ce15-5b65-eef73256d175@open-hieco.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 13 Nov 2026 10:06:37 +0100
X-Gm-Features: AclHuK-1b2VQHyP72RlSkoAcwpr-03tXyP2Sbt0wcavFo0b3c-Gjf1clcwW5VHA
Message-ID: <CAKfTPtCYEgz0cVWLWt+S6+2uwjwsM3xZmjg1oQG7u5CYD9muPA@mail.gmail.com>
Subject: Re: [PATCH 08/20 v3] sched/fair: Add push task mechanism for fair
To: Li kunyu <likunyu@open-hieco.net>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, kayracizmeci@gmail.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Nov 2026 at 09:47, Li kunyu <likunyu@open-hieco.net> wrote:
>
> Hi,
>
> On 2026/11/6 23:19, Vincent Guittot wrote:
> > /*
> >   * select_task_rq_fair: Select a target runqueue for the task.
> >   * There are 2 ways to select the target runqueue:
> > @@ -10552,6 +10712,18 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
> >       cfs_rq->curr = NULL;
> >       if (se->on_rq)
> >               __enqueue_entity(cfs_rq, se);
> > +
> > +     if (next) {
> > +             /*
> > +              * The previous task might be eligible for being pushed on another cpu
> > +              * if it is still active.
> > +              */
> > +             if (next != prev)
> > +                     fair_add_pushable_prev(rq, prev, next);
> > +
> > +             if (next->sched_class != &fair_sched_class)
> > +                     fair_queue_push_tasks(rq);
> > +     }
>
> Regarding if (next->sched_class != &fair_sched_class) - would it be more
> semantically correct to change it to if (sched_class_above(next->sched_class,
> &fair_sched_class))? The current code migrates all CFS tasks on the current rq
> whenever the next task is not of the fair class; I think it would be more
> appropriate to do this only when the next task has a higher scheduling priority.

I'm not sure to get your point.

We want to look for a possibly better CPU for prev when it's put back
in the runnable list. If next is a fair task we queue the call back in
set_next_task_fair()  after having set next task but if next is not a
fair task, we queue the callback right now so it will be called after
swicthing to the not fair task.
That being said we can probably unconditionnaly queue it there

>
> I'm not sure whether my understanding is correct.
>
> --
> thanks,
> kunyu
