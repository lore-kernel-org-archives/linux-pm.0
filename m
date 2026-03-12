Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23473D4121
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773330251; cv=none; b=dxDs6D9dhwp7F0PaJDjE2iXE1p1p5Qy6R8qn1LwDAOIA2txsae6cMf14/UbCHzXKG3cgvSVRuAIfK1pvQK++nD46LQL5ogTHbS1jfUkNdbbRvHdBSsJ8veXUhlhv3lh+CVG0WUDEmU1OBF0JuBHhQjUzQGYAmuP+fvNc1uue2Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773330251; c=relaxed/simple;
	bh=0G2+6AojQC4x+k4NLI1RBY0tQq7WMqzclJ9ZLh+3LUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzmR6JRiaUVRnzBKlLX5lGoj81TwFbgBBxbwXoYJ+gqzCuxkrvDIZysMsUBFAjAoaAO5dIrgwCrPaXfymj+o8FOuRtABz2MZvjRuSyI9xG1+O/qrt93lNQ5OL6Ak38myPNOKwJkeRdL7KHVGoMg6kG58/hzqhWqeZ8QNbHTxQdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLdqFIWS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLdqFIWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CF6C4AF0B
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 15:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773330251;
	bh=0G2+6AojQC4x+k4NLI1RBY0tQq7WMqzclJ9ZLh+3LUg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FLdqFIWS9rN8C5Koc3rM0CQEo86eeGqI1kJMzpUD7N6ZwhMRRyV9MV2dpUeXWCZuO
	 wb2legl2iemxHcPhspbFeWeaF6ZXps7zCWyjAH+J68Or98U3nU5MsPNds5zO73cZyA
	 uh4tKZPF+OWnqBWaNyuvDZcwbPkT86dA7gRNEjJ8glvdFgTAQ5TJTE0ql3Fv5El8H9
	 xaM5fiOjr2hTWNNHzOoksPTfLDO582/5gF91jg99iW+4yzBGFzqo8mIs9PDqMTW4Bc
	 QDoENBu+AXSoOmc3ksPGxEr62L5R1ZoK3pco8U4ePd9tnLgW6+MaA1XdtHgliJE4cF
	 2ZLpn7GXfsA4g==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d741f61ee5so1029927a34.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 08:44:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVH4Nuup/lH59Aol+VTMZW15BD2nIUxzgww/6wlmAR6tiD8EAIDukEIsMyKbFjZpCMlswuJhFOeyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ri5eF9hALP0XHo/ykTOtj+rWUjugzCXpg64bJP6X8mfT56pU
	A99FuYJY99Uk2GwAcihHK2jID9Z/IQcb18Bp1xsJIROZCl5l6iY1o7OLnI+VMnwAEVG6q66WQZP
	YyLn1F9ZVlREvpzz1XsKGX5QcKz6mdVU=
X-Received: by 2002:a05:6820:162b:b0:67b:b1a2:b4d3 with SMTP id
 006d021491bc7-67bc8a5ab32mr4081223eaf.72.1773330250228; Thu, 12 Mar 2026
 08:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c3e22128e6619d24f3fc6ac07d1c854c664a7f1e.1773124395.git.viresh.kumar@linaro.org>
 <05feb9ed-3257-452e-98e9-89637431a347@oss.qualcomm.com> <u4k5z6yilgjqajy6a4zxyt23tgmtp5hxqm6jlc55y2ize4rs46@3czv7uoybqbz>
 <CAJZ5v0jvVNd3v_LcsM9Q2tZRavx0OQwZ-R4vWSzYr6edinRk4A@mail.gmail.com> <z33jb5vwatwba24f2ftz5zb75qzqv7h4tljq72bwbvgphuvuds@jtxtl7geedtb>
In-Reply-To: <z33jb5vwatwba24f2ftz5zb75qzqv7h4tljq72bwbvgphuvuds@jtxtl7geedtb>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Mar 2026 16:43:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0htdQqaQT+-FJ-Agt4aAONXH36Qg2htoo+onLmst0ZoZg@mail.gmail.com>
X-Gm-Features: AaiRm51YTj0w_LkFuys_h6pVNzSe4ZIpJEViRJtxmFBkW7pAZo6AyXqM4JSOCvo
Message-ID: <CAJZ5v0htdQqaQT+-FJ-Agt4aAONXH36Qg2htoo+onLmst0ZoZg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: conservative: Drop cached requested_freq
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 3:48=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 12-03-26, 15:03, Rafael J. Wysocki wrote:
> > So cs_dbs_update() does this:
> >
> > if (requested_freq > policy->max || requested_freq < policy->min) {
> >         requested_freq =3D policy->cur;
> >         dbs_info->requested_freq =3D requested_freq;
> > }
> >
> > Why is it not sufficient?
>
> Because requested_freq is within those limits, it was policy->cur
> which wasn't within these limits, but that too came within that by the
> time cs_dbs_update() gets called after the readjustment.

But how exactly does policy->cur get out the limits?

I guess there's some notification from the firmware or similar that
causes the limits to be updated, but the only way policy->cur can
change is to still fall between the new limits AFAICS.  Or if it is
not the case, there is a bug somewhere in the core.
