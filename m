Return-Path: <SRS0=EVuu=75=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62D7C433DF
	for <linux-pm@archiver.kernel.org>; Tue, 16 Jun 2020 10:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF10220786
	for <linux-pm@archiver.kernel.org>; Tue, 16 Jun 2020 10:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgFPKxi (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:53:38 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53670 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgFPKxi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 06:53:38 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9C73E1C0BD2; Tue, 16 Jun 2020 12:53:36 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:53:25 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh@kernel.org, amit.kucheria@verdurent.com,
        mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/6] Introduce Power domain based warming device driver
Message-ID: <20200616105325.GH1718@bug>
References: <20200604015317.31389-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604015317.31389-1-thara.gopinath@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi!

> Certain resources modeled as a generic power domain in linux kernel can be
> used to warm up the SoC (mx power domain on sdm845) if the temperature
> falls below certain threshold. These power domains can be considered as
> thermal warming devices.  (opposite of thermal cooling devices).

Would you explain when this is needed?

I'd normally expect "too low" temperature to be a problem during power-on, but at
that time Linux is not running so it can not provide the heating...

Best regards,

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
