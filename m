Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320831A00F0
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776680559; cv=none; b=fH5NwCxcOd4xwz3NSzgRiYhdS6kDgmhMtL9i5vw6vsJwOU4SCgOTYeRg9UrRcX4gzhIx4z/bXuVzG4BJShkHG4szBfAvxsgXRPTOa1vqBC9hfkO2npPSLzxQnZjXelXuZ6jycAOeGibYwqGwdzx9qEqHfyl4uQWE9KeSfqWrNh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776680559; c=relaxed/simple;
	bh=CPWPFjwSn4AEOpGGj/u+NiWQOzBchNkurHJ5/FymRWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7w3I9199ftlbEmGqYa3DK54OEV9uWM9g3fBXDchLckvVVufd3eHSyZzyv1uIIFBcLsHAc3qu5db6OVOcxRZ/Za0GBzox4IO9BNwtGnhJXg2LIw9gjmSbNln5Iy0NPnp3FjdeWpUDhnMCv+mAJAKYWWCjm7KLWRy8zrYwcPxWXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFD8M5EB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFD8M5EB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB49C2BCC4
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 10:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776680559;
	bh=CPWPFjwSn4AEOpGGj/u+NiWQOzBchNkurHJ5/FymRWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VFD8M5EBYep4QFJfrsK6t/9FI013V0DLhBoYQ0I1l28uH6IG/Aj+qMB33YHzbDHy2
	 gJ5Wd3GR1zKwbIYHJBDu3AGnKG9/wvnpAO+7kulQrqglT6iGOClU2+Ry5IRMfzLD35
	 RyYk26eXgEeZcQMMtvxs9n1l5ZrYdCYip5u3hnC3yzl4i4t9FGH2fzdEs7rF4QXIHl
	 +p+bSFnRCubo1Ee7crrr60yM9cbaiBYm3HiWukecPFLBeNHt83/+OVGDjx644OcV+P
	 bsoPLXFJkG5zZIlGDP4oMXico6m+DszukCIZKXgzqZgogToXN0Kj9qHHxbe8NHD8gJ
	 5CTt4rUJfKBTw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a10d130b37so2825468e87.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 03:22:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9FQgZvTKwxENX82kNHyh4E5bStqJV+pSs1w57N3HjHutKniIKNKi881sFjVkW2Zx18ApsrNVLKMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAsXldPvWmv7zcroYyjTipvoTDQ4RT852sJSiZ/27qotYFWGMT
	yt2vRmcxrIzM9r+dNh3HK/+7z7wLhWlRHQeL/HcCv7qLVsyI2DRapGMaiMC7GPE7z6SrHF9yYCf
	VWlKz01mcYTvm8DzMivG7XhsxByCkpJU=
X-Received: by 2002:a05:6512:64e4:b0:5a4:5d0:2892 with SMTP id
 2adb3069b0e04-5a4172a2f84mr2772952e87.19.1776680557414; Mon, 20 Apr 2026
 03:22:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0jp-xWc_7Njjsva3EBhJXM31XVBpSspSkTd7FJ0wz1ezQ@mail.gmail.com>
 <1d111777-d1f1-4737-9dd4-3a1205876a2d@oss.qualcomm.com> <8677457e-5d8a-4f30-a688-a4613f17c740@oss.qualcomm.com>
In-Reply-To: <8677457e-5d8a-4f30-a688-a4613f17c740@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Apr 2026 12:22:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hb-RT5ZaRyea+ge5jMsv1g4i-0ONpc2O4uqKe+6A+bsw@mail.gmail.com>
X-Gm-Features: AQROBzAYVlXHxEFazxmWj4C9r4dHcsDpfO0OAjFwlmV-lq5QKD-GhKuWO2fkk14
Message-ID: <CAJZ5v0hb-RT5ZaRyea+ge5jMsv1g4i-0ONpc2O4uqKe+6A+bsw@mail.gmail.com>
Subject: Re: [Pre-CfP] LPC2026: Power management and thermal control micro-conference
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Morten Rasmussen <morten.rasmussen@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Christian Loehle <christian.loehle@arm.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Pierre Gondois <Pierre.Gondois@arm.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, amit.kucheria@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 5:05=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
>
> Resending with the correct email address for Amit :/
>
> On 4/17/26 17:02, Daniel Lezcano wrote:
> >
> > + Amit Kucheria
> >
> > On 3/26/26 15:35, Rafael J. Wysocki wrote:
> >> Hi All,
> >>
> >> I'm looking for topic suggestions to be included in the power
> >> management and thermal control micro-conference submission for
> >> LPC2026.  The deadline for submitting LPC u-conf proposals is April
> >> 23, so if there are any topics you'd like to be covered, please let me
> >> know within the next 2 weeks.
> >
> > I've some topics to be addressed regarding thermal issues, limitations
> > and enhancements, suspend/resume limitations, powercap enhancements,
> > user space resource management and may be power supply.
> >
> > I'm still in the process of collecting information, sorting them out an=
d
> > doing a selection of what is the most relevant for LPC. I should send
> > the selection in a couple of days (may be 3)
> >
> > Is one title + a couple of sentences fine for each topic as pre-CfP ?

A title line itself should be sufficient - I only need a list of
prospective topics to be added to the proposal.

Also, the deadline for proposal submissions is April 23, so if you can
send me something earlier, please do so.
