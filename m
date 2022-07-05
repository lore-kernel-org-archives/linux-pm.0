Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66453C43334
	for <linux-pm@archiver.kernel.org>; Tue,  5 Jul 2022 17:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiGERht (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 5 Jul 2022 13:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiGERh1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 13:37:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589EA1FCE1;
        Tue,  5 Jul 2022 10:37:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C15E9618B8;
        Tue,  5 Jul 2022 17:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CDDC341C7;
        Tue,  5 Jul 2022 17:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657042646;
        bh=Z03DyOKw08NyvBbV0e2NrmufEjG46UtGoFtwcHEG4XQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v9WjN6pyCZhXsj9VLfzY+SopN06++D8wk1SyJWtPl/DTNC4vAztKjLJuKhGBYQH1K
         YzmO1I/sMO3hp4BdRHgurqQhsVBgROxpg/x5F8JQHOdlOxQdCbX89XVfVFEIwGO0/F
         vm/QGPbQA6E70ggXPC6ldOq+yWSALHXAxiMtXyZg=
Date:   Tue, 5 Jul 2022 19:37:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Pin-yen Lin <treapking@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PM: domains: Ensure genpd_debugfs_dir exists before
 remove
Message-ID: <YsR20yPbtUMjZOBC@kroah.com>
References: <20220705171649.969194-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705171649.969194-1-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 06, 2022 at 01:16:49AM +0800, Hsin-Yi Wang wrote:
> Both genpd_debug_add() and genpd_debug_remove() may be called
> indirectly by other drivers while genpd_debugfs_dir is not yet
> set. For example, drivers can call pm_genpd_init() in probe or
> pm_genpd_init() in probe fail/cleanup path:
> 
> pm_genpd_init()
>  --> genpd_debug_add()
> 
> pm_genpd_remove()
>  --> genpd_remove()
>    --> genpd_debug_remove()
> 
> At this time, genpd_debug_init() may not yet be called.
> 
> genpd_debug_add() checks that if genpd_debugfs_dir is NULL, it
> will return directly. Make sure this is also checked
> in pm_genpd_remove(), otherwise components under debugfs root
> which has the same name as other components under pm_genpd may
> be accidentally removed, since NULL represents debugfs root.
> 
> Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v1->v2: Add more context in commit message

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
