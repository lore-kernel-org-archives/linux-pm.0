Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB011E5207
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146063; cv=none; b=AzefElZkhEgzjFIvnRRbIkEhHncd4RMvhPZp6Gz88X6iuTQJvQ+Wc+/tejl4pP7N/423fDmIBR754REL1c2wgy5/FBd0RaKNB0FUkBGgvQozQj4F90TY8Ibu/a+i8GWx5YhI1R5tQzN/GaDQI3ot9YkCbIVpIl7yc1h2iHc0XmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146063; c=relaxed/simple;
	bh=Q8kueLkjBSZDYGwUTBvUWYV5fGfUopwaBg6xtCreKYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djErh7zOH/BCo9kJK7o+flp7Poq52t9suSvZrpwNK/oPCw7e+3gRjYFY08ewiQUfdRXg3JBji/2l95AZpPaE9opL6L9obWk2MutInLv3nyRXqLJHPl3DicymI+VnVt2IgWP6J5eHv3xk6Yn5mmK50FQIBQv8hQpjMHkDvKIFDgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhFOA+GQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhFOA+GQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1250F1F00A3D
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 16:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782146062;
	bh=Q8kueLkjBSZDYGwUTBvUWYV5fGfUopwaBg6xtCreKYQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RhFOA+GQNBCPcsZVN+P8G+ilg53PppinGSMYvbotrm2LcY89WaumLE8BK2bDKc/iC
	 z3ASHLIS6wO9F0g+PtCU6grHcGwbQoJWtjUiPa21bPrjEZUugANrubYqZ3AE87NEnJ
	 pJbc76GyAKEX//XU9kNK3Bar39AO3UACkefxfrZOGuSWiViIBg0wo1T4osq7SOQKWD
	 ptchPsO5qruj7FUrXo2KvWywuXr9wzuwfjvJPRkV6YIlO6J7JmQ20o61uprFh4QlhF
	 BrepJ5Dk8T7I8CFYHQ5dfLVl3vETbzh1pFJxfPQKq2K9ZGei2GM7P7n9LDGN0ZNtbF
	 zTBdeNbXMJXGw==
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-59ebde7d704so1513756e0c.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 09:34:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/z9fG3D9wUHzQyeKokre99cIaRQGIg4Y+TzdjFjJRh5rMFo8QsD6nDe7WaDkOLkdETaPtB7luP1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/OJdhvklWlgNwtueM2Eq+XBuZE7C/a9mTCbDJpgLGJYFey8US
	OCXf4sxUx1YyMcQi2bcqDaYkltI1HSzySPcllW5dwGMwkWvEMt0vH+np24Pds3EFMVQF7EzS2oY
	IwovF679gMmx2QsXLoosj7BHgYmkkBi8=
X-Received: by 2002:a05:6122:907:b0:59f:1b5b:55db with SMTP id
 71dfb90a1353d-5bbeb9d1e5emr7393046e0c.1.1782146061316; Mon, 22 Jun 2026
 09:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6005456.DvuYhMxLoT@rafael.j.wysocki> <dd33bb24d2e8f048f2a10ea9536c9643572110fb.camel@linux.intel.com>
In-Reply-To: <dd33bb24d2e8f048f2a10ea9536c9643572110fb.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Jun 2026 18:34:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iXs=7GsdFYtm_TpvTaJVx9o-5q=XY6vg2ofeirkY1Q6A@mail.gmail.com>
X-Gm-Features: AVVi8CeuUHrHjBD33XcAGDDWY8IuNaIq7-_7WyAzND-yS4ZZVm2hCNX61j5h_8U
Message-ID: <CAJZ5v0iXs=7GsdFYtm_TpvTaJVx9o-5q=XY6vg2ofeirkY1Q6A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] cpufreq: intel_pstate: Set cpuinfo_min_freq to a
 lower value with HWP enabled plus cleanups
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 21, 2026 at 11:50=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Fri, 2026-06-19 at 19:31 +0200, Rafael J. Wysocki wrote:
> > Hi,
> >
> > This is in v2 because technically it is an update of
> >
> > https://lore.kernel.org/linux-pm/2381464.iZASKD2KPV@rafael.j.wysocki/
> >
> > but it contains new patches.
> >
> > This series updates the intel_pstate driver to set cpuinfo_min_freq
> > to a lower
> > value when HWP is enabled to support systems in which CPUs can
> > actually run
> > at performance levels below the current minimum level.
> >
>
> Is this intentional?
>
> HWP_CAP: 0x10f163e
> MSR 0xce(platform_info: 0x804043df8811b00
>
> cpu0/cpufreq/cpuinfo_min_freq
> 100000
>
> cpu0/cpufreq/scaling_min_freq
> 400000

Yes, cpuinfo_min_freq comes from HWP_CAP and the scaling_min_freq
value comes from PLATFORM_INFO if that's what you are asking about.
