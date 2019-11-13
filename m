Return-Path: <SRS0=pWvJ=ZF=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C3DC43331
	for <linux-pm@archiver.kernel.org>; Wed, 13 Nov 2019 12:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCE9222D0
	for <linux-pm@archiver.kernel.org>; Wed, 13 Nov 2019 12:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfKMMRd (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:17:33 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52408 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfKMMRd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 07:17:33 -0500
Received: from 79.184.253.153.ipv4.supernova.orange.pl (79.184.253.153) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 1c4580d13a0a562e; Wed, 13 Nov 2019 13:17:31 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     pavel@ucw.cz, linux-pm@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH 1/1] PM / wakeirq: remove unnecessary parentheses
Date:   Wed, 13 Nov 2019 13:17:31 +0100
Message-ID: <2240259.dxfY0U6Kfo@kreacher>
In-Reply-To: <1571128290-55488-1-git-send-email-tanxiaofei@huawei.com>
References: <1571128290-55488-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, October 15, 2019 10:31:30 AM CET Xiaofei Tan wrote:
> Remove unnecessary parentheses found by code review.
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  drivers/base/power/wakeirq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index 5ce77d1..8e02108 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -272,7 +272,7 @@ void dev_pm_enable_wake_irq_check(struct device *dev,
>  {
>  	struct wake_irq *wirq = dev->power.wakeirq;
>  
> -	if (!wirq || !((wirq->status & WAKE_IRQ_DEDICATED_MASK)))
> +	if (!wirq || !(wirq->status & WAKE_IRQ_DEDICATED_MASK))
>  		return;
>  
>  	if (likely(wirq->status & WAKE_IRQ_DEDICATED_MANAGED)) {
> @@ -299,7 +299,7 @@ void dev_pm_disable_wake_irq_check(struct device *dev)
>  {
>  	struct wake_irq *wirq = dev->power.wakeirq;
>  
> -	if (!wirq || !((wirq->status & WAKE_IRQ_DEDICATED_MASK)))
> +	if (!wirq || !(wirq->status & WAKE_IRQ_DEDICATED_MASK))
>  		return;
>  
>  	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED)
> 

Applied as 5.5 material, thanks!



