Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0275F38736C
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783363927; cv=none; b=PltbtIUTWdVA6moE1iudIz+VE5DaXkkc2+ER7c+nogJQJHIZhBMOlJFP8ohOwUS9cXh7uhhiVbWtyaUZ6TrB/baidnwDjm1KuLxfprT0CTbKvo1rc2KxSw+7pgbePKWqQNUoBDaMfjPVUN2oDI7Tt3gGinktCQUKVstS/PHdk6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783363927; c=relaxed/simple;
	bh=B+YEgf9C6PIcj5YpUHTnIeWbHmKqkj+zvWTKFyv26Ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8kAq14GeiS5EslImyakDMyQyslgTjC/4csz9WCr9pIAccZclRZhKB+5/txf9qvwZMhNzJMEXMQ9QMtZitCSuXs0aYEHom2fMFZGg3QzmoLX3G/CK1VJ2mtmEpz8+wHOeK7vB58V9oDZeppocBixMaEaue3h2K9tM/egIVxYgj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CO+g8utg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CO+g8utg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A606B1F00ACA
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 18:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783363925;
	bh=4Wu4jKp5gGuTLeZTYUOEgMxFCm97ZDdv6CBHk9UuXOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CO+g8utgg1bjp764yXY2npO2SBHJwJ89gfavSTNnp0ogBdsRBdHAXuRP1r7JRmBN5
	 pnn0GCMzrTfyFqmszoa33cK5kRZVCHDMlnjV7wCcGx6GMatbYv+DY0boN0Eaog2Woh
	 0nEZ3sPjbbXMV7br+c1D93W+2kUiw91cjcnBgfzbzE+TZNAz6DqLRjLSYBAHMSTdTr
	 /2/Til1TNuytg6JbUMsKNdwXbk9cFm+3mB9GmIJVOZT68I0pGmaFnVBnT67vSLdVMk
	 cZ+20F8nHksPLMLmsi38Smr3jl0laxfUG/35Vzo50fKlMvHkrrSHPXqlMqEY3tXyDI
	 un89y09Fk1NRQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aeb2bc82ccso3175645e87.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 11:52:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrapS1MasbIzOsVgKJ6YrV66WjV6jOtmmvczsFCxR2FXbhGGzCyzegRouT+gVf/FLfSPjSQ3scGaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGOT602Q5NBc9BCYOBo4C/BaQ0MUEuKjH11V5DIK3F9XoL8B+L
	TZ3ckBsbT8+GU+46AEiIgUwwEBk6lOb/qJxeJwmZ1nV8QmovkKCc8TNfiyyNCQVzX2dGOTckePF
	uwnxCUwnNdQVYYrAFxM9Iw5y05lkobtE=
X-Received: by 2002:a05:6512:254e:b0:5ad:5cec:74d4 with SMTP id
 2adb3069b0e04-5b007bc6019mr256656e87.41.1783363924060; Mon, 06 Jul 2026
 11:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260621022515.10137-1-wangxiaodong827546786@gmail.com>
 <10a04e7d-31b4-4c51-bf68-298f517fbab6@infradead.org> <f08d5dea-e1c7-4ed3-ba1f-c7ac7cce6c2a@oss.qualcomm.com>
In-Reply-To: <f08d5dea-e1c7-4ed3-ba1f-c7ac7cce6c2a@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 6 Jul 2026 20:51:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iLTnNKpqXV_2mYkR4VMOWj1dxVVLTksQZLQ3ZcKfkHPA@mail.gmail.com>
X-Gm-Features: AVVi8Cf0Y3BoHfkJS9_cau8LrVrod4WKIzoZ1FreYDBCfm67bRm-bV9Zdi9LEA0
Message-ID: <CAJZ5v0iLTnNKpqXV_2mYkR4VMOWj1dxVVLTksQZLQ3ZcKfkHPA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: admin-guide: pm: cpufreq: fix
 sampling_rate example command
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	wangxiaodong <wangxiaodong827546786@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: viresh.kumar@linaro.org, corbet@lwn.net, skhan@linuxfoundation.org, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 21, 2026 at 7:57=E2=80=AFAM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> On 6/21/2026 11:52 AM, Randy Dunlap wrote:
> >
> >
> > On 6/20/26 7:25 PM, wangxiaodong wrote:
> >> The example shell command for setting ondemand's sampling_rate wraps a=
n
> >> arithmetic expansion $((...)) in command-substitution backticks. The
> >> arithmetic result is then executed as a command, which fails and write=
s
> >> an empty value. Drop the surrounding backticks so the computed value i=
s
> >> passed to echo as intended.
> >>
> >> Signed-off-by: wangxiaodong <wangxiaodong827546786@gmail.com>
> >> ---
> >>   Documentation/admin-guide/pm/cpufreq.rst | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/=
admin-guide/pm/cpufreq.rst
> >> index 8831cface585..34baf20cc202 100644
> >> --- a/Documentation/admin-guide/pm/cpufreq.rst
> >> +++ b/Documentation/admin-guide/pm/cpufreq.rst
> >> @@ -497,7 +497,7 @@ This governor exposes the following tunables:
> >>      represented by it to be 1.5 times as high as the transition laten=
cy
> >>      (the default)::
> >>
> >> -    # echo `$(($(cat cpuinfo_transition_latency) * 3 / 2))` > ondeman=
d/sampling_rate
> >> +    # echo $(($(cat cpuinfo_transition_latency) * 3 / 2)) > ondemand/=
sampling_rate
> >
> > Ugh. Thanks.
> > Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> >
> > and possibly:
> > Fixes: e54ac586674d ("cpufreq: editing corrections to cpufreq.rst")
>
>
> Thanks Randy,
>
> Just to back up Randy's Fixes suggestion, the line evolved as follows
> (most recent first):
>
> 2025/04/04 e54ac586674d:  #echo `$((.. * 3 / 2))` >  (trailing ` added)
> 2024/10/17 29dcbea92460:  #echo `$((.. * 3 / 2))  >  (still dangling `)
> 2017/03/13 2a0e49279850:  #echo `$((.. * 750 / 1000)) > (dangling leading=
 `)
>
> The stray backtick can be traced back to 2a0e49279850, but it was just a
> dangling backtick then. The closed command-substitution form fixed here
> was only reached after e54ac586674d added the trailing backtick. Note
> that the "750/1000 -> 3/2" change in 29dcbea92460 was not just a doc
> edit: it reflects an actual change in the kernel's behaviour. So on the
> older trees the underlying logic - and hence this documented example -
> is genuinely different, and this patch wouldn't apply cleanly there
> anyway. Pointing Fixes at 2a0e49279850 therefore wouldn't help
> backports.
>
> So using
>
> Fixes: e54ac586674d ("cpufreq: editing corrections to cpufreq.rst")
>
> seems reasonable.
>
> Either way, the fix is fine to me:
>
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

Applied as 7.3 material, thanks!
