From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: powernv: Fixes initialization of chip and chip
 mask
Date: Wed, 20 Apr 2016 15:20:56 +0530
Message-ID: <20160420095056.GE12019@vireshk-i7>
References: <1461144758-17810-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:32920 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932257AbcDTJvA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 05:51:00 -0400
Received: by mail-pa0-f47.google.com with SMTP id zm5so16385144pac.0
        for <linux-pm@vger.kernel.org>; Wed, 20 Apr 2016 02:51:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1461144758-17810-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org

On 20-04-16, 15:02, Shilpasri G Bhat wrote:
> commit 735366fc4077 ("cpufreq: powernv: Call throttle_check() on
> receiving OCC_THROTTLE") used cpumask_of_node() as the chip mask. But
> this mask contains only online cpus. This breaks a setup where cpufreq
> is initialized with few offline cores and made online later. So this
> patch fixes this bug by scanning all the possible cpus and sets the
> cpu in the chip mask. It also fixes the chip discovery with
> non-contiguous cpu mask. This patch creates a list of chips
> 'powernv_chip_list' to replace the chip array for cleaner
> initialization.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 80 +++++++++++++++++++++++----------------
>  1 file changed, 48 insertions(+), 32 deletions(-)

You have made your patch less readable by mixing two things here. Yes
you prefer/need the list way of doing things for the new stuff, but
that should have been done separately. Right now, I have to read it
very carefully to see which line did the real change you are talking
about.

So, please split this up into multiple patches. First one just moving
to the list instead of array.

-- 
viresh
