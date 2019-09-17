Return-Path: <SRS0=4Hy5=XM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FF0C4CEC9
	for <linux-pm@archiver.kernel.org>; Tue, 17 Sep 2019 09:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF94F21897
	for <linux-pm@archiver.kernel.org>; Tue, 17 Sep 2019 09:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfIQJeV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 17 Sep 2019 05:34:21 -0400
Received: from foss.arm.com ([217.140.110.172]:53586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727637AbfIQJeV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Sep 2019 05:34:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 143E028;
        Tue, 17 Sep 2019 02:34:20 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DEE83F59C;
        Tue, 17 Sep 2019 02:34:18 -0700 (PDT)
Date:   Tue, 17 Sep 2019 10:34:12 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/5] cpufreq: qcom-hw: Move driver initialisation earlier
Message-ID: <20190917093412.GA24757@bogus>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
 <b731b713d8738239c26361ece7f5cadea035b353.1568240476.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b731b713d8738239c26361ece7f5cadea035b353.1568240476.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 12, 2019 at 04:02:34AM +0530, Amit Kucheria wrote:
> Allow qcom-hw driver to initialise right after the cpufreq and thermal
> subsystems are initialised in core_initcall so we get earlier access to
> thermal mitigation.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 4b0b50403901..04676cc82ba6 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -327,7 +327,7 @@ static int __init qcom_cpufreq_hw_init(void)
>  {
>  	return platform_driver_register(&qcom_cpufreq_hw_driver);
>  }
> -device_initcall(qcom_cpufreq_hw_init);
> +postcore_initcall(qcom_cpufreq_hw_init);

I am fine with core framework initcall pushed to earlier initcall levels
if required, but for individual/platform specific drivers I am not so
happy to see that.

This goes against the grand plan of single common kernel strategy by
Android moving all drivers as modules. We might decide to make this
a module. Also there are few cpufreq drivers that are modules. Will
they have issues ? If not, why do we need this change at all. Needing
thermal mitigation during boot this earlier is still too much of
expectation, I would rather boot slowly than relying on this feature.

--
Regards,
Sudeep
