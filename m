Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A891EC43334
	for <linux-pm@archiver.kernel.org>; Tue,  5 Jul 2022 10:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiGEKim (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 5 Jul 2022 06:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiGEKim (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 06:38:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0B2C24;
        Tue,  5 Jul 2022 03:38:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38D6761A3D;
        Tue,  5 Jul 2022 10:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CA8C341C7;
        Tue,  5 Jul 2022 10:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657017520;
        bh=z1GqxMIwtmun/u1tj/pwcRt5NAZl8SZdFgsjlbLxAlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rJKQ7WAmD2TzLUHrHcm77qh5JTv1SeM/6ZN4w/jjFPT8kBLaJayUYai8Y/0mPsrqv
         4tc9uz183UNWDGkjq1pM8BUIqx49/xTprWdqJu6abkV9eR0jMVj6gQLMxEG3G6et9E
         ljmGLgZ2uofbAZqt78npuydbsDyZTZ2qJeWldV90=
Date:   Tue, 5 Jul 2022 12:38:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thierry Strudel <tstrudel@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Pin-yen Lin <treapking@chromium.org>
Subject: Re: [PATCH] PM: domains: Ensure genpd_debugfs_dir exists before
 remove
Message-ID: <YsQUrXfugKT1IV75@kroah.com>
References: <20220705094946.827697-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705094946.827697-1-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 05, 2022 at 05:49:47PM +0800, Hsin-Yi Wang wrote:
> genpd_debug_remove() may be indirectly called from others while
> genpd_debugfs_dir is not yet set. Make sure genpd_debugfs_dir exists
> before remove the sub components, otherwise components under
> /sys/kernel/debug may be accidentally removed.
> 
> Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> An example:
> scpsys_probe() in drivers/soc/mediatek/mtk-pm-domains.c indirectly calls
> genpd_debug_remove() on probe fail, causing /sys/kernel/debug/usb to be
> removed.
> ---
>  drivers/base/power/domain.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 3e86772d5fac5..5a2e0232862e0 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -222,6 +222,9 @@ static void genpd_debug_remove(struct generic_pm_domain *genpd)
>  {
>  	struct dentry *d;
>  
> +	if (!genpd_debugfs_dir)
> +		return;
> +
>  	d = debugfs_lookup(genpd->name, genpd_debugfs_dir);
>  	debugfs_remove(d);

Why not just change this to be:
	debugfs_remove(debugfs_lookup(genpd->name, debugfs_lookup("pm_genpd", NULL)));

thanks,

greg k-h
