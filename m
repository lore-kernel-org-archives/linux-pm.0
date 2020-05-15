Return-Path: <SRS0=YTwn=65=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D303C433E1
	for <linux-pm@archiver.kernel.org>; Fri, 15 May 2020 16:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B59D2070A
	for <linux-pm@archiver.kernel.org>; Fri, 15 May 2020 16:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgEOQEV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 15 May 2020 12:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726374AbgEOQEV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 12:04:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3DEC061A0C;
        Fri, 15 May 2020 09:04:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: evelikov)
        with ESMTPSA id 4FCEF2A3495
Date:   Fri, 15 May 2020 17:01:41 +0100
From:   Emil Velikov <emil.velikov@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv1 03/19] power: supply: core: add manufacture date
 properties
Message-ID: <20200515160141.GF2836808@arch-x1c3>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
 <20200513185615.508236-4-sebastian.reichel@collabora.com>
 <20200515144732.GC2836808@arch-x1c3>
 <20200515151408.vbj75fag6ya5g2bq@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515151408.vbj75fag6ya5g2bq@earth.universe>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020/05/15, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, May 15, 2020 at 03:47:32PM +0100, Emil Velikov wrote:
> > On 2020/05/13, Sebastian Reichel wrote:
> > > Some smart batteries store their manufacture date, which is
> > > useful to identify the battery and/or to know about the cell
> > > quality.
> > > 
> > Have you considered exposing this as a single file? Say following
> > the ISO8601 format - YYYY-MM-DD.
> 
> Yes. My initial implementation was exactly that. The thing is, that
> I suspect some fuel gauge implementations may only expose the year
> or just year + month. I chose 3 files, since receiving 'YYYY-MM'
> instead of full ISO code might be more unexpected than not having
> the DAY file available. But I don't have a strong opinion on this.
> 
Fwiw the ISO 8601 allows for YYYY-MM, although you're spot on. Having
the three fields separate makes perfect sense.

Thanks
Emil

