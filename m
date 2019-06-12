Return-Path: <SRS0=77RQ=UL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F17CC31E46
	for <linux-pm@archiver.kernel.org>; Wed, 12 Jun 2019 10:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3064E20874
	for <linux-pm@archiver.kernel.org>; Wed, 12 Jun 2019 10:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560335645;
	bh=8T6dnFzQPiLaoQgZC+Dpz7abgUojnrqzVQ3wpe/w1IE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PAW+vz8wogU+bbqyvk4CxWcLPzC6+wgOniU0mcSzAHdeqshG7JPZ5ZPg3DEuvz1FW
	 eucLQxWfjW0mIIx6UwDr4ly2CCV40UDn/JzFg4LhWep3aBNZ7Igo8YxhFzOZCO5TuL
	 7Ysl3OrgUlxinbwHbZ4jbIV02YWKwlo2JQ2jrGsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbfFLKeE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:34:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbfFLKeE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Jun 2019 06:34:04 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5773B2082C;
        Wed, 12 Jun 2019 10:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560335644;
        bh=8T6dnFzQPiLaoQgZC+Dpz7abgUojnrqzVQ3wpe/w1IE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G30A9vkkKUqaqawEP5TZMl6ELc/YqQb2Jqm894VVfpuQ+P9OsMTUPSthyi0ZTLN3f
         xQdfxpqsvAcjB57t5sjm4MOXTiJ6IotDIzpgZPtK2qlHcgLlu2pQxF1X7ifMRlf77E
         7qhkfpNSLberR1A0AchXnjZ5hEDPf+LSsLEcnruQ=
Date:   Wed, 12 Jun 2019 18:33:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] Add imx7d speed grading and higher OPPs
Message-ID: <20190612103327.GD11086@dragon>
References: <cover.1559730963.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559730963.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 05, 2019 at 01:37:04PM +0300, Leonard Crestez wrote:
> Changes since v1:
>  * Remove the match list from imx-cpufreq-dt
>  * Split arch and cpufreq changes
> Link to v1: https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=124427
> 
> Leonard Crestez (5):
>   cpufreq: imx-cpufreq-dt: Remove global platform match list
>   cpufreq: Switch imx7d to imx-cpufreq-dt for speed grading

>   ARM: imx: Switch imx7d to imx-cpufreq-dt for speed-grading
>   ARM: dts: imx7d: Update cpufreq OPP table
>   ARM: imx_v6_v7_defconfig: Enable CONFIG_ARM_IMX_CPUFREQ_DT

Applied these 3, thanks.
