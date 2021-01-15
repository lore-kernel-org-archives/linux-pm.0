Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DDEC433DB
	for <linux-pm@archiver.kernel.org>; Fri, 15 Jan 2021 10:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4337F236FB
	for <linux-pm@archiver.kernel.org>; Fri, 15 Jan 2021 10:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbhAOKuC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 15 Jan 2021 05:50:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731827AbhAOKuC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Jan 2021 05:50:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF5AC236FB;
        Fri, 15 Jan 2021 10:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610707761;
        bh=FjNsRoYW+it9gChKD+tyEHIzNDez0H8DJ/h10I2Nv2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ucUvslE3SHcVrqu2F65nPc0/AOpq21n+YZzP6lR8XYoyUrCsJH4TM331/vxU4LmMC
         ojpyHAz8We8xWsMIe1ceOyAGtXfWKzrWuWBQ9ylkoauV4930Gvc4/8THVZo1yVtGag
         SOENHUC/XiUp5salCrmt+9TRz0SLfqzJ3iR8YOebMZLsHEMX5SyvYbywMh7nbmb9z9
         vMv4RB27ENjc70N6Ge2RkJdlbLb5eGGGqJI0M6RulzDpwlAKRn4UMd+zeDL0TqdhQx
         5+1KcSm0OyIBy8yeH0KuMtr7DdxMCFBaqHHwf75A0mCbbR0BeWe+eUrqdY+vLwMySN
         WnbHhZ6TkQhXA==
Date:   Fri, 15 Jan 2021 18:49:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, georgi.djakov@linaro.org, cdleonard@gmail.com,
        gregkh@linuxfoundation.org, kernel@pengutronix.de,
        linux-imx@nxp.com, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 5/5] arm64: defconfig: Enable interconnect for imx8mq
Message-ID: <20210115104914.GR28365@dragon>
References: <20210107121754.3295-1-martin.kepplinger@puri.sm>
 <20210107121754.3295-6-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107121754.3295-6-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 07, 2021 at 01:17:54PM +0100, Martin Kepplinger wrote:
> Enable INTERCONNECT_IMX8MQ in order to make interconnect more widely
> available.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> Acked-by: Georgi Djakov <georgi.djakov@linaro.org>

Applied, thanks.
