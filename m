Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED29C41B36F
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777487057; cv=none; b=R09q3utxwcsj8ZqXcjFC8cMMUySmgzafsyznVBLVr7+A19XkXGorbcfvQ/824Ynd+BdX525eI/vtokRoU+5ltHX5nZF2fIsrtzf3SKSvEvnhPWw9cFXJcOD7XFAOU20G1LftSbwhjMwRLi+o4O3+tSfgWBpV/UGnHkc4KDTNqWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777487057; c=relaxed/simple;
	bh=5Cd0UaxrsP5Ow4ItgLLN3F0cLG8bteVnTBK58g/m0Cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rv34YH10TUuom+y9ct+PHI0zylW/aJKG8EU3J1NXyP8iXoJT0G4eoV3E/I8Ak6tqz7EmmNle+aWBHfwkvmCDkwwtbe34L124QoCFJa0OeJar1po8sOi8+/An7nMWEX4IzoxPAVyIb+Wfh/XvC+yLfCFPtc4249yXUT2Be3ELCwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ3+V+ZQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ3+V+ZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7DBC2BCC7
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 18:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777487056;
	bh=5Cd0UaxrsP5Ow4ItgLLN3F0cLG8bteVnTBK58g/m0Cg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UJ3+V+ZQlTQaq2RLRBlGjznDYomXYGyZrjiIffm8md/neU92TYbxq2jTLYFFRXUKz
	 ubl7LpH+qwtOd3Ubeb8ApDEsS1/AT/4AZnQu/pHGR81A0r/pydcKWb8K618LYcXu1g
	 ijO2yDQhRs/kXfOheMTxa8TxdK1DQfePLZabBjKOK+EEJ8C9W6lRyFKKOcGQJNQQUX
	 Ke9S9au++VHPBzlti/qSTA6CIRD50us+nGbICm3gC40OA6Cu56PJCPQKkPv24Cd8bB
	 5BMU7QvY8hcLtfIjo7gzsHQ15OlPimPtYCsXlj4dAk26+O+yQMZ/ElvBV7OIBHWbPR
	 JLfcOfpdycw2A==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a525aedb24so34236e87.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 11:24:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8q82kdK0pff+83aTIcLwt0gEfYtuUUKa7uRmg8BXWBPDy7pmtbA2L7vMhUVjQZdYAsG/OhIWv82g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYgdVDntnQ/lhGx9Um6B6M2yTPtjYcTpwWN4bpf8P5etomP5Kh
	TpK9Bfl6ierk780VE1nXn8lXzpVgv6NXQ/kCVpp1/XRk92KPQOD/IaepNg3l6mAlbvrPqvHDhOE
	ZALrJ2zwztp4HbWa5qcRNTz2xlSHrHKE=
X-Received: by 2002:a05:6512:3d0b:b0:5a4:c6f:d42d with SMTP id
 2adb3069b0e04-5a74661aa9emr3291553e87.37.1777487055022; Wed, 29 Apr 2026
 11:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <6281827.lOV4Wx5bFT@rafael.j.wysocki>
 <CAGAxtY1VBXN_6xY0WiraJt-BQiYp_kSdTt8xbPkgP8xPB26=WQ@mail.gmail.com>
 <12904177.O9o76ZdvQC@rafael.j.wysocki> <CAGAxtY2SEkx7OgMgM5ypA8qsBN0h6pcs111VjnhD-5ZGq7Je6Q@mail.gmail.com>
In-Reply-To: <CAGAxtY2SEkx7OgMgM5ypA8qsBN0h6pcs111VjnhD-5ZGq7Je6Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Apr 2026 20:24:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ikAeu7cW9K6sfKYbbsVK51GOsFrX-qv3KJ7cVr-gRHew@mail.gmail.com>
X-Gm-Features: AVHnY4J9rrJQRyLpwX2WUpJea_sTD2AS0pZj4TmMTTt3-osu9j9rJhGue0HEjGk
Message-ID: <CAJZ5v0ikAeu7cW9K6sfKYbbsVK51GOsFrX-qv3KJ7cVr-gRHew@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
 (schedutil involved)
To: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 11:05=E2=80=AFPM Evgeny Sagatov
<evgeny.sagatov@gmail.com> wrote:
>
> The PC also froze with this patch when I pressed the power button.

Which means that the issue is not simply a matter of the lack of
synchronization between different I/O space accesses, so most likely
the problem lies deeper.

Let me summarize what we've learned so far (and expand the CC list somewhat=
).

For those who have not seen the previous discussion, it is at:

https://lore.kernel.org/lkml/CAGAxtY2SEkx7OgMgM5ypA8qsBN0h6pcs111VjnhD-5ZGq=
7Je6Q@mail.gmail.com/#r

1. The issue is basically that the platform locks up completely when
the power button is pressed

This is reproducible 100% of the time.

The power button processing flow is that, if the power button event is
enabled in the ACPI PM1_ENABLE register, pressing the button causes
the corresponding status bit in the ACPI PM1_STATUS register to be
set, which in turn causes an ACPI interrupt (SCI) to trigger (both
PM1_STATUS and PM1_ENABLE registers are accessible through the I/O
address space).

The SCI processing involves reading both the power button status and
enable bits and clearing the former if set (this needs to be done or
an interrupt storm would start if the status bit was not cleared).

We don't actually know which of the steps above specifically causes
the platform to lock up, but that doesn't matter too much because all
of them are necessary.

Clearing the power button enable bit in PM1_ENABLE prevents the issue
from occurring (but then the power button obviously doesn't work).

2. The issue only occurs if the schedutil cpufreq governor is used

If either the "powersave" or "ondemand" governor is used instead, the
issue doesn't appear.

Also switching over to a different cpufreq governor (on all CPUs)
before pressing the power button makes the issue go away.

3. The issue didn't occur at all before commit e37617c8e53a
("sched/fair: Fix frequency selection for non-invariant case")

Reverting the merge that introduced commit e37617c8e53a into the
mainline makes the issue go away.

4. The issue occurs regardless of how schedutil invokes the cpufreq
driver ("fast switch" vs sugov_deferred_update())

5. The cpufreq driver in question is acpi-cpufreq and it uses a
control register located in the I/O address space (the same control
register is used for all CPUs)

6. If acpi-cpufreq is not allowed to write into the control register
at all, the issue doesn't occur

7. Synchronizing all of the I/O space accesses in the ACPI-related
code (via a spinlock), including acpi-cpufreq, doesn't prevent the
issue from occurring

So overall, it looks like the control register access pattern in
acpi-cpufreq that results from schedutil's use of it after commit
e37617c8e53a somehow puts the platform into a state in which a power
button event causes it to lock up at the hardware level.

While there are a couple of things more to check, I'm afraid that
there may not be a viable way to address this issue other than
replacing the schedutil governor with ondemand on this platform.
