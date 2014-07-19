From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/11] intel_pstate updates
Date: Sat, 19 Jul 2014 22:31:30 +0200
Message-ID: <3522584.qtcX0qT22E@vostro.rjw.lan>
References: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51619 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754635AbaGSUNL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 19 Jul 2014 16:13:11 -0400
In-Reply-To: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dirk.brandewie@gmail.com
Cc: linux-pm@vger.kernel.org, Dirk Brandewie <dirk.j.brandewie@intel.com>, Stratos Karafotis <stratosk@semaphore.gr>

On Friday, July 18, 2014 08:37:16 AM dirk.brandewie@gmail.com wrote:
> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
> 
> These patches have been in the development branch used by Stratos,
> Doug and myself for a long time.  I had hoped to batch them up with
> other functional changes that are under development but those changes
> are still under active discussion and there is no reason to hold these
> changes up.
> 
> Based on v3.16-rc5 commit 1795cd9b3a91d4b5473c97f491d63892442212ab
> 
> Stratos Karafotis (11):
>   cpufreq: intel_pstate: Make intel_pstate_kobject and debugfs_parent
>     locals
>   cpufreq: intel_pstate: Remove unnecessary type casting in div_s64()
>     call
>   cpufreq: intel_pstate: Add missing blank lines after declarations
>   cpufreq: intel_pstate: Fit code in a single line where possible
>   cpufreq: intel_pstate: Cleanup parentheses
>   cpufreq: intel_pstate: Remove unnecessary intermediate variable
>     sample_time
>   cpufreq: intel_pstate: Align multiple lines to open parenthesis
>   cpufreq: intel_pstate: Disable interrupts during MSRs reading
>   cpufreq: intel_pstate: Simplify P state adjustment logic.
>   cpufreq: intel_pstate: Remove core_pct rounding
>   cpufreq: intel_pstate: Keep values in aperf/mperf in full precision

[11/11] appears to be the same as the patch marked [9/17] which I guess
was posted by mistake.  Other than that, looks good.  Queued up for 3.17,
thanks!

> 
>  drivers/cpufreq/intel_pstate.c | 131 +++++++++++++++++------------------------
>  1 file changed, 53 insertions(+), 78 deletions(-)
> 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
