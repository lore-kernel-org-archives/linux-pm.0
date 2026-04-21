Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F33E3D75D0
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779283; cv=none; b=RD/lAT5T/v6DgWrtI8d3Oos31ZRTDyeSR4d3x7bj5aSixqCo0v7wy1jGVjdNargrNDbu40LHjdIJnlmbNNgKSTVq+Geq6oNcbHs3YrJ+o/zf4z6uILILG/CTtk5Q3xPA2Ze0HcAmaO0oBTW9M1t2vyGrHNFuI/o3Gbdyp6t5UuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779283; c=relaxed/simple;
	bh=9J7U/WxZbHUFrgx+cZWkijQJUDbEgi4lYDn6PTbehvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfV9m88StvB3H1duWhAIVT4JWAJzSSO89gqy32I3HKZcqahwjvEDjbGilip8QpxS1lnmWrz5AACOxqDBTplMoEyAtLsnFHcOKemMtY53boGQHCJnFa50Y5i2u32MqrXDdo9QACmpa0wHmF9aoVUixFS/JGL/ep1E1HzxCbkv5sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ns4LVCfN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ns4LVCfN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E59C2BCB9
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 13:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776779282;
	bh=9J7U/WxZbHUFrgx+cZWkijQJUDbEgi4lYDn6PTbehvU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ns4LVCfNpMwmUkYMjeG9c8vJuQjRCB5z4c43cUEG6K1ruSRti6ulniAAxgH+oUAN0
	 OuC/2Iym3TtPr5fM54Nczz0KyyFBBSIN0PaIRg+3J53BbfK4DUPQJvx4YqUwSfTDhB
	 mXfOS8Lcp2Jah0wbCjUSkvZWBkAXhchWFbpq+3/cX9G/fEFPqWJYr5kiLcMyuZxhqp
	 r46RqHSWLf9UjN4FLzKHswDTv98H0N8scIw5lQzqgV8Kq2Gqht7XYJJ0Lrv1jIYBQ1
	 u0bJMgdmYCTXthiNcT7HjCELQrKJGXLTEfxI55ynaMXB9gNvNcTU0n6xQ2NrC/zkjw
	 4nKEomhHr58tQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a1307438ddso3918846e87.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 06:48:02 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxs+f0qqI94TuXWfKhhLMiTbz3Wcd7xBEK2o3/IhJhHmfJvFaEK
	25ZLmzHU/6V5mY13z/sYKxQfuRmFeBOWEIFsEJ/hS7s860b1vk3AIs51GhZUc+udih1QuU6dG2O
	e3hzeURUm5xQPVO18mJOUHTypNf/Fqmw=
X-Received: by 2002:a05:6512:1189:b0:5a4:505:f633 with SMTP id
 2adb3069b0e04-5a4172ebe60mr6638314e87.38.1776779281066; Tue, 21 Apr 2026
 06:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0jp-xWc_7Njjsva3EBhJXM31XVBpSspSkTd7FJ0wz1ezQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jp-xWc_7Njjsva3EBhJXM31XVBpSspSkTd7FJ0wz1ezQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Apr 2026 15:47:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0juVDm3R3rffQsV3gQeC6zr=0q8y+KSpOPqvToyWh7vKQ@mail.gmail.com>
X-Gm-Features: AQROBzD4-7RvqFyAYb189khZnfYuyBotld0E1G0nLNNv2oz9FtrtRatqVhgb92E
Message-ID: <CAJZ5v0juVDm3R3rffQsV3gQeC6zr=0q8y+KSpOPqvToyWh7vKQ@mail.gmail.com>
Subject: Re: [Pre-CfP] LPC2026: Power management and thermal control micro-conference
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Christian Loehle <christian.loehle@arm.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Pierre Gondois <Pierre.Gondois@arm.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Armin Wolf <W_Armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

On Thu, Mar 26, 2026 at 3:35=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi All,
>
> I'm looking for topic suggestions to be included in the power
> management and thermal control micro-conference submission for
> LPC2026.  The deadline for submitting LPC u-conf proposals is April
> 23, so if there are any topics you'd like to be covered, please let me
> know within the next 2 weeks.

Just a reminder.  The submission deadline is on Thursday, so I'm going
to send a proposal tomorrow.

This is the last call for input.

Thanks, Rafael
