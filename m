From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [GIT PULL] Power management fixes for v4.7-rc2
Date: Fri, 03 Jun 2016 23:50:13 +0200
Message-ID: <2755572.OUiMVQx5tM@vostro.rjw.lan>
References: <CAJZ5v0jCH7akpQDmKrXmBSFZNsit1REA5XPcSm4bx6Q1aJxmiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41687 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751544AbcFCVqT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jun 2016 17:46:19 -0400
In-Reply-To: <CAJZ5v0jCH7akpQDmKrXmBSFZNsit1REA5XPcSm4bx6Q1aJxmiQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>

Forgot to send a CC of this to linux-pm, sorry about that.

On Friday, June 03, 2016 11:39:04 PM you wrote:
> Hi Linus,
> 
> Please pull from
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  pm-4.7-rc2
> 
> to receive power management fixes for v4.7-rc2 with top-most commit
> 8cd8cbd4906126951f1bd6ab8a28ee57f0dc1efc
> 
>  Merge branch 'pm-cpufreq-fixes'
> 
> on top of commit 1a695a905c18548062509178b98bc91e67510864
> 
>  Linux 4.7-rc1
> 
> Two fixes for problems introduced recently in the cpufreq core
> and the intel_pstate driver.
> 
> Specifics:
> 
>  - Fix a silly mistake related to the clamp_val() usage in
>    a function added by a recent commit (Rafael Wysocki).
> 
>  - Reduce the log level of an annoying message added to intel_pstate
>    during the recent merge window (Srinivas Pandruvada).
> 
> Thanks!
> 
> ---------------
> 
> Rafael J. Wysocki (1):
>       cpufreq: Fix clamp_val() usage in cpufreq_driver_fast_switch()
> 
> Srinivas Pandruvada (1):
>       cpufreq: intel_pstate: Downgrade print level for _PPC
> 
> ---------------
> 
>  drivers/cpufreq/cpufreq.c      | 2 +-
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

