From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: powernv: Add support of frequency domain
Date: Mon, 18 Dec 2017 13:59:35 +0530
Message-ID: <20171218082935.GH19815@vireshk-i7>
References: <20171213081937.16376-1-huntbag@linux.vnet.ibm.com>
 <20171214044239.GU3322@vireshk-i7>
 <93cc9d38-4fd8-d340-2263-108329b69b94@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:40630 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752476AbdLRI3j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Dec 2017 03:29:39 -0500
Received: by mail-pf0-f176.google.com with SMTP id v26so9394733pfl.7
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2017 00:29:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <93cc9d38-4fd8-d340-2263-108329b69b94@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhishek <huntbag@linux.vnet.ibm.com>
Cc: ego@linux.vnet.ibm.com, rjw@rjwysocki.net, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

On 18-12-17, 10:41, Abhishek wrote:
> We need to do it in this way as the current implementation takes the max of
> the PMSR of the cores. Thus, when the frequency is required to be ramped up,
> it suffices to write to just the local PMSR, but when the frequency is to be
> ramped down, if we don't send the IPI it breaks the compatibility with P8.

Looks strange really that you have to program this differently for speeding up
or down. These CPUs are part of one cpufreq policy and so I would normally
expect changes to any CPU should reflect for other CPUs as well.

@Goutham: Do you know why it is so ?

-- 
viresh
