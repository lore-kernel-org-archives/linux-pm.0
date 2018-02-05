From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: skip cpufreq resume if it's not suspended
Date: Mon, 5 Feb 2018 09:31:18 +0530
Message-ID: <20180205040118.GB28462@vireshk-i7>
References: <1516744675-21233-1-git-send-email-byan@nvidia.com>
 <1744712.rO4QOLozun@aspire.rjw.lan>
 <913f1715-bdd0-1c03-ad76-38be9d3d2298@nvidia.com>
 <17447147.z6jfkRxuEB@aspire.rjw.lan>
 <5A74BD55.5000402@codeaurora.org>
 <dc33ef16-9684-3d8d-f4cc-6e24697f007f@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46132 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbeBEEBW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Feb 2018 23:01:22 -0500
Received: by mail-pl0-f66.google.com with SMTP id 36so10941440ple.13
        for <linux-pm@vger.kernel.org>; Sun, 04 Feb 2018 20:01:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <dc33ef16-9684-3d8d-f4cc-6e24697f007f@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bo Yan <byan@nvidia.com>
Cc: Saravana Kannan <skannan@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, sgurrappadi@nvidia.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 02-02-18, 13:28, Bo Yan wrote:
> On 02/02/2018 11:34 AM, Saravana Kannan wrote:
> >I rather have this fixed in the dpm_suspend/resume() code. This is just
> >masking the first issue that's being caused by unbalanced error handling.
> >If that means adding flags in dpm_suspend/resume() then that's what we
> >should do right now and clean it up later if it can be improved. Making
> >cpufreq more messy doesn't seem like the right answer.

+1

> dpm_suspend and dpm_resume by themselves are not balanced in this particular
> case. As it's currently structured, dpm_resume can't be omitted even if
> dpm_suspend is skipped due to earlier failure.  I think checking
> cpufreq_suspended flag is a reasonable compromise. If we can find a way to
> make dpm_suspend/dpm_resume also balanced, that will be best.

I think cpufreq is just one of the users which broke. Others didn't break
because:

- They don't have a complicated resume part.
- Or we just don't know that they broke.

Resuming something that never suspended is just broken by design. Yeah, its much
simpler in this particular case to fix cpufreq core but the
suspend/resume/hibernation part is really core kernel and should be fixed to
avoid such band-aids.

-- 
viresh
