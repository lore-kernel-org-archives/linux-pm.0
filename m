From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 RESEND 0/3] cpufreq/ondemand support for Xserve G5 & iMac G5 iSight
Date: Tue, 01 Oct 2013 07:00:18 +0200
Message-ID: <1431916.leHx1ThHeV@vostro.rjw.lan>
References: <1380573873-14448-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63659 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751008Ab3JAEsu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2013 00:48:50 -0400
In-Reply-To: <1380573873-14448-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Monday, September 30, 2013 11:44:30 PM Aaro Koskinen wrote:
> Hi,
> 
> This is a resend of the v2 patchset:
> 
> 	http://marc.info/?t=137797013200001&r=1&w=2
> 
> No changes except rebasing. Any chance to get these into v3.13?

Well, Ben's ACKs are missing as far as I'm concerned ...

> Aaro Koskinen (3):
>   cpufreq: pmac64: speed up frequency switch
>   cpufreq: pmac64: provide cpufreq transition latency for older G5
>     models
>   cpufreq: pmac64: enable cpufreq on iMac G5 (iSight) model
> 
>  drivers/cpufreq/pmac64-cpufreq.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
