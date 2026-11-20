Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190850;
	b=4NvzQfOaKcu03RX/jQOZzvwckZjoBFPvV5MvIjDj6zIg0sLWXJSXUUozJ09YnQDDcGVG
	 3Et2UZ0pLDcqhZDH+VRZEWJmzHCW2SHdTmp71LKGwOMWaihYFqAKnFT4fCmOST35E88ZH
	 Yx01OXsj7zuHkXt5qwbn1g+Wq2KRUi2XsaasfyWLnF4vI0uzQkFMdFJNapUjdMcu+xb8p
	 WbJ97tOeWO+B25VsO7Zi11p7lNE0jh98Er/GREEbZI74oSnXgAmW+p7ezlvMuG54h2t2i
	 eJ5iToRWu5Q91CWcGE4/Rwx7wKgRhnkaFm+uexcYWTdwtmSwDU2Xg8FZIBXT3aBI8Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190850;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DSoDSKmnZ/wdtbN8f5BTziBY7icX60tf6nSq2u0pRPE=;
	b=n8JUpyw0iXu9P9+NuC6v8nP98ikuIzHYteTzCFhewsNHDv9lE9nN940bWkuHnzuK+TYI
	 p6ZX2C/GJutBwo6wNqRggVIQ9WxlmI1qZMjidJcQqJjL17u9EzmHR5gITRmQSpsd1kT6N
	 bbDM8G65UZbplsul8/4CmVZVoscd8WwV5S6OQKhh3PXaQxZUAUSvyNb3m+hsAJWQ7PSbj
	 o7eGSqIZ/SJCUk46wnaRTK8h+uUIOrdYp0EUz4XG8ErQbMp0b0+cg9TjWKcJntkr3n4+T
	 NRfxbk3s9uyc6ydyvf5FU0A93FIlwr8dyunmOinv+s0LSmrAwspcVMwbVBtgKjkJyrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fr81NLi9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EF6606A330
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fr81NLi9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85931F000CF
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 16:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795190849;
	bh=DSoDSKmnZ/wdtbN8f5BTziBY7icX60tf6nSq2u0pRPE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fr81NLi9FDlyczgq5U68RdsbqjkxmsZtz7qjAMEs4E4tjJmpdvChnalfjX/a/DUUe
	 qN63eyDldW+m+QIRIqMNGHwed6KQQoEuEM9hh5B3UEEFyt3G/mGLlLFagBJ03TJjlp
	 9Quj8Z+dh/nSVMmRAhMF6FcvCXYvkBO1ZzywCdYzwrm2KOqKPNp/4CjR1urOJCcZbe
	 PimK9BRm7v6u7qK/PwIPrte9CwAgUtCVttKIKKkrNkp4+xMSUPt7vlTE3qYRUBB/w2
	 yGj/Qv60LkI3BeD+700iPaCVezhFZWNm9nvAfBEJ8rH9PthwffGEEEA9l954E0MS8E
	 /5vHJLQ8wiIRA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c0a520df2eso984877e87.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 08:07:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEEFEyZPRiKQUoJ60Zv6FTfNHItLG1R52SKCpn57SDViQ05dzIoInV495LgRlZStXA97Z+wsD6Edg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Xzr030pKfa/qOlWdSat7DVAH8D3bpT0bUw0LPFvXFaJQmQtYs
	lrXbMgDF5iCb/lDTww2/vPrAo9LrzR/7hBS4PoMCZ+iVzXOisiibEFdgHEFV2WQj4ucjafQ4wya
	8tvQR8xBTZsINaRAvSnhKpLO+PN0+Rvg=
X-Received: by 2002:a05:6512:6602:b0:5bf:bd7e:197a with SMTP id
 2adb3069b0e04-5c1bc8488c3mr1018881e87.16.1795190848325; Fri, 20 Nov 2026
 08:07:28 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108145028.2483131-2-thnkslprpt@gmail.com> <CAKfTPtD5vLv_wqfGxVB7kEFDQmB6BQDTvJRGLkHXNZ3d0GHuOg@mail.gmail.com>
In-Reply-To: <CAKfTPtD5vLv_wqfGxVB7kEFDQmB6BQDTvJRGLkHXNZ3d0GHuOg@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 17:07:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hn=vO_3Z07p0vf6j+XmF2RQJ19pGwsTwbCkkmQ8gaNow@mail.gmail.com>
X-Gm-Features: Aa3M54rxB6zdVFiahCV7PF3SFDbV3bRDLKf3AI81jweJmWVXHkK_2DFII5eyNEA
Message-ID: <CAJZ5v0hn=vO_3Z07p0vf6j+XmF2RQJ19pGwsTwbCkkmQ8gaNow@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: schedutil: Skip busy-CPU hold when NOHZ is inactive
To: Vincent Guittot <vincent.guittot@linaro.org>, Avi Weiss <thnkslprpt@gmail.com>, 
	Christian Loehle <christian.loehle@arm.com>, Zhan Xusheng <zhanxusheng@xiaomi.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, zhanxusheng1024@gmail.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 11:52=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Sun, 8 Nov 2026 at 15:50, Avi Weiss <thnkslprpt@gmail.com> wrote:
> >
> > sugov_hold_freq() uses the NOHZ idle-call counter to determine whether
> > a CPU has been idle recently. When NOHZ is disabled or fails to
> > activate, the counter does not advance, causing schedutil to treat
> > the CPU as continuously busy and potentially prevent frequency
> > reductions.
> >
> > Skip the busy-CPU hold when tick_nohz_is_active() is false. This
> > also handles systems where NOHZ was enabled but never activated.
> >
> > Fixes: b7eaf1aab9f8 ("cpufreq: schedutil: Avoid reducing frequency of b=
usy CPUs prematurely")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Applied as 7.5 material, thanks!

> > ---
> > v2:
> > - use tick_nohz_is_active() instead of tick_nohz_enabled to also
> >   handle NOHZ enabled but never activated, as suggested by Zhan Xusheng
> >
> >  kernel/sched/cpufreq_schedutil.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sc=
hedutil.c
> > index 14405a614991..50249cc1a594 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -397,6 +397,9 @@ static bool sugov_hold_freq(struct sugov_cpu *sg_cp=
u)
> >         if (uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)))
> >                 return false;
> >
> > +       if (!tick_nohz_is_active())
> > +               return false;
> > +
> >         /*
> >          * Maintain the frequency if the CPU has not been idle recently=
, as
> >          * reduction is likely to be premature.
> >
> > base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
> > --
> > 2.43.0
> >
