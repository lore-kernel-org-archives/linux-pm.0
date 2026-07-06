Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75B3264E7
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783364579; cv=none; b=bBl9XZBmmkVFmFk/x0ilQL7+yKTEJalGxoAESXtSPOe8Xl5MWMcAJmfj6olZCit+DriJ4Go5h81FeJ4F+gW0VaOqdRLKXi95LYJOCX03EcuH9XrIDSEUwP7znR72ZEbaJC9NxMzyFtahcNp8Zne6A8b8pZnTdtND7AEl2I0bgpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783364579; c=relaxed/simple;
	bh=hecZr0qBMEPKBecycFvnIp/qVRnZO6YOkOQ5Rxer+do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMyLvLQfebXpgmwi6BWRaPx7Q+Smjfv2e5y0XOZZ/FfCmEWBKZxjnYLPeEjowSUx9zw51IQlQ6h7PRRxHyWHlZogYQZw22cYXxhVP0gafvdQkYIb+UC3CWQO6X0KwZ6tUgg4k198mQd83Xx8LztUzBBNNDKaKm3x4QIhPCD5T7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVLDdG+l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVLDdG+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706EF1F00A3E
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 19:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783364578;
	bh=7hhGD5qf89ZeXTYedbPnQ+sUsKyCIfo3XPnuZskJXW0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NVLDdG+lueWHHhSib11SpwO3qGYaJWlZPvbvogrrGePwciJcAdRtX+g3UCuOu44C6
	 /qODXh6XmLQM9X82O8SvrqePj7Lrvz5LegJQ8qm4F/vmSrG3wdDJTb0B+/jqY8FTH7
	 4Y6WJei76+3+h3YhJyQ0I0AqPgz16T8rs4yBquws4I0MxHNassM9LSc6FUleIeHYH8
	 3z35VgSo2hD/BsIADa++qT/cZDLz8x1rvkMT77Jrwz2u1yFh3QgPXxrwMoPQjUL3ve
	 xyJwzs9fsvJ6ZnaiBf2cm8EWnsgwX3BEo1fjXDgq6i+q/54OL8og3gKrVI1byXcUI4
	 +MD3nUOqFwo8g==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aeb78090edso2507800e87.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 12:02:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RruN3N2K65NI/6pXerppfWQeXVEkOcY1F0Cd+DTTfroXcdoQlj29hmUAcPiV5W2c8mZpdbH5xSjig==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpH4K+LVDYYu7GamAkvJWdaNBxU0+MS6SR8SAi5+vmViEzWFYW
	sSoj+XNMyHO4Uxq8nlYeMd0CjDJdNFCGwXbUVA2xlRQTkVObWrliPjDwnnp+v/vgKuSFvK38l4c
	O/RchtcXUqwwEo5MQRboUyVp+tcQhcdA=
X-Received: by 2002:a05:6512:838c:b0:5ae:b78c:1de3 with SMTP id
 2adb3069b0e04-5b007c4acadmr271595e87.42.1783364576889; Mon, 06 Jul 2026
 12:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703092433.4080165-1-zhongqiu.han@oss.qualcomm.com> <483bf544-a033-4f43-870e-2a49790ccbbb@arm.com>
In-Reply-To: <483bf544-a033-4f43-870e-2a49790ccbbb@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 6 Jul 2026 21:02:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hJDVYcRiYJss8xJOs88K0L9odZtzJQutXV3jnU-fSJhw@mail.gmail.com>
X-Gm-Features: AVVi8CeLFOP0g9merGdz3NoxrAR5gIeIa-TjTsShK5UU1HTXPsfjwEMzG04K6YY
Message-ID: <CAJZ5v0hJDVYcRiYJss8xJOs88K0L9odZtzJQutXV3jnU-fSJhw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Fix self-contradictory comment in sugov_iowait_apply()
To: Christian Loehle <christian.loehle@arm.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, joel@joelfernandes.org, patrick.bellasi@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 12:17=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 7/3/26 10:24, Zhongqiu Han wrote:
> > The kerneldoc of sugov_iowait_apply() says the IO boost value is increa=
sed
> > in sugov_iowait_apply() and, in the same sentence, that it is decreased=
 by
> > the same function. That is self-contradictory, and the first part is wr=
ong:
> > sugov_iowait_apply() only decreases the boost.
> >
> > The boost is actually increased in sugov_iowait_boost(). Fix the commen=
t to
> > name sugov_iowait_boost() as the place where the boost is increased, so=
 it
> > matches the code.
> >
> > No functional change.
> >
> > Fixes: fd7d5287fd65 ("cpufreq: schedutil: Cleanup and document iowait b=
oost")
> > Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Applied as 7.3 material, thanks!

> > ---
> >  kernel/sched/cpufreq_schedutil.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sc=
hedutil.c
> > index a4e689eefdfb..f7aa26d62700 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -314,7 +314,7 @@ static void sugov_iowait_boost(struct sugov_cpu *sg=
_cpu, u64 time,
> >   * A CPU running a task which woken up after an IO operation can have =
its
> >   * utilization boosted to speed up the completion of those IO operatio=
ns.
> >   * The IO boost value is increased each time a task wakes up from IO, =
in
> > - * sugov_iowait_apply(), and it's instead decreased by this function,
> > + * sugov_iowait_boost(), and it's instead decreased by this function,
> >   * each time an increase has not been requested (!iowait_boost_pending=
).
> >   *
> >   * A CPU which also appears to have been idle for at least one tick ha=
s also
>
>
