From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] cpufreq: governor: Fix potential races
Date: Tue, 16 Jun 2015 01:48:22 +0200
Message-ID: <12928435.yRdE4OQBRL@vostro.rjw.lan>
References: <cover.1433326032.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50620 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750835AbbFOXWZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 19:22:25 -0400
In-Reply-To: <cover.1433326032.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On Wednesday, June 03, 2015 03:57:10 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> Preeti recently highlighted [1] some issues in cpufreq core locking with
> respect to governors. I wanted to solve them after we have simplified
> the hotplug paths in cpufreq core with my latest patches, but now that
> she has poked me, I have done some work in that area.
> 
> I am trying to solve only a part of the bigger problem (in a way that I
> feel is the right way ahead). The first patches restructures code to
> make it more readable and the last patch does all the major changes. The
> logs in that one should be good enough to explain why and what I am
> doing.
> 
> The first two shouldn't bring any functional change and so can be
> applied early if you are confident about them.
> 
> @Preeti: I would like you to test these patches. These should get rid of
> the crashes you were facing but may generate a WARN() from line 447 of
> cpufreq_governor.c, if the sequence is wrong. That has to be fixed
> separately.
> 
> Line 447: WARN_ON(!dbs_data && (event != CPUFREQ_GOV_POLICY_INIT))
> 
> Rebased over: v4.1-rc6
> Tested-on: ARM dual Cortex -A15 Exynos board.
> 
> [1] http://marc.info/?i=20150601064031.2972.59208.stgit%40perfhull-ltc.austin.ibm.com
> 
> Viresh Kumar (3):
>   cpufreq: governor: register notifier from cs_init()
>   cpufreq: governor: split cpufreq_governor_dbs()
>   cpufreq: governor: Serialize governor callbacks
> 
>  drivers/cpufreq/cpufreq_conservative.c |  28 +--
>  drivers/cpufreq/cpufreq_governor.c     | 340 ++++++++++++++++++---------------
>  drivers/cpufreq/cpufreq_governor.h     |  16 +-
>  drivers/cpufreq/cpufreq_ondemand.c     |   6 +-
>  4 files changed, 209 insertions(+), 181 deletions(-)

I've queued up the series (with the replacement [2/3]) for 4.2, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
