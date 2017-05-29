From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [GIT PULL][RESEND] Thermal SoC management fixes for v4.12-rc3
Date: Mon, 29 May 2017 21:27:33 +0800
Message-ID: <1496064453.2572.8.camel@intel.com>
References: <20170528161451.GA11662@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:63928 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbdE2N1i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 May 2017 09:27:38 -0400
In-Reply-To: <20170528161451.GA11662@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sun, 2017-05-28 at 09:14 -0700, Eduardo Valentin wrote:
> Hello Linus,
> 
> I know this is (very) late, but please consider these six fixes for
> next rc3.
> I tried sending these via Rui, but I think I missed the window to get
> him still in office, so I am sending directly to you.

yes, I missed Eduardo' first pull request and I'm still on holiday till
the day after tomorrow.

> Changelog in this pull:
> - Fixes on TI SoC driver, Broadcom, qoriq.
> - Small sparse warn fix on thermal core.
> 
I'm okay with the changes in this pull request.

thanks,
rui
> On top of my local test, these went through linux-next and kerneci.
> 
> The following changes since commit
> 08332893e37af6ae779367e78e444f8f9571511d:
> 
>   Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-
> thermal fixes
> 
> for you to fetch changes up to
> a54c51863ed1294078a435151e625313b4365ac5:
> 
>   thermal: broadcom: ns-thermal: default on iProc SoCs (2017-05-23
> 20:09:34 -0700)
> 
> ----------------------------------------------------------------
> Colin Ian King (1):
>       thermal: core: make thermal_emergency_poweroff static
> 
> Jon Mason (1):
>       thermal: broadcom: ns-thermal: default on iProc SoCs
> 
> Markus Elfring (3):
>       ti-soc-thermal: Use devm_kcalloc() in ti_bandgap_build()
>       ti-soc-thermal: Delete error messages for failed memory
> allocations in ti_bandgap_build()
>       ti-soc-thermal: Fix a typo in a comment line
> 
> Masahiro Yamada (1):
>       thermal: qoriq: remove useless call for
> of_thermal_get_trip_points()
> 
>  drivers/thermal/broadcom/Kconfig            |  9 +++++----
>  drivers/thermal/qoriq_thermal.c             |  3 ---
>  drivers/thermal/thermal_core.c              |  2 +-
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c | 14 +++++---------
>  4 files changed, 11 insertions(+), 17 deletions(-)
