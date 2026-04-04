Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4DE33A6E0
	for <linux-pm@vger.kernel.org>; Sat,  4 Apr 2026 18:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775329074; cv=none; b=kwL5PlYzr2mBjKUVJJyxlRhL7bN/l24aJ5RtSpoow3fdBtFHEfQbi0xvgFLTly4RCn0Dgk4u4Zj+a9vonaASOZkP2iQDb+zADkOj7FOOI0S6+n5qsfbS47E8XJ1vnoKZi9uwkecL/rs4bO3aOuN2OrnpMsRz7/PIv8tJbpazRvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775329074; c=relaxed/simple;
	bh=wGGGsdStRcBkiebna8T1DxYY51ds6zJJKfHLsEKwyZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdtccxYZ98DBc7XkeMmlaSiFJ9oe3T65V0ib1xugvZzFD2ClA6McLYsSezJ1la1F50x54Aye5eWnh3jzems4NwdVVpOs+p7DyKt/xoNmhepiJylevo1mQDRNR6EONPhYIWrcuW8OGugdpKKEdu6pZIZCYXh8cexFJXJZRiQUZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLzLXii8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLzLXii8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93990C19421
	for <linux-pm@vger.kernel.org>; Sat,  4 Apr 2026 18:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775329073;
	bh=wGGGsdStRcBkiebna8T1DxYY51ds6zJJKfHLsEKwyZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dLzLXii8cS+pHn6NWiKeIgd9ueRaAT4+VTyYjUUI5bwSAWt2YmAW1YObpJmQxNfL/
	 K2HneGbmpHPIbrd1aHTHAMK82LBPiYNH2ye+JJBywRxYI9Z26zu3fPPlkGQGg9FAbK
	 bJBN0sC9DVDlJsBvrRtN2NPffCdN4uAwHdKWgpfdy4iTF7SOnDrRzGw1keSjC4xTJf
	 uEuPl4f0QeQHLmItYwj5kwRdW0WZN7JKCYON81ZQGQdE3wosg44l7ttroTqhtphIqS
	 M9J6U+HkwmnUb/WExQfG/QyQK6HDlAiQVYegw7/aoGbT+EhDyC4L5dBNKjOB4PVUaR
	 ilM0rJ4pu4lUw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40f387a688dso2158608fac.0
        for <linux-pm@vger.kernel.org>; Sat, 04 Apr 2026 11:57:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQzdZv0Frms//ck8KGoBT69Tn+o1mx3iL/+9SWEJjsSMtsIPLaT3UWUcbZGIdXLw4VmlclP5wwBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcy2A6Vi3ZCf+LYkeG4x/1lFSuZ8Gmb4FI2qLhTrZNexM3HyhU
	b7td2BRKBO8QiTuMR+KbIJg3TdlFb6099WCHE5FsjJh1/kLGelpyt+OIEjQy3MeZw+BI6yQIEKE
	GEdMAgIr1Js5WBe356Uo0W0H9jqUgjLU=
X-Received: by 2002:a05:6870:ecaa:b0:409:60ad:2b1e with SMTP id
 586e51a60fabf-4230fd8dcf6mr4115266fac.18.1775329072712; Sat, 04 Apr 2026
 11:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8f7a08eb-26ae-47a5-bcb5-b0db7c8f771b@kernel.org>
