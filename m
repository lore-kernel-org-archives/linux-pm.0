From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 0/2] Enabling PSCI based idle on ARM 32-bit platforms
Date: Tue, 13 Oct 2015 11:44:24 +0100
Message-ID: <20151013104424.GA13899@red-moon>
References: <1444648628-24790-1-git-send-email-lorenzo.pieralisi@arm.com>
 <561CC185.60001@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51843 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932231AbbJMKnw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Oct 2015 06:43:52 -0400
Content-Disposition: inline
In-Reply-To: <561CC185.60001@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Jisheng Zhang <jszhang@marvell.com>, Lina Iyer <lina.iyer@linaro.org>

Hi Daniel,

On Tue, Oct 13, 2015 at 10:32:05AM +0200, Daniel Lezcano wrote:
>=20
> Hi Lorenzo,
>=20
> I would like to take this patch through my tree but it does not apply=
=2E

That's because as I mentioned in the cover letter the series is built
on top of:

git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git tags=
/firmware/psci-1.0

Hopefully this tag will soon get pulled in arm-soc, I will respin a v3
anyway to add tags and fold psci_cpuops.c in psci.c, how do you want to
merge this then ?

Thanks,
Lorenzo

>=20
> Mind to refresh it against linux-pm or v4.3-rc5 ?
>=20
>   -- Daniel
>=20
>=20
> On 10/12/2015 01:17 PM, Lorenzo Pieralisi wrote:
> >This patch series is v2 of a previous posting:
> >
> >http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/3=
73756.html
> >
> >v1->v2:
> >
> >- Refactored patch 1 to remove cpu parameter from cpuidle_ops
> >   suspend hook
> >- Refactored psci_cpu_init_idle to stub out dt parsing function and
> >   make it usable on both ARM/ARM64 with no additional changes
> >- Updated ARM cpuidle_ops to new interfaces
> >- Fixed PSCI enable method string in ARM cpuidle_ops struct
> >
> >PSCI firmware provides a kernel API that, through a standard interfa=
ce,
> >allows to manage power states transitions in a seamless manner for
> >ARM and ARM64 systems.
> >
> >Current PSCI code that initializes CPUidle states on PSCI based
> >systems lives in arch/arm64 directory but it is not ARM64 specific
> >and can be shared with ARM 32-bit systems so that the generic
> >ARM CPUidle driver can leverage the common PSCI interface.
> >
> >This patch series moves PSCI CPUidle management code to
> >drivers/firmware directory so that ARM and ARM64 architecture
> >can actually share the code.
> >
> >It is made up of two patches:
> >
> >Patch 1 refactors ARM 32-bit generic idle implementation to remove
> >the cpu parameter from the cpuidle_ops suspend hook, in preparation
> >for a common PSCI implementation for ARM/ARM64 PSCI idle.
> >
> >Patch 2 moves ARM64 PSCI CPUidle functions implementation to
> >drivers/firmware so that it can be shared with ARM 32-bit platforms
> >code. This patch also adds a PSCI entry section on ARM 32-bit system=
s
> >so that the PSCI CPUidle back-end can be enabled when the enable-met=
hod
> >corresponds to PSCI.
> >
> >Patches apply on top of current patch stack to enable PSCI 1.0:
> >
> >git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git t=
ags/firmware/psci-1.0
> >
> >Tested on Juno board (ARM64), compile tested only on ARM 32-bit syst=
ems.
> >
> >Lorenzo Pieralisi (2):
> >   ARM: cpuidle: remove cpu parameter from the cpuidle_ops suspend h=
ook
> >   ARM64: kernel: PSCI: move PSCI idle management code to
> >     drivers/firmware
> >
> >  arch/arm/include/asm/cpuidle.h |   2 +-
> >  arch/arm/kernel/cpuidle.c      |   2 +-
> >  arch/arm64/kernel/psci.c       |  99 +----------------------------=
-
> >  drivers/firmware/Makefile      |   2 +-
> >  drivers/firmware/psci_cpuops.c | 133 +++++++++++++++++++++++++++++=
++++++++++++
> >  drivers/soc/qcom/spm.c         |  10 ++--
> >  include/linux/psci.h           |   3 +
> >  7 files changed, 146 insertions(+), 105 deletions(-)
> >  create mode 100644 drivers/firmware/psci_cpuops.c
> >
>=20
>=20
> --=20
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software f=
or ARM SoCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>=20
