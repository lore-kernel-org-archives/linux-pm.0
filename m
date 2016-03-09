From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] Revert "cpufreq: postfix policy directory with the first
 CPU in related_cpus"
Date: Wed, 9 Mar 2016 16:39:27 +0700
Message-ID: <20160309093927.GI23015@vireshk-mac-ubuntu>
References: <eb862848df536cb2921945cca690161014c84750.1456996795.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35100 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbcCIJjr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 04:39:47 -0500
Received: by mail-pa0-f45.google.com with SMTP id td3so8644418pab.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Mar 2016 01:39:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <eb862848df536cb2921945cca690161014c84750.1456996795.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org

On 03-03-16, 14:51, Viresh Kumar wrote:
> This reverts commit 3510fac45492 ("cpufreq: postfix policy directory
> with the first CPU in related_cpus").
> 
> Earlier, the policy->kobj was added to the kobject core, before ->init()
> callback was called for the cpufreq drivers. Which allowed those drivers
> to add or remove, driver dependent, sysfs files/directories to the same
> kobj from their ->init() and ->exit() callbacks.
> 
> That isn't possible anymore after commit 3510fac45492 got applied.
> 
> Now, there is no other clean alternative that people can adopt.
> 
> Its better to revert the earlier commit to allow cpufreq drivers to
> create/remove sysfs files from ->init() and ->exit() callbacks.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Sorry about missing SoB (Just noticed it in bleeding-edge).
-- 
viresh
