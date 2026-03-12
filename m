Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A2E3F87F8
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332847; cv=none; b=fsEGxKxDWHgJXCuwyLeOCg2dNd5Tk6e3b3fAkJS2tl4N4VUSa5C7hHUwyOukw/xPYCWiLaknmtiT82NtywxFDtuj0bGv918hPZ1XPRiL0hs8udeRogq/CL3XKng3VEMk0Z4XYwy+empYxJAkz2nq4oW393f77IWk9sJqGRTnVuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332847; c=relaxed/simple;
	bh=klIjtGnnq8IH6AVCLjoMYDQV8qbk0J4MOywm/oNOznM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVaz4vDg6qa8atiJGKCY3OxuIqZdfKN4Y4cAbc1DzBDIlTTUvzkFeCNa8/gD7m755znIM3YyZwqlQcrxApI2y+ZXdZo9y41ypGA7gFwh5dEcGc5bJgJQoSrH+jitBx/r+rYQT4A/QVBJepro4unxbZLeEmWuiFPuQtJp5iJmBC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLW+XA7A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLW+XA7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FF9C2BC87
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 16:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773332846;
	bh=klIjtGnnq8IH6AVCLjoMYDQV8qbk0J4MOywm/oNOznM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RLW+XA7A9j9Ma5L6EdbLiC24jJQI5/DnkpXeeUwJ1zCwbUeXywvWqj8KY/r2yYici
	 L7s6gyZtkTfUvZ/Q/lclS16IPW/T/QKbcnzQw4FZqnbrtG5L2DecRf1NNohkVgXDgn
	 UtjkbXiPaKctlmssI7UsQTI+jTQ0gocqgdaQFiWtf2xqd8om2ZRPNqDNPAFI3/5DnJ
	 5GE+SSFidsP9PNRf5hcHdZUUIt7Yjj+182TkIo364oC+Zm/pzMplLq7uy64eF7aESC
	 9aYcAf6Vjpha4QfEJx790T142+xpMT7plxlbeInPY/NWKGPN5UhRgggNkxqltsOje4
	 nAqZMzJtNd4sw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-67bb3fe55a5so487607eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 09:27:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCulO1ObtGBLKzU+sQAGBvtXOobL9RzrAk3YgI28E0z1nJOQA1FPb1ownEsGLSas2RYu5Vi5EaIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdpc9ys6Wazx5IOKcp8hLQ4Ce4SlVVzh12TPwC7CRqcjrAJTcR
	RaS7+w/hFPuTwLhxOJ15iSQbicMuMNTgHeEa9KXI5MYE+qUMHbH76DK1yW2b7Fr0PeMn/4dXFWm
	7m/t87EMWx2bVyVgR2bDqmUReQxP57D0=
X-Received: by 2002:a05:6820:7083:10b0:67b:c8c4:43bd with SMTP id
 006d021491bc7-67bc8c44adamr2893023eaf.72.1773332846009; Thu, 12 Mar 2026
 09:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c3e22128e6619d24f3fc6ac07d1c854c664a7f1e.1773124395.git.viresh.kumar@linaro.org>
 <05feb9ed-3257-452e-98e9-89637431a347@oss.qualcomm.com> <u4k5z6yilgjqajy6a4zxyt23tgmtp5hxqm6jlc55y2ize4rs46@3czv7uoybqbz>
 <CAJZ5v0jvVNd3v_LcsM9Q2tZRavx0OQwZ-R4vWSzYr6edinRk4A@mail.gmail.com>
 <z33jb5vwatwba24f2ftz5zb75qzqv7h4tljq72bwbvgphuvuds@jtxtl7geedtb>
 <CAJZ5v0htdQqaQT+-FJ-Agt4aAONXH36Qg2htoo+onLmst0ZoZg@mail.gmail.com> <laiiguxeqjrxk36txx3g2ij3yzz7aldzcnnqoxdv3m6pjo42vz@e6a3mvnusqrx>
In-Reply-To: <laiiguxeqjrxk36txx3g2ij3yzz7aldzcnnqoxdv3m6pjo42vz@e6a3mvnusqrx>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Mar 2026 17:27:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hM8wdug1xJ7j0sdVG+=xr3WcJ8OpfRDnmSOt6Zs=h36Q@mail.gmail.com>
X-Gm-Features: AaiRm51RQ-Z4VM7kQSw9d7a7MrA9k3ez03k-HOc7aKaYqBceAUKrChNSto1Tyug
Message-ID: <CAJZ5v0hM8wdug1xJ7j0sdVG+=xr3WcJ8OpfRDnmSOt6Zs=h36Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: conservative: Drop cached requested_freq
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 4:59=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 12-03-26, 16:43, Rafael J. Wysocki wrote:
> > But how exactly does policy->cur get out the limits?
>
> From the first email:
>
> "Later, some frequency division strategies on our platform were triggered
> and the actual frequency become 500MHz -- 1/4 of the OS distribution
> frequency."

Maybe it's too late into the day, but I have problems with parsing this.

IIUC, the platform drops the frequency to something small without
giving a notice to the OS.

> > I guess there's some notification from the firmware or similar that
> > causes the limits to be updated, but the only way policy->cur can
> > change is to still fall between the new limits AFAICS.
>
> AFAIU, the limits (in the view of cpufreq core) doesn't change, just
> the end hardware frequency changes without informing the cpufreq core.
> And if someone tries to read cpuinfo_cur_freq, cpufreq core tries to
> get everything in sync.

In that path it ends up calling cpufreq_verify_current_freq() which
invokes the driver's ->get() callback, so I guess that's the one
providing the "real" frequency.

Next, policy->cur changes via cpufreq_out_of_sync() and
handle_update() is scheduled which ends up calling
cpufreq_set_policy() via refresh_frequency_limits().

Say the limits are not updated, so we end up in
cpufreq_governor_limits(), which calls cpufreq_dbs_governor_limits()
in this particular case.

Next, cpufreq_policy_apply_limits() which should squash policy->cur
between the existing limits.  Effectively, this means that policy->cur
will become equal to one of the limits after that.

Now, IIUC the problem is that a change of the limits may not be the
only reason why requested_freq may need to be updated and adding a
.limits() callback to the conservative governor like in your patch
should address that.
