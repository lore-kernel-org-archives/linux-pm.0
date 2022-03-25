Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C314CC433F5
	for <linux-pm@archiver.kernel.org>; Fri, 25 Mar 2022 04:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239953AbiCYEff (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 25 Mar 2022 00:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiCYEfe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Mar 2022 00:35:34 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0580AC064;
        Thu, 24 Mar 2022 21:34:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V87hnAX_1648182834;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V87hnAX_1648182834)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Mar 2022 12:33:56 +0800
Date:   Fri, 25 Mar 2022 12:33:53 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Huang Jianan <huangjianan@oppo.com>,
        Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Amit Kucheria <amitk@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation/ABI: sysfs-fs-erofs: Fix Sphinx errors
Message-ID: <Yj1GMaQN/W+kpT6e@B-P7TQMD6M-0146.local>
References: <20220324165918.22005-1-hdegoede@redhat.com>
 <20220324165918.22005-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220324165918.22005-4-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 24, 2022 at 05:59:18PM +0100, Hans de Goede wrote:
> Fix the following warnings from "make htmldocs":
> 
> Documentation/ABI/testing/sysfs-fs-erofs:10:
>   ERROR: Unexpected indentation.
>   WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks!

Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  Documentation/ABI/testing/sysfs-fs-erofs | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> index 05482374a741..bb4681a01811 100644
> --- a/Documentation/ABI/testing/sysfs-fs-erofs
> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> @@ -9,8 +9,9 @@ Description:	Shows all enabled kernel features.
>  What:		/sys/fs/erofs/<disk>/sync_decompress
>  Date:		November 2021
>  Contact:	"Huang Jianan" <huangjianan@oppo.com>
> -Description:	Control strategy of sync decompression
> +Description:	Control strategy of sync decompression:
> +
>  		- 0 (default, auto): enable for readpage, and enable for
> -				     readahead on atomic contexts only,
> +		  readahead on atomic contexts only.
>  		- 1 (force on): enable for readpage and readahead.
>  		- 2 (force off): disable for all situations.
> -- 
> 2.35.1
