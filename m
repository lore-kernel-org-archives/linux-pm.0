Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E8038237D
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784795; cv=none; b=nwikw/tDMoX+o80PxVMwaBurFsfBS8+12ZjKe+1a4Uj0E8bbNHv8VWR+9fI3YC/hAM1PpnlAHPV2/8zLQAUpjp/47r3Qk0AClyKVXrrS9v+W6Z5NRAkAtFDbIPkIABJwKCcl6wsOWmmRkvjwxORgJu9tJC1U1HNzlxR9Z2VMpYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784795; c=relaxed/simple;
	bh=+6HzfbJzasi1PBlibV/F/3nsp40ZbE70DhbggepvzBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owEpksOsyxqfZfa8i8pwmYlXXXacd3BSwG6OzBEWqZjXvZI88iQBrXZvzIJLFwsXG7byvBAqxd0dqoSR+Cl7Szl74Uqmre0vVrK3Rb3k2wHU5hzaEwuoDDxO080FQE1fggOwzuZy99ICvMOrxkMa3N+6pWuHd1Tru1XBsofQAcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDCsPoiW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDCsPoiW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD38C2BCC6
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 15:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776784795;
	bh=+6HzfbJzasi1PBlibV/F/3nsp40ZbE70DhbggepvzBc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QDCsPoiWhTeBEF2J9Sb3EbxW9uLj4oyuSqf9fYd3jfvnP9PT4R+srnAS3xC6y2YQz
	 +ymneFH8RV0rtv+sDglvl8aXqtX8rKfUDsLl8CzJFl5iLlbXylHIzFuDFIW5hZnX0X
	 cL6hdMic1I+Ei0Caq9CXhUCzZBKAr80WE5robxReJYy5tbIJm+Q4sJR3JFloQJ8tbM
	 irbWuaWdHtonRafyOiI5Qm5WjT+N5rLjSY/aPS5oI57EW7c6RpkB0IdSPVCfsPs9XF
	 GSjaOk3dEMA4BW5YuJxH2QvyZsOHhmRvEG8pJR1xT93gYX4Dj3e/k+TMdrBi3jcsB1
	 6aDEzEQT8DAuQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a40502e63bso4256074e87.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 08:19:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9E2N+NFrcIXQVapDqHsMcPP6U8zsAkCMRtMQGPkxqEy1vQtEbMNQ5PRgK+ArIE87hVwS/JhMVK4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIVPxbpJjKjOk+8cn4e5ITvoI6hQZ0LGxtOURG2HJwHYNXGVne
	qcrrS90ebPl/oqIGXQTdNz/9yjkCu7I8V9vgnhVDfeVnyPAVZ+7Nc5h1Ja7mmfMmS4JR6FLdV/Z
	7YW4eamsgQfFFidiXQfVs14Od7x2OMK4=
X-Received: by 2002:a05:6512:15a7:b0:5a4:5b5:c84c with SMTP id
 2adb3069b0e04-5a4172cb8c1mr5953662e87.17.1776784793319; Tue, 21 Apr 2026
 08:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0jp-xWc_7Njjsva3EBhJXM31XVBpSspSkTd7FJ0wz1ezQ@mail.gmail.com>
 <CAJZ5v0juVDm3R3rffQsV3gQeC6zr=0q8y+KSpOPqvToyWh7vKQ@mail.gmail.com> <fff66226-a460-4c11-ba4c-88764cc1f1c4@arm.com>
In-Reply-To: <fff66226-a460-4c11-ba4c-88764cc1f1c4@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Apr 2026 17:19:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gmY+4+EFxcP1J=4seB5Z5+oNfmt64i+SP=Meo5y2MsVQ@mail.gmail.com>
X-Gm-Features: AQROBzDB_ah4eLgK6M8FMnotQXoroQ1EpHycMHKzVsEV5XGTtpDpt64X4hkjsMg
Message-ID: <CAJZ5v0gmY+4+EFxcP1J=4seB5Z5+oNfmt64i+SP=Meo5y2MsVQ@mail.gmail.com>
Subject: Re: [Pre-CfP] LPC2026: Power management and thermal control micro-conference
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Christian Loehle <christian.loehle@arm.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Pierre Gondois <Pierre.Gondois@arm.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Armin Wolf <W_Armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Tue, Apr 21, 2026 at 4:27=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Rafael,
>
> On 4/21/26 14:47, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > On Thu, Mar 26, 2026 at 3:35=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> >>
> >> Hi All,
> >>
> >> I'm looking for topic suggestions to be included in the power
> >> management and thermal control micro-conference submission for
> >> LPC2026.  The deadline for submitting LPC u-conf proposals is April
> >> 23, so if there are any topics you'd like to be covered, please let me
> >> know within the next 2 weeks.
> >
> > Just a reminder.  The submission deadline is on Thursday, so I'm going
> > to send a proposal tomorrow.
> >
> > This is the last call for input.
>
> As discussed at OSPM26 during the presentation, I will show some
> implementation and experimental results. So the topic would be:
>
> "Latency-focused QoS for kernel devices - implementation and
> experiments"

Thanks!
