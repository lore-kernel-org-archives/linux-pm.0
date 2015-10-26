From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v7 2/2] cpufreq: intel_pstate: Fix the FSB feq for Airmont
Date: Tue, 27 Oct 2015 00:56:08 +0100
Message-ID: <CAJZ5v0g3OA-ZFF=LJxRiFCcyeuwBCpRzt9mkUvW+tkG=gX+_ZQ@mail.gmail.com>
References: <1445851923-2054-1-git-send-email-philippe.longepe@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35603 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbbJZX4K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2015 19:56:10 -0400
Received: by lfbn126 with SMTP id n126so129575675lfb.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2015 16:56:08 -0700 (PDT)
In-Reply-To: <1445851923-2054-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philippe Longepe <philippe.longepe@linux.intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Mon, Oct 26, 2015 at 10:32 AM, Philippe Longepe
<philippe.longepe@linux.intel.com> wrote:
> From: longepe <philippe.longepe@linux.intel.com>

Please fix this tag.

> Include the Airmont support in the get_scaling function.

The patch is doing more that this.

> Signed-off-by: longepe <philippe.longepe@linux.intel.com>
> Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 56 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 45 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 8618b02..4cdf97a 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -551,20 +551,35 @@ static void atom_set_pstate(struct cpudata *cpudata, int pstate)
>         wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
>  }
>
> -#define ATOM_BCLK_FREQS 5
> -static int atom_freq_table[ATOM_BCLK_FREQS] = { 833, 1000, 1333, 1167, 800};
> -
> -static int atom_get_scaling(void)
> +static int silvermont_get_scaling(void)

So the changelog should say something like

"There are two flavors of Atom cores to be supported by intel_pstate,
Silvermont and Airmont, so make the driver distinguish between them by
adding separate frequency tables etc for each of them and matching the
CPU IDs against them as appropriate."

Thanks,
Rafael
