From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] cpupower enhancements for 3.8
Date: Tue, 27 Nov 2012 23:30:57 +0100
Message-ID: <8078053.x4WavXOkDM@vostro.rjw.lan>
References: <1354018669-63680-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34658 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180Ab2K0W0N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 27 Nov 2012 17:26:13 -0500
In-Reply-To: <1354018669-63680-1-git-send-email-trenn@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-pm@vger.kernel.org, cpufreq@vger.kernel.org

On Tuesday, November 27, 2012 01:17:41 PM Thomas Renninger wrote:
> Palmer Cox (6):
>   cpupower tools: Remove brace expansion from clean target
>   cpupower tools: Update .gitignore for files created in the debug
>     directories
>   cpupower tools: Fix minor warnings
>   cpupower tools: Fix issues with sysfs_topology_read_file
>   cpupower tools: Fix malloc of cpu_info structure
>   cpupower tools: Fix warning and a bug with the cpu package count
> 
> Thomas Renninger (2):
>   cpupower: Provide -c param for cpupower monitor to schedule process
>     on all cores
>   cpupower: IvyBridge (0x3a and 0x3e models) support
> 
>  tools/power/cpupower/.gitignore                    |    7 +++
>  tools/power/cpupower/Makefile                      |    3 +-
>  tools/power/cpupower/debug/i386/Makefile           |    5 ++-
>  tools/power/cpupower/man/cpupower-monitor.1        |   15 +++++-
>  tools/power/cpupower/utils/helpers/cpuid.c         |    2 +
>  tools/power/cpupower/utils/helpers/helpers.h       |   18 ++++---
>  tools/power/cpupower/utils/helpers/sysfs.c         |   19 -------
>  tools/power/cpupower/utils/helpers/topology.c      |   53 +++++++++++---------
>  .../cpupower/utils/idle_monitor/cpupower-monitor.c |   21 +++++++-
>  .../cpupower/utils/idle_monitor/cpupower-monitor.h |   17 ++++++
>  tools/power/cpupower/utils/idle_monitor/snb_idle.c |   10 +++-
>  11 files changed, 110 insertions(+), 60 deletions(-)

Applied to linux-pm.git/linux-next.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
