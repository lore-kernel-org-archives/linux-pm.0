Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFFC34D385
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779468599; cv=none; b=AJuo27HIoX4cMOJO+J+YQmMxZtYq1ygMvda/oDdr8O9rNysqpUBOHusVEP6b7ulx+fESVQtWei+12dz2VfyA14K51I34Tr2avf4gT3oCa4QaylkL5nUomed5/AsDzgp+CA7DKfjZEakjrb3u1+rdsXPRCupzu6bvCYaCLfqDoFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779468599; c=relaxed/simple;
	bh=1fMd7J2OpID7k1eE4I4hSAR5xlYgk/E4KuFLmxL+6yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbwnJDTkPQvfNAXtyMaRuj8EpTg6MWVNx0vvfkuBcTnUyu22OzSol+MPhFjsDPjiQQ4ZG/kkWYZ8Y/H9TQBfxx4y9odXjLDCkhGI+GLmIkNPa1mZ9xLa++BDAYDXYaO8K3FdcbLUD4ghmzQqpAIJ7hzrSmPVC/ClXgreOvE6ots=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAZEEZRl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAZEEZRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC9A1F00ADF
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 16:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779468598;
	bh=I4lAVT9LFjDm7p4L9smIE40CmKR2TiHJdUznQaX6/EA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oAZEEZRlFsB+eoN4+eBJlFrRPWTH+N4qJltx/QpO+fFL3VXq5Tax0dRbt2clizGK4
	 HAw7ShnJLE1lfXt8vQX7cFaEjq7EnaeS6TK+Pni+kg+p9qmEsg1AtZ9PzvGc4EAR99
	 0ewSSGKEoeRZYyGzR+uvLxbOt5WKwdl61ViO9ZTMFRwQsGoronr5lA0rFlOtdr+SGe
	 Kk/P7paOtoposHexVyoT8WNCLmB8egLF3reFh41xrAZNyjKR/05iQYD3/PN4HNRI9i
	 uDnX+55fFCHYPQeWj/fvIpYGFV+p1bjrwumXmHnEfSeYY3ZuJsHQL/JXpWIkA1JSTh
	 qbh9cYN6VmUOw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39556b00a85so59628381fa.0
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 09:49:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ88vGQVn09GLfXODvU9NNPSmaugNtTGeejIKXR9pb+fg+kFWMMFNlsXfFlDWizX8av8HR7Taghncg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw11Yw4R2uj/m5Htu81vXMpDDQZ2jriOQiXU+G3bW9yAT9uUg/f
	V84Ue4L6spf5YcrUAvNzRW55HLr7SKfxaBo4l/7KlGfsWdEf6ijyOb2fZGspAEy8dLULWSE1nIG
	16PgTg7SJhs/AvOBpjmk/LgUHjDo5Syw=
X-Received: by 2002:a05:6512:65:b0:5a4:17a6:9780 with SMTP id
 2adb3069b0e04-5aa3234c7c5mr1029387e87.14.1779468597033; Fri, 22 May 2026
 09:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515084920.70544-1-marco.crivellari@suse.com>
In-Reply-To: <20260515084920.70544-1-marco.crivellari@suse.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 18:49:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gLuMZ7b4fzc=f5Thk+s0bMjtaFS6HDqu9E8MfJa=jApg@mail.gmail.com>
X-Gm-Features: AVHnY4IqxjakekXbxc4Fm91KPw1U-c1aObimX29-KltDabIIOXmD-syVnV5ORI4
Message-ID: <CAJZ5v0gLuMZ7b4fzc=f5Thk+s0bMjtaFS6HDqu9E8MfJa=jApg@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: core: Add WQ_UNBOUND to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 10:49=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
>
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_w=
q")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>
> The refactoring is going to alter the default behavior of
> alloc_workqueue() to be unbound by default.
>
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn=E2=80=99t explicitly specify WQ_U=
NBOUND
> must now use WQ_PERCPU. For more details see the Link tag below.
>
> This workqueue has no benefits being per-CPU, so make it unbound adding
> WQ_UNBOUND, removing also the WQ_POWER_EFFICIENT flag.
>
> Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
> Changes in v3:
> - remove WQ_POWER_EFFICIENT: the workqueue has more benetifs being unboun=
d,
>   so just drop this flag and keep only WQ_UNBOUND.
>
> Link to v2: https://lore.kernel.org/all/20260514142511.325446-1-marco.cri=
vellari@suse.com/
>
> Changes in v2:
> - "thermal_events" workqueue has more benefits being unbound, so instead
>   of WQ_PERCPU, use WQ_UNBOUND.
>
> Link to v1: https://lore.kernel.org/all/20260514132901.275477-1-marco.cri=
vellari@suse.com/
>
>  drivers/thermal/thermal_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 2f4e2dc46b8f..0b322473deac 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1889,7 +1889,7 @@ static int __init thermal_init(void)
>         if (result)
>                 goto error;
>
> -       thermal_wq =3D alloc_workqueue("thermal_events", WQ_POWER_EFFICIE=
NT, 0);
> +       thermal_wq =3D alloc_workqueue("thermal_events", WQ_UNBOUND, 0);
>         if (!thermal_wq) {
>                 result =3D -ENOMEM;
>                 goto unregister_netlink;
> --

Applied as 7.2 material, thanks!
