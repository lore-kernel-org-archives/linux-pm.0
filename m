Return-Path: <SRS0=eD5R=76=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E52C433E0
	for <linux-pm@archiver.kernel.org>; Wed, 17 Jun 2020 21:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 489752184D
	for <linux-pm@archiver.kernel.org>; Wed, 17 Jun 2020 21:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgFQVPL (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:15:11 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:50348 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgFQVPL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jun 2020 17:15:11 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 104E91C0C0D; Wed, 17 Jun 2020 23:15:07 +0200 (CEST)
Date:   Wed, 17 Jun 2020 23:14:36 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh@kernel.org, amit.kucheria@verdurent.com,
        mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/6] Introduce Power domain based warming device driver
Message-ID: <20200617211436.GA2078@bug>
References: <20200604015317.31389-1-thara.gopinath@linaro.org>
 <20200616105325.GH1718@bug>
 <0eb2e140-9c9c-4777-9916-d81eddc793ca@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eb2e140-9c9c-4777-9916-d81eddc793ca@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi!

> >>falls below certain threshold. These power domains can be considered as
> >>thermal warming devices.  (opposite of thermal cooling devices).
> >
> >Would you explain when this is needed?
> >
> >I'd normally expect "too low" temperature to be a problem during power-on, but at
> >that time Linux is not running so it can not provide the heating...
> Hi Pavel,
> 
> This is more in the scenario if the system in on and temperature is dipping
> (I have been told in colder climates). Idea is to turn on resources so as to
> prevent further dipping of temperature if possible.

I guess even that makes sense...

But, out of curiosity, do you know which kind of device is that and in what
kind of environment? I mean, theoretically it may make sense on a cellphone,
but... I guess you have some fun device and would like to know what it is :-).

Hmm. And we can make this quite generic.

while (too_cold())
	barrier();

Wasting power is really easy :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
