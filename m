From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/5] intel_pstate updates for v3.14-rcX
Date: Thu, 13 Feb 2014 01:47:43 +0100
Message-ID: <1412818.o51aAvTvMU@vostro.rjw.lan>
References: <1392228067-14817-1-git-send-email-dirk.j.brandewie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52840 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752070AbaBMAdC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2014 19:33:02 -0500
In-Reply-To: <1392228067-14817-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dirk.brandewie@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Dirk Brandewie <dirk.j.brandewie@intel.com>

On Wednesday, February 12, 2014 10:01:02 AM dirk.brandewie@gmail.com wrote:
> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
> 
> Based on v3.14-rc2
> 
> Patch 1 removes energy reporting the patch from Maurizio Lambardi 
>  intel_pstate: fix race condition in intel_pstate_init() can be dropped.
> 

OK, I'll replace that patch with your [1/5].

> Patch 2-3 cleanups
> 
> Patch 4-5 Baytrail bug fixes

How [4-5/5] depend on [2-3/5]?

I'd prefer to push fixes only for 3.14 at this point to be honest.

> Dirk Brandewie (5):
>   intel_pstate: Remove energy reporting from pstate_sample tracepoint
>   intel_pstate: remove unneeded sample buffers
>   intel_pstate: fix pid_reset to use fixed point values
>   intel_pstate: Use LFM bus ratio as min ratio/P state
>   intel_pstate: Add support for Baytrail turbo P states
> 
>  drivers/cpufreq/intel_pstate.c | 53 +++++++++++++++++++++---------------------
>  include/trace/events/power.h   |  7 +-----
>  2 files changed, 27 insertions(+), 33 deletions(-)

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
