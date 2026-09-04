Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC743CB8FB
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534480; cv=none; b=R4MO4OAFxrJ+L6W8wzZIVHnuG8f6Av3qrLIxoG3vEuvJncqN6P0Rxw3ovBprviAXSxIzj5y4+FgVwffgkEXGOjYvNEqIoeoDaZySm2+nsQVuUozmlgENTx9TxEWxf5QHRugOzNakLXKB5Y7WBxTy1PXlp4qRnVuUtvlojTaQ724=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534480; c=relaxed/simple;
	bh=ruWNXz+MH8ic+Hyiclg6XSxx5S6B8QbIlGJ/67iib3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcHOYyA3R7icvIeVa8xjGirIOlm+8mYYhozxl8DhTY5Z6SpDjrlmRmSvcDdvB6asVjuFcNRV9B/1X+m9+9OFgqB4zJiMdY3tqMCk5tE5v16yIUThPGnyhpxbU41SdEP1AdEfM+cfsdglN/zgFNr6FS6iSTB4o3sffDeUOkQ9zQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1lRsXTj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1lRsXTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514851F00A3E
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788534478;
	bh=ruWNXz+MH8ic+Hyiclg6XSxx5S6B8QbIlGJ/67iib3E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=M1lRsXTjXYd6/GDJQnnM0A9IJrqKcy7+y43QwLsxNSVIhpJcUubFqVu37xxWL8qlt
	 WnlDxgoD5lupufgaWqMDKvbXB3ogWMqN0/1KjbiGpv3LblydAkSrr39uNP4rl/BZBF
	 wt6JByUnaKIa2GJEVXSWr+4Eq6MK4XXz0hqOtkfTmLqDh4eV1NonZhMPToKPZ6lwfj
	 fxR/2w2IYKjut2fiPLBxJQuJJuSfDKeG4Fjyp/F6CzhRMEDbsppJcPUZIm3qtF0op9
	 BeT1Xw4zRPIgYRi02rssDvfn8WqEDW6Meu/5nVrF8EHH+HhoJCnvV8hItB5sWsTFC/
	 IW/T14rSGuhhQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b5e5ab03afso953292e87.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:07:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzymL2Z2USFZ/Re1oPd20uEhP0eRPxKJpQmDZYEtkK/UHlz3IG6BwL6tAHlCMjMWQdmnKOI0EBIEg==@vger.kernel.org
X-Gm-Message-State: AFuF++mTRk42pUNWZiXZRvJFjgk3bBQ/QLKka0SPxth/2uRaJgWKCLsq
	8APlGxQpIpV3gMQjvfx1MGH6Qa0N8YiHiP/VZpQ/WD1poV8/JjA9upvrYEhMH90X9eGQ3UndCaR
	Zv2zfDqODZf8HgAxMiv2GZHuX8+SOkBk=
X-Received: by 2002:a05:6512:224b:b0:5b6:1a7c:fd8b with SMTP id
 2adb3069b0e04-5b61a7cfeebmr749153e87.49.1788534476676; Fri, 04 Sep 2026
 08:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <83f87db8-fa13-41d0-ae52-544d22e228e6@oss.qualcomm.com>
 <20260902041915.3453421-1-runyu.xiao@seu.edu.cn> <apelmtFEMcyXle8m@vireshk-B250M-D3H>
In-Reply-To: <apelmtFEMcyXle8m@vireshk-B250M-D3H>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 17:06:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jVjW7XAsphJoMX9=RK0NHDtkz+9jLSDVbFwtxfGKNjcA@mail.gmail.com>
X-Gm-Features: AcwNN1XBVhuHq9BgKwUfRlSsmNd6h6splQwKUoG3JYuxxWKyzFJc00eCNfX--TU
Message-ID: <CAJZ5v0jVjW7XAsphJoMX9=RK0NHDtkz+9jLSDVbFwtxfGKNjcA@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: initialize policy rwsem before sysfs publication
To: Viresh Kumar <viresh.kumar@linaro.org>, Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 6:27=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 02-09-26, 12:19, Runyu Xiao wrote:
> > cpufreq_policy_alloc() initializes policy->rwsem after
> > kobject_init_and_add() has created the policy sysfs directory and its
> > default attributes. A sysfs access can therefore reach a policy callbac=
k
> > before the semaphore has been initialized.
> >
> > Initialize policy->rwsem before publishing the policy kobject so sysfs
> > callbacks always see an initialized semaphore.
> >
> > Fixes: 2fc3384dc75b ("cpufreq: Initialize policy->kobj while allocating=
 policy")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/all/20260830155301.2713780-1-runyu.xiao@s=
eu.edu.cn/
> > Assisted-by: Codex:GPT-5
> > Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> > Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 7.3-rc material, thanks!
