Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EA7346E7D
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307628; cv=none; b=ZCSwjX7UTHjZHB1bjvYvvxtnFwgclpQL/dn0XsUVDFIb0oHjG6qDx5r+jXnTkBHIHoVMfWQjluUoVQSOxZHsA6XQY2a8QiXCOIVKNuDg2PuqnovOb5NliPgvL0oDUYuJkmMQc/a0muPMDy4ggGKUKD5nEiWPOOzSNYN3tmq8uus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307628; c=relaxed/simple;
	bh=5Mz0v38CbFiopNoMNy8Zs+kIgJklekqYQPhkEFFqjek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECL/qLYG0cwbHFGmjGNp+rOtS30mdEoFCidRyPikjBH5N2Yg/75HIa1JgbaB4PZQopWA2xuqFpXXMsgDm4Cto0YU/vFVC3tZ6cuLpnRnR1OR+L/ojYAqIcam0luKdAcxF3xwArT7HGJwAZ9TMXcERSo7oJOX8fGy9PdtA1yJCaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cn/vs5Z0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cn/vs5Z0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF191F00899
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 20:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779307626;
	bh=eltgoZTbDlP19naAUzDKIMm3KfD2K9gnzkkfYyALvGw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cn/vs5Z0cEdxBltTt/jrbuUvGoVt9d+aDEkqMqOJ/puzso7HcV1mHGBNdvhs7e4Rm
	 bfyk0Kps9OALCRZ/geITFdvNmToU9JbsfE/PuaK/dQyA3Y7uuu0ple7bsX6hQUtoDy
	 pupiFXP3c4LDK8AWlBlJ6UXLmeHWaWr9Qfy7k6ZirAYt2SaywTdo2m5uJLHOqn2oMF
	 CkTWamkJ0VK1GQ3lF85aKEAceYbzB6sCEGsf/ueaLAz3IqUWdjkJvtCj5v/fpGDQ/n
	 wCOihc7Vv90Re48tNlU1gP120HNMJp2Xi5xd2NrMJfIQJtEZd/qXlUbCZo5lh3NQY0
	 VS0nScLugOz8A==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a858881ad2so7117325e87.3
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 13:07:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8/TzZJWWgJmL4ZAwUcmngmB4jMxWC9/Ykdv/9YmsHCGFGl9Ypp6LhPfgzK5tdbmPDPGzGkoj9DSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPb48IXBDRZpbBlkpUghKpea0aexi3Fl+Ebz/f0xGMAVOA8Rlq
	kUOqaZCrnpiGMBzLZYXbYQAtgWrBUgbiShSSFZuvgCLMu/FSl13EQT1C9HDXO1hseKuRvDXXLLf
	dCLRoNx4/kNfpg5HsPHCwMKPHvidzwFk=
X-Received: by 2002:a05:6512:6d6:b0:5a3:ed0a:efb4 with SMTP id
 2adb3069b0e04-5aa0e7402f5mr6256328e87.38.1779307625288; Wed, 20 May 2026
 13:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fc712ca8-253a-4a08-8ed6-4082fc50fff2@kernel.org>
In-Reply-To: <fc712ca8-253a-4a08-8ed6-4082fc50fff2@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 May 2026 22:06:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gJhhK-s2k82PJmPAqJHAXx1RxPm0v3MpfOrX3AmWOoow@mail.gmail.com>
X-Gm-Features: AVHnY4LGjAJ6EW5_CoacCt7MSg0WcmMCS1VopPmgRwwyD3XUzbxBGBTemyCetqQ
Message-ID: <CAJZ5v0gJhhK-s2k82PJmPAqJHAXx1RxPm0v3MpfOrX3AmWOoow@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate fixes for 7.1 (2026-05-14)
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, K Prateek Nayak <KPrateek.Nayak@amd.com>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 14, 2026 at 6:40=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> Hi,
>
> Some fixes for this current cycle, thanks!
>
> The following changes since commit 7fd2df204f342fc17d1a0bfcd474b24232fb0f=
32:
>
>    Linux 7.1-rc2 (2026-05-03 14:21:25 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v7.1-2026-05-14
>
> for you to fetch changes up to e4e9b7b38d5db2cc6a8770bc0596bb8b36b92b1f:
>
>    cpufreq/amd-pstate: Drop Kconfig option for dynamic EPP (2026-05-14
> 08:47:48 -0500)
>
> ----------------------------------------------------------------
> amd-pstate fixes for 7.1 (05/14/2026)
>
> A number of fixes to the dynamic epp feature which was new
> to kernel 7.1, including making it opt in only.
>
> ----------------------------------------------------------------
> K Prateek Nayak (6):
>        cpufreq/amd-pstate: Grab "amd_pstate_driver_lock" when toggling
> dynamic_epp
>        cpufreq/amd-pstate: Return -ENOMEM on failure to allocate
> profile_name
>        cpufreq/amd-pstate: Allow writes to dynamic_epp when state isn't
> modified
>        cpufreq/amd-pstate: Reorder notifier unregistration and floor
> perf reset
>        cpufreq/amd-pstate: Use "epp_default_dc" as default when
> dynamic_epp is disabled
>        cpufreq/amd-pstate-ut: Drop policy reference before driver switch
>
> Mario Limonciello (1):
>        cpufreq/amd-pstate: Drop Kconfig option for dynamic EPP
>
>   Documentation/admin-guide/pm/amd-pstate.rst | 11 +++++------
>   drivers/cpufreq/Kconfig.x86                 | 12 ------------
>   drivers/cpufreq/amd-pstate-ut.c             | 36
> +++++++++++++++++++++++++++++-------
>   drivers/cpufreq/amd-pstate.c                | 27
> ++++++++++++++++++---------
>   4 files changed, 52 insertions(+), 34 deletions(-)

Sorry for the delay.

Pulled and added to linux-pm.git/fixes, thanks!
