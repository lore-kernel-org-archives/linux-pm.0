From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] cpupower: mperf monitor: Correct use of ! and &
Date: Wed, 30 Jul 2014 02:28:11 +0200
Message-ID: <2905082.LOmnC9giP0@vostro.rjw.lan>
References: <2377922.j9jRKZAKtD@vostro.rjw.lan> <1406650340-38644-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53280 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752651AbaG3AJj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jul 2014 20:09:39 -0400
In-Reply-To: <1406650340-38644-1-git-send-email-trenn@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-pm@vger.kernel.org, Himangi Saraogi <himangi774@gmail.com>

On Tuesday, July 29, 2014 06:12:18 PM Thomas Renninger wrote:
> From: Himangi Saraogi <himangi774@gmail.com>
> 
> In commit ae91d60ba88ef0bdb1b5e9b2363bd52fc45d2af7, a bug was fixed that
> involved converting !x & y to !(x & y).  The code below shows the same
> pattern, and thus should perhaps be fixed in the same way.
> 
> The Coccinelle semantic patch that makes this change is as follows:
> 
> // <smpl>
> @@ expression E1,E2; @@
> (
>   !E1 & !E2
> |
> - !E1 & E2
> + !(E1 & E2)
> )
> // </smpl>
> 
> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> Signed-off-by: Thomas Renninger <trenn@suse.de>

All three queued up for 3.17, thanks!

> ---
>  .../cpupower/utils/idle_monitor/mperf_monitor.c    |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
> index 5650ab5..90a8c4f 100644
> --- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
> +++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
> @@ -237,7 +237,7 @@ static int init_maxfreq_mode(void)
>  	unsigned long long hwcr;
>  	unsigned long min;
>  
> -	if (!cpupower_cpu_info.caps & CPUPOWER_CAP_INV_TSC)
> +	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_INV_TSC))
>  		goto use_sysfs;
>  
>  	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD) {
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
