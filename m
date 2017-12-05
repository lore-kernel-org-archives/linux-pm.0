From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: powernv: Define methods to parse positive &
 negative pstates
Date: Tue, 5 Dec 2017 11:11:30 +0530
Message-ID: <20171205054130.vsr45ekas3f5k3cg@vireshk-mac-ubuntu>
References: <1512017018-4857-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38856 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752182AbdLEFle (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Dec 2017 00:41:34 -0500
Received: by mail-pf0-f193.google.com with SMTP id u25so10422092pfg.5
        for <linux-pm@vger.kernel.org>; Mon, 04 Dec 2017 21:41:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1512017018-4857-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, svaidy@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, huntbag@linux.vnet.ibm.com, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

On 30-11-17, 10:13, Shilpasri G Bhat wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Pstates are 8bit values but on POWER8 they are negative and on POWER9
> they are positive. This patch adds helper routines to differentiate
> the sign to read the correct pstate value.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 43 ++++++++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 10 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
