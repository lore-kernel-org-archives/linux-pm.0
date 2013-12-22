From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH RESEND] cpufreq: Fix sscanf robustness
Date: Sun, 22 Dec 2013 02:05:05 +0100
Message-ID: <1952313.Ju5ZCk3TWs@vostro.rjw.lan>
References: <20131217150723.29514.53369.stgit@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55065 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754867Ab3LVAvl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 Dec 2013 19:51:41 -0500
In-Reply-To: <20131217150723.29514.53369.stgit@alan.etchedpixels.co.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan <gnomes@lxorguk.ukuu.org.uk>
Cc: akpm@linux-foundation.org, linux-pm@vger.kernel.org

On Tuesday, December 17, 2013 03:07:31 PM Alan wrote:
> The cpufreq-set tool has a missing length check. This is basically
> just correctness but still should get fixed.
> 
> One of a set of sscanf problems reported by Jackie Chang
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>

Queued up for 3.14 (with a slightly modified changelog).

Thanks,
Rafael


> ---
>  tools/power/cpupower/utils/cpufreq-set.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
> index dd1539e..a416de8 100644
> --- a/tools/power/cpupower/utils/cpufreq-set.c
> +++ b/tools/power/cpupower/utils/cpufreq-set.c
> @@ -257,7 +257,7 @@ int cmd_freq_set(int argc, char **argv)
>  				print_unknown_arg();
>  				return -EINVAL;
>  			}
> -			if ((sscanf(optarg, "%s", gov)) != 1) {
> +			if ((sscanf(optarg, "%19s", gov)) != 1) {
>  				print_unknown_arg();
>  				return -EINVAL;
>  			}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
