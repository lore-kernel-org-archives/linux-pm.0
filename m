From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Replace recover_policy with new_policy in
 cpufreq_online()
Date: Wed, 29 Jul 2015 11:08:46 +0530
Message-ID: <20150729053846.GD21493@linux>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
 <1702607.RH80fBCN6J@vostro.rjw.lan>
 <3091538.g8dYBumqSx@vostro.rjw.lan>
 <2952411.gjDWaFdOqs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36725 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbbG2Fiy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2015 01:38:54 -0400
Received: by pdjr16 with SMTP id r16so84594261pdj.3
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2015 22:38:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2952411.gjDWaFdOqs@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 29-07-15, 03:08, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The recover_policy is unsed in cpufreq_online() to indicate whether
> a new policy object is created or an existing one is reinitialized.
> 
> The "recover" part of the name is slightly confusing (it should be
> "reinitialization" rather than "recovery") and the logical not (!)
> operator is applied to it in almost all of the checks it is used in,
> so replace that variable with a new one called "new_policy" that
> will be true in the case of a new policy creation.
> 
> While at it, drop one of the labels that is jumped to from only
> one spot.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> One extra cleanup on top of https://patchwork.kernel.org/patch/6888751/
> 
> ---
>  drivers/cpufreq/cpufreq.c |   23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
