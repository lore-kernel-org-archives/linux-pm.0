From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] tools/power turbostat: Disable HWP OOB status
Date: Fri, 11 Nov 2016 23:18:57 +0100
Message-ID: <CAJZ5v0gmRucf71PmqF+J1vOoYW_dBgs6t+40SNZhB6JxUF-n6Q@mail.gmail.com>
References: <1478902499-21293-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36180 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934016AbcKKWS7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Nov 2016 17:18:59 -0500
Received: by mail-qt0-f196.google.com with SMTP id n34so1687378qtb.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Nov 2016 14:18:58 -0800 (PST)
In-Reply-To: <1478902499-21293-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>

On Fri, Nov 11, 2016 at 11:14 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> Display if the HWP is enabled in OOB (Out of band) mode.

Hmm.  Should the subject be "tools/power turbostat: Display HWP OOB status"?

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 3e199b5..27fb0f0 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -3174,10 +3174,11 @@ void decode_misc_pwr_mgmt_msr(void)
>                 return;
>
>         if (!get_msr(base_cpu, MSR_MISC_PWR_MGMT, &msr))
> -               fprintf(outf, "cpu%d: MSR_MISC_PWR_MGMT: 0x%08llx (%sable-EIST_Coordination %sable-EPB)\n",
> +               fprintf(outf, "cpu%d: MSR_MISC_PWR_MGMT: 0x%08llx (%sable-EIST_Coordination %sable-EPB %sable-OOB)\n",
>                         base_cpu, msr,
>                         msr & (1 << 0) ? "DIS" : "EN",
> -                       msr & (1 << 1) ? "EN" : "DIS");
> +                       msr & (1 << 1) ? "EN" : "DIS",
> +                       msr & (1 << 8) ? "EN" : "DIS");
>  }
>
>  void process_cpuid()
> --

Thanks,
Rafael
