Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F78370D53
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776887318; cv=none; b=i8HhpZLfO9S2h2huxdWAdtylXwoN4LZ4Lb4Fwu7TXWFEUzd3jLzU13dDvn1GL9xtPVP4oz32e2h0bTI4Atxrk0/7+lvwPiIrTkU7taaReRqEMmvvJavoGtJ35R+LC/NT2X2vSnR/b1jY3+8pq8Q9VlFCKND4yL0Kz0I7iM3aidU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776887318; c=relaxed/simple;
	bh=MUcF9S/+3wL4ll/HIPf3VdVW5a+/BY/UN9Zktomd2HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGbObdcJi9LONlGe/wpaffAZ7braVBlfI+bFUE26g0g2JsTHUmppXxXs2HKwMMEN4Reg3ipwp1RHHbzA0QkKodnrfYxxCMh4ThyUSlcI6L4ch9HC5Uv4if83JY3BtB3wUQEiz4bd6rQGTUuGljakGpIyGPaacYP2T3NbeVb2YS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5+SIebO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5+SIebO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D334DC2BCB3
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 19:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776887317;
	bh=MUcF9S/+3wL4ll/HIPf3VdVW5a+/BY/UN9Zktomd2HA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b5+SIebOYzWqoXTSlqfp0fqk6f/sAJygYy/t+39uyXEBpX5dCDUN/nYYbEqA7wElf
	 QWCULqQqKUXWWK10w+yfvZqrgbwM1AL6N07gg826R82s8UuuA5MA0zoVMBo8KOS+0H
	 H5sJJIoeAOyRM5nkoZ8Ulx5CJxD9r3jCrF7xJjAdyvzcOnD/7LPA0FwLMd8ZMkt2NI
	 FxZkCkyGTahFDoWMQJOaJw3ad1RL6jWJhbKOvyg/TX4x1n245aqVlJO/mWngoSC5A1
	 SlDN4gBdo7IMq0UKwjyiUMGrnm4A/LjtaiReBVcMjY3PiYjs50DL17XkVXXpUIFOEN
	 ulTthrvumzLzw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a41099fa86so5198247e87.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 12:48:37 -0700 (PDT)
X-Gm-Message-State: AOJu0YxaWtKgPsI59O/K5mmpQs4ji1lexIO0raLDc1Fe2Gv66nptejCl
	zwIgLagsubaPXbT2cAAcNyxL1ker846w+nIhjXOqvC2V3oNkG1JJrUb2Y/W9z5YcrY+nWBpopG/
	BTGjPXsbow8jHJeeXQMgjbxrOzbYeRmQ=
X-Received: by 2002:a05:6512:3b99:b0:5a2:7bc2:a385 with SMTP id
 2adb3069b0e04-5a4172e2c7cmr7201764e87.38.1776887316248; Wed, 22 Apr 2026
 12:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0jp-xWc_7Njjsva3EBhJXM31XVBpSspSkTd7FJ0wz1ezQ@mail.gmail.com>
 <CAJZ5v0juVDm3R3rffQsV3gQeC6zr=0q8y+KSpOPqvToyWh7vKQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0juVDm3R3rffQsV3gQeC6zr=0q8y+KSpOPqvToyWh7vKQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Apr 2026 21:48:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ge3q5JMm7fdySqLeD+TByhgqDFnp2NNF7ATSeHnBjPiw@mail.gmail.com>
X-Gm-Features: AQROBzB_scII0s-YDn6w4WnJx5evCyNtXbRIqiidjZNGiLKARkt4nmBicnnuC2s
Message-ID: <CAJZ5v0ge3q5JMm7fdySqLeD+TByhgqDFnp2NNF7ATSeHnBjPiw@mail.gmail.com>
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

On Tue, Apr 21, 2026 at 3:47=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi Everyone,
>
> On Thu, Mar 26, 2026 at 3:35=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > Hi All,
> >
> > I'm looking for topic suggestions to be included in the power
> > management and thermal control micro-conference submission for
> > LPC2026.  The deadline for submitting LPC u-conf proposals is April
> > 23, so if there are any topics you'd like to be covered, please let me
> > know within the next 2 weeks.
>
> Just a reminder.  The submission deadline is on Thursday, so I'm going
> to send a proposal tomorrow.
>
> This is the last call for input.

The proposal has been submitted, but it is still possible to update
it, so if you have any additional topic suggestions, please let me
know.

Thanks, Rafael
