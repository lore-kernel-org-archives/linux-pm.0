From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 1/2] cpufreq: qoriq: Remove __exit macro from .exit
 callback
Date: Tue, 19 Apr 2016 14:41:51 +0530
Message-ID: <20160419091151.GA2905@vireshk-i7>
References: <1461056407-22542-1-git-send-email-hongtao.jia@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34107 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbcDSJLz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2016 05:11:55 -0400
Received: by mail-pf0-f181.google.com with SMTP id c20so4982568pfc.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2016 02:11:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1461056407-22542-1-git-send-email-hongtao.jia@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jia Hongtao <hongtao.jia@nxp.com>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, scott.wood@nxp.com, yuantian.tang@nxp.com

On 19-04-16, 17:00, Jia Hongtao wrote:
> .exit callback (qoriq_cpufreq_cpu_exit()) is also used during suspend.
> So __exit macro should be removed or the function will be discarded.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> ---
>  drivers/cpufreq/qoriq-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
