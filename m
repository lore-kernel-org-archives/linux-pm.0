From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 12/12] cpufreq: dt: Reintroduce independent_clocks
 platform data
Date: Mon, 11 Dec 2017 14:03:28 +0530
Message-ID: <20171211083328.GE25177@vireshk-i7>
References: <1512726150-7204-1-git-send-email-sricharan@codeaurora.org>
 <1512726150-7204-13-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40092 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdLKIdd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Dec 2017 03:33:33 -0500
Received: by mail-pg0-f66.google.com with SMTP id k15so10433337pgr.7
        for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2017 00:33:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1512726150-7204-13-git-send-email-sricharan@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08-12-17, 15:12, Sricharan R wrote:
> The Platform data was removed earlier by,
> 'commit eb96924acddc ("cpufreq: dt: Kill platform-data")'
> since there were no users at that time.
> Now this is required when the each of the cpu clocks
> can be scaled independently, which is the case
> for krait cores. So reintroduce it.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 7 ++++++-
>  drivers/cpufreq/cpufreq-dt.h | 6 ++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)

Nack. This information should come from the OPP layer (Hint:
dev_pm_opp_of_get_sharing_cpus()).

-- 
viresh
