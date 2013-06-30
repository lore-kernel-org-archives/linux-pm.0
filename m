From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] intel_pstate: Add Haswell CPU models
Date: Sun, 30 Jun 2013 20:50:07 +0530
Message-ID: <CAOh2x=nBKhhGPK7+xooKEKN96UQqdzhvn=TT9HTfRFgCE6OYMA@mail.gmail.com>
References: <51CD8087.7030303@spicious.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:62309 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab3F3PUI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jun 2013 11:20:08 -0400
In-Reply-To: <51CD8087.7030303@spicious.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nell Hardcastle <nell@spicious.com>
Cc: cpufreq@vger.kernel.org, dirk.j.brandewie@intel.com, Linux PM list <linux-pm@vger.kernel.org>

You need to cc linux-pm list too, so that Rafael can pick this one.

On Fri, Jun 28, 2013 at 5:54 PM, Nell Hardcastle <nell@spicious.com> wrote:
> Enable the intel_pstate driver for Haswell CPUs and one Ivy Bridge model not already included (0x3E). I've been testing this change on the Core i5-4200u (model 0x45) and I referenced the list of models in tools/power/x86/turbostat/turbostat.c:has_nehalem_turbo_ratio_limit to determine the others.

Please respect the 80 column rule for writing patches.

> Fixes https://bugzilla.kernel.org/show_bug.cgi?id=60211
>
> Signed-off-by: Nell Hardcastle <nell@spicious.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 07f2840..dbd1032 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -522,6 +522,11 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
>         ICPU(0x2a, default_policy),
>         ICPU(0x2d, default_policy),
>         ICPU(0x3a, default_policy),
> +       ICPU(0x3c, default_policy),
> +       ICPU(0x3e, default_policy),
> +       ICPU(0x3f, default_policy),
> +       ICPU(0x45, default_policy),
> +       ICPU(0x46, default_policy),

Looks fine otherwise. Please add my
Acked-by: Viresh Kumar <viresh.kumar@linaro.org> and resend V2 with
fixed commit log.
