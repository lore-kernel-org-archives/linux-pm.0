From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: skip cpufreq resume if it's not suspended
Date: Mon, 5 Feb 2018 14:35:46 +0530
Message-ID: <20180205090546.GE28462@vireshk-i7>
References: <1516744675-21233-1-git-send-email-byan@nvidia.com>
 <dc33ef16-9684-3d8d-f4cc-6e24697f007f@nvidia.com>
 <20180205040118.GB28462@vireshk-i7>
 <1710637.vo8uP0oTBm@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f49.google.com ([209.85.160.49]:41701 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbeBEJFu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Feb 2018 04:05:50 -0500
Received: by mail-pl0-f49.google.com with SMTP id k8so9144582pli.8
        for <linux-pm@vger.kernel.org>; Mon, 05 Feb 2018 01:05:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1710637.vo8uP0oTBm@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bo Yan <byan@nvidia.com>, Saravana Kannan <skannan@codeaurora.org>, sgurrappadi@nvidia.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 05-02-18, 09:50, Rafael J. Wysocki wrote:
> By design (which I admit may be confusing) it should be fine to call
> dpm_resume_end() after a failing dpm_suspend_start(), whatever the reason
> for the failure is.  cpufreq_suspend/resume() don't take that into account,
> everybody else does.

Hmm, I see. Can't do much then, just fix the only broken piece of code :)

-- 
viresh
