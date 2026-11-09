Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794238085;
	b=lNYjwC44bZC/VDIPwUOoNst2gqCf5U4MBu4hveSnb5sv36WDK+FoJjLj1/WY60kAg7C2
	 xppAsXzqdNCYLezYcFdUXri/qyp7rlM3TSv2rjrwQSz0RjqDOf0BNtHV+TECM66n94is4
	 YuGe/anSgvjSBXtz64KJ9IW28Ja6l+M+z5ZjuTt+agvpK2Akwdc2V1sTfLFQ5VB7HK03Y
	 KofFpSCslBvzuzaQPeZFGWTTRSoMx3gZ5Q6ldMPmOllh4PHg67h4xkCnm/mGhaMoCUrEj
	 Kz8BnnchBYIXOaVLHNupen0e1C8XbhSR5ngOe6Mj+UaxmW0UhZTDR3OOTUIADWOIWoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=rc8neeysb2lhJi4v3fQWNja46WdfiOwuQ6GoM/+JvzI=;
	b=AAggO7joBUqHnyb9lhuQvIYHpQsOmhIMRPbZQClnQdQ6+wIDogtBp6gY3/PPBnYyNAlM
	 Wj30uROnUk55ullzjAbvHmTZ64zsabrvexiwtEnd9D83cfWUXTVxk98D3MwaoDhUMjz+A
	 Yg4oVAOf8EZOMVKI99L8XodvxSv0Fl0zb9m1KChzOrz1RJiTNFORbe9kbe5+frlUf4a/0
	 rVdGQF3mtc+NUiAk5wxyd0v2/nlAoa77Sz3dlAsj0BRfZ7UzMcUIIIDtNjtD80BEU4/3H
	 q+ZIGz6L1lOEWH/fFGkq9yFMv3RB+8oByar1ufMF4eSqpXcqh5fKQr77lQk/q+LmnpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zHmolP8k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76994606A332
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 15:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76994606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zHmolP8k
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b587538a37so1442085a12.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 07:28:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794238083; cv=none;
        d=google.com; s=arc-20260327;
        b=ZRMJqJj0/jPeBEn71oGS/8NPf//cYnMRQf6Qua0+TUt2jj6Pna+G/CwwN/j+p/ON9M
         UqCQf/ZfjwnClJi3Ue/k/zwhbad0mn9d83OSRfrOTcovws9KMWj7Nkwp4mDYB0h+ocoL
         wTvRvcbIrfb/O9/OTqcpwNkzU3b8ajsKuJYCAxEUQ0GsKzWKD96W8/S2RiVg4/0XoHIb
         jqewU2lwm4HDxzM7eA6c4r3eVduq9/C568T76leS5V+oHKBnUjsnpePyIArazVUgsaTN
         14GQfBgKSErLwN2PW8RsXVP7DMhEQ/ILzNw5C0TRN+vueuF4CwlFIIS5qhjML0WlssOu
         lh6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rc8neeysb2lhJi4v3fQWNja46WdfiOwuQ6GoM/+JvzI=;
        fh=FZzC74WjHD8qZsZltMp/ZxldrDWMueTarjEFLMHrCGw=;
        b=MSddLnZaU8jgBrmOuxVXZr/m+le/W3cIwuj+NPfhBmJOTD9Cavnt+KGIxKvRaXf4Lw
         8Y3fS9GbG+EKElvUJFy7Tpegyx+AwOA1ASa0I4mMlPN24V2seM/rseV9jDguIc0+HDZ1
         FFQTkDZwcrRpSAvASHjBrsPW2eK98EuZ05H4ml65VdSTchtlch2ABTAAoDzJHTB62x4P
         jiJZ0XGFJ7B9x8u8RVslo+TOzDHZvt73ZvdkjftUeDFBaDlqUkXOrYHPtFUGw2wWX93Q
         eU/bSdbH+oCVQMh23gAv7dSDbUuRtQs5NCi1hyt4aYrclNbl9oRmKGgUwV2kkrt5UH7s
         Rfiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794238083; x=1794842883; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rc8neeysb2lhJi4v3fQWNja46WdfiOwuQ6GoM/+JvzI=;
        b=zHmolP8kJzpNhKmXGS2JUdry8wd7hwRK2Fk6tq465Zy6uEp9nOp3OCbY4ANUd4YEWF
         xPIl0WZdHEcYrtwZNvQoCcSOgc1P3tWKyTyFVLPmorOnHudnj2LU+lg4DjXl5iB2PsQ0
         FEDRDDp/jVCw/TSQ2qydBzZcfMgi5J/4ZlT0suLyU6wmscIj07i8ciz7KHhhDBMj/h8L
         njOMLbxga9zrlTjCohbg5oj3C495NMsr9PzYOd1b7GGomW2a1jP69x4yDhaLJvCBEnXE
         G/vS/cgHvmdNowld9azpMV0CzMdlKKZBqlIbDJeOgTRw70tdC2cgeajqJ8rxDlqQVdwK
         hbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794238083; x=1794842883;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rc8neeysb2lhJi4v3fQWNja46WdfiOwuQ6GoM/+JvzI=;
        b=fS+Oy06BGIw3PlOmRemXHJgMJDka0cAqc0UXBCmpG3rgXlMw+XQJ3dvSXih6mNw4Zn
         lxl6twZ+1Uhqi5r+Jndk3RLYdP7hTO/ykS6pf7llNsHMZ7yyW+8XeTQOaoFBzHX/uzIx
         lQo3Q7G3Qo0jA8QPcjxzSXLkdRY1VWeUxEPy5rpA05Vf3+DgGK88DOGchlugJinDuEOP
         lOwJC7AVlfb7SliMTR313chuzaDuaV0HEd4imVb/qspEWLRTsdiZaq7pgYW+k0Exe9/T
         iZk5btAurLKlU8cGw+C66Ai/72jYgZ36PIO/VP3mILKG0Qzche1ApOn6Yc+j6qTwhAt9
         5k+A==
