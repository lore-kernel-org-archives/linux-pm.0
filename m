From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v1 5/6] bitops: Introduce BIT_ULL
Date: Thu, 19 Sep 2013 18:48:30 +0200
Message-ID: <20130919164830.GB9427@pd.tnic>
References: <1379606435-15871-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1379606435-15871-6-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:51847 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751933Ab3ISQsg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 19 Sep 2013 12:48:36 -0400
Content-Disposition: inline
In-Reply-To: <1379606435-15871-6-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, len.brown@intel.com, rjw@sisk.pl, arjan@linux.intel.com, jacob.jun.pan@linux.intel.com

On Thu, Sep 19, 2013 at 09:00:34AM -0700, Srinivas Pandruvada wrote:
> Adding BIT(x) equivalent for unsigned long long type, BIT_ULL(x).
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/bitops.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index a3b6b82..34e9e94 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -4,6 +4,7 @@
>  
>  #ifdef	__KERNEL__
>  #define BIT(nr)			(1UL << (nr))
> +#define BIT_ULL(nr)		(1ULL << (nr))

We already have BIT_64 for that.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
