Return-Path: <SRS0=Nxon=DQ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56FAC433DF
	for <linux-pm@archiver.kernel.org>; Fri,  9 Oct 2020 12:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6644A222B9
	for <linux-pm@archiver.kernel.org>; Fri,  9 Oct 2020 12:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbgJIMg5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 9 Oct 2020 08:36:57 -0400
Received: from foss.arm.com ([217.140.110.172]:49938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgJIMg5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Oct 2020 08:36:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7C441063;
        Fri,  9 Oct 2020 05:36:56 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8F0A3F70D;
        Fri,  9 Oct 2020 05:36:55 -0700 (PDT)
Date:   Fri, 9 Oct 2020 13:36:49 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] MAINTAINERS: Add section for cpuidle-psci PM domain
Message-ID: <20201009123649.GA18074@e121166-lin.cambridge.arm.com>
References: <20201001092852.124740-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001092852.124740-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 01, 2020 at 11:28:52AM +0200, Ulf Hansson wrote:
> The cpuidle-psci-domain.c is not listed in the section for the cpuidle
> driver for ARM PSCI. From discussions at LKML, Lorenzo and Sudeep prefer
> that we add a separate section for it, so let's do that and add myself as
> the maintainer for this part.
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 45102f1fe361..be8e3e9a8e29 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4574,6 +4574,14 @@ L:	linux-arm-kernel@lists.infradead.org
>  S:	Supported
>  F:	drivers/cpuidle/cpuidle-psci.c
>  
> +CPUIDLE DRIVER - ARM PSCI PM DOMAIN
> +M:	Ulf Hansson <ulf.hansson@linaro.org>
> +L:	linux-pm@vger.kernel.org
> +L:	linux-arm-kernel@lists.infradead.org
> +S:	Supported
> +F:	drivers/cpuidle/cpuidle-psci.h
> +F:	drivers/cpuidle/cpuidle-psci-domain.c
> +
>  CRAMFS FILESYSTEM
>  M:	Nicolas Pitre <nico@fluxnic.net>
>  S:	Maintained
> -- 
> 2.25.1
> 
