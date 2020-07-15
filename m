Return-Path: <SRS0=OhA8=A2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1410C433E6
	for <linux-pm@archiver.kernel.org>; Wed, 15 Jul 2020 07:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1C82068F
	for <linux-pm@archiver.kernel.org>; Wed, 15 Jul 2020 07:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594797002;
	bh=WLhsfcw7plg3hRP+qrV1SqW/pj2gCtEA71Y0It0scw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V/1TsV06O34BwNHj/Q5s8A/4kTduP+3ky3KueLa4PRgbFEw1mYCXxdNtbMn3nenFE
	 VKttA+7TTAkpgGETImKdbmxrrv88B8DaSRLID39M9ZQsrHD9AVtx1zlg11SvM8Erdt
	 l1pXtMRceaXmbIj5R9vuzKgOtf2x2e0uecuW3NpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgGOHKC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgGOHKC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jul 2020 03:10:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DDE32065E;
        Wed, 15 Jul 2020 07:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594797001;
        bh=WLhsfcw7plg3hRP+qrV1SqW/pj2gCtEA71Y0It0scw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZ+qkrW8xpb7lNU6FXeBKdC1NMA5hPPJdfjGqEEvsEl7nooJOuZ0XI/+EZbyKDiqk
         3Cqi88UXzlwLme6V15WR6vMKeBf90O0PM9q7RYS6XjSGDobP7mtqoU8ZV5LBmaA8x1
         qLWB3MMFn6AwiueMHO1Kcq5RHb7XrzWqr/2OUWIY=
Date:   Wed, 15 Jul 2020 09:09:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v3 1/5] power: supply: core: add quick charge type
 property
Message-ID: <20200715070957.GB2303720@kroah.com>
References: <cover.1594726859.git.huangqiwu@xiaomi.com>
 <40809c9b859c086ba6aec56b24402d41c60d6e71.1594726859.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40809c9b859c086ba6aec56b24402d41c60d6e71.1594726859.git.huangqiwu@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 15, 2020 at 08:35:19AM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> Reports the kind of quick charge type based on
> different adapter power. UI will show different
> animation effect for different quick charge type.
> 
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 21 +++++++++++++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                | 10 ++++++++++
>  3 files changed, 32 insertions(+)

What changed in any of these patches from the previous versions?  Always
list that below the --- line, like the documentation asks you to do.

And where is the 0/5 email for this series?

Please fix up and resend as a new version.

thanks,

greg k-h
