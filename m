Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565B6C433E0
	for <linux-pm@archiver.kernel.org>; Fri, 19 Mar 2021 18:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B75961956
	for <linux-pm@archiver.kernel.org>; Fri, 19 Mar 2021 18:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhCSSMK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 19 Mar 2021 14:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhCSSLu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 14:11:50 -0400
X-Greylist: delayed 387 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 Mar 2021 11:11:50 PDT
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A3CC06174A;
        Fri, 19 Mar 2021 11:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cmfD7KpKbERp7mA2RZE6JFAcn4PUcgfcPqGA1gdRqVU=; b=QeNYa+X/il2iwspX5UIR76a8yw
        YSr5EZc+lvwo1f4/TzGkDIjT8bd54gtFjZ5Z1uVaVt6mdCfd2VVAvhPSJdvPfpOXR4FWHwTtyloWp
        s2AhRPj0zCrtkrCrzyact06SXhjMYYESC8anrvJoWJGSpZe+gE09FWeY/Of8Gdc8ovNPs9qur3KUM
        B6ii80bGCgXlzbKk61zKv/5M5LrN+tFFPZ35Tlq1oD9DLyovHzu7+DOZMiFUq4NF3Svhxc7aV2JGe
        f7rvMwt38LaEQ50mwiXBXKI3fQvi+RERJNXXwtHB1TIxaAPZ40YjGuCa5tJD+kMGarAa4axsPXVju
        0VrlD70g==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNJb9-001RlW-HU; Fri, 19 Mar 2021 18:11:48 +0000
Date:   Fri, 19 Mar 2021 11:11:47 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: charger-manager: Fix a typo
In-Reply-To: <20210319055230.32220-1-unixbhaskar@gmail.com>
Message-ID: <469f4918-bd2d-8586-accd-77eeaf6dcd68@bombadil.infradead.org>
References: <20210319055230.32220-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_111147_601507_DBF2695A 
X-CRM114-Status: GOOD (  12.90  )
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote:

> s/systme/system/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> drivers/power/supply/charger-manager.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
> index 4dea8ecd70bc..45da870aecca 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -1604,7 +1604,7 @@ static int charger_manager_probe(struct platform_device *pdev)
> 	mutex_unlock(&cm_list_mtx);
>
> 	/*
> -	 * Charger-manager is capable of waking up the systme from sleep
> +	 * Charger-manager is capable of waking up the system from sleep
> 	 * when event is happened through cm_notify_event()
> 	 */
> 	device_init_wakeup(&pdev->dev, true);
> --
> 2.26.2
>
>
