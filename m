From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] Documentation: cpufreq: intel_pstate: fix typo
Date: Thu, 18 Feb 2016 20:30:13 +0100
Message-ID: <CAJZ5v0jqsp=OVXXZZRkakSgh+sqjH1C4_HdU1+B=K+C20d3aZA@mail.gmail.com>
References: <1455807106-4224-1-git-send-email-felipe@nutanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:33526 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946538AbcBRTaP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 14:30:15 -0500
Received: by mail-lb0-f195.google.com with SMTP id bc4so1771623lbc.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2016 11:30:14 -0800 (PST)
In-Reply-To: <1455807106-4224-1-git-send-email-felipe@nutanix.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Franciosi <felipe@nutanix.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Thu, Feb 18, 2016 at 3:51 PM, Felipe Franciosi <felipe@nutanix.com> wrote:
> This just swaps a colon for a quote in the intel_pstate documentation.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> ---
>  Documentation/cpu-freq/intel-pstate.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/cpu-freq/intel-pstate.txt b/Documentation/cpu-freq/intel-pstate.txt
> index f7b12c0..e6bd1e6 100644
> --- a/Documentation/cpu-freq/intel-pstate.txt
> +++ b/Documentation/cpu-freq/intel-pstate.txt
> @@ -25,7 +25,7 @@ callback, so cpufreq core can't request a transition to a specific frequency.
>  The driver provides minimum and maximum frequency limits and callbacks to set a
>  policy. The policy in cpufreq sysfs is referred to as the "scaling governor".
>  The cpufreq core can request the driver to operate in any of the two policies:
> -"performance: and "powersave". The driver decides which frequency to use based
> +"performance" and "powersave". The driver decides which frequency to use based
>  on the above policy selection considering minimum and maximum frequency limits.
>
>  The Intel P-State driver falls under the latter category, which implements the
> --

OK, I'm queuing this up for 4.6.

Thanks,
Rafael
