Return-Path: <SRS0=E5yJ=DK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BE7C41604
	for <linux-pm@archiver.kernel.org>; Sat,  3 Oct 2020 22:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF55206F8
	for <linux-pm@archiver.kernel.org>; Sat,  3 Oct 2020 22:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgJCWPp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 3 Oct 2020 18:15:45 -0400
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:57676 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725913AbgJCWPp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Oct 2020 18:15:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C13E718029120;
        Sat,  3 Oct 2020 22:15:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: land70_6101ae7271b0
X-Filterd-Recvd-Size: 1838
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat,  3 Oct 2020 22:15:43 +0000 (UTC)
Message-ID: <ebafdf9c1647070c45124786e71a0112f86d10b8.camel@perches.com>
Subject: Re: [PATCH][next] power: supply: fix spelling mistake "unprecise"
 -> "imprecise"
From:   Joe Perches <joe@perches.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Colin King <colin.king@canonical.com>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 03 Oct 2020 15:15:42 -0700
In-Reply-To: <20201003215102.5hl5lvidyki2xu7b@earth.universe>
References: <20200902101656.57676-1-colin.king@canonical.com>
         <20201003215102.5hl5lvidyki2xu7b@earth.universe>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 2020-10-03 at 23:51 +0200, Sebastian Reichel wrote:
> On Wed, Sep 02, 2020 at 11:16:56AM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > There is a spelling mistake in a dev_info message. Fix it.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> 
> Thanks, queued.
[]
> > diff --git a/drivers/power/supply/rn5t618_power.c b/drivers/power/supply/rn5t618_power.c
[]
> > @@ -487,7 +487,7 @@ static int rn5t618_power_probe(struct platform_device *pdev)
> >  		 * gauge will get decalibrated.
> >  		 */
> >  		dev_info(&pdev->dev, "Fuel gauge not enabled, enabling now\n");
> > -		dev_info(&pdev->dev, "Expect unprecise results\n");
> > +		dev_info(&pdev->dev, "Expect imprecise results\n");

Might as well be a single line too

		dev_info(&pdev->dev, "Fuel gauge not enabled, enabling now - expect imprecise results\n");


