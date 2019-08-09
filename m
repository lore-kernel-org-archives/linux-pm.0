Return-Path: <SRS0=aSb8=WF=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41174C433FF
	for <linux-pm@archiver.kernel.org>; Fri,  9 Aug 2019 16:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD6C214C6
	for <linux-pm@archiver.kernel.org>; Fri,  9 Aug 2019 16:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565369630;
	bh=9wbSn6LJh7acT2h7wInsGRfEhL2mf1j4PDVBbYpUZnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tPY76lRVU1dzjJEiAmxVJogdsjJoUvm/N5k4fEZT17Myui4g6awd9hGNvP74eLBgl
	 1IxwrS5oem4ybvhiJIDo+YOWZxgRGuWPF9rqtI0/b9EH+bNh/Rjf2/tkTZPJnqU0gv
	 x2Wwp+Mp5/3MWvq40xXDQy/nkO70j0CzIQ+AmnpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407462AbfHIQxt (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:53:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfHIQxt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Aug 2019 12:53:49 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C199C2086A;
        Fri,  9 Aug 2019 16:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565369628;
        bh=9wbSn6LJh7acT2h7wInsGRfEhL2mf1j4PDVBbYpUZnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z+srWe8CDYXXEzb9TFTXCqDeHrWV4CWVX3KBcTABLraCCx7n+HYqnsqA+PU/2qDoh
         gb4cvYdg/raT4ftzZNKqAJOoJ3EihmmMgv0RP6qaudGl7djUrhQuka4e34HJakWMnJ
         Qioe7WDnzlhyk7NxU0E86I+cgyy/ndf9faPSpuMM=
Date:   Fri, 9 Aug 2019 17:53:43 +0100
From:   Will Deacon <will@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 7/8] arm64: defconfig: Enable the PSCI CPUidle driver
Message-ID: <20190809165343.5qg3nwgwy6ybms3k@willie-the-truck>
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com>
 <cover.1565348376.git.lorenzo.pieralisi@arm.com>
 <58d9677db3510ed106fe23118090c84f78a44102.1565348376.git.lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58d9677db3510ed106fe23118090c84f78a44102.1565348376.git.lorenzo.pieralisi@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 09, 2019 at 12:03:13PM +0100, Lorenzo Pieralisi wrote:
> Enable the PSCI CPUidle driver to replace the functionality
> previously provided by the generic ARM CPUidle driver through
> CPU operations.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0e58ef02880c..c0a7cfe3aebd 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -72,6 +72,7 @@ CONFIG_RANDOMIZE_BASE=y
>  CONFIG_HIBERNATION=y
>  CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
>  CONFIG_ARM_CPUIDLE=y
> +CONFIG_ARM_PSCI_CPUIDLE=y
>  CONFIG_CPU_FREQ=y
>  CONFIG_CPU_FREQ_STAT=y
>  CONFIG_CPU_FREQ_GOV_POWERSAVE=m

I'll queue the first 6 patches in this series, but please route this one
via arm-soc to avoid conflicts:

Acked-by: Will Deacon <will@kernel.org>

Failing that, I'm happy to take it at -rc1.

Will