X-Forwarded-Encrypted: i=1; AL+hErF8v/4bCIZ7+m134LwpF5q0rZPCXqywl+exyT66xtB4sdJTBzI6Zx3/V+42MmZ+cVNbadJcNWdxCQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/7iZOC9zDHmzxJ3NBWUwt74/m0PWaTmIWrVaUZkEfSlsns88r3
	1Wi3jsF/wBJYdi01X4pVG0W524Cr6s+yNuOrr3iJbRrcfZ5GfoQcntGzVJzGC1rSarRQX3lncig
	CAXdMc9bP2epPWINVv5tDn0hhCv58u951akDjl91y3Q==
X-Gm-Gg: AYBFou0v3quwxLOxeyjzcBarAWrnszXUZ8TsLdqte6pU4blTo/WBXC2TU1zYo0/q6QZ
	X0O9anqMERuLqMRWXom+RFGalJ6ynAHJSWNchub+2s/etpaar88+RNGHkpCbDwoHliTgmb8zSzN
	n0IavwGdp7tAlAnN9aQVa7MdmkedfDhqLyt/khRHfCiPO55V4BxppV0t9EeNbG6ArV6lvUFYAYj
	WWkVX8ZVy9R8gnE9e4NQ0d+MdTE6TsVSNHvNH2ojrQPtRAddNJblGQtCazKd2/454ZsXTVpjFhm
	iBKYiPSzSzPMkMeULuKNVOYyI1b6fURciwCc/FX5BVO3cu+g1ist6g3Cjnlc8HXvEfNyimh5t4y
	KyFnZ3G+5M1N9SuFxDo8qxYC+eeSZMiU+JpW0Q+WeUt/8tD74iWsRtZkZGDtfFD5hqFeThpVtG/
	xC2yuaYU58uZFYw0w=
X-Received: by 2002:a05:6402:4513:b0:6b7:28b9:f357 with SMTP id
 4fb4d7f45d1cf-6b728b9f818mr2731473a12.40.1794238083112; Mon, 09 Nov 2026
 07:28:03 -0800 (PST)
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
 <20261106151947.3991524-6-vincent.guittot@linaro.org> <au4i4IWFvJw-7Q0Q@scheduler.schedules>
In-Reply-To: <au4i4IWFvJw-7Q0Q@scheduler.schedules>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 9 Nov 2026 16:27:51 +0100
X-Gm-Features: AclHuK-rDLMXgdJprNmM67KERGYoPJj3EfP3DSZ08EHC8kkLhXMU79a1MZdCg4I
Message-ID: <CAKfTPtAwAkm1NaZac2HKDPgAOh=7OjasQRwgr=e5jfSeQe_R7A@mail.gmail.com>
Subject: Re: [PATCH 05/20 v3] sched/eevdf: Add per cpu cached min_slice
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Nov 2026 at 07:53, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> On Fri, Nov 06, 2026 at 04:19:32PM +0100, Vincent Guittot wrote:
> > In order to use min_slice during CPU selection, update a cached value when
> > needed after en/dequeing a new task. This cached value includes current
> > task.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/core.c  |  1 +
> >  kernel/sched/fair.c  | 28 ++++++++++++++++++++++++++++
> >  kernel/sched/sched.h |  1 +
> >  3 files changed, 30 insertions(+)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index d7c3b43158de..031efe7d49fb 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -9012,6 +9012,7 @@ void __init sched_init(void)
> >               rq->sd = NULL;
> >               rq->rd = NULL;
> >               rq->cpu_capacity = SCHED_CAPACITY_SCALE;
> > +             rq->min_slice = ULONG_MAX;
>
> This is already getting changed to 0 in 6/20, instead of changing there,
> wouldn't it be better if we changed it here from the start?

Yes, the rq->min_slice = 0 in patch 6 should have been part of this
patch. I merged it to the wrong patch



>
> Aside from that,
>
> Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>
