Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5107D3C0A10
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926593; cv=none; b=NjM9OB0XjbK57xoNuZnWi9cDlZ04o4j+930749ZnVUXdJZS7/7Xo5N8ov1FRJE7nJ9T+EiS7jZeq30ojN0eq466aBVISy9GgkA4Ewv0ucSp2k35f9JOaSFNEikQcn5dG6k7aRRKRMHIOQH0tK5xFIxIFKJtw/f3EHtILP4v/YCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926593; c=relaxed/simple;
	bh=PWYXr+ZoyYQYPGuHWuNw8UOZcJClfeYZxpxnQMv+/+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1V57AggULw42IrR43B7+7wMS292gwkrGBI/GPDLuXSx8CLBHIJ+JfYoOFUM860NHpkf/PW6gwnFZRzX/2spSl6odyzGWEEx7EFRfT+MhoF06XmH1CI7ThgiNYsf2dbEIcclhZPoptVkDDe+WGw893YXRr4THQjKX3r4hz7Pkjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXteCTWM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXteCTWM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A531F00893
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780926587;
	bh=Sma7ibtRFYlIEhmwHMzo6KzW9y+zKN+/BTTbVxcUjsc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eXteCTWMmhI+sdVTG9c2N8vlT4LlRqwcl3EjqTjT5VBxh7N1X5fU4PqwkbP/YyzIZ
	 q/083lH0offB01L/krd4YF6E1Yw2SiRV3Oc7miNqKsKHJmvElyB1Bhkt7tHqp/zIr0
	 4LLTe1kcj61eQnjpo95X7mbnN2nuV7Bnaz1oUCv6Gy9wCO1pZ13jKuRA/6QV6DcKEV
	 rPyEOwzhCPNoVyEup9wuwScleOWnggx/8K0jnwX41/sLkiSmlx5GlWKibZOzr/giMR
	 GO8jyu3sohgB3e18AZkN4dasCLnWOBdLKDThFSmfB7rWBsxkSZF1tVZEO/d/DNr+9M
	 gJep2yTTG619w==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3967738c801so37239041fa.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 06:49:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+YnJTwXU8DN28I5pvLgWTiBVbh3M4RkJQfBMlSv+i18efPsfuF7G1lb9jswaej4TEB6YwY8lPj8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyjuN13wLPUy/if0K+eD3tfrzEt6kMkTTpB+cXmzuXAq67DwZf
	rBaA5n4ohdOUYA6L36/wichMMhhGJT1PpE3uN58cHvonLAeqCNKOzUfrd9fQArVXuZxe1wxSNwK
	17wpeWWhJc+zUwJmX48OVPbhLMWVpQZY=
X-Received: by 2002:ac2:4c51:0:b0:5aa:64cb:9594 with SMTP id
 2adb3069b0e04-5aa87be4524mr4994267e87.15.1780926585468; Mon, 08 Jun 2026
 06:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606210420.2311145-1-ovidiu.panait.oss@gmail.com>
In-Reply-To: <20260606210420.2311145-1-ovidiu.panait.oss@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 15:49:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hLqhe9ume5E6gG0S6bKRKT-z=2QqbdA3vuxTGdKRUdjg@mail.gmail.com>
X-Gm-Features: AVVi8CeBrRQ3NaFqmZqtwaMdZuxVhSgjFfJEmMIQ1Cqu7byT1dQ27pjOpTVzGoM
Message-ID: <CAJZ5v0hLqhe9ume5E6gG0S6bKRKT-z=2QqbdA3vuxTGdKRUdjg@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal: testing: Avoid NULL pointer dereference on
 missing arg
To: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 11:05=E2=80=AFPM Ovidiu Panait
<ovidiu.panait.oss@gmail.com> wrote:
>
> Commands such as deltz expect an argument after the ":" separator.
> When the separator is missing, arg gets set to NULL, which is fed
> directly to sscanf(). This causes a NULL ptr dereference:
>
> $ echo deltz > /sys/kernel/debug/thermal-testing/command
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> ...
> sscanf+0x57/0x80
> tt_del_tz+0x39/0x1e0
> tt_command_write+0x115/0x140
> full_proxy_write+0x5d/0x90
> vfs_write+0xd2/0x480
> ? srso_alias_return_thunk+0x5/0xfbef5
> ? count_memcg_events+0x8b/0x1a0
> ? srso_alias_return_thunk+0x5/0xfbef5
> ksys_write+0x75/0xf0
> __x64_sys_write+0x1d/0x30
> x64_sys_call+0x223/0x1dd0
> do_syscall_64+0x97/0x4b0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> To fix this, make arg an empty string instead of leaving it NULL when the
> separator is missing. sscanf() then fails correctly with -EINVAL on it.
>
> Fixes: f6a034f2df42 ("thermal: Introduce a debugfs-based testing facility=
")
> Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
> ---
>  drivers/thermal/testing/command.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/thermal/testing/command.c b/drivers/thermal/testing/=
command.c
> index 1159ecea57e7..5513a26feed7 100644
> --- a/drivers/thermal/testing/command.c
> +++ b/drivers/thermal/testing/command.c
> @@ -150,6 +150,8 @@ static ssize_t tt_command_process(char *s)
>         if (arg) {
>                 *arg =3D '\0';
>                 arg++;
> +       } else {
> +               arg =3D s + strlen(s);
>         }
>
>         for (i =3D 0; i < ARRAY_SIZE(tt_command_strings); i++) {
> --

The issue addressed by this change should be fixed by

https://lore.kernel.org/linux-pm/20260605185212.2491144-1-sam.moelius@trail=
ofbits.com/

that has just been applied.

Thanks!
