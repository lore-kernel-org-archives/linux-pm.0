Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CE53A872A
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774900721; cv=none; b=QXq3w9gnxWZ3Gi4YqTJAobioDppjXZmyq+KJ3P6rN2188sJz77+K5kpkHk/vtq14PUhEPTBERgXNEiGRECO9wExsHQaGUpwVajJ71v3QdWnGvMgnr/xuJNCgdeC9Q6VOIj4s/OUhRjVBju0POUaGJRoV16NCYGe10897Ss4MeZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774900721; c=relaxed/simple;
	bh=81hTsW42wmJOgxxunpVJTB5c7yVV/1ZMpFSf30BLrCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/d4DWGcJ8itclxiS9A5seAiRLXK1GXt4zz0zCGyHjXpwmIF7ejmiJ5mpeI7NFzxQhLZ8bIVJrN86FKaQDRmZLwO0qdg/kEeuHcnUmCucq3kLOAxujwjV11PmOn3dU7z/t8LserOxjfTK4bEpPWHUonZfa3lkGLvjvdj4nKbXVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivjyVrKH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivjyVrKH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06416C4AF09
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 19:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774900721;
	bh=81hTsW42wmJOgxxunpVJTB5c7yVV/1ZMpFSf30BLrCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ivjyVrKHN8OiYhK5qI4J9Aimi8Q09sYWhFfrNjp3FTtEzYrx9Bq4KQ5yLzA/RB7EH
	 aU72I2OBhyJxdtmzf9RqaisJTSa3wuEUUhPlnXFcSHOI4n1fdgR0sBVA8Q1K8dppzD
	 gC6qrvQllKRKfV956I7N1DyGIykODny0GXLh03dLjV2X25vmGSqxFsyMpX4JLLTYIN
	 jtQUfmhtffdnetcqrAPvTQFlRaLzxDWTEO8T8wAl6BPOFsRMrNz/RLZgm3lJfGQzrt
	 MnsGz6Begk5xJCDIKioWu60j+YYu1AP5vw+pPlDzXr0B0n4ZlfOc3PrYPud0BXQOFD
	 0DE/AIdSXRDEA==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-67bac077116so2303094eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 12:58:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAuSEZXKLg1zcpaiaxcZPut4JV+/1dftUMJln01JQkPaPVykh2GsE2BfVN1fcPd6WbvKBZIYubZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzY+PCoOS6wdPy6hCxI4MF75dRcATbR9eTLlzNUiz+XGqAJY4Yg
	kd8VZ4jnzTOI3348UQs7mKCYag4BJhy6BK0MiXTDZGvaYjLmGGx8amJMZ87T3jRbhPdW853nyZQ
	hfxr69ORBhvouYYl2Zi6aiKgKJr2LnA4=
X-Received: by 2002:a05:6820:161f:b0:67c:28b0:41e3 with SMTP id
 006d021491bc7-67e187484dfmr7069040eaf.57.1774900720157; Mon, 30 Mar 2026
 12:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326204404.1401849-1-pierre.gondois@arm.com>
 <mv7ham5nlret74v6kvstourb2f7d4zxurbgpqm57w7c3hzdw2c@w2rx5r2t5vyg> <d13a7a60-dcee-483e-8ea8-a551ca2db467@arm.com>
In-Reply-To: <d13a7a60-dcee-483e-8ea8-a551ca2db467@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 30 Mar 2026 21:58:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gy65eHkWiOR2C30CBdjfe_MNqg4wUHXzDmrOzyxaNCNw@mail.gmail.com>
X-Gm-Features: AQROBzDwrZeC12zZ3IcRaM-_laDCJjLyJS3Ppp7Ztgu2NhvL1yV-nDnmXEhaxYo
Message-ID: <CAJZ5v0gy65eHkWiOR2C30CBdjfe_MNqg4wUHXzDmrOzyxaNCNw@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] cpufreq: Introduce boost frequency QoS
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 5:09=E2=80=AFPM Pierre Gondois <pierre.gondois@arm.=
com> wrote:
>
>
> On 3/27/26 04:43, Viresh Kumar wrote:
> > On 26-03-26, 21:43, Pierre Gondois wrote:
> >> Pierre Gondois (2):
> >>    cpufreq: Remove max_freq_req update for pre-existing policy
> >>    cpufreq: Add boost_freq_req QoS request
> >>
> >>   drivers/cpufreq/amd-pstate.c   |  2 --
> >>   drivers/cpufreq/cppc_cpufreq.c | 10 ++-----
> >>   drivers/cpufreq/cpufreq.c      | 50 +++++++++++++++++++++-----------=
--
> >>   include/linux/cpufreq.h        |  1 +
> >>   4 files changed, 34 insertions(+), 29 deletions(-)
> > Thanks Pierre for your patience.
> Thanks for the review (to Lifeng aswell)
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 7.1 material, thanks!
