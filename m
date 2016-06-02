From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/8] cpufreq: powerenv: Fix memory leak
Date: Thu, 2 Jun 2016 16:52:03 +0530
Message-ID: <20160602112203.GO3725@vireshk-i7>
References: <cover.1464776797.git.viresh.kumar@linaro.org>
 <f67b4b395c777a3e933ab51eafcd76b1299bf1fb.1464776797.git.viresh.kumar@linaro.org>
 <1464865688.11826.1.camel@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35596 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbcFBLWH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 07:22:07 -0400
Received: by mail-pa0-f46.google.com with SMTP id xk1so5217201pac.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2016 04:22:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1464865688.11826.1.camel@ellerman.id.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linaro-kernel@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 02-06-16, 21:08, Michael Ellerman wrote:
> On Wed, 2016-06-01 at 16:04 +0530, Viresh Kumar wrote:
> 
> > The policy is copied (unnecessarily) and is never freed. Fix it by just
> > getting a reference to the existing policy structure and putting it
> > back.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> When was it broken, always?
> 
> Cc: stable ?

Its a small memory leak and its not that we will fail on something. So
didn't bother to add those details, but in case they are required:

Cc: <stable@vger.kernel.org> # 4.3+
Fixes: 227942809b52 ("cpufreq: powernv: Restore cpu frequency to policy->cur on unthrottling")

-- 
viresh
