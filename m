From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] intel_pstate bug fixes
Date: Mon, 07 Jul 2014 02:26:46 +0200
Message-ID: <2292059.lDAGgm9ZnI@vostro.rjw.lan>
References: <1403274480-10593-1-git-send-email-dirk.j.brandewie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55065 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751898AbaGGAIn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 6 Jul 2014 20:08:43 -0400
In-Reply-To: <1403274480-10593-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dirk.brandewie@gmail.com
Cc: linux-pm@vger.kernel.org, stable@vger.kernel.org, Dirk Brandewie <dirk.j.brandewie@intel.com>

On Friday, June 20, 2014 07:27:57 AM dirk.brandewie@gmail.com wrote:
> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
> 
> Bug fixes for intel_pstate based on v3.16-rc1.
> 
> Patch 1 fixes a regression reported at https://bugzilla.kernel.org/show_bug.cgi?id=77951
> 
> Patch 2-3 two issues reported in https://bugzilla.kernel.org/show_bug.cgi?id=64251
> 
> Dirk Brandewie (3):
>   intel_pstate: Fix setting VID
>   intel_pstate: don't touch turbo bit if turbo disabled or unavailable.
>   intel_pstate: Update documentation of {max,min}_perf_pct sysfs files
> 
>  Documentation/cpu-freq/intel-pstate.txt |  7 +++++--
>  drivers/cpufreq/intel_pstate.c          | 32 +++++++++++++++++++++-----------
>  2 files changed, 26 insertions(+), 13 deletions(-)

All three queued up as fixes for -rc5, thanks!

Rafael

