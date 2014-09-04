From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] cpufreq_opp: Fixed the order of argument for kcalloc.
Date: Thu, 04 Sep 2014 14:07:49 -0700
Message-ID: <5408D4A5.5040103@codeaurora.org>
References: <1408180966-15493-1-git-send-email-moon.linux@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:56078 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbaIDVHv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 17:07:51 -0400
In-Reply-To: <1408180966-15493-1-git-send-email-moon.linux@yahoo.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anand Moon <moon.linux@yahoo.com>, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/16/14 02:22, Anand Moon wrote:
> These changes fix the argument to the kcalloc
>         @n: number of elements.
>         @size: element size.
>         @flags: the type of memory to allocate (see kmalloc).
>
>         void *kcalloc(size_t n, size_t size, gfp_t flags)
>
> Signed-off-by: Anand Moon <moon.linux@yahoo.com>
> ---

Oops.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Can this be picked up?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

