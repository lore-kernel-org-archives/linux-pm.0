From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: imx6q: add CPU as cooling device
Date: Wed, 15 Nov 2017 14:36:23 +0530
Message-ID: <20171115090623.GJ3257@vireshk-i7>
References: <20171114135128.6173-1-bst@pengutronix.de>
 <20171115045956.GG3257@vireshk-i7>
 <6926d893-53ca-7719-f530-0406148f8fde@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:51959 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754097AbdKOJG0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 04:06:26 -0500
Received: by mail-pf0-f193.google.com with SMTP id j28so14245953pfk.8
        for <linux-pm@vger.kernel.org>; Wed, 15 Nov 2017 01:06:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <6926d893-53ca-7719-f530-0406148f8fde@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bastian Stender <bst@pengutronix.de>
Cc: shawnguo@kernel.org, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, kernel@pengutronix.de, linux-pm@vger.kernel.org

On 15-11-17, 10:04, Bastian Stender wrote:
> Yes, I looked how drivers/cpufreq/mediatek-cpufreq.c handles the cooling
> device. So dev_pm_opp_free_cpufreq_table is obviously not needed, but why do
> we need no cpufreq_cooling_unregister call here?

My comment was only for the last line, i.e. dev_pm_opp_free_cpufreq_table(). Of
course we need to use cpufreq_cooling_unregister() as you pointed out.

-- 
viresh
