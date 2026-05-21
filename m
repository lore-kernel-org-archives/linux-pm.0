Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C263525B0BF
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376773; cv=none; b=fByqowCQCStkZwEseHMyjPFEawRNGBBUO635o2b1kQtqdCSGf7smPqVejRxbe3H5tJwt8Pim8SwKpiiUh1H11nD1nA6vFdr7k2WqYZ0oW2RTsQ9h91JDW4iOWDvlm2XiqeJQZnQwyFc0GROntYJDxdvC/kBaqSLA9sxhaMMfE88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376773; c=relaxed/simple;
	bh=BIsUe6w+KM5x0w/5vjYn2j7/HYDXWylVNp8CZFeTHaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrbVfuGUOvxmTeIR49SMuDqZdEOb7KuelL2Tq1RyxP95IFhUEkBeO3GIk8cDILiMuG6+siyTnDVnz9DN13pgGFnUVUSt53G4Iw5en785lVkP6TcFZvT69e7rMlLoxS6WBfa5wgLo6/y3uEIsBam84PAE7QJ0GRdtL/io/dGGZ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=je3t1kkP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="je3t1kkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B53A1F00ADE
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376772;
	bh=aALeOR9hfy8bHyrlawuLA7z1MlWWj+GXYcbQDLYD2eA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=je3t1kkPF2eT9rIqHF2nxL4008/ld+vf7A8qVlX2Wc9/GPPBPGqZlWRHp5AXAfaFF
	 a0sSDTVxYuIDKEJltNaa9yii1qwnrpYz6kMrza76Vf3P7u9paYas28hhlw6FugaqZe
	 VNayY2FexTCVN5je7NTCsC8XOLpxIO/So28GXq/JXTqq9HoYYuFM4ERe3BRzYZ0UdX
	 Yu10NhMkbuIx/IjMeDaKHLku8BQ7WANFfUSCzkPsh+dkmE1817PFQc5h1h5Y0Oqg9s
	 e+64+af4SGC8FzoBfnjBIguKbyhjWpRNanO0lZzcEgMlphvQ3erdiJ+kKywzLbKRB2
	 fTB3UyenaUp6A==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a8d1f43432so10801185e87.3
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:19:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8EcA/XyOxkjMpJtMKmYaIzjudkxRydQgg/+/3pRYdVE95CsuMvT8jrxQqFtD3tWdKpcufHnapahw==@vger.kernel.org
X-Gm-Message-State: AOJu0YywR4mG6bw4/WFW5kgnv+kVJWSq/p58vglvsMZQWu+Yiaxl/X3K
	3ONYzhej15uABoMiWZY2cM20FqM/sRb6uf27Z7dd7gLr5b4f/3lXmZ32N2Hc2UqcPhwFRgMGamj
	s+q6HcsbfhOqn8plhC8BKAx/JaMU5u30=
X-Received: by 2002:a05:6512:2186:b0:5aa:143e:77b7 with SMTP id
 2adb3069b0e04-5aa2ba98f34mr872047e87.43.1779376770909; Thu, 21 May 2026
 08:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0ie54h2aK05qNZTWNw5bu7GZDgsxM55KSsuF=ReLMkm-w@mail.gmail.com>
 <20260408141914.35281-1-nanmu@xiaomi.com> <b3cabf3d-7672-4816-91f0-e6fafd9db4d0@oss.qualcomm.com>
 <20260511111407.455-1-nanmu@xiaomi.com> <ea8bbb35-0fc5-4d45-9c9c-577e97282afe@oss.qualcomm.com>
In-Reply-To: <ea8bbb35-0fc5-4d45-9c9c-577e97282afe@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 May 2026 17:19:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jwRPQCkeCpm8rgE7Hsbg8ZnHPLYxw=91FeFsdqBKeUzw@mail.gmail.com>
X-Gm-Features: AVHnY4JHIxQJE9MR2VKyTWZUAuAU4CdggCoMQHfijiStRWhEyrD9xNsf6jpedJ0
Message-ID: <CAJZ5v0jwRPQCkeCpm8rgE7Hsbg8ZnHPLYxw=91FeFsdqBKeUzw@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: Fix hotplug-suspend race during reboot
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Tianxiang Chen <nanmu@xiaomi.com>
Cc: viresh.kumar@linaro.org, lingyue@xiaomi.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 3:54=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> On 5/11/2026 7:14 PM, Tianxiang Chen wrote:
> > On 4/14/2026 10:44 PM, Zhongqiu Han wrote:
> >> May I know did you test this with lockdep enabled? Specifically, does
> >> the new cpus_read_lock() -> policy->rwsem ordering in cpufreq_suspend(=
)
> >> trigger any lockdep warnings? Thanks
> >
> > Hi Zhongqiu,
> >
> > Thanks for the review.
> >
> > I did test v2 with lockdep enabled and was NOT able to reproduce any
> > warning.
> >
> > No circular-locking splat or "possible deadlock" report was observed
> > in dmesg across multiple runs.
>
>
> Thanks for the confirmation.
>
> >
> > My reasoning for why the new order should be safe:
> >
> >    * The patch establishes  cpus_read_lock() -> policy->rwsem.
> >    * The hotplug path already holds cpu_hotplug_lock (write side,
> >      via the hotplug core) before taking policy->rwsem inside
> >      cpufreq_offline()/cpufreq_online(), i.e. the same direction.
> >    * I grep'd cpufreq and did not find an existing path that takes
> >      policy->rwsem first and then acquires cpus_read_lock()
> >      underneath. If I missed one, please point me at it.
> >    * cpus_read_lock() is a percpu-rwsem read side and is re-entrant,
> >      so even if an outer caller already holds it (e.g. via a pm
> >      notifier running inside a hotplug callback) this is safe.
> >
> > May I ask whether you have actually observed a lockdep splat on this
> > change on any downstream tree, or is this a precautionary question?
> > If you have a specific call chain in mind, I would like to add
> > targeted coverage before v3 so we can nail it down definitively.
>
>
> This was mainly a precautionary question on my side, to make sure there
> aren't any hidden locking concerns. In my experience, running new
> locking changes under lockdep can be a useful sanity check, so I wanted
> to double=E2=80=91check.
>
>
> For context, none of the existing cpufreq driver .suspend callbacks
> currently invoke cpus_read_lock() so this does not affect any existing
> suspend paths.
>
>
> Looks okay to me.
>
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

Applied as 7.1-rc material, thanks!