In-Reply-To: <8f7a08eb-26ae-47a5-bcb5-b0db7c8f771b@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 4 Apr 2026 20:57:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jNYriwUxbsOEJsxMTjkmgA37w9jiV9PdkbVFXiwN18+w@mail.gmail.com>
X-Gm-Features: AQROBzAHbcQPkrcKFX_G4_hQJNQJTRTKbrkuUwQ364cU5Lu7nnjrnBbnJpO6aIc
Message-ID: <CAJZ5v0jNYriwUxbsOEJsxMTjkmgA37w9jiV9PdkbVFXiwN18+w@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate new content for 7.1 (2026-04-02)
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 10:33=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> The following changes since commit c369299895a591d96745d6492d4888259b004a=
9e:
>
>    Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v7.1-2026-04-02
>
> for you to fetch changes up to 9487e2a00e7b3c6f258c5c99953f470eba6fb61d:
>
>    MAINTAINERS: amd-pstate: Step down as maintainer, add Prateek as
> reviewer (2026-04-02 11:30:24 -0500)
>
> ----------------------------------------------------------------
> amd-pstate new content for 7.1 (2026-04-02)
>
> Add support for new features:
>   * CPPC performance priority
>   * Dynamic EPP
>   * Raw EPP
>   * New unit tests for new features
> Fixes for:
>   * PREEMPT_RT
>   * sysfs files being present when HW missing
>   * Broken/outdated documentation
>
> ----------------------------------------------------------------
> Gautham R. Shenoy (13):
>        amd-pstate: Fix memory leak in amd_pstate_epp_cpu_init()
>        amd-pstate: Update cppc_req_cached in fast_switch case
>        amd-pstate: Make certain freq_attrs conditionally visible
>        x86/cpufeatures: Add AMD CPPC Performance Priority feature.
>        amd-pstate: Add support for CPPC_REQ2 and FLOOR_PERF
>        amd-pstate: Add sysfs support for floor_freq and floor_count
>        amd-pstate: Introduce a tracepoint trace_amd_pstate_cppc_req2()
>        amd-pstate-ut: Add module parameter to select testcases
>        amd-pstate-ut: Add a testcase to validate the visibility of
> driver attributes
>        Documentation/amd-pstate: List amd_pstate_hw_prefcore sysfs file
>        Documentation/amd-pstate: List amd_pstate_prefcore_ranking sysfs f=
ile
>        Documentation/amd-pstate: Add documentation for
> amd_pstate_floor_{freq,count}
>        MAINTAINERS: amd-pstate: Step down as maintainer, add Prateek as
> reviewer
>
> K Prateek Nayak (2):
>        cpufreq/amd-pstate: Pass the policy to amd_pstate_update()
>        cpufreq: Pass the policy to cpufreq_driver->adjust_perf()
>
> Mario Limonciello (AMD) (6):
>        cpufreq/amd-pstate: Cache the max frequency in cpudata
>        cpufreq/amd-pstate: Add dynamic energy performance preference
>        cpufreq/amd-pstate: add kernel command line to override dynamic ep=
p
>        cpufreq/amd-pstate: Add support for platform profile class
>        cpufreq/amd-pstate: Add support for raw EPP writes
>        cpufreq/amd-pstate-ut: Add a unit test for raw EPP
>
> Ninad Naik (1):
>        Documentation: amd-pstate: fix dead links in the reference section
>
>   Documentation/admin-guide/kernel-parameters.txt |   7 ++
>   Documentation/admin-guide/pm/amd-pstate.rst     |  87 ++++++++++++--
>   MAINTAINERS                                     |   2 +-
>   arch/x86/include/asm/cpufeatures.h              |   2 +-
>   arch/x86/include/asm/msr-index.h                |   5 +
>   arch/x86/kernel/cpu/scattered.c                 |   1 +
>   drivers/cpufreq/Kconfig.x86                     |  13 +++
>   drivers/cpufreq/amd-pstate-trace.h              |  35 ++++++
>   drivers/cpufreq/amd-pstate-ut.c                 | 279
> +++++++++++++++++++++++++++++++++++++++++++-
>   drivers/cpufreq/amd-pstate.c                    | 625
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++-------------
>   drivers/cpufreq/amd-pstate.h                    |  37 +++++-
>   drivers/cpufreq/cpufreq.c                       |   6 +-
>   drivers/cpufreq/intel_pstate.c                  |   4 +-
>   include/linux/cpufreq.h                         |   4 +-
>   kernel/sched/cpufreq_schedutil.c                |   5 +-
>   rust/kernel/cpufreq.rs                          |  13 +--
>   tools/arch/x86/include/asm/cpufeatures.h        |   2 +-
>   17 files changed, 1009 insertions(+), 118 deletions(-)

Pulled, thanks!
