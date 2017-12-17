From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [v3 PATCH 3/3] powernv-cpufreq: Treat pstates as opaque 8-bit values
Date: Sun, 17 Dec 2017 14:17:02 +1100
Message-ID: <CAKTCnz=qMNECSSfVGXNfN9JfxAZUB86-dwtx1ZCicmj7b7Kweg@mail.gmail.com>
References: <1513148261-21097-1-git-send-email-ego@linux.vnet.ibm.com> <1513148261-21097-4-git-send-email-ego@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:37717 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757126AbdLQDRE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Dec 2017 22:17:04 -0500
In-Reply-To: <1513148261-21097-4-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, huntbag@linux.vnet.ibm.com, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>

On Wed, Dec 13, 2017 at 5:57 PM, Gautham R. Shenoy
<ego@linux.vnet.ibm.com> wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> On POWER8 and POWER9, the PMSR and the PMCR registers define pstates
> to be 8-bit wide values. The device-tree exports pstates as 32-bit
> wide values of which the lower byte is the actual pstate.
>
> The current implementation in the kernel treats pstates as integer
> type, since it used to use the sign of the pstate for performing some
> boundary-checks. This is no longer required after the patch
> "powernv-cpufreq: Fix pstate_to_idx() to handle non-continguous
> pstates".
>
> So, in this patch, we modify the powernv-cpufreq driver to uniformly
> treat pstates as opaque 8-bit values obtained from the device-tree or
> the PMCR. This simplifies the extract_pstate() helper function since
> we no longer no longer require to worry about the sign-extentions.
>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 47 ++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 8e3dbca..8a4e2ce 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -110,12 +110,11 @@ struct global_pstate_info {
>   *         hashtable
>   */
>  struct pstate_idx_revmap_data {
> -       int pstate_id;
> +       u8 pstate_id;
>         unsigned int cpufreq_table_idx;
>         struct hlist_node hentry;
>  };
>
> -u32 pstate_sign_prefix;
>  static bool rebooting, throttled, occ_reset;
>
>  static const char * const throttle_reason[] = {
> @@ -170,14 +169,9 @@ enum throttle_reason_type {
>         bool wof_enabled;
>  } powernv_pstate_info;
>
> -static inline int extract_pstate(u64 pmsr_val, unsigned int shift)
> +static inline u8 extract_pstate(u64 pmsr_val, unsigned int shift)
>  {
> -       int ret = ((pmsr_val >> shift) & 0xFF);
> -
> -       if (!ret)
> -               return ret;
> -
> -       return (pstate_sign_prefix | ret);
> +       return ((pmsr_val >> shift) & 0xFF);
>  }

So we just added this and moved from an int to u8. I was going to ask
if we still need an int in patch1, but I thought the driver dealt with
just integers because of the larger framework.

Balbir Singh.
