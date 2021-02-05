Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94A7C433E0
	for <linux-pm@archiver.kernel.org>; Fri,  5 Feb 2021 09:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89BC564FB9
	for <linux-pm@archiver.kernel.org>; Fri,  5 Feb 2021 09:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhBEJ5V (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 5 Feb 2021 04:57:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhBEJy4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Feb 2021 04:54:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90E2564FBC;
        Fri,  5 Feb 2021 09:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612518855;
        bh=qqGS/sqwAf0mec/vUlbRuCasqOYPkR2xSCTJXt2Iw34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XdQGGIPtSw1Aw+LVyu9t22n8gc1Z9YOhrLUMXol8pNxflAQoCjfkuW2yC888XeU6C
         lNFY8zgQZ5Vv4kvhlufhrLZOVc2xr4DlttWtp5jWM0SkLgFFJ8bpH0WR/rVKlpgq3o
         REwZWF8Q3xTTTI9u2nAfSxab4wNc2KGHBEvKWg8w=
Date:   Fri, 5 Feb 2021 10:54:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, giometti@enneenne.com,
        abbotti@mev.co.uk, hsweeten@visionengravers.com, kw@linux.com,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kbuild@vger.kernel.org,
        masahiroy@kernel.org, michal.lkml@markovi.net,
        linuxarm@openeuler.org, prime.zeng@huawei.com
Subject: Re: [PATCH 4/4] staging: comedi: Use subdir-ccflags-* to inherit
 debug flag
Message-ID: <YB0VxBrYM3BSoxrc@kroah.com>
References: <1612518255-23052-1-git-send-email-yangyicong@hisilicon.com>
 <1612518255-23052-5-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612518255-23052-5-git-send-email-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 05, 2021 at 05:44:15PM +0800, Yicong Yang wrote:
> From: Junhao He <hejunhao2@hisilicon.com>
> 
> Use subdir-ccflags-* instead of ccflags-* to inherit the debug
> settings from Kconfig when traversing subdirectories.

Again, explain _why_.

Please read the section entitled "The canonical patch format" in the
kernel file, Documentation/SubmittingPatches for what a proper changelog
should look like.

thanks,

greg k-h
