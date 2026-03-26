Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC837CD2A
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535933; cv=none; b=GayYZ4aSQ1xJ2qTOkUxBJfgzREigORY+Nc5SBYgbqFIjlvHqV4FnDgKfYUhucwGkMOjZA+SoVHOOzZgjMsuIf+Bs0S7nJupOjXXRP9Is0gEd1hDq61GVqb8n9xUKwVnwF/YX0oD1EIWNmst2O9p938mpNVGpmY+RpjCTM0xxvxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535933; c=relaxed/simple;
	bh=hBaf4ja8GMh15Nqs+VwT0k/E4eks+kElGr0xvPrPtE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTYDHrd9ey51vl3IFvaarVY5eRAdeyerDBJLJU0UQ6vG9fv7xJpvkCWEJ1o6PfnpUgqM4HcOICblVGZsaJFB3gTTZTsHnN5F8LUWDkfwmjPw4r0s94vxyiiChtmzfr64WJJK+Dlfi1/JgEZhipTrAKZe5fDty14VhbFOTltzI9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtS/ilCl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtS/ilCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF8FC2BCC4
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 14:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774535933;
	bh=hBaf4ja8GMh15Nqs+VwT0k/E4eks+kElGr0xvPrPtE4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MtS/ilClo/68fY+I21WkrgUuAvUVTL3y0dNEyby1HrZITmn8K5zK6F0uXcIxeZtpe
	 wgG+6nBr+DgLhmBAaojewfG7YXnGUUDh7zp3o1d4Hck8Y3yZ5+77TIFmIy5LYkLlYh
	 /iJylwhJfWsUV9evvwwQZHUABeBOvJ+fo+g38SZL0gSx2lxwuBHh97m74MtRFHwnHX
	 sBkD0HFTh8eIoUg6b8WmeAsdrDQqcqLwoVdYRYKw3Xj081iQhCPUZauSbAS6scfQ1v
	 sTkyP2hlI/T3DHO3gg6M6IDqFaOiXlg8YXYSPALtn2VmYNYcxn3HXSsI11ZpZ+dHTH
	 7luvHipapF1ZA==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d7f09aa39fso1223107a34.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 07:38:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YyxuQPoxVhfsNNnIlCb3BefwmzE5/qMG+O/cfAz6LJ5PtwHQ44b
	zDGZp/OSVA2MgpYQQWoNKEzQyMh2secuQ5MGjbMHEumZhUEiwnp/1q6HmgGuLocH0h/fP0oQDTn
	ySnrJebkK5sjY/YTTQj7pWeiyF6JXI1k=
X-Received: by 2002:a05:6820:3094:b0:67c:250c:ac45 with SMTP id
 006d021491bc7-67dff464247mr4065682eaf.32.1774535932007; Thu, 26 Mar 2026
 07:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0jp-xWc_7Njjsva3EBhJXM31XVBpSspSkTd7FJ0wz1ezQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jp-xWc_7Njjsva3EBhJXM31XVBpSspSkTd7FJ0wz1ezQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Mar 2026 15:38:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g1+4qNO336VauM=wn4p5hoP2-dShzoibMFR4GysqvYug@mail.gmail.com>
X-Gm-Features: AQROBzD1exJc_Ag4teYvqCuyq-jXbJMm5qe5_pzGlUmBUf80Er5_kSm32A7SdwU
Message-ID: <CAJZ5v0g1+4qNO336VauM=wn4p5hoP2-dShzoibMFR4GysqvYug@mail.gmail.com>
Subject: Re: [Pre-CfP] LPC2026: Power management and thermal control micro-conference
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Morten Rasmussen <morten.rasmussen@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Christian Loehle <christian.loehle@arm.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Pierre Gondois <Pierre.Gondois@arm.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Mario and Gautham

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
>
> Thanks, Rafael
